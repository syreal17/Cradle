with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with GNAT.Sockets;
with Ada.Strings.Unbounded;
with Ada.Containers.Ordered_Maps; use Ada.Containers;
with Ada.Text_IO;
with Ada.Exceptions;
with Ada.Containers.Ordered_Sets;

with network; use network;

package serv_task_lib is

   package GS renames Gnat.Sockets;
   package SU renames Ada.Strings.Unbounded;
   package cons renames Ada.Text_IO;

   package List_of_Inds is new Ada.Containers.Ordered_Sets
      (Element_Type => Positive);

   task type Serv_Task is
      entry Construct;
      entry Add_Client(Cxn_Record_Init: Cxn_Record; Debunk_Inds_Out: out List_of_Inds.Set);
      entry Del_Client(Sender_I: Positive);
      entry Relay_Msg(SendMsg : SU.Unbounded_String; Sender_I : Positive);
   end Serv_Task;
   
   type Serv_Task_Ptr is access all Serv_Task;

   function "=" (L, R : Cxn_Record) return Boolean;
   
   --generic for creating a map
   package Cxns is new Ada.Containers.Ordered_Maps
     (Key_Type => Positive,
      Element_Type => Cxn_Record);

end serv_task_lib;
