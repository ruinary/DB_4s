use UNIVER;

---1

	select FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from FACULTY, PULPIT, PROFESSION
where FACULTY.FACULTY = PULPIT.FACULTY and PULPIT.FACULTY = PROFESSION.FACULTY
and PROFESSION_NAME in (select PROFESSION_NAME from  PROFESSION
            where (PROFESSION_NAME like '%����%'))

---2
	select FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from (FACULTY INNER JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY) INNER JOIN PROFESSION ON PULPIT.FACULTY = PROFESSION.FACULTY 
WHERE PROFESSION_NAME in (select PROFESSION_NAME from  PROFESSION
            where (PROFESSION_NAME like '%����%'))


---3
	select FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from (FACULTY INNER JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY) INNER JOIN PROFESSION ON PULPIT.FACULTY = PROFESSION.FACULTY 
            where (PROFESSION_NAME like '%����%')

---4
select AUDITORIUM_NAME,AUDITORIUM_CAPACITY from AUDITORIUM order by AUDITORIUM_CAPACITY desc;

select AUDITORIUM_NAME,AUDITORIUM_CAPACITY from AUDITORIUM a
where AUDITORIUM_CAPACITY = (
	select top(1) AUDITORIUM_CAPACITY 
	from AUDITORIUM aa
	where aa.AUDITORIUM_TYPE = a.AUDITORIUM_TYPE 
	order by AUDITORIUM_CAPACITY desc)
order by AUDITORIUM_CAPACITY desc

select AUDITORIUM_NAME,AUDITORIUM_CAPACITY FROM AUDITORIUM a
where AUDITORIUM  = (
	select top(1) AUDITORIUM
	from AUDITORIUM aa
	where aa.AUDITORIUM_TYPE = a.AUDITORIUM_TYPE 
	order by AUDITORIUM_CAPACITY desc)
order by AUDITORIUM_CAPACITY desc;

---5

select FACULTY.FACULTY_NAME from FACULTY
where not exists (select *from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY)

---6

 select top 1
	(select avg(NOTE) from PROGRESS where SUBJECT like '����') [����],
	(select avg(NOTE) from PROGRESS where SUBJECT like '��') [��],
	(select avg(NOTE) from PROGRESS where SUBJECT like '����') [����]
	from PROGRESS

---7

select SUBJECT,  NOTE from PROGRESS
where NOTE >=all (select NOTE from PROGRESS where IDSTUDENT between 5 and 1008)

---8

select SUBJECT,  NOTE from PROGRESS
where NOTE >=any (select NOTE from PROGRESS where IDSTUDENT between 5 and 1008)

---9

use A_MyBASE


select *from ������
where ����������_�����������_������ >=all (select ����������_�����������_������  from ������ where ���_�������� =  '�������')


select *from ������
where ����������_�����������_������ >=any (select ����������_�����������_������  from ������ where ���_�������� =  '�������')

select top 1
(select avg (����������_�����������_������) from ������ where ���_�������� =  '�������')[����������_�����������_������]
from ������

---10
use UNIVER;


select STUDENT.NAME,Day(BDAY)[���� ��������], STUDENT.BDAY FROM STUDENT WHERE DAY(BDAY)
IN ( 
	SELECT DAY(BDAY) 
	FROM STUDENT  
	GROUP BY DAY(BDAY) 
	HAVING COUNT(DAY(BDAY)) > 1) 
group by Day(Bday),STUDENT.NAME,STUDENT.BDAY
order by '���� ��������' asc;
