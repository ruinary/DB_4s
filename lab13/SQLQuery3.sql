use UUNIVER;

-- ���� ��� ����� NULL, �����. ������ ���� ������ �� ���
-- ���� ������ NULL, �����. ��� ������� ���. ���
-- ���� ������ NULL, �����. ������, �����-��� ���. �������
-- ���� ��� �� NULL, �����. ������, �����-��� ���. ������� �� ���. ���
-- ���� ������ �������. ������, �����. ������ ���.�����
go
create function FFACPUL(@f varchar(20), @p varchar(20)) returns table
as return
select FACULTY.FACULTY, PULPIT.PULPIT from FACULTY left outer join PULPIT
  on FACULTY.FACULTY = PULPIT.FACULTY
   where FACULTY.FACULTY = ISNULL(@f, FACULTY.FACULTY) and --������ ��������, �� ������ null
    PULPIT.PULPIT = ISNULL(@p, PULPIT.PULPIT);

go
select * from dbo.FFACPUL(null, null);
select * from dbo.FFACPUL('����', null);
select * from dbo.FFACPUL(null, '����');
select * from dbo.FFACPUL('����', '����');