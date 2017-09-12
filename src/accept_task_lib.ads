with Ada.Text_IO;
with Gnat.Sockets;

with recv_task_lib; use recv_task_lib;
with serv_task_lib; use serv_task_lib;
with network; use network;

package accept_task_lib is

   package cons renames Ada.Text_IO;
   package GS renames Gnat.Sockets;

   task type Accept_Task is
      entry Construct(Server_Socket_Init: GS.Socket_Type; Serv_Task_Ptr_Init : Serv_Task_Ptr);
      --entry Update_Clients(CSs : out Cxn_Streams; CSs_I : out Positive);
   end Accept_Task;
   
   type Accept_Task_Ptr is access all Accept_Task;

end accept_task_lib;
