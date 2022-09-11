use UUNIVER;

go
create trigger TR on AUDITORIUM_TYPE instead of INSERT
as
begin
	DECLARE curs CURSOR local for SELECT AUDITORIUM_TYPENAME from AUDITORIUM_TYPE;
	declare @numb nvarchar(30), @aud nvarchar(30), @count int, @type nvarchar(5);
	set @count = 0;
	OPEN curs;
	fetch  curs into @aud;  
		while @@fetch_status = 0
		begin 		
			set @numb = (select AUDITORIUM_TYPENAME from INSERTED);
			set @type = (select AUDITORIUM_TYPE from INSERTED);
			if(@numb = @aud)
			set @count = @count + 1;
			if(@count > 1)
			begin
				raiserror('Нельзя вставить повторяющееся значение',10,1);
				rollback;
				--delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE=@type;
			end; 
			fetch curs into @aud;  
		end; 
	CLOSE curs;
end;
return;
--открыть транакцию,комит и ролбэк
insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME) values('ЛК_17','Лекционная2');

drop table TR_AUDIT
go 
create table TR_AUDIT
(
ID int identity,
STMT varchar(20)
check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50),
CC varchar(300)
)

	drop trigger TR_TEACHER_INS


	go
    create  trigger TR_TEACHER_INS 
      on TEACHER after INSERT  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print 'Вставка';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('INS', 'TR_TEACHER_INS', @in);	         
      return;  
      go

	  insert into  TEACHER values('ИВНВ', 'Иванов', 'м', 'ИСиТ');
	  select * from TR_AUDIT