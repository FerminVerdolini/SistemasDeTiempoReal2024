with Ada.Text_IO; use Ada.Text_IO;

package body PID is


    procedure Programar (el_Controlador: in out Controlador;
                            Kp, Ki, Kd:        Real) is 
    begin
        el_Controlador.Kd := kd;
        el_Controlador.Ki := Ki;
        el_Controlador.Kp := kp;
    end Programar;

    procedure Controlar (con_el_Controlador: in out Controlador;
                                     R, C:        Entrada;
                                        U: out    Salida) is 
    E : Real;
    begin
        E := Real(R-C);

        con_el_Controlador.S_Anterior := con_el_Controlador.S_Anterior + E; 
    

        U := Salida(con_el_Controlador.Kp * (E+
                                            Real((Real(1)/con_el_Controlador.Ki)*con_el_Controlador.S_Anterior*Real(0.2))+
                                            Real(con_el_Controlador.Kd*(((E)-con_el_Controlador.Error_Anterior)/Real(0.2)))));

        con_el_Controlador.Error_Anterior := Real(E);
    end Controlar;

end PID;
