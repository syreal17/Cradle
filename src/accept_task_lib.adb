package body accept_task_lib is

   task body Accept_Task is
      ServerSocket: GS.Socket_Type;
      ClientStreams_I : Positive := 1;
      Serv : Serv_Task_Ptr;
      Recv : Recv_Task_Ptr;
   begin
      accept Construct(Server_Socket_Init: GS.Socket_Type; Serv_Task_Ptr_Init : Serv_Task_Ptr) do
         ServerSocket := Server_Socket_Init;
         Serv := Serv_Task_Ptr_Init;
      end Construct;
   
      loop
         declare
            ClientSocket : GS.Socket_Type;
            ClientSocketAddr : GS.Sock_Addr_Type;
            ClientStream : aliased GS.Stream_Access;
            Cxn: Cxn_Record;
         begin
            --ltj: environment task to handle accepting new cxns and spinning off
            --new tasks
            Accept_Chat_Cxn(ServerSocket, ClientSocket, ClientSocketAddr);
            ClientStream := GS.Stream(ClientSocket);
            
            --TODO: create Cxn_Record
            Cxn.Ind := ClientStreams_I;
            Cxn.Cxn := ClientStream;
            --TODO: move Serv rendz in here
            Serv.Add_Client(Cxn);
            
            --cons.Put_Line("INFO: About to start new recv");
            --create new recv task with new ClientStream
            Recv := new Recv_Task;
            Recv.Construct(Serv, Cxn);
            --cons.Put_Line("INFO: Done starting new recv");
            
            ClientStreams_I := ClientStreams_I + 1;
         end;

      end loop;
   end Accept_Task;
end accept_task_lib;
