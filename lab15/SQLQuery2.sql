use UUNIVER;

go
select	   AUDITORIUM.AUDITORIUM			[���������],
           AUDITORIUM.AUDITORIUM_TYPE		[�������������_����],
		   AUDITORIUM.AUDITORIUM_CAPACITY	[�����������] 
		   from AUDITORIUM join AUDITORIUM_TYPE
		     on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
	where AUDITORIUM.AUDITORIUM_TYPE = '��' for xml AUTO, root('������_���������'), elements;

