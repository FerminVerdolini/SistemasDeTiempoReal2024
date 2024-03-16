-- Este programa pretende ilustrar la forma de manejo de las herramientas
-- del entorno de desarrollo en Ada.

-- Paquete est�ndar que vamos a manejar.
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_Io.Unbounded_io; use Ada.Text_Io.Unbounded_io;

-- Procedimiento principal.
procedure registros is

    
    type Return_t is (OK, Error);

    type Dia_t is new positive range 1..31;
    
    type Mes_t is (Enero,Febrero,Marzo,Abril
                    ,Mayo,Junio,Julio,Agosto,
                    Septiembre,Octubre,Noviembre,Diciembre);
    type Anio_t is new positive range 2000..2024;

    type Fecha_t is record
        dia : Dia_t;
        mes : Mes_t;
        anio : Anio_t;
    end record;
    
    type Nota_t is delta 0.1 range 0.0 .. 10.0;

    type Registro_t is record
        titulo : Unbounded_String;
        fecha  : Fecha_t;
        nota   : Nota_t;
    end record;
    type Registros_t is array(integer range <>) of Registro_t;
    type pRegistros_t is access Registros_t;
    
    -- Creaci�n de ejemplares, para la entrada/salida de n�meros, a partir
    -- de los paquete gen�ricos "Ada.Text_Io.Integer_Io" y
    -- "Ada.Text_Io.Float_Io".

    package ES_Pos is new Ada.Text_Io.Integer_Io(Positive);
    package ES_Float is new  Ada.Text_Io.Float_IO(Float);

    package ES_Dia is new Ada.Text_IO.Integer_IO(Dia_t);
    package ES_Mes is new Ada.Text_Io.Enumeration_Io(Mes_t);
    package ES_Anio is new Ada.Text_IO.Integer_IO(Anio_t);
    package ES_Nota is new Ada.Text_IO.Fixed_IO(Nota_t);
    --package ES_Promedio is new Ada.Text_IO.Fixed_IO(Promedio_t);

    -- Procedimiento que recibe:
    --     -(in out) el puntero del arreglo de registros
    --     -(in) la posicion a cargar de la fecha
    --     -(out) El retorno de error de la funcion
    -- Este procedimiento recibe la entrada de la fecha de la con un manejo de excepciones
    procedure inputFecha( r :in out pRegistros_t; i : Positive; retval : out Return_t) is
    begin
        Put("Fecha. Dia: ");
        ES_Dia.Get(r(i).fecha.dia);
        Put("Mes: ");
        ES_Mes.Get(r(i).fecha.mes);
        Put("Anio: ");
        ES_Anio.Get(r(i).fecha.anio);
        retval := OK;
    exception
        when Constraint_Error =>
        Put("La fecha ingresada no es valida. Intente nuevamente: ");New_Line;
        retval := Error;
        when others =>
        Put("La fecha ingresada no es valida. Intente nuevamente: ");New_Line;
        retval := Error;
    end inputFecha;

    -- Retorna la fecha mas antigua de los registros
    function fechaMasAntigua(r : pRegistros_t) return Fecha_t is
        firstFecha : Fecha_t;
    begin
        firstFecha := r(r'First).fecha;
        for i in r'Range loop
            if r(i).fecha.anio < firstFecha.anio then
                firstFecha := r(i).fecha;
            elsif r(i).fecha.anio = firstFecha.anio then

                if Mes_t'pos(r(i).fecha.mes) < Mes_t'pos(firstFecha.mes) then
                    firstFecha := r(i).fecha;
                elsif r(i).fecha.mes = firstFecha.mes then

                    if r(i).fecha.dia < firstFecha.dia then
                        firstFecha := r(i).fecha;
                    end if;

                end if;

            end if;
        end loop;
        return firstFecha;
    end fechaMasAntigua;

    --Retorna la fecha mas reciente de los registros
    function fechaMasReciente(r : pRegistros_t) return Fecha_t is
        lastFecha : Fecha_t;
    begin
        lastFecha := r(r'First).fecha;
        for i in r'Range loop
            if r(i).fecha.anio > lastFecha.anio then
                lastFecha := r(i).fecha;
            elsif r(i).fecha.anio = lastFecha.anio then

                if Mes_t'pos(r(i).fecha.mes) > Mes_t'pos(lastFecha.mes) then
                    lastFecha := r(i).fecha;
                elsif r(i).fecha.mes = lastFecha.mes then

                    if r(i).fecha.dia > lastFecha.dia then
                        lastFecha := r(i).fecha;
                    end if;

                end if;

            end if;
        end loop;
        return lastFecha;
    end fechaMasReciente;
    -- Declaraci�n de variables locales.
    size, maxPos, minPos: Positive;
    maxAux: Nota_t := Nota_t'First;
    minAux: Nota_t := Nota_t'Last;
    prom: Float := 0.0;
    r : pRegistros_t;
    retval : Return_t;
begin
    Put("Numero de registros: ");
    ES_Pos.Get(size);

    r := new Registros_t(1..(size));
    for i in r'Range loop
        New_Line;

        Put("Registro nro. " & i'Image);New_Line;
        
        Put("Título: ");
        Skip_Line;
        Get_Line(r(i).titulo);

        loop
            inputFecha(r,i,retval);
            exit when retval = OK;
        end loop;

        Put("Nota: ");
        ES_Nota.Get(r(i).nota);
        
        if r(i).nota > maxAux then
            maxAux := r(i).nota;
            maxPos := i;
        end if;

        if r(i).nota < minAux then
            minAux := r(i).nota;
            minPos := i;
        end if;

        prom := prom + (Float(r(i).nota));
    end loop;
    New_Line;

    Put("Estadisticas");
    New_Line;
    Put("Nota mínima:" & minAux'Image & " Pelicula: ");
    Put(r(minPos).titulo);
    Put(" alquilada el" & r(minPos).fecha.dia'Image & " de " & r(minPos).fecha.mes'Image & " de" & r(minPos).fecha.anio'Image);
    New_Line;
    Put("Nota maxima:" & maxAux'Image & " Pelicula: ");
    Put(r(maxPos).titulo);
    Put(" alquilada el" & r(maxPos).fecha.dia'Image & " de " & r(maxPos).fecha.mes'Image & " de" & r(maxPos).fecha.anio'Image);
    
    New_Line;
    prom := prom/Float(size);
    Put("La Nota media del periodo" & fechaMasAntigua(r).dia'Image & " de " & fechaMasAntigua(r).mes'Image & " de" & fechaMasAntigua(r).anio'Image);
    Put(" a" & fechaMasReciente(r).dia'Image & " de " & fechaMasReciente(r).mes'Image & " de" & fechaMasReciente(r).anio'Image & " ha sido de");
    ES_Float.Put(prom, Aft => 2, Exp => 0);

end registros;

