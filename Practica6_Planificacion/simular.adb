with Ada.Text_IO, plan, proc;
use Ada.Text_IO, plan, proc;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Task_Identification; use Ada.Task_Identification;


procedure simular is
    type ref_Procedimiento_t is access procedure;

    task type Tarea_t (Nombre   : Natural;
                       T        : Natural;
                       D        : Natural;
                       C        : Natural;
                       P        : Natural;
                       Codigo_ciclico : ref_Procedimiento_t) is
                       pragma Priority (P);
    end Tarea_t;


    Tarea1: Tarea_t (1, 2400,  600, 400, 4, P1'Access);
    Tarea2: Tarea_t (2, 3200, 1200, 600, 3, P2'Access);
    Tarea3: Tarea_t (3, 3600, 2000, 800, 2, P3'Access);
    Tarea4: Tarea_t (4, 4000, 3200, 800, 1, P4'Access);
    
    task body Tarea_t is
        Siguiente_Instante: Time;
        Plazo : Time;
    begin
        Siguiente_Instante := Clock;
        loop
            delay until Siguiente_Instante;
            Plazo := Clock + Milliseconds(D);
            select
                delay until Plazo;
                Put_Line(Nombre'Image & " No ha cumplido el Plazo");
            then abort
                Codigo_ciclico.all;                
            end select;
            Siguiente_Instante := Siguiente_Instante + Milliseconds(T);
        end loop;                   
    end Tarea_t;
begin
    delay 50.0;
    Abort_Task(Tarea1'Identity);
    Abort_Task(Tarea2'Identity);
    Abort_Task(Tarea3'Identity);
    Abort_Task(Tarea4'Identity);
   
end simular;