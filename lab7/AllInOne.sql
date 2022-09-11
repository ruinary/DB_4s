use UNIVER;

--1
create view [�������������]
as 
select TEACHER [������� ���], TEACHER_NAME [���], GENDER [���], PULPIT [�������]
from TEACHER;

use UNIVER;
select * from [�������������]

--2
create view [���-�� ������]
as
select f.FACULTY_NAME [���������], count(*) [���-�� ������]
from FACULTY f join PULPIT p
on f.FACULTY = p.FACULTY
group by f.FACULTY_NAME

use UNIVER;
select * from [���-�� ������]

--3
create view ��������� (�����)
as
select a.AUDITORIUM [���������]
from AUDITORIUM a
where a.AUDITORIUM_TYPE like '��%';
go

insert ��������� values('200-3�')
insert ��������� values('100-3�')
update ��������� set ����� = '324-1' where ����� = '236-1'
delete from ��������� where ����� = '100-3�'
delete from AUDITORIUM where AUDITORIUM = '100-3�'


--4
create view ����������_��������� (�����, �����������)
as
select a.AUDITORIUM [���������], a.AUDITORIUM_CAPACITY [�����������]
from AUDITORIUM a
where a.AUDITORIUM_CAPACITY > 40 with check option

delete from ����������_��������� where ����� = '1234'
insert into ����������_��������� values('145', 10)
insert into ����������_��������� values('12345678', 80)

--5
create view ����������
as
select top 50
s.SUBJECT [������������], s.SUBJECT_NAME [�������� ��������], s.PULPIT [�������]
from SUBJECT s
order by ������������

--6
create view [���-�� ������ SCHEMABINDING] with schemabinding
as
select f.FACULTY_NAME [���������], count(*) [���-�� ������]
from dbo.FACULTY f join dbo.PULPIT p
on f.FACULTY = p.FACULTY
group by f.FACULTY_NAME;


alter table PULPIT alter column PULPIT decimal;

--delete from [���-�� ������ SCHEMABINDING] where ��������� = '���������� ������������ �������'

--7
use A_MyBASE;
create view [���������+������]
as
select o.*, j.*
from ��������� o, ������ j

use A_MyBASE;
select * from [���������+������]
--8
create view ����������
as
select top(10) * from 
		(select top(10) 
		WEEKDAY [����],
		PARA [�����],
		convert(varchar, GROUPS) + ' ������' [������],
		AUDITORIUM+SUBJECT [������]
		from TIMETABLE) ttbl
			pivot
			(max(������)
			for ������
			in ([2 ������], [13 ������], [15 ������])
			) pvt
		order by �����

use UNIVER;
select * from [����������]