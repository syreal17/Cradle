package body serv_task_lib is

   function "=" (L, R : Cxn_Record) return Boolean is
   begin
      return L.Ind = R.Ind;   
   end "=";
   
   task body Serv_Task is
      --ClientStreams_I : Positive;
      SendMsg_N : Positive;
      ClientCxns: Cxns.Map;
      Debunk_Inds: List_of_Inds.Set;
   begin
      accept Construct do
         null;
      end Construct;
      
      loop
         select
            accept Add_Client(Cxn_Record_Init: Cxn_Record; Debunk_Inds_Out: out List_of_Inds.Set) do
                  ClientCxns.Insert(Cxn_Record_Init.Ind, Cxn_Record_Init);
                  Debunk_Inds_Out := Debunk_Inds;
                  Debunk_Inds.Clear;
            end Add_Client;
         or
            accept Del_Client(Sender_I: Positive) do
               cons.Put_Line("Serv_Task: In Del_Client!");
               ClientCxns.Delete(Sender_I);
               Debunk_Inds.Insert(Sender_I);
            end Del_Client;
         or
            accept Relay_Msg (SendMsg : SU.Unbounded_String; Sender_I : Positive) do
               SendMsg_N := SU.Length(SendMsg);
               
               declare
                  ClientStream : aliased GS.Stream_Access;
                  Msg : String(1..SendMsg_N);
                  c: Cxns.Cursor := Cxns.First(ClientCxns);
               begin
                  for I in Msg'Range loop
                     Msg(I) := SU.Element(SendMsg, I);
                  end loop;
                  
                  -- iterate with cursor over map
                  while Cxns.Has_Element(c) loop
                     if Cxns.Key(c) /= Sender_I then
                        ClientStream := Cxns.Element(c).Cxn;
                        String'Write(ClientStream, Msg);
                     end if;
                     Cxns.Next(c);
                  end loop;
               end;
            end Relay_Msg;
         end select;
      end loop;
      
   exception
      when e : others =>
         cons.Put_Line("Serv_Task: " & Ada.Exceptions.Exception_Name(e) & ": " & Ada.Exceptions.Exception_Message(e));      
   end Serv_Task;
   
end serv_task_lib;
