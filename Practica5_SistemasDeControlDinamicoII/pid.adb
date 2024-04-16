package body PID is


    procedure Programar (el_Controlador: in out Controlador;
                            Kp, Ki, Kd:        Real) is 
    begin
        Controlador.Kd := kd;
        Controlador.Ki := Ki;
        Controlador.Kp := kp;
    end Programar;

    procedure Controlar (con_el_Controlador: in out Controlador;
                                     R, C:        Entrada;
                                        U: out    Salida) is 
    begin
        U := Controlador.Kp * ((R-C)+((1/Controlador.Ki)*Controlador.S_Anterior*0.2)+(Controlador.Kd*(((R-C)-Controlador.Error_Anterior)/(0.2))));
    end Programar;

end PID;
