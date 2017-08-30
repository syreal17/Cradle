package body recv_task_lib is

   task body Recv_Task is
      ClientStream : GS.Stream_Access;
   begin
      accept Construct(CS : aliased GS.Stream_Access) do
         ClientStream := CS;
      end Construct;
      
      loop
         --receive message octet by octet, until LF
         declare
            RecvMsg : SU.Unbounded_String;
            O : String(1 .. 1);
         begin
            loop
               String'Read(ClientStream, O);
   
               if O(1) = LF then
                  exit;
               end if;
   
               SU.Append(RecvMsg, O);
            end loop;
   
            ucons.Put_Line(RecvMsg);
         end;
      end loop;
   end Recv_Task;
   
end recv_task_lib;
