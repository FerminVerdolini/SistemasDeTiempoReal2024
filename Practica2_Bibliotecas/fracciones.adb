with Ada.Text_Io; use Ada.Text_Io;

package body Fracciones is
    package ES_Pos is new Ada.Text_Io.Integer_Io(Positive);
    package ES_Int is new Ada.Text_Io.Integer_Io(Integer);
    --Operador de suma
    function "+" (X, Y: fraccion_t) return fraccion_t is
        retval : fraccion_t;
    begin
        retval.Num := (X.Num * Y.Den) + (Y.Num * X.Den);
        retval.Den := (X.Den * Y.Den);

        Reduce(retval);

        return retval;
    end "+";

    --Operador de elemento opuesto
    function "-" (X: fraccion_t) return fraccion_t is
        retval : fraccion_t;
    begin
        retval.Num := -(X.Num);
        retval.Den :=  (X.Den);

        Reduce(retval);

        return retval;
    end "-";

    --Operador de resta
    function "-" (X, Y: fraccion_t) return fraccion_t is
        retval : fraccion_t;
    begin
        -- Utiliza los operadores de suma y de elemento opuesto
        retval := X + (-Y);

        Reduce(retval);

        return retval;
    end "-";

    --Operador de producto
    function "*" (X, Y: fraccion_t) return fraccion_t is
        retval : fraccion_t;
    begin
        retval.Num := (X.Num * Y.Num);
        retval.Den := (X.Den * Y.Den);

        Reduce(retval);

        return retval;
    end "*";

   
    --Operador de division
    function "/" (X, Y: fraccion_t) return fraccion_t is
        retval : fraccion_t;
    begin
        if(Y.Num = 0) then
            Put("Error: No se puede dividir por cero");
            new_line;
        else
            if(Y.Num < 0) then 
                retval.Num := - (X.Num * Y.Den);
                retval.Den := ABS (X.Den * Y.Num);
            else
                retval.Num := (X.Num * Y.Den);
                retval.Den := (X.Den * Y.Num);
            end if;    
                Reduce(retval);
        end if;


    return retval;
    end "/";

    --Operador Logico de Igualdad
    function "=" (X, Y: fraccion_t) return Boolean is
        retval : Boolean;
    begin
        --Equivalencia segun conjunto reducible
        retval := ((X.Num * Y.Den) = (X.Den * Y.Num));

        return retval;
    end "=";

    --Funcion que ejecuta el algoritmo de Euclides
    function mcd(a,b : Integer) return Integer is
    auxrem,aux1,aux2 : Integer;
    begin
        aux1 := a;
        aux2 := b;

        --Mientras el resto de la division sea diferente de 0
        --Divido el segundo valor por el resto
        loop
            auxrem := aux1 rem aux2;

            exit when auxrem = 0;

            aux1 := aux2;
            aux2 := auxrem;
        end loop;

        --Returno el valor mas pequenio de la division cuando el resto es 0
        return ABS aux2;
    end mcd;

    procedure Reduce (X : in out fraccion_t) is
    m : Integer;
    begin
        m :=mcd(X.Num,X.Den);

        if(X.Den = 0 ) then
            Put("Error: No se puede divir por cero");
            new_line;
        else
            X.Num := X.Num / m;
            X.Den := X.Den / m;
        end if;

    end Reduce;

    procedure Leer (F: out fraccion_t) is
    begin
        ES_INT.get(F.Num);
        ES_Pos.get(F.Den);
    end Leer;
    
    procedure Escribir (F: fraccion_t) is
    begin
        new_line;ES_Int.put(F.Num);
        Put("/");
        ES_Pos.put(F.Den);new_line;
    end Escribir;

    function "/" (X, Y: Integer) return fraccion_t is
    retval : fraccion_t;
    begin
        if(Y<0) then         
            retval.Num :=   -X;
            retval.Den :=ABS Y;
        else
            retval.Num := X;
            retval.Den := Y;
        end if;

        Reduce(retval);

        return retval;
    end "/";


    function Numerador (F: fraccion_t) return Integer is
    begin
        return F.Num;
    end Numerador;

    function Denominador (F: fraccion_t) return Positive is
    begin
        return F.Den;
    end Denominador;
end Fracciones;