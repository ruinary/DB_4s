use UUNIVER;

go
select PULPIT.FACULTY[���������/@���], TEACHER.PULPIT[���������/�������/@���], 
    TEACHER.TEACHER_NAME[���������/�������/�������������/@���]
	    from TEACHER inner join PULPIT
		    on TEACHER.PULPIT = PULPIT.PULPIT
			   where TEACHER.PULPIT = '����' for xml path, root('������_��������������_�������_����');


