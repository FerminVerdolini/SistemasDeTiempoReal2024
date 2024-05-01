with Ada.Execution_Time; use Ada.Execution_Time;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;

package body Plan is
    procedure Medir(Procedimientos: array_ref_Procedimiento_t;
                Tiempos : out array_Tiempos_t) is
        Start_Cpu_Time, Stop_Cpu_Time : CPU_Time;
        Elapsed_Cpu_Time : Time_Span;
    begin
        for i in Procedimientos'Range loop            
            Start_Cpu_Time := Clock;
            Procedimientos(i).all;
            Stop_Cpu_Time := Clock;
            Elapsed_Cpu_Time := Stop_Cpu_Time - Start_Cpu_Time; 
            Tiempos(i) := Integer(To_Duration(Elapsed_Cpu_Time) * 1000);
        end loop;
    end Medir;

    procedure set_Prioridad(Tareas: in out array_reg_Planificacion_t) is
    begin
        for i in Tareas'Range loop
            Tareas(i).P := 1;
            for j in Tareas'Range loop
                if  i /= j then
                    if Tareas(i).D < Tareas(j).D then
                        Tareas(i).P := Tareas(i).P + 1;
                    elsif Tareas(i).D = Tareas(j).D then
                        if Tareas(i).C > Tareas(j).C then
                            Tareas(i).P := Tareas(i).P + 1;
                        end if;     
                    end if;
                end if;   
            end loop;
        end loop;
    end Set_Prioridad;

    procedure ordenar_Tareas(Tareas: in out array_reg_Planificacion_t) is
        Tareas_Ordenadas : array_reg_Planificacion_t := Tareas;
    begin
        for i in Tareas'Range loop
            for j in Tareas'Range loop
                if Tareas(j).P = (Tareas'Length - (i-1)) then
                    Tareas_Ordenadas(i) := Tareas(j);
                end if;
            end loop;
        end loop;
        Tareas := Tareas_Ordenadas;
    end ordenar_Tareas;

    procedure set_Respuesta(Tareas: in out array_reg_Planificacion_t) is
        w_act,w_ant :Float;
        n : Integer;
    begin
        for i in Tareas'Range loop
            n:=0;
            w_act := Float(Tareas(i).C);
            loop
                w_ant := w_act;
                w_act := Float(Tareas(i).C);
                for j in 1..i loop
                    if j /= i then
                        w_act := w_act + (Float'Ceiling(w_ant / Float(Tareas(j).T)) * Float(Tareas(j).C));
                    end if;
                end loop;
                if  w_act = w_ant then
                    Tareas(i).R := Natural(w_act);
                    Tareas(i).Planificable := True;
                    exit;
                elsif w_act > Float(Tareas(i).D) then
                    Tareas(i).R := Natural(w_act);
                    Tareas(i).Planificable := False;
                    exit;
                end if;
            end loop;
        end loop;
    end set_Respuesta;

    procedure Planificar(Tareas: in out array_reg_Planificacion_t) is
    begin
        set_Prioridad(Tareas);    
        ordenar_Tareas(Tareas);

        set_Respuesta(Tareas);
    end Planificar;
end Plan;