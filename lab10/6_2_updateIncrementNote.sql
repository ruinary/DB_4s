declare @im char(20), @n int;  
declare PROGRESS_ADD_CURSOR cursor local for 
select NAME, NOTE from PROGRESS join STUDENT
  on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
    where PROGRESS.IDSTUDENT=13
open PROGRESS_ADD_CURSOR;  
    fetch  PROGRESS_ADD_CURSOR into @im, @n; 
    UPDATE PROGRESS set NOTE=NOTE+1 where current of PROGRESS_ADD_CURSOR;
close PROGRESS_ADD_CURSOR;

select NAME, NOTE from PROGRESS join STUDENT
  on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT 
    where PROGRESS.IDSTUDENT=13