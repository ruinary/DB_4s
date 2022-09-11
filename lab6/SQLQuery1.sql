use UNIVER 

---1

select min(AUDITORIUM_CAPACITY)[��� �����������],
		max(AUDITORIUM_CAPACITY)[���� �����������], 
		avg(AUDITORIUM_CAPACITY)[������� ], 
		sum(AUDITORIUM_CAPACITY)[���������],
		count(*)[���-�� ���������]
	from AUDITORIUM;

---2

select AUDITORIUM.AUDITORIUM_TYPE,
		min(AUDITORIUM_CAPACITY)[��� �����������],
		max(AUDITORIUM_CAPACITY)[���� �����������], 
		avg(AUDITORIUM_CAPACITY)[������� ], 
		sum(AUDITORIUM_CAPACITY)[���������],
		count(*)[���-�� ���������] 
	from AUDITORIUM inner join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
	group by AUDITORIUM.AUDITORIUM_TYPE

---3

SELECT *
	FROM(SELECT CASE 
		WHEN NOTE = 10 then '10'
		WHEN NOTE between 8 and 9 then '8-9'
		WHEN NOTE between 6 and 7 then '6-7'
		WHEN NOTE between 4 and 5 then '4-5'
	END [������],
	COUNT(*) as [���-��]
	FROM PROGRESS GROUP BY CASE
		WHEN NOTE = 10 then '10'
		WHEN NOTE between 8 and 9 then '8-9'
		WHEN NOTE between 6 and 7 then '6-7'
		WHEN NOTE between 4 and 5 then '4-5'
	END) AS T
ORDER BY Case [������]
	WHEN '10' then 1
	WHEN '8-9' then 2
	WHEN '6-7' then 3
	WHEN '4-5' then 4
	ELSE 0
	END;


---4

select a.FACULTY,
	   b.PROFESSION, 
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) [AVG NOTE]
from ((FACULTY a inner join GROUPS b on a.FACULTY = b.FACULTY)
inner join STUDENT on b.IDGROUP = STUDENT.IDGROUP) 
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
group by a.FACULTY,
		 b.PROFESSION



		 
select a.FACULTY,
	   b.PROFESSION,
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) [AVG NOTE]
from ((FACULTY a inner join GROUPS b on a.FACULTY = b.FACULTY)
inner join STUDENT on b.IDGROUP = STUDENT.IDGROUP) 
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.SUBJECT = '��' or PROGRESS.SUBJECT = '����'
group by a.FACULTY,
		 b.PROFESSION



---5
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY ROLLUP (GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT);


---6


SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY CUBE (GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT)



---7


SELECT	
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
UNION
SELECT	
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('����')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT





SELECT	
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('��')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
UNION all
SELECT	
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('����')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT



---8

SELECT	
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('��')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
INTERSECT 
SELECT	
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('����')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT


---9
SELECT	
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
EXCEPT
SELECT	
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [����������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('����')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT

---10

select p1.SUBJECT as ' ����������', 
	p1.NOTE as '������', 
	(select count(*) from PROGRESS p2
	where p2.SUBJECT = p1.SUBJECT and p2.NOTE = p1.NOTE) as '���-�� ���������'
from PROGRESS p1
group by p1.SUBJECT, p1.NOTE
having NOTE in (8, 9)




---11

use A_MyBASE;


select min(����������_�����������_������)[���],
		max(����������_�����������_������)[����], 
		avg(����������_�����������_������)[�����], 
		sum(����������_�����������_������)[�������],
		count(*)[���-�� �������]
	from ������;


select ��������, ���_��������
 from ������ where ��������='kfc'
	union
 select ��������, ���_��������
 from ������ where ��������='bk'


 select ��������, ���_��������
 from ������ where ��������='kfc'
	union all
 select ��������, ���_��������
 from ������ where ��������='bk'


 select ��������, ���_��������
 from ������ where ��������='kfc'
	INTERSECT
 select ��������, ���_��������
 from ������ where ��������='bk'

 
 select ��������, ���_��������
 from ������ where ��������='kfc'
	EXCEPT 
 select ��������, ���_��������
 from ������ where ��������='bk'
  

---12

use UNIVER;

select * from FACULTY;
select * from GROUPS;
select * from STUDENT;
--12.1
select isnull(f.FACULTY, '�����') [���������], s.IDGROUP [������], COUNT(*) [���-�� ���������]
from GROUPS g	join STUDENT s on s.IDGROUP = g.IDGROUP
				join FACULTY f on f.FACULTY = g.FACULTY
group by rollup (f.FACULTY, s.IDGROUP)
--
select * from AUDITORIUM;
select * from AUDITORIUM_TYPE;
--12.2
select distinct ������, [��� ���������], count(*)[����������], sum(AUDITORIUM_CAPACITY) [��������� �����������] 
from (select top(30) case 
			when a.AUDITORIUM_NAME like '%-1' then '1'
			when a.AUDITORIUM_NAME like '%-2' then '2'
			when a.AUDITORIUM_NAME like '%-3' then '3'
			when a.AUDITORIUM_NAME like '%-4' then '4'
			when a.AUDITORIUM_NAME like '%-5' then '5'
			else '---'
		end [������], 
		a.AUDITORIUM_TYPE [��� ���������],
		a.AUDITORIUM_CAPACITY
		from AUDITORIUM a order by ������) as T
group by rollup ( [��� ���������], ������, AUDITORIUM_CAPACITY) --group by cube AUDITORIUM.AUDITORIUM_TYPE
--
select AUDITORIUM.AUDITORIUM_TYPE,COUNT(AUDITORIUM.AUDITORIUM_CAPACITY)[����������],sum(AUDITORIUM.AUDITORIUM_CAPACITY)[��������� �����������] 
from AUDITORIUM
group by cube( AUDITORIUM.AUDITORIUM_TYPE)

