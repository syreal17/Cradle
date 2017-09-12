with Gnat.Sockets;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;

with network; use network;
with serv_task_lib; use serv_task_lib;

package recv_task_lib is

   package GS renames Gnat.Sockets;
   package SU renames Ada.Strings.Unbounded;
   package ucons renames Ada.Strings.Unbounded.Text_IO;
   package cons renames Ada.Text_IO;

   task type Recv_Task is
      entry Construct(CS : aliased GS.Stream_Access; Serv_Task_Ptr_Init : Serv_Task_Ptr);
   end Recv_Task;
   
   type Recvs_Array is array (Positive range 1 .. MAX_CXNS) of Recv_Task;

end recv_task_lib;
