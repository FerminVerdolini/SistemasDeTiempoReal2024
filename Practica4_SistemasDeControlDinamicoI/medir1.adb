with Sensor; with Calefactor;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

procedure Medir1 is
    tiempo_delta: constant := 0.2;
    te, temp_act, temp_ant : Sensor.Temperaturas;
    pot : Calefactor.Potencias := 1000.00;
    tiempo,Siguiente_Instante: Time;
    Periodo: constant Time_Span := To_Time_Span(tiempo_delta);
    count : Seconds_Count;
    Sub : Time_Span;
    L : Duration;
    onRegimen : Boolean;
    Cp,temp_delta,temp_delta_max : Float;

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
    tiempo := Clock;
    

    loop
        delay until Siguiente_Instante;

        temp_ant := temp_act;
        Sensor.Leer(temp_act);
        temp_delta := Float(temp_act)-Float(temp_ant);
        if temp_delta > temp_delta_max then 
            temp_delta_max := temp_delta;
        end if;
        Put("Temperatura actual del horno : " & temp_act'Image & "C");New_Line;
        if  (not onRegimen) and (temp_delta > 0.0) then 
            Split (T => tiempo, SC => Count, TS => Sub);
            L:= To_Duration(Sub);
            onRegimen := true;
            Put("L = " & L'Image & "s");New_Line;
        end if;

        if(onRegimen) and (temp_delta = 0.0) then
            Cp := (Float(pot))/(Float(temp_act)-Float(te));
            exit;
        end if;
        Siguiente_Instante := Siguiente_Instante + Periodo;

    end loop;
    
    Put("Te = " & te'Image & "C");New_Line;
    Put("L = " & L'Image & "s");New_Line;
    Put("dT = " & Float(temp_delta_max)'Image & "C");New_Line;
    Put("dt = " & tiempo_delta'Image & "s");New_Line;
    Put("P = " & Float(pot)'Image & "W");New_Line;
    Put("T = " & Float(temp_act)'Image & "C");New_Line;
    Put("Cp = " & Cp'Image & "W/C");New_Line;

-- Escribo estos datos en un txt lo optimo seria usar medir 2 apartir de estos
    Create (F, Out_File, File_Name);
    Put_Line (F, "Te = " & te'Image & "C");
    Put_Line (F, "dT = " & Float(temp_delta_max)'Image & "C");
    Put_Line (F, "dt = " & tiempo_delta'Image & "s");
    Put_Line (F, "P = " & Float(pot)'Image & "W");
    Put_Line (F, "T = " & Float(temp_act)'Image & "C");
    Put_Line (F, "Cp = " & Cp'Image & "W/C");
    Close (F);

    Calefactor.Escribir(0.0);

end Medir1;

--Periodo: constant Time_Span := To_Time_Span(Ts);
--Siguiente_Instante: Time := Clock;