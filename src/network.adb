package body network is

   procedure Init_Chat_Server(
      ServerSocket : Out GS.Socket_Type;
      ServerSocketAddress : Out GS.Sock_Addr_Type) 
   is
   begin
      ServerSocket := GS.No_Socket;
      ServerSocketAddress := GS.No_Sock_Addr;
   
      -- create the socket which will used for all http traffic
      GS.Create_Socket(
         Socket => ServerSocket,
         Family => GS.Family_Inet,
         Mode   => GS.Socket_Stream);
   
      -- Allow socket to be bound to address already in use
      GS.Set_Socket_Option(ServerSocket,
         GS.Socket_Level, (GS.Reuse_Address, True));
   
      -- bind the socket to the first IP address on localhost, chat port
      ServerSocketAddress.Addr := GS.ANY_INET_ADDR;
      ServerSocketAddress.Port := GS.Port_Type(CHAT_PORT);
      GS.Bind_Socket(ServerSocket,ServerSocketAddress);
   
      --now ready to accept connections
      GS.Listen_Socket(Socket => ServerSocket, Length => 16);  -- allow 16 queued connections
   
      --if any of the above operations fail
      EXCEPTION
         WHEN E : OTHERS =>
            Ada.Text_IO.Put_Line(Ada.Exceptions.Exception_Name(E) & ":  " & Ada.Exceptions.Exception_Message(E));
   end Init_Chat_Server;
   
   procedure Accept_Chat_Cxn(
      ServerSocket : GS.Socket_Type;
      ClientSocket : Out GS.Socket_Type;
      ClientSocketAddr : Out GS.Sock_Addr_Type)
   is
   begin
         Ada.Text_IO.Put_Line("INFO: Waiting for cxn");
         GS.Accept_Socket(ServerSocket, ClientSocket, ClientSocketAddr);
         Ada.Text_IO.Put_Line("INFO: Accepted cxn");
   end Accept_Chat_Cxn;
   
end network;
