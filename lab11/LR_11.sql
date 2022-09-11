use master;

--1

set nocount on
if  exists (select * from  SYS.OBJECTS where OBJECT_ID= object_id(N'DBO.MyTable') )	     
	drop table MyTable;        

declare @c int, @flag char = 'r';           
SET IMPLICIT_TRANSACTIONS  ON
	
CREATE table MyTable(
ID int identity(1,1), 
word nvarchar(20)
);                         

INSERT MyTable values ('Яблоко'),('Груша'),('Стол');
set @c = (select count(*) from MyTable);
print 'количество строк в таблице MyTable: ' + cast( @c as varchar(2));
if @flag = 'c' commit;
else rollback; 
SET IMPLICIT_TRANSACTIONS  OFF   

if  exists (select * from  SYS.OBJECTS where OBJECT_ID= object_id(N'DBO.MyTable') )
	print 'таблица MyTable есть'; 
	else print 'таблицы MyTable нет';
--2
use UNIVER;

begin try
	begin tran
		delete AUDITORIUM where AUDITORIUM_NAME = '311-1';
		insert into AUDITORIUM values('311-1','ЛБ-К','15','311-1');
		update AUDITORIUM set AUDITORIUM_CAPACITY = '30' where AUDITORIUM_NAME='311-1';
		print 'Транзакция прошла успешно'; 
	commit tran;
end try
begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0 rollback tran;
end catch;
--3
use UNIVER;

DECLARE @savepoint varchar(30);
begin try
	begin tran
		set @savepoint = 'save1'; save tran @savepoint;
		delete AUDITORIUM where AUDITORIUM_NAME = '311-1';									
		set @savepoint = 'save2'; save tran @savepoint;
		insert into AUDITORIUM values('311-1','ЛБ-К','15','311-1');							
		set @savepoint = 'save3'; save tran @savepoint;
		update AUDITORIUM set AUDITORIUM_CAPACITY = 30 where AUDITORIUM_NAME='311-1';		
		print 'Транзакция прошла успешно'; 
	commit tran;
end try
begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0
		begin
			print 'Контрольная точка: ' + @savepoint;
			rollback tran @savepoint;
			commit tran;
		end;
end catch;	
--8
-----@@TRANCOUNT-----вложенные транзакции
SELECT COUNT(*) '1', @@TRANCOUNT 'TRANCOUNT' FROM AUDITORIUM;
BEGIN TRANSACTION A;

INSERT INTO AUDITORIUM values('311-1','ЛК','60','311-1');
SELECT COUNT(*) '2', @@TRANCOUNT 'TRANCOUNT' FROM AUDITORIUM;

BEGIN TRANSACTION B
DELETE AUDITORIUM WHERE AUDITORIUM ='311-1';
SELECT COUNT(*) '3', @@TRANCOUNT 'TRANCOUNT' FROM AUDITORIUM;

COMMIT TRANSACTION B;
SELECT COUNT(*) '4', @@TRANCOUNT 'TRANCOUNT' FROM AUDITORIUM;

INSERT INTO AUDITORIUM values('311-1','ЛК','60','311-1');
SELECT COUNT(*) '5', @@TRANCOUNT 'TRANCOUNT' FROM AUDITORIUM;

COMMIT TRANSACTION A;
SELECT COUNT(*) '6', @@TRANCOUNT 'TRANCOUNT' FROM AUDITORIUM;
--9
/* 
	Уровень изолированности SERIALIZABLE подойдёт для транзакций получения данных 
из таблицы ЗАКАЗАННЫЕ_ТОВАРЫ, ЗАКАЗЫ ведь возможность ошибочного чтения информации при выполнении пользователем 
заказа должна быть сведена к минимуму.
	Уровень изолированности REPEATABLE READ подойдёт для транзакций получения данных
из таблиц ТОВАРЫ, так как возможность чтения незафиксированных данных не несёт фатальных
ошибок при работе с подобными базами данных для магазина.
	Уровень изолированности READ COMMITED не допускает неподтверждённого чтения.
Подойдёт для таблицы типа ИЗБРАННЫЕ_ТОВАРЫ,так как получение данных об избранных
товарах со стороны пользователя не может привести к ошибочным действиям при оформлении заказа,
а лишь при его выборе в процессе пользования, к примеру, интернет-магазина 
*/
go


use АртёмПРОДАЖИ;

--1
set nocount on
if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
drop table X;   

declare @c int, @flag char = 'c';           -- commit или rollback?
SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
CREATE table X(K int );                         -- начало транзакции 
	INSERT X values (1),(2),(3);
	set @c = (select count(*) from X);
	print 'количество строк в таблице X: ' + cast( @c as varchar(2));
	if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
	else   rollback;                                 -- завершение транзакции: откат  
SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
	
if  exists (select * from  SYS.OBJECTS       -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )
print 'таблица X есть';  
else print 'таблицы X нет'

--2
use АртёмПРОДАЖИ;
select * from ТОВАРЫ;

begin try				--начало явной транзакции 
begin tran
		delete ТОВАРЫ where Наименование = 'Стол'
--		delete ТОВАРЫ where Наименование = 'Телевизор'
		insert ТОВАРЫ values	('Стол', 60, 30),
								('Телевизор', 500, 5);
		print 'Транзакция прошла успешно'; 
	commit tran;		--фиксация транзакции
end try
begin catch
	print 'ОШИБКА: ' + case	when error_number()=2627
		then 'дублирование товара'
		else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;

--3
declare @point varchar(32);
begin try
	begin tran
		delete ТОВАРЫ where Наименование = 'Стол';
		set @point = 'p1'; save tran @point;
		insert ТОВАРЫ  values	('Стол', 60, 30);
		set @point = 'p2'; save tran @point;
		insert ТОВАРЫ  values	('Телевизор', 500, 5);
	commit tran;
end try
begin catch
	print 'ОШИБКА: ' + case when error_number()=2627
		then 'дублирование товара'
		else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0
		begin 
			print 'контрольная точка: ' + @point;
			rollback tran @point;				--откат к контрольной точке
			commit tran;			--фиксация изменений, выполненных до контрольной точки
		end
end catch;

--4
--- A ---
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert Товары' 'результат', * 
	from Товары where Наименование = 'Блокнот';
	select @@SPID, 'update Заказы'  'результат',  
	Наименование_товара, Цена_продажи 
	from Заказы   where Наименование_товара = 'Блокнот';
	commit; 
	-------------------------- t2 -----------------
--- B ---	
	begin transaction 
	select @@SPID
	insert Товары values ('Блокнот', 2, 80); 
	update Заказы set Наименование_товара  =  'Блокнот' 
                           where Наименование_товара = 'Стол' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;

--5
--- A ---
select * from ЗАКАЗЫ;

    set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from Заказы where Наименование_товара = 'Диван';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update Заказы'  'результат', count(*)
	from ЗАКАЗЫ  where Наименование_товара = 'Диван';
	commit; 

--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
    update ЗАКАЗЫ set Наименование_товара = 'Диван' where Наименование_товара = 'Шкаф'
--	update ЗАКАЗЫ set Наименование_товара = 'Шкаф' where Цена_продажи = 340
    commit; 
	-------------------------- t2 --------------------	

--6
-- A ---
    set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select Заказчик from ЗАКАЗЫ where Наименование_товара = 'Маркер';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case when Заказчик = 'Луч' 
		then 'insert  Заказы'  
		else ' ' 
	end 'результат', Заказчик from Заказы  where Наименование_товара = 'Маркер';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert ЗАКАЗЫ values (12,  'Маркер',  78,  10,  '01.12.2014',  'Луч');
          commit; 
	-------------------------- t2 --------------------

--7
--- A ---
    set transaction isolation level SERIALIZABLE 
	begin transaction 
	delete Заказы where Заказчик = 'Луч';  
          insert Заказы values (14, 'Стул', 78,  10,  '01.12.2014', 'Луч');
          update Заказы set Заказчик = 'Луч' where Наименование_товара = 'Стул';
          select  Заказчик from Заказы  where Наименование_товара = 'Стул';
	-------------------------- t1 -----------------
	select  Заказчик from Заказы  where Наименование_товара = 'Стул';
	-------------------------- t2 ------------------ 
	commit; 	

	--- B ---	
	begin transaction 	  
	delete Заказы where Заказчик = 'Луч';  
          insert Заказы values (14, 'Стул', 78,  10,  '01.12.2014', 'Луч');
          update Заказы set Заказчик = 'Луч' where Наименование_товара = 'Стул';
          select  Заказчик from Заказы  where Наименование_товара = 'Стул';
          -------------------------- t1 --------------------
          commit; 
          select  Заказчик from Заказы  where Наименование_товара = 'Стул';
      -------------------------- t2 --------------------
