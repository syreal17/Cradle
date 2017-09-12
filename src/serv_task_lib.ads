with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with GNAT.Sockets;
with Ada.Strings.Unbounded;

with network; use network;

package serv_task_lib is

   package GS renames Gnat.Sockets;
   package SU renames Ada.Strings.Unbounded;

   task type Serv_Task is
      entry Construct(ServerSocketInit : GS.Socket_Type; CSs : Cxn_Streams; CSs_I : Positive);
      entry Update_Clients(CSs : Cxn_Streams; CSs_I : Positive);
      entry Relay_Msg(SendMsg : SU.Unbounded_String; C : Positive);
   end Serv_Task;
   
   type Serv_Task_Ptr is access all Serv_Task;

end serv_task_lib;
