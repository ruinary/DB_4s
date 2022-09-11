use UUNIVER;
go 
	create trigger PTran 
	on PULPIT after INSERT, DELETE, UPDATE  
	as declare @c int = (select count (*) from PULPIT); 	 
	 if (@c >26) 
	 begin
       raiserror('Общая количество кафедр не может быть >26', 10, 1);
	 rollback; 
	 end; 
	 return;          

	insert into PULPIT(PULPIT) values ('ТТПЛ')