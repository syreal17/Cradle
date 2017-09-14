with Ada.Text_IO;
with Gnat.Sockets;
with Ada.Containers.Ordered_Maps; use Ada.Containers;
with Ada.Unchecked_Deallocation;

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
   
   --generic for creating a map
   package Ind_to_RTP is new Ada.Containers.Ordered_Maps
     (Key_Type => Positive,
      Element_Type => Recv_Task_Ptr);
      
   procedure Free_Recv is new Ada.Unchecked_Deallocation(Recv_Task, Recv_Task_Ptr);

end accept_task_lib;
