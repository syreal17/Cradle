package body accept_task_lib is

   task body Accept_Task is
      ServerSocket : GS.Socket_Type;
      ClientStreams : Cxn_Streams;
      ClientStreams_I : Positive;
      Recvs : Recvs_Array;
      Serv : Serv_Task_Ptr;
   begin
      accept Construct(ServerSocketInit : GS.Socket_Type; CSs : Cxn_Streams; CSs_I : Positive; Serv_Task_Ptr_Init : Serv_Task_Ptr) do
         ServerSocket := ServerSocketInit;
         ClientStreams := CSs;
         ClientStreams_I := CSs_I;
         Serv := Serv_Task_Ptr_Init;
      end Construct;
   
      loop
         declare
            ClientSocket : GS.Socket_Type;
            ClientSocketAddr : GS.Sock_Addr_Type;
            ClientStream : aliased GS.Stream_Access;
         begin
            --ltj: environment task to handle accepting new cxns and spinning off
            --new tasks
            Accept_Chat_Cxn(ServerSocket, ClientSocket, ClientSocketAddr);
            ClientStream := GS.Stream(ClientSocket);
            -- add to a growing array of cxn records
            ClientStreams(ClientStreams_I) := ClientStream;
            ClientStreams_I := ClientStreams_I + 1;
         end;
      
         cons.Put_Line("INFO: About to start new recv");
         --create new recv task with new ClientStream
         Recvs(ClientStreams_I-1).Construct(ClientStreams(ClientStreams_I - 1), Serv);
         cons.Put_Line("INFO: Done starting new recv");
         
         --cons.Put_Line("INFO: Updating Clients in Accept Task");
         --accept Update_Clients(CSs : out Cxn_Streams; CSs_I : out Positive) do
         --   CSs := ClientStreams;
         --   CSs_I := ClientStreams_I;
         --end Update_Clients;
         --TODO: add rendezvous to server below
         Serv.Update_Clients(ClientStreams, ClientStreams_I);

      end loop;
   end Accept_Task;
end accept_task_lib;
