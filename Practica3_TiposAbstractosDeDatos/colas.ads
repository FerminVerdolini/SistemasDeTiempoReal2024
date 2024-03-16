with ada.Unchecked_Deallocation;

generic
    type elemento_t is private;
    with function ToString(el_Elemento: elemento_t) return string;
package Colas is
    type cola_t is limited private;

    procedure Poner (elemento: elemento_t; cola: in out cola_t);
    procedure Quitar (elemento: out elemento_t; cola: in out cola_t);

    function Esta_Vacia (cola: cola_t) return Boolean;
    function Esta_Llena (cola: cola_t) return Boolean;
    procedure MostrarCola (cola: cola_t);

    procedure Copiar ( origen: cola_t; destino:in out cola_t);
    function "="(cola1, cola2: cola_t) return Boolean;
private
    -- Definición del tipo "cola_t"
    -- En esta ocasión se implementa una cola dinámica
    type nodo_t;
    type ref_nodo is access nodo_t;
    type nodo_t is record
        Datos: elemento_t;
        ptr_Siguiente: ref_Nodo;
    end record;
    type cola_t is record
        ptr_Primero,
        ptr_Ultimo : ref_Nodo;
    end record;
    procedure Liberar is new Ada.Unchecked_Deallocation(nodo_t,ref_nodo);
    procedure Vaciar (cola: in out cola_t);
    function size (cola : cola_t) return Integer;
end Colas;