with Ada.Text_Io, Colas, Fracciones; use Ada.Text_Io,Fracciones;
procedure Cola_Fracciones is
    package Colas_de_Fracciones is new Colas (fraccion_t, Imprimir);
    use Colas_de_Fracciones;

    C: cola_t;
begin
--  Se comenta la reduccion de las fracciones 
--  para que 2/2 no sea 1/1
--  y asi cumplir con la consigna :D
    for I in 1..4 loop
        for J in 1..4 loop
            Poner((I/J),C);
        end loop;
    end loop;
    Put("Cola de fracciones: ");
    MostrarCola(C);
end Cola_Fracciones;
