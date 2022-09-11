USE master;

CREATE database UNIVER


use UNIVER;

------------Создание и заполнение таблицы AUDITORIUM_TYPE 

create table AUDITORIUM_TYPE 

(
    AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
    AUDITORIUM_TYPENAME  varchar(30),       
 );

insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )       
 values ('ЛК',  'Лекционная');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         
values ('ЛБ-К',  'Компьютерный класс');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         
values ('ЛК-К',  'Лекционная с уст. проектором');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          
values  ('ЛБ-X',  'Химическая лаборатория');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        
values  ('ЛБ-СК', 'Спец. компьютерный класс');
                      





-------------Создание и заполнение таблицы AUDITORIUM  
  create table AUDITORIUM 

(
   AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
   AUDITORIUM_TYPE     char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
   AUDITORIUM_CAPACITY  int constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- вместимость 
   AUDITORIUM_NAME      varchar(50)                                     
);


insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('301-1', 'ЛБ-К', 15, '301-1');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('304-4', 'ЛБ-К', 90, '304-4');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('313-1', 'ЛК-К', 60, '313-1');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('314-4', 'ЛК', 90, '314-4');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('320-4', 'ЛК', 90, '320-4');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('324-1', 'ЛК-К', 50, '324-1');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('413-1', 'ЛБ-К', 15, '413-1');
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_TYPE,  AUDITORIUM_CAPACITY, AUDITORIUM_NAME)   
values  ('423-1', 'ЛБ-К', 90, '423-1');



  ------Создание и заполнение таблицы FACULTY
  create table FACULTY
  (   
       FACULTY      char(10)   constraint  FACULTY_PK primary key,
       FACULTY_NAME  varchar(50) default '???'
  );

insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('ХТиТ',   'Химическая технология и техника');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('ЛХ',     'Лесохозяйственный факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('ИЭФ',     'Инженерно-экономический факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('ТТЛП',    'Технологии и техника лесной промышленности');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('ТОВ',     'Технологии органических веществ');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
values  ('ИТ',     'Факультет информационных технологий');  





------Создание и заполнение таблицы PROFESSION
   create table PROFESSION
  (  
       PROFESSION   char(20) constraint PROFESSION_PK  primary key,
       FACULTY    char(10) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
       PROFESSION_NAME varchar(100),    
       QUALIFICATION   varchar(50)  
  );  
                   
 insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-36 06 01', 'ИДиП',   'Полиграфическое оборудование и системы обработки информации', 'инженер-электромеханик' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-36 07 01', 'ХТиТ',   'Машины и аппараты химических производств и предприятий строительных материалов', 'инженер-механик' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-40 01 02', 'ИТ',   'Информационные системы и технологии', 'инженер-программист-системотехник' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-46 01 01', 'ТТЛП',   'Лесоинженерное дело', 'инженер-технолог' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-47 01 01', 'ИДиП',   'Издательское дело', 'редактор-технолог' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-48 01 02', 'ТОВ',   'Химическая технология органических веществ, материалов и изделий', 'инженер-химик-технолог' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-48 01 05', 'ТОВ',   'Химическая технология переработки древесины', 'инженер-химик-технолог' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-54 01 03', 'ТОВ',   'Физико-химические методы и приборы контроля качества продукции', 'инженер по сертификации' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-75 01 01', 'ЛХФ',   'Лесное хозяйство', 'инженер лесного хозяйства' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-75 02 01', 'ЛХФ',   'Садово-парковое строительство', 'инженер садово-паркового строительства' );
insert into PROFESSION( PROFESSION, FACULTY,  PROFESSION_NAME, QUALIFICATION)  
values    ( '1-89 02 02', 'ЛХФ',   'Туризм и природопользование', 'специалист в сфере туризма' );

 


 ------Создание и заполнение таблицы PULPIT
  create table  PULPIT 
(   
    PULPIT   char(20)  constraint PULPIT_PK  primary key,
    PULPIT_NAME  varchar(100), 
    FACULTY   char(10)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
);

insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('РИТ', 'Редакционно-издательских технологий ','ИДиП' );
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('СБУАиА', 'Статистики, бухгалтерского учета, анализа и аудита','ИЭФ');          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТДП', 'Технологий деревообрабатывающих производств','ТТЛП');           
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
  values  ('ТиДИД', 'Технологии и дизайна изделий из древесины','ТТЛП');                
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('ТиП', 'Туризма и природопользования','ЛХФ') ;
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('ТЛ', 'Транспорта леса','ТТЛП');              
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТНВиОХТ','Технологии неорганических веществ и общей химической технологии','ХТиТ')  ;        
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТНХСиППМ', 'Технологии нефтехимического синтеза и переработки полимерных материалов', 'ТОВ');                          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ХПД','Химической переработки древесины','ТОВ')  ;
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('ХТЭПиМЭЕ','Химии, технологии элетрохимических производств и материалов электронной техники', 'ХТиТ');   
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('ЭТиМ','Экономической теории и маркетинга','ИЭФ');  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('ИСиТ', 'Информационных систем и технологий ','ИТ'  )  ;
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('ПОИТ', 'Программное обеспечение информационных технологий ','ИТ'  )  ;    



------Создание и заполнение таблицы TEACHER
 create table TEACHER
 (   
     TEACHER    char(10)  constraint TEACHER_PK  primary key,
     TEACHER_NAME  varchar(100), 
     GENDER     char(1) CHECK (GENDER in ('м', 'ж')),
     PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 );
 

insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('НСКВ',    'Носков Михаил Трофимович', 'м',  'ТТЛП');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('ПРКП',    'Прокопенко Николай Иванович', 'м',  'ТНХСиППМ');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('МРЗВ',    'Морозова Елена Степановна', 'ж',  'ИСиТ');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('РВКС',    'Ровкас Андрей Петрович', 'м',  'ОВ');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('РЖКВ',    'Рыжиков Леонид Николаевич', 'м',  'ЛВ');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('РМНВ',    'Романов Дмитрий Михайлович', 'м',  'ИСиТ');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('СМЛВ',    'Смелов Владимир Владиславович', 'м',  'ИСиТ');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('КРЛВ',    'Крылов Павел Павлович', 'м',  'ИСиТ');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('ЧРН',    'Чернова Анна Викторовна', 'ж',  'ХПД');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('МХВ',    'Мохов Михаил Сергеевич', 'м',  'ПОИТ');





------Создание и заполнение таблицы SUBJECT
create table SUBJECT
    (     
           SUBJECT  char(10) constraint SUBJECT_PK  primary key, 
           SUBJECT_NAME varchar(100) unique,
           PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)   
     );

 insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('СУБД',   'Системы управления базами данных', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT)
                       values ('БД',     'Базы данных','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ИНФ',    'Информационные технологии','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ОАиП',  'Основы алгоритмизации и программирования', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ПЗ',     'Представление знаний в компьютерных системах', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ПСП',    'Программирование сетевых приложений', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('МСОИ',  'Моделирование систем обработки информации', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ПИС',     'Проектирование информационных систем', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('КГ',      'Компьютерная геометрия ','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
           values ('ПМАПЛ',   'Полиграф. машины, автоматы и поточные линии', 'ПОИТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('КМС',     'Компьютерные мультимедийные системы', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ОПП',     'Организация полиграф. производства', 'ПОИТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT)
                       values ('ДМ',   'Дискретная математика', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                      values ('МП',   'Математическое программирование','ИСиТ');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
               values ('ЛЭВМ', 'Логические основы ЭВМ',  'ИСиТ');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
               values ('ООП',  'Объектно-ориентированное программирование', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ЭП', 'Экономика природопользования','МиЭП')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ЭТ', 'Экономическая теория','ЭТиМ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТРИ',    'Технология резиновых изделий','ТНХСиППМ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТиОЛ',   'Технология и оборудование лесозаготовок', 'ЛМиЛЗ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ПЭХ',    'Прикладная электрохимия','ХТЭПиМЭЕ')               
 

------Создание и заполнение таблицы GROUPS
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
         values ('ИТ','1-40 01 02', 2013) --1
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ИТ','1-40 01 02', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ИТ','1-40 01 02', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('ИТ','1-40 01 02', 2010)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('ИТ','1-40 01 02', 2013)---5 гр
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values   ('ИТ','1-40 01 02', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ИТ','1-40 01 02', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ИТ','1-40 01 02', 2010)-----8 гр
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('ИТ','1-40 01 02', 2013)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('ИТ','1-40 01 02', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values  ('ИТ','1-40 01 02', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ХТиТ','1-36 07 01', 2013)---12 гр    
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ХТиТ','1-36 07 01', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ХТиТ','1-36 07 01', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ХТиТ','1-36 07 01', 2010)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ТОВ','1-48 01 02', 2012) ---16 гр
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ТОВ','1-48 01 02', 2011)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ТОВ','1-48 01 05', 2013)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ТТЛП','1-46 01 01', 2013)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ТТЛП','1-46 01 01', 2012)
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ТТЛП','1-46 01 01', 2012)--27 гр
                  
                          


------Создание и заполнение таблицы STUDENT
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
        values (1, 'Хартанович Екатерина Александровна', '11.03.1995'),        
          (1, 'Горбач Елизавета Юрьевна',    '07.12.1995'),
           (1, 'Зыкова Кристина Дмитриевна',  '12.10.1995'),
           (1, 'Шенец Екатерина Сергеевна',   '08.01.1995'),
           (1, 'Шитик Алина Игоревна',  '02.08.1995')       
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (12, 'Силюк Валерия Ивановна',         '12.07.1994'),
           (10, 'Сергель Виолетта Николаевна',    '06.03.1994'),
           (11, 'Добродей Ольга Анатольевна',     '09.11.1994'),
           (15, 'Подоляк Мария Сергеевна',        '04.10.1994'),
           (8, 'Никитенко Екатерина Дмитриевна', '08.01.1994'),
           (8, 'Яцкевич Галина Иосифовна',       '02.08.1993'),
           (7, 'Осадчая Эла Васильевна',         '07.12.1993'),
           (7, 'Акулова Елена Геннадьевна',      '02.12.1993'),
           (1, 'Плешкун Милана Анатольевна',     '08.03.1992'),
           (1, 'Буянова Мария Александровна',    '02.06.1992'),
           (1, 'Харченко Елена Геннадьевна',     '11.12.1992'),
           (2, 'Крученок Евгений Александрович', '11.05.1992'),
           (2, 'Бороховский Виталий Петрович',   '09.11.1992'),
           (2, 'Мацкевич Надежда Валерьевна',    '01.11.1992'),
           (3, 'Логинова Мария Вячеславовна',    '08.07.1995'),
           (3, 'Белько Наталья Николаевна',      '02.11.1995'),
           (3, 'Селило Екатерина Геннадьевна',   '07.05.1995'),
           (3, 'Дрозд Анастасия Андреевна',      '04.08.1995'),
           (4, 'Козловская Елена Евгеньевна',    '08.11.1994'),
           (4, 'Потапнин Кирилл Олегович',       '02.03.1994'),
           (4, 'Равковская Ольга Николаевна',    '04.06.1994'),
           (4, 'Ходоронок Александра Вадимовна', '09.11.1994'),
           (4, 'Рамук Владислав Юрьевич',        '04.07.1994'),
           (5, 'Неруганенок Мария Владимировна', '03.01.1993'),
           (5, 'Цыганок Анна Петровна',          '12.09.1993'),
           (5, 'Масилевич Оксана Игоревна',      '12.06.1993'),
           (5, 'Алексиевич Елизавета Викторовна','09.02.1993'),
           (5, 'Ватолин Максим Андреевич',       '04.07.1993'),
           (5, 'Синица Валерия Андреевна',       '08.01.1992'),
           (6, 'Кудряшова Алина Николаевна',     '12.05.1992'),
           (6, 'Мигулина Елена Леонидовна',      '08.11.1992'),
           (6, 'Шпиленя Алексей Сергеевич',      '12.03.1992'),
           (6, 'Астафьев Игорь Александрович',   '10.08.1995'),
           (6, 'Гайтюкевич Андрей Игоревич',     '02.05.1995'),
           (7, 'Рученя Наталья Александровна',   '08.01.1995'),
           (9, 'Тарасевич Анастасия Ивановна',   '11.09.1995'),
           (21, 'Жоглин Николай Владимирович',   '08.01.1994'),
           (18, 'Санько Андрей Дмитриевич',      '11.09.1994'),
           (10, 'Пещур Анна Александровна',      '06.04.1994'),
           (10, 'Бучалис Никита Леонидович',     '12.08.1994')
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (12, 'Лавренчук Владислав Николаевич','07.11.1993'),
           (13, 'Власик Евгения Викторовна',     '04.06.1993'),
           (15, 'Абрамов Денис Дмитриевич',      '10.12.1993'),
           (15, 'Оленчик Сергей Николаевич',     '04.07.1993'),
           (15, 'Савинко Павел Андреевич',       '08.01.1993'),
           (15, 'Бакун Алексей Викторович',      '02.09.1993'),
           (16, 'Бань Сергей Анатольевич',       '11.12.1995'),
           (17, 'Сечейко Илья Александрович',    '10.06.1995'),
           (8, 'Кузмичева Анна Андреевна',      '09.08.1995'),
           (9, 'Бурко Диана Францевна',         '04.07.1995'),
           (10, 'Даниленко Максим Васильевич',   '08.03.1995'),
           (11, 'Зизюк Ольга Олеговна',          '12.09.1995'),
           (11, 'Шарапо Мария Владимировна',     '08.10.1994'),
           (12, 'Касперович Вадим Викторович',   '10.02.1994'),
           (13, 'Чупрыгин Арсений Александрович','11.11.1994'),
           (14, 'Воеводская Ольга Леонидовна',   '10.02.1994'),
           (15, 'Метушевский Денис Игоревич',    '12.01.1994'),
           (16, 'Ловецкая Валерия Александровна','11.09.1993'),
           (16, 'Дворак Антонина Николаевна',    '01.12.1993'),
           (17, 'Щука Татьяна Николаевна',       '09.06.1993'),
           (17, 'Коблинец Александра Евгеньевна','05.01.1993'),
           (18, 'Фомичевская Елена Эрнестовна',  '01.07.1993'),
           (18, 'Бесараб Маргарита Вадимовна',   '07.04.1992'),
           (18, 'Бадуро Виктория Сергеевна',     '10.12.1992'),
           (19, 'Тарасенко Ольга Викторовна',    '05.05.1992'),
           (19, 'Афанасенко Ольга Владимировна', '11.01.1992'),
           (19, 'Чуйкевич Ирина Дмитриевна',     '04.06.1992'),
           (19, 'Брель Алеся Алексеевна',        '08.01.1994'),
           (19, 'Кузнецова Анастасия Андреевна', '07.02.1994'),
           (20, 'Томина Карина Геннадьевна',     '12.06.1994'),
           (20, 'Дуброва Павел Игоревич',        '03.07.1994'),
           (20, 'Шпаков Виктор Андреевич',       '04.07.1994'),
           (20, 'Шнейдер Анастасия Дмитриевна',  '08.11.1993'),
           (20, 'Шыгина Елена Викторовна',       '02.04.1993'),
           (20, 'Клюева Анна Ивановна',          '03.06.1993'),
           (20, 'Доморад Марина Андреевна',      '05.11.1993'),
           (21, 'Линчук Михаил Александрович',   '03.07.1993'),
           (21, 'Васильева Дарья Олеговна',      '08.01.1995'),
           (21, 'Щигельская Екатерина Андреевна','06.09.1995'),
           (21, 'Сазонова Екатерина Дмитриевна', '08.03.1995'),
           (21, 'Бакунович Алина Олеговна',      '07.08.1995')



------Создание и заполнение таблицы PROGRESS
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
    values ('ОАиП', 1,  '01.10.2013',6),
           ('ОАиП', 2,  '01.10.2013',8),
           ('ОАиП', 3,  '01.10.2013',7),
           ('ОАиП', 4,  '01.10.2013',5),
           ('ОАиП', 5,  '01.10.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('СУБД', 6,  '01.12.2013',5),
           ('СУБД', 7,  '01.12.2013',9),
           ('СУБД', 8,  '01.12.2013',5),
           ('СУБД', 9,  '01.12.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values ('КГ',   10,  '06.5.2013',4),
           ('КГ',   11,  '06.05.2013',7),
           ('КГ',   12,  '06.05.2013',7),
           ('КГ',   13,  '06.05.2013',9),
           ('КГ',   14,  '06.05.2013',5),
           ('КГ',   15,  '06.05.2013',6)

--drop table student
 --drop table GROUPS
 --drop table FACULTY
 --drop table PROFESSION
 --drop table Progress
 --drop table PULPIT
 --drop table SUBJECT
 --drop table TEACHER


