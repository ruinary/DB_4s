-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 1
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
select * from PROGRESS

use UNIVER;
go 
create function COUNT_STUDENTS(@faculty varchar(20)) returns int
as begin 
declare @ret int = 0;
set @ret = (select count(IDSTUDENT) from 
			GROUPS inner join FACULTY 
			on GROUPS.FACULTY = FACULTY.FACULTY inner join STUDENT
			on STUDENT.IDGROUP = GROUPS.IDGROUP where GROUPS.FACULTY = @faculty);
return @ret;
end;
go

--DROP FUNCTION COUNT_STUDENTS;

declare @faculty_name char(10) = 'ИТ';
declare @f_result int = dbo.COUNT_STUDENTS(@faculty_name);
print 'Количество студентов факультета ' + rtrim(@faculty_name) + ': ' + cast(@f_result as varchar);


--DROP FUNCTION SUBD_PROGRESS
go 
create function SUBD_PROGRESS(@subject varchar(20)) returns table
	as return select NOTE from PROGRESS where SUBJECT=@subject
go

select * from dbo.SUBD_PROGRESS('КГ');



-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 2
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
create function FSUBJECTS(@p varchar(20)) returns varchar(300)
as begin
DECLARE Discipline CURSOR LOCAL for select [SUBJECT_NAME] from [SUBJECT] where [SUBJECT].PULPIT = @p;
DECLARE @subject varchar(60), @subject_ot varchar(300) ='';
OPEN Discipline;
FETCH Discipline into @subject;
while @@FETCH_STATUS = 0
	begin
		set @subject_ot = RTRIM(@subject) +', ' +  @subject_ot;
		FETCH  Discipline into @subject;
	end;
CLOSE Discipline;
set @subject_ot = @subject_ot;
return @subject_ot;
end;
go
--DROP FUNCTION FSUBJECTS;

select PULPIT.PULPIT 'Кафедра', dbo.FSUBJECTS(PULPIT.PULPIT) 'Дисциплины кафедры' from PULPIT;
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 3
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
create function FFACPUL(@faculty varchar(20), @pulpit varchar(20)) returns table
as return 
	select FACULTY.FACULTY,PULPIT.PULPIT from
		FACULTY left outer join PULPIT
		on FACULTY.FACULTY = PULPIT.FACULTY
		where FACULTY.FACULTY = isnull(@faculty,FACULTY.FACULTY)and
			PULPIT.PULPIT = isnull(@pulpit,PULPIT.PULPIT);
go
--DROP FUNCTION FFACPUL;

select * from dbo.FFACPUL(NULL,NULL);
select * from dbo.FFACPUL('ТТЛП',NULL);
select * from dbo.FFACPUL(NULL,'ИСиТ');
select * from dbo.FFACPUL('ИТ','ИСиТ');
select * from dbo.FFACPUL('ЛХ','ПИ');

-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 4
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
create function FTEACHER (@pulpit varchar(20)) returns int
as begin
		declare @result int = 0;
		set @result  = (select count(*) from
									TEACHER inner join PULPIT
									on TEACHER.PULPIT = PULPIT.PULPIT
									where PULPIT.PULPIT = isnull(@pulpit,PULPIT.PULPIT));
		return @result;
end;
go
--DROP FUNCTION FTEACHER;

select PULPIT, dbo.FTEACHER(PULPIT.PULPIT) 'Количество преподавателей' from PULPIT;
select dbo.FTEACHER(NULL) 'Всего преподавателей';

-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 6
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use UNIVER;

go 
create function COUNT_PULPIT(@faculty varchar(20)) returns int
as begin 
declare @ret int = 0;
set @ret = (select count(PULPIT) from 
			PULPIT where FACULTY = @faculty);
return @ret;
end;

go 
create function COUNT_GROUP(@faculty varchar(20)) returns int
as begin 
declare @ret int = 0;
set @ret = (select count(IDGROUP) from 
			GROUPS where FACULTY = @faculty);
return @ret;
end;

go 
create function COUNT_PROFESSION(@faculty varchar(20)) returns int
as begin 
declare @ret int = 0;
set @ret = (select count(PROFESSION) from 
			PROFESSION where FACULTY = @faculty);
return @ret;
end;

--DROP FUNCTION COUNT_PULPIT;
--DROP FUNCTION COUNT_GROUP;
--DROP FUNCTION COUNT_PROFESSION;

go
create function FACULTY_REPORT(@c int) returns @fr table
([Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int,[Количество студентов] int, [Количество специальностей] int )
as begin 
           declare cc CURSOR static for select FACULTY from FACULTY where dbo.COUNT_STUDENTS(FACULTY) > @c; 
	       declare @f varchar(30);
	       open cc;  
           fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  dbo.COUNT_PULPIT(@f),
	            dbo.COUNT_GROUP(@f),   dbo.COUNT_STUDENTS(@f),
	            dbo.COUNT_PROFESSION(@f)); 
	            fetch cc into @f;  
	       end;   
                 return; 
	end;

--DROP FUNCTION FACULTY_REPORT;

go
SELECT * from  dbo.FACULTY_REPORT(0);
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 1
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use АртёмПРОДАЖИ;

go
create function COUNT_ZAKAZY (@f varchar(20)) returns int
as begin 
	declare @rc int=0;
	set @rc = (select COUNT(Номер_заказа) 
				from ЗАКАЗЫ z join ЗАКАЗЧИКИ zk
					on z.Заказчик = zk.Наименование_фирмы
						where Наименование_фирмы = @f);
	return @rc;
end; 
go
select * from ЗАКАЗЫ;
declare @f int = dbo.COUNT_ZAKAZY('Луч');
print 'Количество заказов: ' + cast(@f as varchar(4));

select Наименование_фирмы, dbo.COUNT_ZAKAZY(Наименование_фирмы) from ЗАКАЗЧИКИ
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 2
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use АртёмПРОДАЖИ;

DROP function FZakazy
go
create FUNCTION FZakazy(@tz char(20)) returns char(300) 
as begin  
	declare @tv char(20);  
	declare @t varchar(300) = '';  
	declare ZkTovar CURSOR LOCAL 
	for select Наименование_товара from Заказы  where Заказчик = @tz;
		open ZkTovar;	  
			 fetch  ZkTovar into @tv;   	 
			 while @@fetch_status = 0                                     
			 begin 
				 set @t = @t + rtrim(@tv) + ', ';         
				 FETCH  ZkTovar into @tv; 
			 end;    
			 return @t;
end;  
go
select Наименование_фирмы, dbo.FZakazy(Наименование_фирмы) [Заказанные_товары]  from Заказчики;
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 3
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use АртёмПРОДАЖИ;

go
create function FTovCena(@f varchar(50), @p real) returns table
as return
select f.Наименование, f.Цена, p.Цена_продажи
from dbo.TОВАРЫ f left outer join ЗАКАЗЫ p
	on f.Наименование = p.Наименование_товара
	where f.Наименование = isnull (@f, f.Наименование)			--Функция ISNULL проверяет значение некоторого выражения.
			and p.Цена_продажи = isnull(@p, p.Цена_продажи);	--Если оно равно NULL, то функция возвращает значение,
go																--которое передается в качестве второго параметра
select * from dbo.FTovCena(NULL, NULL);
select * from dbo.FTovCena('Стул офисный', NULL);
select * from dbo.FTovCena(NULL, 400);
select * from dbo.FTovCena('Шкаф', 340);
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 4
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use АртёмПРОДАЖИ;

go
create function FKolTov(@p varchar(50)) returns int
as begin
	declare @rc int = (select count(*) from ЗАКАЗЫ
						where Заказчик = isnull(@p, Заказчик));
	return @rc;
end;
go
select distinct Заказчик, dbo.FKolTov(Заказчик) [Количество_заказов] from ЗАКАЗЫ
select dbo.FKolTov(NULL) [Всего_заказов]

--

go
create function TEACHER_SUBJECTS(@c varchar(100)) returns table
	as
	begin
	declare @pulpit char(20) = (select top(1) TEACHER.PULPIT from TEACHER where TEACHER.TEACHER_NAME Like @c;
	return select SUBJECT.SUBJECT_NAME from SUBJECT,PULPIT where PULPIT.PULPIT_NAME Like 'ИСиТ                ';
	end;
go
drop function TEACHER_SUBJECTS;
select * from dbo.TEACHER_SUBJECTS('ИСиТ');
