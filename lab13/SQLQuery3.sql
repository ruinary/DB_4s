use UUNIVER;

-- если оба парам NULL, возвр. список всех кафедр на фак
-- если второй NULL, возвр. все кафедры зад. фак
-- если первый NULL, возвр. строку, соотв-щую зад. кафедре
-- если оба не NULL, возвр. строку, соотв-щую зад. кафедре на зад. фак
-- если нельзя сформир. строки, возвр. пустой рез.набор
go
create function FFACPUL(@f varchar(20), @p varchar(20)) returns table
as return
select FACULTY.FACULTY, PULPIT.PULPIT from FACULTY left outer join PULPIT
  on FACULTY.FACULTY = PULPIT.FACULTY
   where FACULTY.FACULTY = ISNULL(@f, FACULTY.FACULTY) and --первое значение, не равное null
    PULPIT.PULPIT = ISNULL(@p, PULPIT.PULPIT);

go
select * from dbo.FFACPUL(null, null);
select * from dbo.FFACPUL('ИДиП', null);
select * from dbo.FFACPUL(null, 'ИСиТ');
select * from dbo.FFACPUL('ИДиП', 'ИСиТ');