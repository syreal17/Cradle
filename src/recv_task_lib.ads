with Gnat.Sockets;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Ada.Exceptions;
with Ada.Unchecked_Deallocation;

with network; use network;
with serv_task_lib; use serv_task_lib;

package recv_task_lib is

   package GS renames Gnat.Sockets;
   package SU renames Ada.Strings.Unbounded;
   package ucons renames Ada.Strings.Unbounded.Text_IO;
   package cons renames Ada.Text_IO;

   task type Recv_Task is
      entry Construct(
      Serv_Task_Ptr_Init: Serv_Task_Ptr; 
      Cxn_Record_Init: Cxn_Record);
   end Recv_Task;
   
   type Recvs_Array is array (Positive range 1 .. MAX_CXNS) of Recv_Task;
   type Recv_Task_Ptr is access all Recv_Task;

end recv_task_lib;
