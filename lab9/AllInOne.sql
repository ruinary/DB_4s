use UNIVER

---1

exec sp_helpindex'AUDITORIUM' 
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'TEACHER'
exec sp_helpindex 'TIMETABLE'

drop table #t1

CREATE table  #t1
 (    TIND int,  
      TFIELD varchar(100) 
  );

set nocount on;
declare @i int = 0;
while @i<1001
begin
	insert #t1(TIND,TFIELD)
	values(rand() * 1000, REPLICATE('string ', 10));
	if (@i %100 =0)
	print @i;
	set @i=@i+1;
end;

select * from #t1 where TIND between 300 and 700 order by TIND

 checkpoint;  --�������� ��
 DBCC DROPCLEANBUFFERS;  --�������� �������� ���

 CREATE clustered index #indx on #t1(TIND asc) --�������� ����������������� ������ �������


 ---2
 drop table #t2


 CREATE table #t2
(    TKEY int, 
      CC int identity(1, 1),
      TF varchar(100)
)

  set nocount on;           
  declare @k int = 0;
  while   @k < 20000       
  begin
       INSERT #t2(TKEY, TF) values(floor(30000*RAND()), replicate('������ ', 10));
        set @k = @k + 1; 
  end;
  
  SELECT count(*)[���������� �����] from #t2;
  SELECT * from #t2

  SELECT * from  #t2 where  TKEY = 556 and  CC > 3

    CREATE index #EX_NONCLU on #t2(TKEY, CC) --�������� ���������� ��������������������� �������


---3


drop table #temp_table_2


create table #temp_table_2
(
	some_ind int, 
	some_field varchar(20),
	cc int identity(1,1)
)
SET nocount on;
DECLARE @j int = 0;
while @j < 30000
begin
	insert #temp_table_2(some_ind, some_field)
		values(FLOOR(RAND()*30000), REPLICATE('test2',3) );
	SET @j = @j + 1; 
end

select * from #temp_table_2 where cc >500 and some_ind between 1500 and 5000 

select CC, some_ind from #temp_table_2 where some_ind > 500

CREATE index #temp_table_2_nonclu_2 on #temp_table_2(some_ind) INCLUDE(cc) --�������� ���������������������� ������� ��������

---4

SELECT some_ind from  #temp_table_2 where some_ind between 5000 and 19999; --�� ������������ ��� ���������� � ����������
SELECT some_ind from  #temp_table_2 where some_ind>15000 and  some_ind < 20000  --�� ������������ ��� ���������� � ����������
SELECT some_ind from  #temp_table_2 where some_ind=16000 --������������ ��� ���������� � ����������, �.�. ��������� ��������

 CREATE  index #temp_table_WHERE on #temp_table_2(some_ind) where (some_ind>15000 and  some_ind  < 20000); --�������� ��������������������� ������� ����������
 drop index #temp_table_WHERE on #temp_table_2

 ---5

  use tempdb

 CREATE index #temp_table_2_ind  on #temp_table_2(some_ind); --�������� �������� ��������������������� �������

SELECT	name [������],
		avg_fragmentation_in_percent [������������(%)] 
	FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
  OBJECT_ID(N'#temp_table_2'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
  where name is not null;

INSERT top(200000) #temp_table_2(some_ind, some_field) select some_ind, some_field from #temp_table_2;

ALTER index #temp_table_2_ind on #temp_table_2 reorganize; 
ALTER index #temp_table_2_ind  on #temp_table_2 rebuild with (online = off);

drop index #temp_table_2_ind on #temp_table_2



---6

CREATE index #temp_table_2_ind1  on #temp_table_2(some_ind)
	with (fillfactor = 65);

INSERT top(50)percent into #temp_table_2(some_ind, some_field) 
select some_ind, some_field  from #temp_table_2; 


use tempdb


SELECT name [������], avg_fragmentation_in_percent [������������(%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#temp_table_2'), NULL, NULL, NULL) ss
       JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
       where name is not null;

drop index #temp_table_2_ind1 on #temp_table_2


drop table #temp_table_2


---7

use A_MyBase


exec sp_helpindex'���������' 
exec sp_helpindex '������'
exec sp_helpindex '������'


drop index #cnt on ������
drop index #i1 on ������
drop index #i2 on ������
drop index #i3 on ������

select * from ������ order by ����������_�����������_������

create index #cnt  on ������(����������_�����������_������)

select ����������_�����������_������,�����_������ from ������
create index #i1 on ������(����������_�����������_������,�����_������ )

create index #i2 on ������(����������_�����������_������) include (�����_������)

select �����_������ from ������ where �������� = 'kfc'
create index #i3 on ������(��������) where �������� = 'kfc'


SELECT name [������], avg_fragmentation_in_percent [������������(%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'A_MyBase'), OBJECT_ID(N'������'), NULL, NULL, NULL) ss
       JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
       where name is not null;


