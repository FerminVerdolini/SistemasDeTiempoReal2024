with Ada.Text_Io, Fracciones;
with Ada.Exceptions;
use Ada.Text_Io, Fracciones;

procedure Prueba is
    package Integer_Es is new Integer_Io (Integer);
    use Integer_es;
    Practica_no_Apta: exception;
    A: fraccion_t := 2/3;
    B: fraccion_t := (-9)/18;
    P: fraccion_t := 0/5;

begin

    if Numerador (B) /= -1 or
        Denominador (B) /= 2 then
        raise Constraint_Error;
    end if;
    Put("El valor de A = ");
    Escribir(A);
    Put(" El valor de B = ");
    Escribir(B);
    Put(" El valor de P = ");
    Escribir(P);
    Put_Line(" ");
    if B /= 1/(-2) then raise Practica_no_Apta;
    end if;
    Put("A+B = ");
    Escribir(A+B);
    if A+B /= 1/(6) then raise Practica_no_Apta;
    end if;
    Put("-A = ");
    Escribir(-A);
    if -A /= -2/3 then raise Practica_no_Apta;
    end if;
    Put("A-B = ");
    Escribir(A-B);
    if A-B /= 7/6 then raise Practica_no_Apta; end if;
    Put("A*B = ");
    Escribir(A*B);
    if A*B /= -1/3 then raise Practica_no_Apta; end if;
    Put("A/B = ");
    Escribir(A/B);
    if A/B /= -4/3 then raise Practica_no_Apta; end if;
    Put("A-B = ");
    Escribir(A-B);
    if A-B /= 7/6 then raise Practica_no_Apta; end if;
    Put("A-A = ");
    Escribir(A-A);
    if A-A /= 0/3 then raise Practica_no_Apta; end if;

    Put("A/P = ");
    Escribir(A/P);
    P:=A/P;
    P:=1/1;
    for I in 1..10 loop
        P:=P*B;
    end loop;
    if P/= 1/1024 then raise Practica_no_Apta; end if;
    Put_Line ("Práctica apta");
exception
    when Ocurrencia : Practica_no_Apta =>
        Put_line ("Práctica no apta.");
        Put (Ada.Exceptions.Exception_Information (Ocurrencia));
    when Ocurrencia : Constraint_Error =>
        Put_Line ("Práctica no apta:");
        Put_Line ("Las fracciones tienen que representarse mediante");
        Put_Line ("fracciones irreducibles");
        Put_Line ("Es necesario reducir las fracciones");
        Put_Line (Ada.Exceptions.Exception_Information (Ocurrencia));
end Prueba;