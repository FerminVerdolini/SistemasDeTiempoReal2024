with Ada.Text_Io, Plan;use Ada.Text_Io, Plan;
with Proc; use Proc;

procedure Prueba is
    package Integer_Es is new Integer_Io (Integer);
    use Integer_Es;
    Tareas: array_reg_Planificacion_t := (
    -- -------------------------------------------------
    -- Tarea T D C P R Planificable
    -- -------------------------------------------------
    ( 1, 20, 20, 3, 1, 0, False ),
    ( 2, 20, 5, 3, 1, 0, False ),
    ( 3, 15, 7, 3, 1, 0, False ),
    ( 4, 10, 10, 4, 1, 0, False )
    -- -------------------------------------------------
                                );

    Tareas2: array_reg_Planificacion_t := (
    -- -------------------------------------------------
    -- Tarea T D C P R Planificable
    -- -------------------------------------------------
    ( 1, 2400, 600, 0, 1, 0, False ),
    ( 2, 3200, 1200, 0, 1, 0, False ),
    ( 3, 3600, 2000, 0, 1, 0, False ),
    ( 4, 4000, 3200, 0, 1, 0, False )
    -- -------------------------------------------------
                                );

    Procedimientos: array_ref_Procedimiento_t := (P1'Access, P2'Access,P3'Access, P4'Access);
    Tiempos: array_Tiempos_t (Procedimientos'Range);
                                                                    
begin
    Planificar (Tareas);
    Put_line (
    "+---------------------------------------------------+");
    Put_Line (
    "| Tarea  T  D  C  P  R  Planificable |");
    Put_line (
    "|---------------------------------------------------|");
    for I in Tareas'Range loop
        Put ("| ");
        Put (Tareas(I).Nombre, Width=>5); Put (" ");
        Put (Tareas(I).T, Width=>2); Put (" ");
        Put (Tareas(I).D, Width=>2); Put (" ");
        Put (Tareas(I).C, Width=>2); Put (" ");
        Put (Tareas(I).P, Width=>2); Put (" ");
        Put (Tareas(I).R, Width=>2); Put (" ");
        if Tareas(I).Planificable then
            Put_Line (" SI |");
        else
            Put_Line (" NO |");
        end if;
    end loop;
    Put_line (
    "+---------------------------------------------------+");

    Medir (Procedimientos, Tiempos);
    Put_line("+-------------------------+");
    Put_Line("| Procedimiento T.computo |");
    Put_line("|-------------------------|");
    for I in Tiempos'Range loop
        Put("| ");Put(I,Width=>13);Put(" ");
        Put(Tiempos(I),Width=>9);Put(" |");
        New_Line;        
        Tareas2(i).C := Tiempos(i);
    end loop;
    Put_line("+--------------------------+");

    Planificar (Tareas2);
    Put_line (
    "+---------------------------------------------------+");
    Put_Line (
    "| Tarea    T    D    C    P    R  Planificable |");
    Put_line (
    "|---------------------------------------------------|");
    for I in Tareas2'Range loop
        Put ("| ");
        Put (Tareas2(I).Nombre, Width=>5); Put (" ");
        Put (Tareas2(I).T, Width=>4); Put (" ");
        Put (Tareas2(I).D, Width=>4); Put (" ");
        Put (Tareas2(I).C, Width=>4); Put (" ");
        Put (Tareas2(I).P, Width=>4); Put (" ");
        Put (Tareas2(I).R, Width=>4); Put (" ");
        if Tareas2(I).Planificable then
            Put_Line (" SI |");
        else
            Put_Line (" NO |");
        end if;
    end loop;
    Put_line (
    "+---------------------------------------------------+");

end Prueba;
