with Gnat.Sockets;
with Ada.Exceptions;
with Ada.Text_IO;
with Ada.Strings.Unbounded;

with network; use network;
with accept_task_lib; use accept_task_lib;
with serv_task_lib; use serv_task_lib;

procedure Main is

   package GS renames Gnat.Sockets;
   package cons renames Ada.Text_IO;
   package SU renames Ada.Strings.Unbounded;

   ServerSocket : GS.Socket_Type;
   ServerSocketAddr : GS.Sock_Addr_Type;
   Acpt : Accept_Task;
   Serv : Serv_Task_Ptr;
begin
   Init_Chat_Server(ServerSocket, ServerSocketAddr);

   Serv := new Serv_Task;
   Serv.Construct;
   Acpt.Construct(ServerSocket, Serv);

   exception
      when e : others =>
         cons.Put_Line("main: " & Ada.Exceptions.Exception_Name(e) & ": " & Ada.Exceptions.Exception_Message(e));
end Main;
