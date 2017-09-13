package body recv_task_lib is

   task body Recv_Task is
      ClientStream : aliased GS.Stream_Access;
      Serv : Serv_Task_Ptr;
      Sender_I : Positive;
   begin
      accept Construct(
      Serv_Task_Ptr_Init : Serv_Task_Ptr; 
      Cxn_Record_Init: Cxn_Record) 
      do
         Serv := Serv_Task_Ptr_Init;
         ClientStream := Cxn_Record_Init.Cxn;
         Sender_I := Cxn_Record_Init.Ind;
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
            
            Serv.Relay_Msg(RecvMsg, Sender_I);
         end;
      end loop;
      
   exception
      when e: GS.Socket_Error =>
         Serv.Del_Client(Sender_I);
      when e: others =>
         cons.Put_Line("Recv_Task: " & Ada.Exceptions.Exception_Name(e) & ": " & Ada.Exceptions.Exception_Message(e)); 
   end Recv_Task;
   
end recv_task_lib;
