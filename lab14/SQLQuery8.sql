use UNIVER;
	go 
	create trigger F_INSTEAD_OF 
	on FACULTY instead of DELETE 
	as 
raiserror(N'�������� ���������', 10, 1);
	return;

	 delete FACULTY where FACULTY = '����'

	 drop trigger F_INSTEAD_OF
	 drop trigger PTran
	 drop trigger TR_TEACHER
	 drop trigger TR_TEACHER_DEL

go