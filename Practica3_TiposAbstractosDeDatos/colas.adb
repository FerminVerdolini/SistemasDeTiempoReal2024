with ada.Text_Io; use ada.Text_Io;
package body Colas is

    procedure Poner (elemento: elemento_t; 
                        cola: in out cola_t) is
    nodo_pointer : ref_nodo := new nodo_t;                     
    begin

        nodo_pointer.Datos := elemento;
        nodo_pointer.ptr_Siguiente := null;
    
        if Esta_Vacia(cola) then 
            cola.ptr_Ultimo := nodo_pointer;
            cola.ptr_Primero := nodo_pointer;
        else
            cola.ptr_ultimo.ptr_Siguiente := nodo_pointer;
            cola.ptr_Ultimo := nodo_pointer;
        end if;
    
    end Poner;

    procedure Quitar (elemento: out elemento_t; 
                        cola: in out cola_t) is                     
    nodo_pointer : ref_nodo ;                         
    begin
        if not Esta_Vacia(cola) then        
            nodo_pointer := cola.ptr_Primero;
            if nodo_pointer = cola.ptr_Ultimo then
                cola.ptr_Ultimo := null;
                cola.ptr_Primero := null;
            else
                cola.ptr_Primero := nodo_pointer.ptr_Siguiente;
            end if;
            elemento := nodo_pointer.Datos;
            Liberar(nodo_pointer);

        end if;

    end Quitar;

    function Esta_Vacia (cola: cola_t) return Boolean is
    begin
        return cola.ptr_Primero = null;
    end Esta_Vacia;

    function Esta_Llena (cola: cola_t) return Boolean is
    begin
        return False;
    end Esta_Llena;

    procedure MostrarCola (cola : cola_t) is
    nodo_pointer : ref_nodo;                         
    begin
        if not Esta_Vacia(cola) then
        nodo_pointer := cola.ptr_Primero;
            new_line;
            loop
                Put(ToString(nodo_pointer.Datos));
                exit when nodo_pointer = cola.ptr_Ultimo;
                Put(",");
                nodo_pointer := nodo_pointer.ptr_Siguiente;
            end loop;  
            new_line;
        end if;
    end MostrarCola;

    procedure Copiar(origen: cola_t; destino:in out cola_t) is
    nodo_pointer : ref_nodo ;                         
    begin
        Vaciar(destino);
        if not Esta_Vacia(origen) then
            nodo_pointer := origen.ptr_Primero;
            loop
                Poner(nodo_pointer.Datos,destino);
                exit when nodo_pointer = origen.ptr_Ultimo;
                nodo_pointer := nodo_pointer.ptr_Siguiente;
            end loop;    
        end if;
    end Copiar;

    function "=" (cola1, cola2: cola_t) return Boolean is
    retval : Boolean := True;
    nodo_pointer1,nodo_pointer2 : ref_nodo;                         
    begin
        if size(cola1) /= size(cola2) then
            retval := false;
        elsif not (Esta_Vacia(cola1) and Esta_Vacia(cola2)) then
            nodo_pointer1 := cola1.ptr_Primero;
            nodo_pointer2 := cola2.ptr_Primero;
            loop
                if nodo_pointer1.Datos /= nodo_pointer2.Datos then
                    retval := false;
                    exit;
                end if;
                exit when (nodo_pointer1 = cola1.ptr_Ultimo) or
                        (nodo_pointer2 = cola2.ptr_Ultimo);
                nodo_pointer1 := nodo_pointer1.ptr_Siguiente;
                nodo_pointer2 := nodo_pointer2.ptr_Siguiente;
            end loop;    
        end if;  

        return retval;          
    end "=";

    function size (cola : cola_t) return Integer is
    retval : Integer :=0;
    nodo_pointer : ref_nodo;
    begin 
        if not Esta_Vacia(cola) then
           nodo_pointer := cola.ptr_Primero;
           loop
                retval := retval + 1;
                exit when nodo_pointer = cola.ptr_Ultimo;
                nodo_pointer := nodo_pointer.ptr_Siguiente;
            end loop;  
        end if;

        return retval;
    end size;

    procedure Vaciar (cola: in out cola_t) is
    elm : elemento_t;
    begin        
        loop
            exit when Esta_Vacia(cola);
            Quitar(elm,cola);
        end loop;  
    end Vaciar;
end Colas;