package body send_task_lib is

   task body Send_Task is
      ServerSocket : GS.Socket_Type;
      ClientStreams : Cxn_Streams;
      ClientStreams_I : Positive;
      SendMsg_N : Positive := 1;
   begin
      accept Construct(ServerSocketInit : GS.Socket_Type; CSs : Cxn_Streams; CSs_I : Positive) do
         ServerSocket := ServerSocketInit;
         ClientStreams := CSs;
         ClientStreams_I := CSs_I;
      end Construct;
   
      <<Send_Update_Loop_Label>>
      Send_Update_Loop:
      loop
         select
            Acpt.Update_Clients(ClientStreams, ClientStreams_I);
            cons.Put_Line("INFO: Clients Updated in Send Task");
         or
            delay 0.01;
            select
               accept Relay_Msg(SendMsg : String(1..64)) do
                  SendMsg_N := SendMsg'Last;
                  for I in SendMsg'Range loop
                     if SendMsg(I) = LF then
                        SendMsg_N = I;
                        exit;
                     end if;
                  end loop;
                  
                  declare
                     ClientStream : GS.Stream_Access;
                     Msg : String(1..SendMsg_N);
                  begin
                     for I in Msg'Range loop
                        Msg(I) := SendMsg(I);
                     end loop;
                     
                     for I in 1..ClientStreams_I-1 loop
                        ClientStream := ClientStreams(I);
                        String'Write(ClientStream, Msg);
                     end loop;
                  end;
               end Relay_Msg;
            or
               delay 0.01;
            end select;
         end select;
      end loop Send_Update_Loop;
      
      exception
         when e : others =>
            cons.Put_Line(Ada.Exceptions.Exception_Name(e) & ": " & Ada.Exceptions.Exception_Message(e));
   end Send_Task;
   
end send_task_lib;
