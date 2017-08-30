with Gnat.Sockets;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;

package recv_task_lib is

   package GS renames Gnat.Sockets;
   package SU renames Ada.Strings.Unbounded;
   package ucons renames Ada.Strings.Unbounded.Text_IO;

   task type Recv_Task is
      entry Construct(CS : aliased GS.Stream_Access);
   end Recv_Task; 

end recv_task_lib;
