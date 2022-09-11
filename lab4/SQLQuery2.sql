USE UNIVER;

--1
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
FROM AUDITORIUM INNER JOIN AUDITORIUM_TYPE
ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

--2
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
FROM AUDITORIUM INNER JOIN AUDITORIUM_TYPE
ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE AND AUDITORIUM_TYPE.AUDITORIUM_TYPENAME LIKE '%омпьют%'

--3
SELECT T1.AUDITORIUM, T2.AUDITORIUM_TYPENAME
FROM AUDITORIUM AS T1,  AUDITORIUM_TYPE AS T2
WHERE T1.AUDITORIUM_TYPE = T2.AUDITORIUM_TYPE AND T2.AUDITORIUM_TYPENAME LIKE '%омпьют%'

--4
SELECT FACULTY.FACULTY[факультет], PULPIT.PULPIT[кафедра], PROFESSION.PROFESSION[специальность], SUBJECT.SUBJECT[дисциплина], STUDENT.NAME[имя студента], PROGRESS.NOTE,
CASE 
WHEN PROGRESS.NOTE = 6 THEN 'шесть'
WHEN PROGRESS.NOTE = 7 THEN 'семь'
WHEN PROGRESS.NOTE = 8 THEN 'восемь'
END[оценка]
FROM (((FACULTY inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY) 
  inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
  inner join (GROUPS inner join STUDENT on GROUPS.IDGROUP = STUDENT.IDGROUP) on FACULTY.FACULTY = GROUPS.FACULTY))
  inner join (SUBJECT inner join PROGRESS on SUBJECT.SUBJECT = PROGRESS.SUBJECT and (PROGRESS.NOTE BETWEEN 6 AND 8 )) on PULPIT.PULPIT = SUBJECT.PULPIT
  ORDER BY FACULTY.FACULTY ASC , PULPIT.PULPIT ASC, PROFESSION.PROFESSION ASC, STUDENT.NAME ASC, оценка DESC

--5
SELECT FACULTY.FACULTY[факультет], PULPIT.PULPIT[кафедра], PROFESSION.PROFESSION[специальность], SUBJECT.SUBJECT[дисциплина], STUDENT.NAME[имя студента], PROGRESS.NOTE,
CASE 
WHEN PROGRESS.NOTE = 6 THEN 'шесть'
WHEN PROGRESS.NOTE = 7 THEN 'семь'
WHEN PROGRESS.NOTE = 8 THEN 'восемь'
END[оценка]
FROM (((FACULTY inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY) 
  inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
  inner join (GROUPS inner join STUDENT on GROUPS.IDGROUP = STUDENT.IDGROUP) on FACULTY.FACULTY = GROUPS.FACULTY))
  inner join (SUBJECT inner join PROGRESS on SUBJECT.SUBJECT = PROGRESS.SUBJECT and (PROGRESS.NOTE BETWEEN 6 AND 8 )) on PULPIT.PULPIT = SUBJECT.PULPIT
  ORDER BY (case 
  when PROGRESS.NOTE = '7' then '1'
  when PROGRESS.NOTE = '8' then '2'
  when PROGRESS.NOTE = '6' then '3'
  end)

  --6

  select isnull (TEACHER.TEACHER_NAME, '***')[ПРЕПОДАВАТЕЛЬ], PULPIT.PULPIT_NAME[КАФЕДРА]
  FROM PULPIT LEFT OUTER JOIN TEACHER
  ON PULPIT.PULPIT = TEACHER.PULPIT

  --7
    select isnull (TEACHER.TEACHER_NAME, '***')[ПРЕПОДАВАТЕЛЬ],  PULPIT.PULPIT_NAME [КАФЕДРА]
  FROM TEACHER RIGHT OUTER JOIN PULPIT
  ON PULPIT.PULPIT = TEACHER.PULPIT

      select isnull (TEACHER.TEACHER_NAME, '***')[ПРЕПОДАВАТЕЛЬ], ISNULL ( PULPIT.PULPIT_NAME, '***' )[КАФЕДРА]
  FROM PULPIT RIGHT OUTER JOIN TEACHER
  ON PULPIT.PULPIT = TEACHER.PULPIT

  --8

  select  PULPIT.PULPIT, isnull(TEACHER.TEACHER_NAME,'***')[Teacher]
from PULPIT full outer join TEACHER
on PULPIT.PULPIT = TEACHER.PULPIT

select  PULPIT.PULPIT, isnull(TEACHER.TEACHER_NAME,'***')[Teacher]
from TEACHER full outer join PULPIT
on PULPIT.PULPIT = TEACHER.PULPIT
where TEACHER_NAME is null


drop table t1;
drop table t2;

create table t1
( id int primary key,
  c1 nvarchar(20)
)

insert into t1
values (1, 'rrr'), (2,'ttt'), (3, 'qqq'), (4, 'eee')

create table t2
(id varchar primary key,
c1 nvarchar(20),
t1 int foreign key references t1(id) )

insert into t2 
values ('a', 'jjj', 2), ('b', 'kkk', 1), ('c', 'ooo', NULL), ('d', 'fff', NULL)


select t2.id, t2.c1, t1.c1    --правой и левой
from t2 full outer join t1 
on t2.t1 = t1.id order by t1.c1

select t2.id, t2.c1, t1.c1    --правой
from t2 right  outer join t1 
on t2.t1 = t1.id
where t2.t1 is null

select t2.id, t2.c1, t1.c1  --левой
from t2 left outer join t1 
on t2.t1 = t1.id 
where t1.id is null

select t2.id, t2.c1, t1.c1    --левой фулл
from t2 full outer join t1 
on t2.t1 = t1.id 
where t1.id is null or t2.t1 is null and t1.id is null


--9

SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME  --just cross
FROM AUDITORIUM cross JOIN AUDITORIUM_TYPE


SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME  --надо получить
FROM AUDITORIUM INNER JOIN AUDITORIUM_TYPE
ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME  --получили
FROM AUDITORIUM cross JOIN AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE


--10

use A_MyBASE

select Заказы.Номер_заказа, Заказы.Заказчик, Заказы.Заказанный_товар
from Заказы inner join Заказчики
on Заказы.Заказчик=Заказчики.[Наименование_фирмы]

select Заказы.Номер_заказа, Заказы.Заказчик, Заказы.Заказанный_товар
from Заказы inner join Заказчики
on Заказы.Заказчик=Заказчики.[Наименование_фирмы]
and Заказы.Заказчик like 'kfc'

select Заказы.Номер_заказа, Заказы.Заказчик, Заказы.Заказанный_товар, Заказы.Количество_заказанного_товара
from Заказы inner join Заказчики
on Заказы.Заказчик=Заказчики.[Наименование_фирмы]
order by 
(case 
when (Заказы.Количество_заказанного_товара between 1 and 9 ) then 2
when (Заказы.Количество_заказанного_товара between 10 and 20 ) then 1
else 3
end
)

select Заказы.Номер_заказа, Заказы.Заказчик, Заказы.Заказанный_товар
from Заказы  full outer join Заказчики
on Заказы.Заказчик=Заказчики.[Наименование_фирмы]
where Заказы.Заказчик is null

select Заказы.Номер_заказа, Заказы.Заказчик, Заказы.Заказанный_товар
from Заказы cross join Заказчики

select Заказы.Номер_заказа, Заказы.Заказчик, Заказы.Заказанный_товар
from Заказы cross join Заказчики
where Заказы.Заказчик=Заказчики.[Наименование_фирмы]


--11
use UNIVER


--drop table TIMETABLE;
create table TIMETABLE
(
ID int primary key,
GROUPS int foreign key references GROUPS(IDGROUP),
AUDITORIUM char(20) foreign key references AUDITORIUM(AUDITORIUM),
SUBJECT char(10) foreign key references SUBJECT(SUBJECT),
TEACHER char(10) foreign key references TEACHER(TEACHER),
WEEKDAY nvarchar(20) check (WEEKDAY in('Понедельник','Вторник','Среда','Четверг','Пятница','Суббота')),
PARA nvarchar(20) check (PARA in('14:40-16:00','16:30-17:50','18:05-19:25','19:40-21:00','13:00-14:20','11:25-12:45'))
)


insert into TIMETABLE(ID, GROUPS, AUDITORIUM, SUBJECT, TEACHER, WEEKDAY, PARA)
values (1 , 2, '301-1', 'ООП', 'КРЛВ', 'Понедельник', '14:40-16:00'),
(2, 15, '304-4', 'ПЭХ', 'МРЗВ', 'Четверг', '18:05-19:25'),
(3, 1, NULL, NULL, NULL, 'Понедельник', '18:05-19:25'),
(4, 2, '313-1', 'ПЗ', 'МХВ ', 'Суббота', '16:30-17:50'),
(5, 2, '423-1', 'ЭТ', 'ПРКП', 'Понедельник', '14:40-16:00'),
(6, 2, '313-1', 'КГ', 'КРЛВ', 'Четверг', '16:30-17:50'),
(7, NULL, NULL, NULL, 'РМНВ', 'Пятница', '19:40-21:00'),
(8, NULL, NULL, NULL, 'ЧРН', 'Пятница', '11:25-12:45'),
(9, 13, '423-1', 'МП', 'СМЛВ', 'Суббота', '11:25-12:45'),
(10, 13, '320-4', 'ЛЭВМ', 'ЧРН', 'Суббота', '14:40-16:00'),
(11, 13, '324-1', 'СУБД', 'СМЛВ', 'Понедельник', '11:25-12:45'),
(12, NULL, NULL, NULL, NULL, NULL, '11:25-12:45'),
(13, NULL, NULL, NULL, 'КРЛВ', 'Понедельник', '16:30-17:50'),
(14, 2, NULL, NULL, NULL, 'Понедельник', '19:40-21:00')


select * from TIMETABLE order by
(case
when (TIMETABLE.WEEKDAY = 'Понедельник') then 1
when (TIMETABLE.WEEKDAY = 'Вторник') then 2
when (TIMETABLE.WEEKDAY = 'Среда') then 3
when (TIMETABLE.WEEKDAY = 'Четверг') then 4
when (TIMETABLE.WEEKDAY = 'Пятница') then 5
when (TIMETABLE.WEEKDAY = 'Суббота') then 6
end)


select TIMETABLE.WEEKDAY, TIMETABLE.PARA, AUDITORIUM.AUDITORIUM
from TIMETABLE full outer join AUDITORIUM
on TIMETABLE.AUDITORIUM = AUDITORIUM.AUDITORIUM order by
(case
when (TIMETABLE.WEEKDAY = 'Понедельник') then 1
when (TIMETABLE.WEEKDAY = 'Вторник') then 2
when (TIMETABLE.WEEKDAY = 'Среда') then 3
when (TIMETABLE.WEEKDAY = 'Четверг') then 4
when (TIMETABLE.WEEKDAY = 'Пятница') then 5
when (TIMETABLE.WEEKDAY = 'Суббота') then 6
end)

SELECT DISTINCT AUDITORIUM.AUDITORIUM ,TIMETABLE.WEEKDAY,TIMETABLE.AUDITORIUM
		From AUDITORIUM cross join TIMETABLE
		where TIMETABLE.AUDITORIUM != AUDITORIUM.AUDITORIUM and  TIMETABLE.PARA ='14:40-16:00';

SELECT DISTINCT AUDITORIUM.AUDITORIUM ,TIMETABLE.WEEKDAY,TIMETABLE.AUDITORIUM
		From AUDITORIUM cross join TIMETABLE
		where TIMETABLE.AUDITORIUM != AUDITORIUM.AUDITORIUM and  TIMETABLE.WEEKDAY ='Четверг';


SELECT DISTINCT TEACHER.TEACHER ,TIMETABLE.WEEKDAY,TIMETABLE.AUDITORIUM
					From TEACHER right outer join TIMETABLE
					ON TEACHER.TEACHER != TIMETABLE.TEACHER
	
SELECT DISTINCT TIMETABLE.GROUPS ,TIMETABLE.WEEKDAY,TIMETABLE.AUDITORIUM
					From GROUPS right outer join TIMETABLE
					on GROUPS.IDGROUP != TIMETABLE.GROUPS	