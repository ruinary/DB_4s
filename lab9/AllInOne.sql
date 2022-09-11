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

 checkpoint;  --фиксация БД
 DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

 CREATE clustered index #indx on #t1(TIND asc) --создание кастеризировнного просто индекса


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
       INSERT #t2(TKEY, TF) values(floor(30000*RAND()), replicate('строка ', 10));
        set @k = @k + 1; 
  end;
  
  SELECT count(*)[количество строк] from #t2;
  SELECT * from #t2

  SELECT * from  #t2 where  TKEY = 556 and  CC > 3

    CREATE index #EX_NONCLU on #t2(TKEY, CC) --создание составного некластеризированного индекса


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

CREATE index #temp_table_2_nonclu_2 on #temp_table_2(some_ind) INCLUDE(cc) --создание неклластеризированного индекса покрытия

---4

SELECT some_ind from  #temp_table_2 where some_ind between 5000 and 19999; --не используется при сортировке и фильтрации
SELECT some_ind from  #temp_table_2 where some_ind>15000 and  some_ind < 20000  --не используется при сортировке и фильтрации
SELECT some_ind from  #temp_table_2 where some_ind=16000 --используется при сортировке и фильтрации, т.к. фиксируем значение

 CREATE  index #temp_table_WHERE on #temp_table_2(some_ind) where (some_ind>15000 and  some_ind  < 20000); --создание некластеризированного индекса фильтрации
 drop index #temp_table_WHERE on #temp_table_2

 ---5

  use tempdb

 CREATE index #temp_table_2_ind  on #temp_table_2(some_ind); --создание простого некластеризированного индекса

SELECT	name [Индекс],
		avg_fragmentation_in_percent [Фрагментация(%)] 
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


SELECT name [индекс], avg_fragmentation_in_percent [фрагментация(%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#temp_table_2'), NULL, NULL, NULL) ss
       JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
       where name is not null;

drop index #temp_table_2_ind1 on #temp_table_2


drop table #temp_table_2


---7

use A_MyBase


exec sp_helpindex'Заказчики' 
exec sp_helpindex 'Заказы'
exec sp_helpindex 'Товары'


drop index #cnt on Заказы
drop index #i1 on Заказы
drop index #i2 on Заказы
drop index #i3 on Заказы

select * from Заказы order by Количество_заказанного_товара

create index #cnt  on Заказы(Количество_заказанного_товара)

select Количество_заказанного_товара,Номер_заказа from Заказы
create index #i1 on Заказы(Количество_заказанного_товара,Номер_заказа )

create index #i2 on Заказы(Количество_заказанного_товара) include (Номер_заказа)

select Номер_заказа from Заказы where Заказчик = 'kfc'
create index #i3 on Заказы(Заказчик) where Заказчик = 'kfc'


SELECT name [индекс], avg_fragmentation_in_percent [фрагментация(%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'A_MyBase'), OBJECT_ID(N'Заказы'), NULL, NULL, NULL) ss
       JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
       where name is not null;


