use UUNIVER;
go   
create trigger AUD_AFTER_DEL1 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL1';
 return;  
go 
create trigger AUD_AFTER_DEL2 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL2';
 return;  
go  
create trigger AUD_AFTER_DEL3 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL3';
 return;  
go    


select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='FACULTY' and e.type_desc = 'DELETE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL3', 
	                        @order='First', @stmttype = 'DELETE';
exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL2', 
	                        @order='Last', @stmttype = 'DELETE';


select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='FACULTY' and e.type_desc = 'DELETE';