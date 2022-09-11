--declare cur cursor local dynamic for 
--	select p.IDSTUDENT, s.NAME, p.NOTE from PROGRESS p
--	join STUDENT s on s.IDSTUDENT = p.IDSTUDENT
--	where p.NOTE < 4
--		FOR UPDATE
--declare @id varchar(5), @nm varchar(50), @nt int


--open cur
--fetch cur into @id, @nm, @nt
--print @id + ': ' + @nm + ' (оценка ' + cast(@nt as varchar) + ')'
--delete PROGRESS where CURRENT OF cur	-- все удалится
--delete STUDENT where CURRENT OF cur
--close cur

insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values 
           ('КГ', 16,  '2013-12-04',3),
           ('КГ', 17,  '2013-12-04',3),
       ('КГ',   18,  '2013-06-04',3),
           ('КГ',   19,  '2013-01-04',3),
           ('КГ',   20,  '2013-01-04',3),
           ('КГ',   21,  '2013-01-04',3)
select* from PROGRESS;
go
DECLARE @id varchar(10), @name varchar(100), @subj varchar(50), @note varchar(2);
DECLARE PROGRESS_DELETE_CURSOR CURSOR LOCAL DYNAMIC
  for SELECT STUDENT.IDSTUDENT, STUDENT.NAME, PROGRESS.SUBJECT, PROGRESS.NOTE from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT FOR UPDATE;
OPEN PROGRESS_DELETE_CURSOR
fetch PROGRESS_DELETE_CURSOR into @id,@name,@subj,@note;
if(@note < 4)
      begin
        DELETE PROGRESS where CURRENT OF PROGRESS_DELETE_CURSOR;
      end;
print @id + ' - ' + @name + ' - '+ @subj + ' - ' + @note ;
While (@@FETCH_STATUS = 0)
  begin
    fetch PROGRESS_DELETE_CURSOR into @id,@name,@subj,@note;
    print @id + ' ▬ ' + @name + ' ▬ '+ @subj + ' ▬ ' + @note ;
    if(@note < 4)
      begin
        DELETE PROGRESS where CURRENT OF PROGRESS_DELETE_CURSOR;
      end;
  end;
close PROGRESS_DELETE_CURSOR;

select* from PRogress;
--select* from PROGRESS;

