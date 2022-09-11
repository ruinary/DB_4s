--1
declare @ch char(1) = 's',						-- сразу
		@varch varchar(15) = 'hello world',		-- сразу
		@date datetime,							-- set
		@time time(3),							-- set
		@int int,								-- select
		@sint smallint,							-- select
		@tint tinyint,							-- empty
		@num numeric(12,5),						-- select
		@capacity integer						-- select-запрос


set @date = getdate()
set @time = '12:30:15.123'

select @int = 1234
select @sint = 1
select @capacity = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM)
select @num = 124123.3213


print 'char:           ' + @ch
print 'varchar:        ' + @varch
print 'int:            ' + cast(@int as char)
print 'smallint:      ' + cast(@sint as char)
print 'numeric(12,5):  ' + cast(@num as char)

--select @date [Date], @time [Time], @capacity [Avg capacity], @tint [Empty]

--2
declare @total integer = (select sum(AUDITORIUM_CAPACITY) from AUDITORIUM),
		@count integer,
		@avg real,
		@countLess integer,
		@percent numeric (12,5)


print 'Total capacity: ' + cast(@total as char)
print '================================'

if @total > 200
begin
select @count = (select count(*) from AUDITORIUM)
select @avg  =  (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM)
select @countLess = (select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY < @avg)
select @percent = cast(@countLess as real) / cast(@count as real)

print 'Count of auditoriums:    ' + cast (@count as char)
print 'Average capacity:        ' + cast (@avg as char)
print 'Count of less than avg:  ' + cast (@countLess as char)
print 'Percent of them:         ' + cast (@percent as char)
end


else 
print 'Total capacity: ' + cast(@total as char)

--3
print '========================================================================='
print '                                ВЕРСИЯ'
print @@VERSION
print '========================================================================='

print 'Server Name: ' + cast(@@SERVERNAME as char)
print 'Process ID: ' + cast(@@SPID as char)
print 'Rows count: ' + CAST(@@ROWCOUNT as char)
print 'Last error ID: ' + cast(@@ERROR as char)
print 'Transaction Level: ' + cast(@@TRANCOUNT as char)
print 'Fetch status: ' + cast(@@FETCH_STATUS as char)
print 'Current operation Level: ' + cast(@@NESTLEVEL as char)
print '========================================================================='

--4.1
declare @z numeric(5, 3), @t float, @x float, @sin numeric(5, 3), @4tx numeric(5, 3), @1ex numeric(5, 3)
set @t = 13
set @x = 2.1	

if (@t > @x) 
	set @z = sin(@t) * sin(@t)
else if (@t < @x)
	set @z = 4 * (@t + @x)
else 
	set @z = 1 - exp(@x - 2)

print 'z = ' + cast(@z as char)

--4.2
declare @fullFIO varchar(100) = (select top 1 NAME from STUDENT where NAME like 'Хартанович%')
print 'Полное ФИО:        ' + @fullFIO
declare @shortFIO varchar(100) = substring(@fullFIO, 0, charindex(' ', @fullFIO) + 1) 
+ substring(@fullFIO, charindex(' ', @fullFIO) + 1, 1) + '. '
+ substring(@fullFIO, charindex(' ', @fullFIO, charindex(' ', @fullFIO) + 1) + 1, 1) + '.'
print 'Сокращённое ФИО:   ' + @shortFIO

--4.3
declare @student table (ФИО varchar(100), [День рождения] varchar(50), Возраст integer)

declare @name varchar(100) = (select top 1 s.NAME from STUDENT s where month(s.BDAY) = month(getdate()) + 1)
declare @bday varchar(100) = (select top 1 s.BDAY from STUDENT s where month(s.BDAY) = month(getdate()) + 1)
declare @age int = datediff(year, @bday, getdate())
insert @student values(@name, @bday, @age)

declare @bday2 varchar(100) = (select top 1 s.BDAY from STUDENT s where month(s.BDAY) = month(getdate()) + 1 order by s.IDSTUDENT desc)
declare @name2 varchar(100) = (select top 1 s.NAME from STUDENT s where s.BDAY = @bday2)
declare @age2 int = datediff(year, @bday2, getdate())
insert @student values(@name2, @bday2, @age)

select * from @student

--4.4
declare @group integer = 1
declare @dow date
set @dow = (select top 1 p.PDATE from PROGRESS p 
join STUDENT s on s.IDSTUDENT = p.IDSTUDENT
where s.IDGROUP = @group and p.SUBJECT = 'ОАиП')
print @dow

--4.5
declare @idgr integer = 6 --1
declare @count integer = (select count(*) from STUDENT where IDGROUP = @idgr)
declare @avg numeric(5,2)

if (@count > 5)
begin
set @avg = (select avg (cast (p.NOTE as int)) from STUDENT s join PROGRESS p on s.IDSTUDENT = p.IDSTUDENT)
print 'Средний балл в ' + cast(@idgr as varchar) + ' группе — ' + cast(@avg as varchar)
end
else 
print 'Кол-во учеников в ' + cast(@idgr as varchar) + ' группе — ' + cast(@count as varchar) + ' человек.'

--5
declare @idgr integer = 6 --1
declare @count integer = (select count(*) from STUDENT where IDGROUP = @idgr)
declare @avg numeric(5,2)

if (@count > 5)
begin
set @avg = (select avg (cast (p.NOTE as int)) from STUDENT s join PROGRESS p on s.IDSTUDENT = p.IDSTUDENT)
print 'Средний балл в ' + cast(@idgr as varchar) + ' группе — ' + cast(@avg as varchar)
end
else 
print 'Кол-во учеников в ' + cast(@idgr as varchar) + ' группе — ' + cast(@count as varchar) + ' человек.'

--6
select PROGRESS.IDSTUDENT [Студент],
	case
		when NOTE between 9 and 10 then 'отлично'
		when NOTE between 6 and 8 then 'хорошо'
		when NOTE between 4 and 5 then 'плохо'
		else 'пересдача'
	end Результат
from PROGRESS

group by PROGRESS.IDSTUDENT,
	case 
		when NOTE between 9 and 10 then 'отлично'
		when NOTE between 6 and 8 then 'хорошо'
		when NOTE between 4 and 5 then 'плохо'
		else 'пересдача'
	end 

--7
drop table #temp
create table #temp (tid integer, tstr varchar(20), tnum numeric(10,3))

declare @i int = 0
while (@i < 10)
begin
insert into #temp values(@i, 'Запись №' + cast(@i as varchar), 100*rand())
set @i = @i + 1
end

select * from #temp

--8
declare @i int = 1

while @i < 100
begin
print @i
set @i = @i * 2
if (@i > 50)
	return
end

--9
begin try
declare @i int = 1
set @i = @i / 0
end try

begin catch
print 'ERROR!'
print 'Error number:    ' + cast(ERROR_NUMBER() as varchar)
print 'Error severity:  ' + cast(ERROR_SEVERITY() as varchar)
print 'Error line:      ' + cast(ERROR_LINE() as varchar)
print 'Error state:     ' + cast(ERROR_STATE() as varchar)
print 'Error message:   ' + cast(ERROR_MESSAGE() as varchar)
end catch