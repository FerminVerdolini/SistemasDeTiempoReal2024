with Plan; use Plan;
with Proc; use Proc;
with Ada.Text_IO; use Ada.Text_IO;

procedure Auxiliar is
    Procedimientos: array_ref_Procedimiento_t := (P1'Access, P2'Access,P3'Access, P4'Access);
    Tiempos: array_Tiempos_t (Procedimientos'Range);
    
    package ES_Pos is new Ada.Text_Io.Integer_Io(Positive);

begin
    Medir (Procedimientos, Tiempos);
    Put_line("+-------------------------+");
    Put_Line("| Procedimiento T.computo |");
    Put_line("|-------------------------|");
    for I in Tiempos'Range loop
        Put("| ");ES_Pos.Put(I,Width=>13);Put(" ");
        ES_Pos.Put(Tiempos(I),Width=>9);Put(" |");
        New_Line;
    end loop;
    Put_line("+--------------------------+");
end Auxiliar;