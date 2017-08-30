with Ada.Text_IO;
with Gnat.Sockets;

with network; use network;
with recv_task_lib; use recv_task_lib;

package accept_task_lib is

   package cons renames Ada.Text_IO;
   package GS renames Gnat.Sockets;

   task type Accept_Task is
      entry Construct(ServerSocketInit : GS.Socket_Type; CSs : Cxn_Streams; CSs_I : Positive);
      entry Update_Clients(CSs : out Cxn_Streams; CSs_I : out Positive);
   end Accept_Task; 

end accept_task_lib;
