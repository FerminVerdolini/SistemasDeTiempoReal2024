with Sensor; with Calefactor;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

procedure Medir is
    tiempo_delta: constant := 0.2;
    te, temp_act, temp_ant, temp_at_delta_max : Sensor.Temperaturas;
    pot : Calefactor.Potencias := 1000.00;

    Start_Time, Stop_Time_L, Stop_Time_Delta : Time;
    Elapsed_Time_L,Elapsed_Time_Delta : Time_Span;

    Siguiente_Instante: Time;
    Periodo: constant Time_Span := To_Time_Span(tiempo_delta);

    L,tiempo_at_delta_max : Duration;
    onRegimen : Boolean;
    temp_delta,temp_delta_max : Float;

    F         : File_Type;
    File_Name : constant String := "mediciones.txt";
begin
    Sensor.Leer(te);
    Put("Te = " & te'Image & "C");New_Line;

    Put("Calentando con = " & pot'Image & "W");New_Line;
    Calefactor.Escribir(pot);
    onRegimen := False;
    temp_act := Te;
    temp_delta_max := 0.0;
    
    Siguiente_Instante := Clock;
    Start_Time := Clock;

    loop
        delay until Siguiente_Instante;

        temp_ant := temp_act;
        Sensor.Leer(temp_act);
        temp_delta := Float(temp_act)-Float(temp_ant);
        if temp_delta > temp_delta_max then 
            temp_delta_max := temp_delta;
            temp_at_delta_max := temp_act;

            Stop_Time_Delta := Clock;
            Elapsed_Time_Delta := Stop_Time_Delta - Start_Time; 
            tiempo_at_delta_max:= To_Duration(Elapsed_Time_Delta);
            Put("t_0 = " & tiempo_at_delta_max'Image & "s" );New_Line;
        end if;
        Put("Temperatura actual del horno : " & temp_act'Image & "C");New_Line;
        if  (not onRegimen) and (temp_delta > 0.0) then 
            Stop_Time_L := Clock;
            Elapsed_Time_L := Stop_Time_L - Start_Time; 
            L:= To_Duration(Elapsed_Time_L);
            onRegimen := true;
            Put("L = " & L'Image & "s");New_Line;
        end if;

        exit when (onRegimen) and (temp_delta = 0.0) ;
           
        Siguiente_Instante := Siguiente_Instante + Periodo;

    end loop;
    
    Put("Te = " & te'Image & "C");New_Line;
    Put("L = " & L'Image & "s");New_Line;
    Put("dT = " & Float(temp_delta_max)'Image & "C");New_Line;
    Put("dt = " & tiempo_delta'Image & "s");New_Line;
    Put("P = " & Float(pot)'Image & "W");New_Line;
    Put("T = " & Float(temp_act)'Image & "C");New_Line;
    Put("T_0 = " & temp_at_delta_max'Image & "C" );New_Line;
    Put("t_0 = " & tiempo_at_delta_max'Image & "C" );New_Line;

-- Escribo estos datos en un txt lo optimo seria usar medir 2 apartir de estos
    Create (F, Out_File, File_Name);
    Put_Line (F, "Te = " & te'Image & "C");
    Put_line(F,"L = " & L'Image & "s");
    Put_Line (F, "dT = " & Float(temp_delta_max)'Image & "C");
    Put_Line (F, "dt = " & tiempo_delta'Image & "s");
    Put_Line (F, "P = " & Float(pot)'Image & "W");
    Put_Line (F, "T = " & Float(temp_act)'Image & "C");
    Put_Line(F,"T_0 = " & temp_at_delta_max'Image & "C" );
    Put_Line(F,"t_0 = " & tiempo_at_delta_max'Image & "C" );
    Close (F);

    Calefactor.Escribir(0.0);

end Medir;

--Periodo: constant Time_Span := To_Time_Span(Ts);
--Siguiente_Instante: Time := Clock;