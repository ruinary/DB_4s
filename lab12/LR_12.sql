-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 1
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use UNIVER;
set nocount on;

select * from SUBJECT;
DROP PROCEDURE PSUBJECT;

go
create PROCEDURE PSUBJECT
as
begin
	select SUBJECT 'Код', SUBJECT_NAME 'Дисциплина', PULPIT 'Кафедра' from SUBJECT;
	declare @q int = (select count(*) from SUBJECT);
	return @q;
end;

declare @result int = 0
EXEC @result = PSUBJECT
print char(10) + 'Количество дисциплин:' + cast(@result as varchar(5));
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 2
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
ALTER PROCEDURE PSUBJECT @p varchar(20) = NULL, @c int output
as begin
	declare @k int = (select count(*) from SUBJECT);
	print 'параметры: @p = ' + @p + ', @c = ' + cast(@c as varchar(3));
	select * from SUBJECT where PULPIT = @p;
	set @c = @@rowcount;
	return @k;
end;

go
declare @result int = 0, @r int = 0, @n varchar(20) = 'ИСиТ';
EXEC @result = PSUBJECT @p=@n, @c = @r output;
print 'Количество дисциплин всего: ' + cast(@result as varchar(5));
print 'Количество дициплин кафедры ' + cast(@n as varchar(5)) + ' = ' + cast(@r as varchar(5));

DROP PROCEDURE PSUBJECT;
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 3
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use UNIVER;

DROP PROCEDURE PSUBJECT;
DROP TABLE #SUBJECT;
CREATE TABLE #SUBJECT
(
	Код			char(10)		not null,
	Дисциплина	varchar(100)			,
	Кафедра		char(20)		not null
);
go
create PROCEDURE PSUBJECT
as
begin
	select SUBJECT 'Код', SUBJECT_NAME 'Дисциплина', PULPIT 'Кафедра' from SUBJECT;
	declare @q int = (select count(*) from SUBJECT);
	return @q;
end;

go
alter PROCEDURE PSUBJECT @find_sub varchar(20)
as begin
	select SUBJECT 'Код', SUBJECT_NAME 'Дисциплина', PULPIT 'Кафедра' from SUBJECT where PULPIT= @find_sub;
	print 'параметры: @p = ' + @find_sub;
	declare @k int = (select count(*) from SUBJECT);
	return @k ;
end;

INSERT #SUBJECT exec PSUBJECT @find_sub = 'ЭТиМ';

SELECT * FROM #SUBJECT;

-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 4
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use UNIVER;

go
CREATE PROCEDURE PAUDITORIUM_INSERT @a char(20), @n varchar(50), @c int = 0, @t char(10)
as	declare @ret int = 1;

	begin try
		INSERT into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
			values(@a, @n, @c, @t);
		return  @ret;
	end try

	begin catch
		print 'Код ошибки: ' + cast(ERROR_NUMBER() as varchar(6));
		print 'Сообщение об ошибке: ' + ERROR_MESSAGE();
		print 'Строка ошибки: ' + cast(ERROR_LINE()as varchar(8));
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры ошибки: ' + ERROR_PROCEDURE();
		print 'Уровень серьёзности ошибки: ' + cast(ERROR_SEVERITY()as varchar(6));
		print 'Метка ошибки: ' + cast(ERROR_STATE()as varchar(8));
		return -1;
	end catch;

DECLARE @paud int = 0;
EXEC @paud = PAUDITORIUM_INSERT @a='423-1', @n='423-3', @c='90', @t='ЛБ-К';
SELECT * FROM AUDITORIUM;

DELETE AUDITORIUM where AUDITORIUM_NAME='423-3';
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 5
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use UNIVER;

go
CREATE PROCEDURE SUBJECT_REPORT @p CHAR(10)
as 
	declare @ret int = 0;
	begin try
		declare @subjects nvarchar(300) ='',@subject nvarchar(10);
		DECLARE  Sub_Report CURSOR LOCAL for
		select [SUBJECT] from [SUBJECT] where PULPIT = @p;
		if  not exists (select [SUBJECT] from [SUBJECT] where PULPIT = @p)
			raiserror('Ошибка', 11, 1);
		else
			open Sub_Report;
			fetch Sub_Report into @subject;
			set @subjects += '';
			while @@FETCH_STATUS = 0
				begin	
					set @subjects = RTRIM(@subject) + ' ' +@subjects;
					set @ret = @ret + 1;
					fetch Sub_Report into @subject;
				end;
			print char(10) + 'Дисциплины кафедры ' + @p;
			print @subjects;
			close Sub_Report;
			return @ret;
	end try

	begin catch
		print 'Ошибка в параметрах.'
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры:' + error_procedure();
		return @ret;
	end catch;

DECLARE @res_rep int;

exec @res_rep = SUBJECT_REPORT @p = 'ИСиТ';
print 'Количество дисциплин: ' + cast(@res_rep as varchar(3));

exec @res_rep = SUBJECT_REPORT @p = 'ЭТиМ';
print 'Количество дисциплин: ' + cast(@res_rep as varchar(3));

DROP PROCEDURE SUBJECT_REPORT;
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 6
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
use UNIVER;

go
CREATE PROCEDURE PAUDITORIUM_INSERT_X @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn varchar(50)
as	declare @ret int = 1;

	begin try
		set transaction isolation level SERIALIZABLE;
			begin tran
				INSERT into AUDITORIUM_TYPE
					values(@t, @tn);
				EXEC PAUDITORIUM_INSERT @a=@a, @n=@n, @c=@c, @t=@t;
			commit tran;
			return  @ret;
	end try

	begin catch
		print 'Код ошибки: ' + cast(ERROR_NUMBER() as varchar(6));
		print 'Сообщение об ошибке: ' + ERROR_MESSAGE();
		print 'Строка ошибки: ' + cast(ERROR_LINE()as varchar(8));
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры ошибки: ' + ERROR_PROCEDURE();
		print 'Уровень серьёзности ошибки: ' + cast(ERROR_SEVERITY()as varchar(6));
		print 'Метка ошибки: ' + cast(ERROR_STATE()as varchar(8));
		if @@TRANCOUNT > 0 rollback tran;
		return -1;
	end catch;

DECLARE @paud int = 0;
EXEC @paud = PAUDITORIUM_INSERT_X @a='555-5',@n='555-5',@c='90',@t='Б-К', @tn ='Библиотека-компьютерный класс';

select * from AUDITORIUM_TYPE;
select * from AUDITORIUM;

DELETE AUDITORIUM where AUDITORIUM_NAME='555-5';
DELETE AUDITORIUM_TYPE where AUDITORIUM_TYPE='Б-К';
DROP PROCEDURE PAUDITORIUM_INSERT_X;
DROP PROCEDURE PAUDITORIUM_INSERT;
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--								ЗАДАНИЕ 1/2
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use АртёмПРОДАЖИ

set nocount on;
DROP PROCEDURE PrZakazy;
go
CREATE PROCEDURE PrZakazy		-- создание процедуры
as begin
	DECLARE @i int = (SELECT COUNT(*) FROM ЗАКАЗЫ);
	SELECT * FROM ЗАКАЗЫ;
	return @i;
end;

DECLARE @k int = 0;
EXEC @k = PrZakazy;		-- вызов процедуры
print 'Кол-во товаров = ' + cast(@k as varchar(3));

go
ALTER PROCEDURE PrZakazy @p varchar(20), @c int output
as begin
	declare @k int = (select count(*) from ЗАКАЗЫ);
	print 'параметры: @p = ' + @p + ', @c = ' + cast(@c as varchar(3));
	select * from ЗАКАЗЫ where Заказчик = @p;
	set @c = @@rowcount;
	return @k;
end;

go
declare @k int = 0, @r int = 0, @n nvarchar(20) = 'Гиппо';
exec @k = PrZakazy @p=@n, @c = @r output;
print 'Кол-во товаров всего = ' + cast(@k as varchar(3));
print 'Кол-во товаров, заказанных фирмой ' + cast(@n as varchar(5)) + ' = ' + cast(@r as varchar(3));
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--								ЗАДАНИЕ 3
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
alter procedure PrZakazy @p varchar(20)
as begin
	DECLARE @k INT = (select COUNT(*) from ЗАКАЗЫ);
	select * from ЗАКАЗЫ where Заказчик = @p;
end;
	
go
create table #Zk
(
	ORDER_NUM int primary key,
	ITEM_NAME nvarchar(50),
	PRICE real,
	QUAN int,
	DATE date,
	CUSTOMER nvarchar(50)
)

INSERT #Zk exec PrZakazy @p = 'Гиппо';
INSERT #Zk exec PrZakazy @p = 'Мартин';

select * from #Zk;
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--								ЗАДАНИЕ 4
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use АртёмПРОДАЖИ
go
create procedure TovaryInsert
					@t NVARCHAR(50), @cn REAL, @kl INT = null
as declare @rc int = 1;
begin try
	insert into dbo.TОВАРЫ(Наименование, Цена, Количество)
			values (@t, @cn, @kl)
	return @rc;
end try
begin catch
		print 'Код ошибки: ' + cast(ERROR_NUMBER() as varchar(6));
		print 'Сообщение об ошибке: ' + ERROR_MESSAGE();
		print 'Строка ошибки: ' + cast(ERROR_LINE()as varchar(8));
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры ошибки: ' + ERROR_PROCEDURE();
		print 'Уровень серьёзности ошибки: ' + cast(ERROR_SEVERITY()as varchar(6));
		print 'Метка ошибки: ' + cast(ERROR_STATE()as varchar(8));
		if @@TRANCOUNT > 0 rollback tran;
		return -1;
	end catch;
go
declare @rc int;  
exec @rc = TovaryInsert @t  = 'Помидор', @cn = 1, @kl = 90;  
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--								ЗАДАНИЕ 5
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use АртёмПРОДАЖИ
drop procedure ORDER_REPORT; 
go
CREATE PROCEDURE ORDER_REPORT @p CHAR(10)
as 
	declare @ret int = 0;
	begin try
		declare @subjects nvarchar(300) ='',@subject nvarchar(10);
		DECLARE  Sub_Report CURSOR LOCAL for
		select Наименование_товара from ЗАКАЗЫ where Заказчик = @p;
		if not exists (select Наименование_товара from ЗАКАЗЫ where Заказчик = @p)
			raiserror('Ошибка', 11, 1);
		else
			open Sub_Report;
			fetch Sub_Report into @subject;
			set @subjects += '';
			while @@FETCH_STATUS = 0
				begin	
					set @subjects = RTRIM(@subject) + ' ' +@subjects;
					set @ret = @ret + 1;
					fetch Sub_Report into @subject;
				end;
			print char(10) + 'Товары магазина ' + @p + ': ';
			print @subjects;
			close Sub_Report;
			return @ret;
	end try

	begin catch
		print 'Ошибка в параметрах.'
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры:' + error_procedure();
		return @ret;
	end catch;

DECLARE @res_rep int;
exec @res_rep = ORDER_REPORT @p = 'Гиппо';
print 'Количество товаров: ' + cast(@res_rep as varchar(3));
exec @res_rep = ORDER_REPORT @p = 'Мартин';
print 'Количество товаров: ' + cast(@res_rep as varchar(3));
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--								ЗАДАНИЕ 6
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use АртёмПРОДАЖИ
drop procedure TovaryInsert_X; 
go
create  procedure TovaryInsert_X
     @a int, @b NVARCHAR(50), @c REAL, @d INT = null, 
     @e date, @f NVARCHAR(50)   
as  declare @rc int=1;                            
begin try 
    set transaction isolation level SERIALIZABLE;          
    begin tran
	    exec @rc=TovaryInsert @b, @c, @d;  
    insert into ЗАКАЗЫ (Номер_заказа, Наименование_товара,  
         Цена_продажи, Количество, Дата_поставки, Заказчик)
                                               values (@a, @b, @c, @d, @e, @f)

    commit tran; 
    return @rc;           
end try
begin catch 
    print 'номер ошибки  : ' + cast(error_number() as varchar(6));
    print 'сообщение     : ' + error_message();
    print 'уровень       : ' + cast(error_severity()  as varchar(6));
    print 'метка         : ' + cast(error_state()   as varchar(8));
    print 'номер строки  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print 'имя процедуры : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go

declare @rc int;  
exec @rc = TovaryInsert_X @a = 17, @b = 'Пылесос', @c = 90,
@d =  2, @e =  '15.07.2014', @f = 'Белвест';  
print 'Операция прошла успешно' ;  
-------------
go
create procedure K
as
begin
select * FROM UNIVER.GROUPS;

end;

exec K;





















