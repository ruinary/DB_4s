use UUNIVER;
drop function COUNT_STUDENTS;
go
create function COUNT_STUDENTS(@faculty nvarchar(20)) returns int
as begin
declare @rc int = 0;
set @rc = (
SELECT count(IDSTUDENT) from STUDENT join GROUPS
    on STUDENT.IDGROUP = GROUPS.IDGROUP
	join FACULTY
	    on GROUPS.FACULTY = FACULTY.FACULTY
		    where FACULTY.FACULTY = @faculty);
return @rc;
end; 
go
declare @n int = dbo.COUNT_STUDENTS('ИДиП');
print 'Количество студентов: ' + cast(@n as varchar(4));

go
alter function COUNT_STUDENTS(@faculty varchar(20) = null, @prof varchar(20) = '1-40 01 02') returns int
as begin
declare @rc int = 0;
set @rc = (
SELECT count(IDSTUDENT) from FACULTY inner join GROUPS
	on FACULTY.FACULTY = GROUPS.FACULTY
	inner join STUDENT
		on GROUPS.IDGROUP = STUDENT.IDGROUP
			where FACULTY.FACULTY = @faculty and GROUPS.PROFESSION = @prof);
return @rc;
end; 
go
declare @n int = dbo.COUNT_STUDENTS('ИДиП', '1-40 01 02');
print 'Количество студентов: ' + cast(@n as varchar(4));