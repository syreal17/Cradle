package body recv_task_lib is

   task body Recv_Task is
      ClientStream : GS.Stream_Access;
      Serv : Serv_Task_Ptr;
   begin
      accept Construct(CS : aliased GS.Stream_Access; Serv_Task_Ptr_Init : Serv_Task_Ptr) do
         ClientStream := CS;
         Serv := Serv_Task_Ptr_Init;
      end Construct;
      
      loop
         --receive message octet by octet, until LF
         declare
            RecvMsg : SU.Unbounded_String;
            O : String(1 .. 1);
         begin
            
            loop
               cons.Put_Line("INFO: Recv:before stream read");
               String'Read(ClientStream, O);
               cons.Put_Line("INFO: Recv:after stream read");
 
               if O(1) = LF then
                  exit;
               end if;
 
               SU.Append(RecvMsg, O);
            end loop;
 
            ucons.Put_Line(RecvMsg);
            
            Serv.Relay_Msg(RecvMsg);
         end;
      end loop;
   end Recv_Task;
   
end recv_task_lib;
