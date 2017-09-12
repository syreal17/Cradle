package body recv_task_lib is

   task body Recv_Task is
      ClientStream : GS.Stream_Access;
      Serv : Serv_Task_Ptr;
      C : Positive;
   begin
      accept Construct(CS : aliased GS.Stream_Access; Serv_Task_Ptr_Init : Serv_Task_Ptr; C_init : Positive) do
         ClientStream := CS;
         Serv := Serv_Task_Ptr_Init;
         C := C_Init;
      end Construct;
      
      loop
         --receive message octet by octet, until LF
         declare
            RecvMsg : SU.Unbounded_String;
            O : String(1 .. 1);
         begin
            
            loop
               --cons.Put_Line("INFO: Recv:before stream read");
               String'Read(ClientStream, O);
               --cons.Put_Line("INFO: Recv:after stream read");
 
               SU.Append(RecvMsg, O);
               
               if O(1) = LF then
                  exit;
               end if;
            end loop;
 
            ucons.Put_Line(RecvMsg);
            
            Serv.Relay_Msg(RecvMsg,C);
         end;
      end loop;
   end Recv_Task;
   
end recv_task_lib;
