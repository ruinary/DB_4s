USE master;

CREATE database UNIVER


use UNIVER;

------------�������� � ���������� ������� AUDITORIUM_TYPE 

create table AUDITORIUM_TYPE 

(
    AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
    AUDITORIUM_TYPENAME  varchar(30),       
 );

insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )       
 values ('��',  '����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         
values ('��-�',  '������������ �����');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         
values ('��-�',  '���������� � ���. ����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          
values  ('��-X',  '���������� �����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        
values  ('��-��', '����. ������������ �����');
                      





-------------�������� � ���������� ������� AUDITORIUM  
  create table AUDITORIUM 

(
   AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
   AUDITORIUM_TYPE     char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
   AUDITORIUM_CAPACITY  int constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- ����������� 
   AUDITORIUM_NAME      varchar(50)                                     
);


insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('301-1', '��-�', 15, '301-1');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('304-4', '��-�', 90, '304-4');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('313-1', '��-�', 60, '313-1');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('314-4', '��', 90, '314-4');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('320-4', '��', 90, '320-4');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('324-1', '��-�', 50, '324-1');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('413-1', '��-�', 15, '413-1');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('423-1', '��-�', 90, '423-1');



  ------�������� � ���������� ������� FACULTY
  create table FACULTY
  (   
       FACULTY      char(10)   constraint  FACULTY_PK primary key,
       FACULTY_NAME  varchar(50) default '???'
  );

insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('����',   '���������� ���������� � �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('��',     '����������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('���',     '���������-������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('����',    '���������� � ������� ������ ��������������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('���',     '���������� ������������ �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('��',     '��������� �������������� ����������');  





------�������� � ���������� ������� PROFESSION
   create table PROFESSION
  (  
       PROFESSION   char(20) constraint PROFESSION_PK  primary key,
       FACULTY    char(10) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
       PROFESSION_NAME varchar(100),    
       QUALIFICATION   varchar(50)  
  );  
                   
 insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-36 06 01', '����',   '��������������� ������������ � ������� ��������� ����������', '�������-��������������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-36 07 01', '����',   '������ � �������� ���������� ����������� � ����������� ������������ ����������', '�������-�������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-40 01 02', '��',   '�������������� ������� � ����������', '�������-�����������-�������������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-46 01 01', '����',   '�������������� ����', '�������-��������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-47 01 01', '����',   '������������ ����', '��������-��������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-48 01 02', '���',   '���������� ���������� ������������ �������, ���������� � �������', '�������-�����-��������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-48 01 05', '���',   '���������� ���������� ����������� ���������', '�������-�����-��������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-54 01 03', '���',   '������-���������� ������ � ������� �������� �������� ���������', '������� �� ������������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-75 01 01', '���',   '������ ���������', '������� ������� ���������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-75 02 01', '���',   '������-�������� �������������', '������� ������-��������� �������������' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-89 02 02', '���',   '������ � ������������������', '���������� � ����� �������' );

 


 ------�������� � ���������� ������� PULPIT
  create table  PULPIT 
(   
    PULPIT   char(20)  constraint PULPIT_PK  primary key,
    PULPIT_NAME  varchar(100), 
    FACULTY   char(10)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
);

insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('���', '�����������-������������ ���������� ','����' );
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('������', '����������, �������������� �����, ������� � ������','���');          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('���', '���������� �������������������� �����������','����');           
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
  values  ('�����', '���������� � ������� ������� �� ���������','����');                
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('���', '������� � ������������������','���') ;
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('��', '���������� ����','����');              
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('�������','���������� �������������� ������� � ����� ���������� ����������','����')  ;        
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('��������', '���������� ���������������� ������� � ����������� ���������� ����������', '���');                          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('���','���������� ����������� ���������','���')  ;
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('��������','�����, ���������� ���������������� ����������� � ���������� ����������� �������', '����');   
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('����','������������� ������ � ����������','���');  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('����', '�������������� ������ � ���������� ','��'  )  ;
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('����', '����������� ����������� �������������� ���������� ','��'  )  ;    



------�������� � ���������� ������� TEACHER
 create table TEACHER
 (   
     TEACHER    char(10)  constraint TEACHER_PK  primary key,
     TEACHER_NAME  varchar(100), 
     GENDER     char(1) CHECK (GENDER in ('�', '�')),
     PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 );
 

insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������ ������ ����������', '�',  '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '���������� ������� ��������', '�',  '��������');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '�������� ����� ����������', '�',  '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������ ������ ��������', '�',  '��');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������� ������ ����������', '�',  '��');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������� ������� ����������', '�',  '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������ �������� �������������', '�',  '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������ ����� ��������', '�',  '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',    '������� ���� ����������', '�',  '���');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',    '����� ������ ���������', '�',  '����');





------�������� � ���������� ������� SUBJECT
create table SUBJECT
    (     
           SUBJECT  char(10) constraint SUBJECT_PK  primary key, 
           SUBJECT_NAME varchar(100) unique,
           PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)   
     );

 insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('����',   '������� ���������� ������ ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT)
                       values ('��',     '���� ������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '�������������� ����������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������ �������������� � ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('��',     '������������� ������ � ������������ ��������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '���������������� ������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������������� ������ ��������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '�������������� �������������� ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('��',      '������������ ��������� ','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
           values ('�����',   '��������. ������, �������� � �������� �����', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '������������ �������������� �������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('���',     '����������� ��������. ������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT)
                       values ('��',   '���������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                      values ('��',   '�������������� ����������������','����');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
               values ('����', '���������� ������ ���',  '����');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
               values ('���',  '��������-��������������� ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��', '��������� ������������������','����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��', '������������� ������','����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('���',    '���������� ��������� �������','��������') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('����',   '���������� � ������������ �������������', '�����') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('���',    '���������� ������������','��������')               
 

------�������� � ���������� ������� GROUPS
create table GROUPS 

(   
    IDGROUP  integer  identity(1,1) constraint GROUP_PK  primary key,              
    FACULTY   char(10) constraint  GROUPS_FACULTY_FK foreign key         
                                                         references FACULTY(FACULTY), 
     PROFESSION  char(20)  constraint  GROUPS_PROFESSION_FK foreign key         
                                                         references PROFESSION(PROFESSION),
    YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  )


insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('��','1-40 01 02', 2013) --1
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('��','1-40 01 02', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('��','1-40 01 02', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('��','1-40 01 02', 2010)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('��','1-40 01 02', 2013)---5 ��
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values   ('��','1-40 01 02', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('��','1-40 01 02', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('��','1-40 01 02', 2010)-----8 ��
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('��','1-40 01 02', 2013)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('��','1-40 01 02', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('��','1-40 01 02', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-36 07 01', 2013)---12 ��    
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-36 07 01', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-36 07 01', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-36 07 01', 2010)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('���','1-48 01 02', 2012) ---16 ��
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('���','1-48 01 02', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('���','1-48 01 05', 2013)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-46 01 01', 2013)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-46 01 01', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-46 01 01', 2012)--27 ��
                  
                          


------�������� � ���������� ������� STUDENT
create table STUDENT 
(   
      IDSTUDENT   integer  identity(1,1) constraint STUDENT_PK  primary key,
      IDGROUP   integer  constraint STUDENT_GROUP_FK foreign key         
                      references GROUPS(IDGROUP),        
      NAME   nvarchar(100), 
      BDAY   date,
      STAMP  timestamp,
      INFO     xml,
      FOTO     varbinary
 ) ;


insert into STUDENT (IDGROUP, NAME, BDAY)
        values (1, '���������� ��������� �������������', '11.03.1995'),        
          (1, '������ ��������� �������',    '07.12.1995'),
           (1, '������ �������� ����������',  '12.10.1995'),
           (1, '����� ��������� ���������',   '08.01.1995'),
           (1, '����� ����� ��������',  '02.08.1995')       
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (12, '����� ������� ��������',         '12.07.1994'),
           (10, '������� �������� ����������',    '06.03.1994'),
           (11, '�������� ����� �����������',     '09.11.1994'),
           (15, '������� ����� ���������',        '04.10.1994'),
           (8, '��������� ��������� ����������', '08.01.1994'),
           (8, '������� ������ ���������',       '02.08.1993'),
           (7, '������� ��� ����������',         '07.12.1993'),
           (7, '������� ����� �����������',      '02.12.1993'),
           (1, '������� ������ �����������',     '08.03.1992'),
           (1, '������� ����� �������������',    '02.06.1992'),
           (1, '�������� ����� �����������',     '11.12.1992'),
           (2, '�������� ������� �������������', '11.05.1992'),
           (2, '����������� ������� ��������',   '09.11.1992'),
           (2, '�������� ������� ����������',    '01.11.1992'),
           (3, '�������� ����� ������������',    '08.07.1995'),
           (3, '������ ������� ����������',      '02.11.1995'),
           (3, '������ ��������� �����������',   '07.05.1995'),
           (3, '����� ��������� ���������',      '04.08.1995'),
           (4, '���������� ����� ����������',    '08.11.1994'),
           (4, '�������� ������ ��������',       '02.03.1994'),
           (4, '���������� ����� ����������',    '04.06.1994'),
           (4, '��������� ���������� ���������', '09.11.1994'),
           (4, '����� ��������� �������',        '04.07.1994'),
           (5, '����������� ����� ������������', '03.01.1993'),
           (5, '������� ���� ��������',          '12.09.1993'),
           (5, '��������� ������ ��������',      '12.06.1993'),
           (5, '���������� ��������� ����������','09.02.1993'),
           (5, '������� ������ ���������',       '04.07.1993'),
           (5, '������ ������� ���������',       '08.01.1992'),
           (6, '��������� ����� ����������',     '12.05.1992'),
           (6, '�������� ����� ����������',      '08.11.1992'),
           (6, '������� ������� ���������',      '12.03.1992'),
           (6, '�������� ����� �������������',   '10.08.1995'),
           (6, '���������� ������ ��������',     '02.05.1995'),
           (7, '������ ������� �������������',   '08.01.1995'),
           (9, '��������� ��������� ��������',   '11.09.1995'),
           (21, '������ ������� ������������',   '08.01.1994'),
           (18, '������ ������ ����������',      '11.09.1994'),
           (10, '����� ���� �������������',      '06.04.1994'),
           (10, '������� ������ ����������',     '12.08.1994')
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (12, '��������� ��������� ����������','07.11.1993'),
           (13, '������ ������� ����������',     '04.06.1993'),
           (15, '������� ����� ����������',      '10.12.1993'),
           (15, '������� ������ ����������',     '04.07.1993'),
           (15, '������� ����� ���������',       '08.01.1993'),
           (15, '����� ������� ����������',      '02.09.1993'),
           (16, '���� ������ �����������',       '11.12.1995'),
           (17, '������� ���� �������������',    '10.06.1995'),
           (8, '��������� ���� ���������',      '09.08.1995'),
           (9, '����� ����� ���������',         '04.07.1995'),
           (10, '��������� ������ ����������',   '08.03.1995'),
           (11, '����� ����� ��������',          '12.09.1995'),
           (11, '������ ����� ������������',     '08.10.1994'),
           (12, '���������� ����� ����������',   '10.02.1994'),
           (13, '�������� ������� �������������','11.11.1994'),
           (14, '���������� ����� ����������',   '10.02.1994'),
           (15, '����������� ����� ��������',    '12.01.1994'),
           (16, '�������� ������� �������������','11.09.1993'),
           (16, '������ �������� ����������',    '01.12.1993'),
           (17, '���� ������� ����������',       '09.06.1993'),
           (17, '�������� ���������� ����������','05.01.1993'),
           (18, '����������� ����� ����������',  '01.07.1993'),
           (18, '������� ��������� ���������',   '07.04.1992'),
           (18, '������ �������� ���������',     '10.12.1992'),
           (19, '��������� ����� ����������',    '05.05.1992'),
           (19, '���������� ����� ������������', '11.01.1992'),
           (19, '�������� ����� ����������',     '04.06.1992'),
           (19, '����� ����� ����������',        '08.01.1994'),
           (19, '��������� ��������� ���������', '07.02.1994'),
           (20, '������ ������ �����������',     '12.06.1994'),
           (20, '������� ����� ��������',        '03.07.1994'),
           (20, '������ ������ ���������',       '04.07.1994'),
           (20, '������� ��������� ����������',  '08.11.1993'),
           (20, '������ ����� ����������',       '02.04.1993'),
           (20, '������ ���� ��������',          '03.06.1993'),
           (20, '������� ������ ���������',      '05.11.1993'),
           (21, '������ ������ �������������',   '03.07.1993'),
           (21, '��������� ����� ��������',      '08.01.1995'),
           (21, '���������� ��������� ���������','06.09.1995'),
           (21, '�������� ��������� ����������', '08.03.1995'),
           (21, '��������� ����� ��������',      '07.08.1995')



------�������� � ���������� ������� PROGRESS
create table PROGRESS
 ( 
    SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
     IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
     PDATE    date, 
     NOTE     integer check (NOTE between 1 and 10)
  );

insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values ('����', 1,  '01.10.2013',6),
           ('����', 2,  '01.10.2013',8),
           ('����', 3,  '01.10.2013',7),
           ('����', 4,  '01.10.2013',5),
           ('����', 5,  '01.10.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('����', 6,  '01.12.2013',5),
           ('����', 7,  '01.12.2013',9),
           ('����', 8,  '01.12.2013',5),
           ('����', 9,  '01.12.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values ('��',   10,  '06.5.2013',4),
           ('��',   11,  '06.05.2013',7),
           ('��',   12,  '06.05.2013',7),
           ('��',   13,  '06.05.2013',9),
           ('��',   14,  '06.05.2013',5),
           ('��',   15,  '06.05.2013',6)

--drop table student
 --drop table GROUPS
 --drop table FACULTY
 --drop table PROFESSION
 --drop table Progress
 --drop table PULPIT
 --drop table SUBJECT
 --drop table TEACHER


