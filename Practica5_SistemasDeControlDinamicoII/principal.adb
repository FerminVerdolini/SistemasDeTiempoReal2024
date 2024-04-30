with Sensor; with Calefactor; with PID;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

procedure Principal is
    Ts: constant := 0.2;
    T, Tref : Sensor.Temperaturas;
    P : Calefactor.Potencias ;

    Start_Time, Current_Time : Time;
    Elapsed_Time : Time_Span;

    Siguiente_Instante: Time;
    Periodo: constant Time_Span := To_Time_Span(Ts);

    package ES_Temp is new Ada.Text_IO.Float_IO(Sensor.Temperaturas);
    package Control_Horno is new
                   PID (Real => Float,
                               Entrada => Sensor.Temperaturas,
                                  Salida => Calefactor.Potencias);
    
    C : Control_Horno.Controlador;

    F         : File_Type;
    File_Name : constant String := "PID.txt";
begin
    Control_Horno.Programar(C,1.01164, 3.20038, 0.800095); --Paso las constantes que calcule en el punto 1
    
    Put("Ingrese temperatura de referencia:");New_Line;
    ES_Temp.Get(Tref);    
    
    Siguiente_Instante := Clock;
    Start_Time := Clock;

    Create (F, Out_File, File_Name);
    

    loop
        delay until Siguiente_Instante;

        Sensor.Leer(T);

        Control_Horno.Controlar(C,Tref,T,P);

        Calefactor.Escribir(P);

        Put("Temperatura actual del horno : " & T'Image & "C");New_Line;

        Put_Line (F, T'Image);

        Current_Time := Clock;
        Elapsed_Time := Current_Time - Start_Time; 
        exit when Float(To_Duration(Elapsed_Time)) /60.0 > 10.0 ; 
        
           
        Siguiente_Instante := Siguiente_Instante + Periodo;

    end loop;
    
    Close (F);

    Calefactor.Escribir(0.0);

end Principal;

--Periodo: constant Time_Span := To_Time_Span(Ts);
--Siguiente_Instante: Time := Clock;