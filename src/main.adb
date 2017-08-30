with Gnat.Sockets;
with Ada.Exceptions;
with Ada.Text_IO;

with network; use network;
with accept_task_lib; use accept_task_lib;
with send_task_lib; use send_task_lib;
with recv_task_lib; use recv_task_lib;

procedure Main is

   package GS renames Gnat.Sockets;
   package cons renames Ada.Text_IO;

   ServerSocket : GS.Socket_Type;
   ServerSocketAddr : GS.Sock_Addr_Type;
   ClientStreams : Cxn_Streams;
   ClientStreams_I : Positive := 1;
   Acpt : Accept_Task;
   Send : Send_Task;
begin
   Init_Chat_Server(ServerSocket, ServerSocketAddr);

   Send.Construct(ServerSocket, ClientStreams, ClientStreams_I);

   exception
      when e : others =>
         cons.Put_Line(Ada.Exceptions.Exception_Name(e) & ": " & Ada.Exceptions.Exception_Message(e));
end Main;
