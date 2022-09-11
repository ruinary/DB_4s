-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 1
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use UNIVER
go
SELECT * from TEACHER where PULPIT = 'ИСиТ' for xml PATH('TEACHER'), root('Преподаватели_кафедры_ИСиТ'),elements;
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 2
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
select	   AUDITORIUM.AUDITORIUM			[Аудитория],
           AUDITORIUM.AUDITORIUM_TYPE		[Наимменование_типа],
		   AUDITORIUM.AUDITORIUM_CAPACITY	[Вместимость] 
		   from AUDITORIUM join AUDITORIUM_TYPE
		     on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
	where AUDITORIUM.AUDITORIUM_TYPE = 'ЛК' for xml AUTO, root('Список_аудиторий'), elements;
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 3
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
declare @h int = 0,
@sbj varchar(3000) = '<?xml version="1.0" encoding="windows-1251" ?>
                      <дисциплины>
					     <дисциплина код="КГиГ" название="Компьютерная геометрия и графика" кафедра="ИСиТ" />
						 <дисциплина код="ОЗИ" название="Основы защиты информации" кафедра="ИСиТ" />
						 <дисциплина код="ВД" название="WEB-дизайн" кафедра="ИСиТ" />
					  </дисциплины>';
exec sp_xml_preparedocument @h output, @sbj;
insert SUBJECT select[код], [название], [кафедра] from openxml(@h, '/дисциплины/дисциплина',0)
    with([код] char(10), [название] varchar(100), [кафедра] char(20));
exec sp_xml_removedocument @h;

delete from SUBJECT where SUBJECT.SUBJECT='КГиГ' or SUBJECT.SUBJECT='ОЗИ' or SUBJECT.SUBJECT='ВД'
select * from SUBJECT
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 4
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
insert into STUDENT(IDGROUP, NAME, BDAY, INFO)
	values(22, 'Артём Е.В.', '22.01.2003',
	'<студент>
	   <паспорт серия="AB" номер="3132398" дата="26.11.2018" />
	   <телефон>291477513</телефон>
	   <адрес>
		  <страна>Беларусь</страна>
		  <город>Минск</город>
		  <улица>Шафарнянская</улица>
	      <дом>3</дом>
		  <квартира>95</квартира>
		</адрес>
	</студент>');
select * from STUDENT where NAME = 'Артём Е.В.';
delete STUDENT where NAME = 'Артём Е.В.';
update STUDENT set INFO = '<студент>
					           <паспорт серия="AB" номер="3132398" дата="26.11.2018" />
							   <телефон>375291111111</телефон>
							   <адрес>
								  <страна>Беларусь</страна>
								  <город>Минск</город>
								  <улица>Шафарнянская</улица>
	         					  <дом>3</дом>
								  <квартира>95</квартира>
								</адрес>
							</студент>' where NAME='Артём Е.В.'
select NAME[ФИО], INFO.value('(студент/паспорт/@серия)[1]', 'char(2)')[Серия паспорта],
	INFO.value('(студент/паспорт/@номер)[1]', 'varchar(20)')[Номер паспорта],
	INFO.query('/студент/адрес')[Адрес]
		from  STUDENT
			where NAME = 'Артём Е.В.';     
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 5
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use master;
go
drop XML SCHEMA COLLECTION Student;
drop table STUDENT;
go
create table STUDENT 
(    IDSTUDENT integer  identity(1000,1)  primary key,
      IDGROUP integer  ,        
      NAME nvarchar(100), 
      BDAY  date,
      STAMP timestamp,
      INFO   xml,    -- типизированный столбец XML-типа
      FOTO  varbinary
  );
  insert into STUDENT(IDGROUP, NAME, BDAY, INFO)
	values(22, 'Артём Е.В.', '22.01.2003',
	'<студент>
	   <паспорт серия="AB" номер="3132398" дата="26.11.2018" />
	   <телефон>375291477513</телефон>
	   <адрес>
		  <страна>Беларусь</страна>
		  <город>Минск</город>
		  <улица>Шафарнянская</улица>
	      <дом>3</дом>
		  <квартира>95</квартира>
		</адрес>
	</студент>');

go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xs:element name="студент">  
		<xs:complexType>
			<xs:sequence>
				<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
					<xs:complexType>
						<xs:attribute name="серия" type="xs:string" use="required" />
						<xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
						<xs:attribute name="дата"  use="required" >  
							<xs:simpleType> 
								<xs:restriction base ="xs:string">
									<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType> 
				</xs:element>
				<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
				<xs:element name="адрес">
					<xs:complexType>
						<xs:sequence>
							<xs:element name="страна" type="xs:string" />
							<xs:element name="город" type="xs:string" />
							<xs:element name="улица" type="xs:string" />
							<xs:element name="дом" type="xs:string" />
							<xs:element name="квартира" type="xs:string" />
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
		</xs:complexType>
	</xs:element>
</xs:schema>';

--alter table STUDENT alter column INFO xml
select Name, INFO from STUDENT where NAME='Артём Е.В.'
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
--							ЗАДАНИЕ 7
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
use UNIVER;
go
select 
	rtrim(F.FACULTY) as "@код",
	(select COUNT(*) from PULPIT as P where P.FACULTY = F.FACULTY) as "количество_кафедр",
	(select rtrim(p.PULPIT) as "@код",
			(
				select 
					rtrim(T.TEACHER) as "преподаватель/@код",
					T.TEACHER_NAME as "преподаватель"
				from 
					TEACHER as T where T.PULPIT = p.PULPIT
				for xml path(''),type, root('преподаватели')
			)
		from 
			PULPIT as p where p.FACULTY = F.FACULTY 
		for xml path('кафедра'), type, root('кафедры')
	) 
from
	FACULTY as F
for xml path('факультет'), type, root('университет')