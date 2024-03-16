with Ada.Text_Io, Colas; use Ada.Text_Io;
procedure Principal is
    package Colas_de_Integer is new Colas (Integer, Integer'image);
    use Colas_de_Integer;
    Practica_no_Apta: exception;

    C1, C2, C3: cola_t;
    E: Integer;
begin
    for I in 1..10 loop
        Poner (I, C1);
    end loop;
    Put_Line("En C1 tenemos ");
    MostrarCola(C1);
    for I in 11..20 loop
        Poner (I, C2);
    end loop;
    new_line;
    Put_Line("En C2 tenemos ");
    MostrarCola(C2);

    new_line;
    Put_Line("1.- Comprobando si C1 = C1 .... ");
    if C1 /= C1 then raise Practica_no_Apta; end if; Put("OK!");
    new_line;
    Put_Line("2.- Comprobando si C1 /= C2 .... ");
    if C1 = C2 then raise Practica_no_Apta; end if; Put("OK!");

    Poner (1, C3); Copiar (C2, C3);
    Put_Line("En C2 tenemos ");
    MostrarCola(C2);
    new_line;
    Put_Line("En C3 tenemos ");
    MostrarCola(C3);
    new_line;
    Put_Line("3.- Comprobando si C2 = C3 .... "); Put("OK!");
    if C2 /= C3 then raise Practica_no_Apta; end if;

    Put_Line("4.- Comprobando copiar .... ");
    Poner (100, C3);
    Poner (200, C2);
    Put_Line("En C2 tenemos ");
    MostrarCola(C2);
    new_line;
    Put_Line("En C3 tenemos ");
    MostrarCola(C3);
    new_line;
    if C2 = C3 then raise Practica_no_Apta; end if; Put("OK!");

    Quitar (E, C3);
    Put_Line("En C2 tenemos ");
    MostrarCola(C2);
    Put_Line("En C3 tenemos ");
    MostrarCola(C3);
    Put_Line("5.- Comprobando si C2 = C3 .... ");
    if C2 = C3 then raise Practica_no_Apta; end if; Put("OK!");


    while not Esta_Vacia (C2) loop
        Quitar (E, C2); Poner (E, C1);
    end loop;
    
    while not Esta_Vacia (C3) loop
    Quitar (E, C3);
    end loop;
    
    for I in 1..20 loop
        Poner (I, C2);
    end loop;
    Poner(200, C2);
    
    Put_Line("6.- Comprobando quitar .... ");
    if C1 /= C2 then raise Practica_no_Apta; end if; Put("OK!");

    while not Esta_Vacia (C3) loop
        Quitar (E, C3);
    end loop;
    while not Esta_Vacia (C2) loop
        Quitar (E, C2);
    end loop;
    for I in 1..20 loop
        Poner (I, C2);
    end loop;
    for I in 1..19 loop
        Poner (I, C3);
    end loop;

    Put_Line("En C2 tenemos ");
    MostrarCola(C2);
    new_line;
    Put_Line("En C3 tenemos ");
    MostrarCola(C3);
    new_line;
    Put_Line("7.- Comprobando si C2 = C3 .... ");
    if C2 = C3 then raise Practica_no_Apta; end if; Put("OK!");


    Put_Line("8.- Comprobando liberar memoria .... ");
    for I in 1..1e7 loop
    begin
        Poner (1, C1); Quitar (E, C1);
    exception
        when Storage_Error =>
            Put_Line ("Práctica no apta:");
            Put_Line ("La función Quitar no libera memoria.");
    end;
    end loop;
    Put_Line ("Práctica apta.");
exception
    when Practica_no_Apta =>
        Put_Line ("Práctica no apta:");
        Put_Line ("Alguna operación no está bien implementada.");
    when Storage_Error =>
        Put_Line ("Práctica no apta:");
        Put_Line ("Posible recursión infinita.");
end Principal;