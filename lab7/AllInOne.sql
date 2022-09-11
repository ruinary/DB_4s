use UNIVER;

--1
create view [Преподаватель]
as 
select TEACHER [Кодовое имя], TEACHER_NAME [ФИО], GENDER [Пол], PULPIT [Кафедра]
from TEACHER;

use UNIVER;
select * from [Преподаватель]

--2
create view [Кол-во кафедр]
as
select f.FACULTY_NAME [Факультет], count(*) [Кол-во кафедр]
from FACULTY f join PULPIT p
on f.FACULTY = p.FACULTY
group by f.FACULTY_NAME

use UNIVER;
select * from [Кол-во кафедр]

--3
create view Аудитории (Номер)
as
select a.AUDITORIUM [Аудитория]
from AUDITORIUM a
where a.AUDITORIUM_TYPE like 'ЛК%';
go

insert Аудитории values('200-3а')
insert Аудитории values('100-3а')
update Аудитории set Номер = '324-1' where Номер = '236-1'
delete from Аудитории where Номер = '100-3а'
delete from AUDITORIUM where AUDITORIUM = '100-3а'


--4
create view Лекционные_аудитории (Номер, Вместимость)
as
select a.AUDITORIUM [Аудитория], a.AUDITORIUM_CAPACITY [Вместимость]
from AUDITORIUM a
where a.AUDITORIUM_CAPACITY > 40 with check option

delete from Лекционные_аудитории where Номер = '1234'
insert into Лекционные_аудитории values('145', 10)
insert into Лекционные_аудитории values('12345678', 80)

--5
create view Дисциплины
as
select top 50
s.SUBJECT [Аббревиатура], s.SUBJECT_NAME [Название предмета], s.PULPIT [Кафедра]
from SUBJECT s
order by Аббревиатура

--6
create view [Кол-во кафедр SCHEMABINDING] with schemabinding
as
select f.FACULTY_NAME [Факультет], count(*) [Кол-во кафедр]
from dbo.FACULTY f join dbo.PULPIT p
on f.FACULTY = p.FACULTY
group by f.FACULTY_NAME;


alter table PULPIT alter column PULPIT decimal;

--delete from [Кол-во кафедр SCHEMABINDING] where Факультет = 'Технология органических веществ'

--7
use A_MyBASE;
create view [Заказчики+Товары]
as
select o.*, j.*
from Заказчики o, Товары j

use A_MyBASE;
select * from [Заказчики+Товары]
--8
create view Расписание
as
select top(10) * from 
		(select top(10) 
		WEEKDAY [День],
		PARA [Время],
		convert(varchar, GROUPS) + ' группа' [Группа],
		AUDITORIUM+SUBJECT [Ячейка]
		from TIMETABLE) ttbl
			pivot
			(max(Ячейка)
			for Группа
			in ([2 группа], [13 группа], [15 группа])
			) pvt
		order by Время

use UNIVER;
select * from [Расписание]