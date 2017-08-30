package body send_task_lib is

   task body Send_Task is
      ServerSocket : GS.Socket_Type;
      ClientStreams : Cxn_Streams;
      ClientStreams_I : Positive;
      Acpt : Accept_Task;
      SendMsg : String(1..64);
      SendMsg_N : Positive := 1;
   begin
      accept Construct(ServerSocketInit : GS.Socket_Type; CSs : Cxn_Streams; CSs_I : Positive) do
         ServerSocket := ServerSocketInit;
         ClientStreams := CSs;
         ClientStreams_I := CSs_I;
         Acpt.Construct(ServerSocket, ClientStreams, ClientStreams_I);
      end Construct;
   
      <<Send_Update_Loop_Label>>
      Send_Update_Loop:
      loop
         select
            Acpt.Update_Clients(ClientStreams, ClientStreams_I);
            cons.Put_Line("INFO: Clients Updated in Send Task");
         or
            delay 0.01;
            if ClientStreams_I <= 1 then
               goto Send_Update_Loop_Label;
            else
               --send message as string to client
               declare
                  --SendMsg : String := cons.Get_Line & LF;
                  C : Character;
                  ClientStream : GS.Stream_Access;
               begin
                  cons.Get_Immediate(C);
                  SendMsg(SendMsg_N) := C;
                  SendMsg_N := SendMsg_N + 1;
                  if C = LF or SendMsg_N = SendMsg'Last then
                     declare
                        Msg : String(1..SendMsg_N-1);
                     begin
                        --copy truncated string
                        for I in Msg'Range loop
                           Msg(I) := SendMsg(I);
                        end loop;
                        
                        for I in 1 .. ClientStreams_I-1 loop
                           ClientStream := ClientStreams(I);
                           String'Write(ClientStream, Msg);
                        end loop;
                        --reset SendMsg_N, and SendMsg
                        SendMsg_N := 1;
                     end;
                  end if;
               end;
            end if;
         end select;
      end loop Send_Update_Loop;
      
      exception
         when e : others =>
            cons.Put_Line(Ada.Exceptions.Exception_Name(e) & ": " & Ada.Exceptions.Exception_Message(e));
   end Send_Task;
   
end send_task_lib;
