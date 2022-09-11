USE master;

CREATE database A_MyBASE
on primary 
(name= N'MYBASE_mdf', filename = N'D:\study\2 ����\��\lab3\MYBASE_mdf.mdf', size= 10240Kb, maxsize = unlimited, filegrowth = 1024Kb),

filegroup fg1
(name= N'MYBASE_fg1_1', filename = N'D:\study\2 ����\��\lab3\MYBASE_fgq-1.ndf', size= 10240Kb, maxsize = 1Gb, filegrowth = 25%),
(name= N'MYBASE_fg1_2', filename = N'D:\study\2 ����\��\lab3\MYBASE_fqg-2.ndf', size= 10240Kb, maxsize = 1Gb, filegrowth = 25%)
log on
(name= N'MYBASE_log', filename = N'D:\study\2 ����\��\lab3\MYBASE_log.ldf', size= 10240Kb, maxsize = 2048Gb, filegrowth =10% )


use A_MyBASE;

CREATE TABLE ���������
	(   ������������_����� nvarchar(20) primary key,
	    ����� nvarchar(50),
	    ������� nvarchar(10),
		����������_���� nvarchar(20),
           ) on FG1 ;

CREATE TABLE ������
	(   ������������_������ nvarchar(20) primary key,
	    ���� money,
	    �������� text,
           ) ;

CREATE TABLE ������
	(   �����_������ int primary key,
	    �������� nvarchar(20) foreign key references ���������(������������_�����),
	    ����������_����� nvarchar(20) foreign key references ������(������������_������),
		����������_�����������_������ int,
		����_�������� date,
           ) ;


ALTER TABLE ������ ADD ���_�������� nvarchar(10) default '������' check (���_�������� in ('������','�������'));

ALTER TABLE ������ DROP Column ����_��������;


INSERT into ���������(������������_�����, �����, �������, ����������_����)
	Values ('kfc', 'kirova 2', '1285589', '�������1'),
		   ('bk', 'sverdlova 15', '552563', '�������2');
Insert into ������(������������_������, ����, ��������)
	values ('stol', 90, 'jobijtrijifjvcfrgk jhbdfue uvsdueyr3e evfg'),
			('stul', 12, 'lekjg ejfue xggw hu hyd ');
insert into ������ (�����_������, ��������, ����������_�����, ����������_�����������_������)
	values (1, 'kfc', 'stul', 20);


select * from ���������;
select �����, ������� from ���������;
select count(*) from ������;
select ������������_������ from ������ where ���� < 40;
select distinct top(1) *from ������;

update ������ set ���� = ����+1 Where ������������_������ = 'stol';
select ����, ������������_������ from  ������ where  ������������_������= 'stol';

select ������������_������ From ������ where ������������_������ like 's%'
select ����, ������������_������ from  ������ where ���� between 11 and 100;
select ����, ������������_������ from  ������ where ���� in (5, 94);



