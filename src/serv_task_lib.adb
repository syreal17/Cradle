package body serv_task_lib is
   
   task body Serv_Task is
      ServerSocket : GS.Socket_Type;
      ClientStreams : Cxn_Streams;
      ClientStreams_I : Positive;
      SendMsg_N : Positive;
   begin
      accept Construct(ServerSocketInit : GS.Socket_Type; CSs : Cxn_Streams; CSs_I : Positive) do
         ServerSocket := ServerSocketInit;
         ClientStreams := CSs;
         ClientStreams_I := CSs_I;
      end Construct;
      
      loop
         select
            accept Update_Clients (CSs : Cxn_Streams; CSs_I : Positive) do
               ClientStreams := CSs;
               ClientStreams_I := CSs_I;
            end Update_Clients;
         or
            accept Relay_Msg (SendMsg : SU.Unbounded_String) do
               SendMsg_N := SU.Length(SendMsg);
               
               declare
                  ClientStream : GS.Stream_Access;
                  Msg : String(1..SendMsg_N);
               begin
                  for I in Msg'Range loop
                     Msg(I) := SU.Element(SendMsg, I);
                  end loop;
                  
                  for I in 1..ClientStreams_I-1 loop
                     ClientStream := ClientStreams(I);
                     String'Write(ClientStream, Msg);
                  end loop;
               end;
            end Relay_Msg;
         end select;
      end loop;
   end Serv_Task;
   
end serv_task_lib;
