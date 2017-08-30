with Gnat.Sockets;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Ada.Text_IO;
with Ada.Containers.Indefinite_Vectors; use Ada.Containers;
with Ada.Exceptions;

with network; use network;
with accept_task_lib; use accept_task_lib;

package send_task_lib is

   package cons renames Ada.Text_IO;
   package GS renames Gnat.Sockets;

   task type Send_Task is
      entry Construct(ServerSocketInit : GS.Socket_Type; CSs : Cxn_Streams; CSs_I : Positive);
   end Send_Task;

end send_task_lib;
