with Sensor; with Calefactor;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

procedure Medir2 is

    dTiempo  : constant := 0.2;
    P        : Calefactor.Potencias := 1000.00;
    te       : Sensor.Temperaturas := 20.0;
    T        : Sensor.Temperaturas := 86.6629;
    cp       : Float := 15.0;
    ct_delta_max   : Float;
    ct_aux   : Float;

    Periodo: constant Time_Span := To_Time_Span(dTiempo);
    temp_act,temp_ant : Sensor.Temperaturas;
    Siguiente_Instante: Time;
    temp_delta_max : Float := 0.0;
    temp_delta : Float ;
    onRegimen : Boolean := False;

begin
    Sensor.Leer(temp_act);
    
    Put("Calentando con = " & P'Image & "W");New_Line;
    Calefactor.Escribir(P);
    Siguiente_Instante := Clock;    

    loop
        delay until Siguiente_Instante;

        temp_ant := temp_act;
        Sensor.Leer(temp_act);
        temp_delta := Float(temp_act)-Float(temp_ant);
        
        if (not onRegimen) and (temp_delta /= 0.0) then
            onRegimen := true;
        end if;

        if (onRegimen) and temp_delta /= 0.0 then 
            ct_aux := ((Float(P) - cp * (Float(temp_act) - Float(te)) ) * dTiempo) / temp_delta; 
            Put("ct actual con t actual= : " & ct_aux'Image & "C");New_Line;
            
            if (temp_delta > temp_delta_max) then
            ct_delta_max := ct_aux;
            end if;

        
        end if;
        exit when (onRegimen) and (temp_delta = 0.0);

        Siguiente_Instante := Siguiente_Instante + Periodo;

    end loop;
    
            
    Put("ct Final = " & ct_aux'Image & "W/C");New_Line;
    Put("ct delta Maximo = " & ct_delta_max'Image & "W/C");New_Line;


    Calefactor.Escribir(0.0);

end Medir2;