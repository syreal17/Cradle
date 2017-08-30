with Gnat.Sockets;
with Ada.Text_IO;
with Ada.Exceptions;

with recv_task_lib; use recv_task_lib;

package network is
   package GS renames Gnat.Sockets;
   
   CHAT_PORT : constant Positive := 31337;
   MAX_CXNS : constant Positive := 16;
   
   type Cxn_Streams is array (Positive range 1 .. MAX_CXNS) of aliased GS.Stream_Access;
   type Recvs_Array is array (Positive range 1 .. MAX_CXNS) of Recv_Task;
   
   procedure Init_Chat_Server(
      ServerSocket : Out GS.Socket_Type;
      ServerSocketAddress : Out GS.Sock_Addr_Type);
   procedure Accept_Chat_Cxn(
      ServerSocket : GS.Socket_Type;
      ClientSocket : Out GS.Socket_Type;
      ClientSocketAddr : Out GS.Sock_Addr_Type);

end network;
