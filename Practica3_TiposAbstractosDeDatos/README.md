## Práctica 3

# Tipos abstractos de datos

Con esta práctica se pretende que el alumno:

* construya una unidad reutilizable e implemente un tipo abstracto de datos con la semántica de las
  colas y

* trabaje con tipos puntero y controle la recolección de memoria basura.

### 3.1 Tareas a Realizar

Escribir un paquete de nombre Colas que se ajuste a la especificación siguiente:

> **Fichero 3.1**: Especificación del paquete `Colas` (`colas.ads`)

```ada
generic
    type elemento_t is private;
    with function ToString(el_Elemento: elemento_t) return string;
package Colas is
    type cola_t is limited private;

    procedure Poner (el_Elemento: elemento_t; en_la_Cola: in out cola_t);
    procedure Quitar (un_Elemento: out elemento_t; de_la_Cola: in out cola_t);

    function Esta_Vacia (La_Cola: cola_t) return Boolean;
    function Esta_Llena (La_Cola: cola_t) return Boolean;
    procedure MostrarCola (La_Cola: cola_t);

    procedure Copiar ( Origen: cola_t; Destino:in out cola_t);
    function "="(La_Cola, Con_La_Cola: cola_t) return Boolean;
private
    -- Definición del tipo "cola_t"
    -- En esta ocasión se implementa una cola dinámica
    type Nodo;
    type ref_Nodo is access Nodo;
    type Nodo is record
        Datos: elemento_t;
        ptr_Siguiente: ref_Nodo;
    end record;
    type cola_t is record
        ptr_Primero,
        ptr_Último : ref_Nodo;
    end record;
end Colas;
```

    El tipo `Cola` se implementará como una lista lineal simplemente enlazada. Para ello será necesario trabajar con tipos puntero. Siempre que se trabaja con punteros hay que prestar atención a la recolección de la memoria basura. 

    Algunos compiladores de Ada disponen de un recolector para la memoria basura, la cual es liberada automáticamente cuando no hay ninguna referencia a ella o cuando el tipo acceso que se utiliza para crearla deja de ser visible. La forma de trabajo del recolector no está definida en la norma por lo que depende de cada compilador. La periodicidad, no predecible, del funcionamiento del recolector introduce demoras en el funcionamiento global del sistema y esta sobrecarga es inadmisible en algunos sistemas de tiempo real

    Para dar respuesta a este problema, la norma *RM95* define un procedimiento genérico para liberar memoria en los instantes especificados por la aplicación. Este procedimiento se llama  `Ada.Unchecked_Deallocation`. Aunque no se comprenda toda la información ofrecida sobre el procedimiento `Unchecked_Deallocation`,
el alumno debe poder extraer aquella información que le permita construir un procedimiento derivado, de nombre `Liberar`, que sirva para liberar memoria de acuerdo con las necesidades de la práctica.

    Para probar este paquete puede utilizarse el programa siguiente:

> **Programa 3.2**: Prueba del paquete `Colas` (`principal.adb`)

```ada
with Ada.Text_Io, Colas; use Ada.Text_Io;
procedure Principal is
    package Colas_de_Integer is new Colas (Integer, Integer’image);
    use Colas_de_Integer;
    Práctica_no_Apta: exception;

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
    if C1 /= C1 then raise Práctica_no_Apta; end if; Put("OK!");
    new_line;
    Put_Line("2.- Comprobando si C1 /= C2 .... ");
    if C1 = C2 then raise Práctica_no_Apta; end if; Put("OK!");

    Poner (1, C3); Copiar (C2, C3);
    Put_Line("En C2 tenemos ");
    MostrarCola(C2);
    new_line;
    Put_Line("En C3 tenemos ");
    MostrarCola(C3);
    new_line;
    Put_Line("3.- Comprobando si C2 = C3 .... "); Put("OK!");
    if C2 /= C3 then raise Práctica_no_Apta; end if;

    Put_Line("4.- Comprobando copiar .... ");
    Poner (100, C3);
    Poner (200, C2);
    Put_Line("En C2 tenemos ");
    MostrarCola(C2);
    new_line;
    Put_Line("En C3 tenemos ");
    MostrarCola(C3);
    new_line;
    if C2 = C3 then raise Práctica_no_Apta; end if; Put("OK!");

    Quitar (E, C3);
    Put_Line("En C2 tenemos ");
    MostrarCola(C2);
    Put_Line("En C3 tenemos ");
    MostrarCola(C3);
    Put_Line("5.- Comprobando si C2 = C3 .... ");
    if C2 = C3 then raise Práctica_no_Apta; end if; Put("OK!");


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
    if C1 /= C2 then raise Práctica_no_Apta; end if; Put("OK!");

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
    if C2 = C3 then raise Práctica_no_Apta; end if; Put("OK!");


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
    when Práctica_no_Apta =>
        Put_Line ("Práctica no apta:");
        Put_Line ("Alguna operación no está bien implementada.");
    when Storage_Error =>
        Put_Line ("Práctica no apta:");
        Put_Line ("Posible recursión infinita.");
end Principal;
```

    En la segunda parte de esta práctica vamos a modificar el paquete `Fracciones` de la práctica anterior añadiéndole una función nueva y vamos a crear una cola de fracciones con el paquete `Cola`

1. Añade a tu paquete `Fracciones` de la práctica anterior una función pública con la siguiente forma `function Imprimir (F:fraccion_t) return string;`

2. Crea un procedimiento principal en un nuevo fichero `Cola_Fracciones.adb` que, haciendo uso del paquete `Fracciones` y el paquete `Cola` cree un paquete para implementar colas de fracciones

3. En el código de `Cola_Fracciones.adb` crea una cola de fracciones y rellénala, utilizando dos bucles for anidados con los valores:
   
   $$
   \frac{1}{1},\frac{1}{2},\frac{1}{3},\frac{1}{4},\frac{2}{1},\frac{2}{2},\frac{2}{3},\frac{2}{4},\frac{3}{1},\frac{3}{2},\frac{3}{3},\frac{3}{4},\frac{4}{1},\frac{4}{2},\frac{4}{3},\frac{4}{4},
   $$

4. Muestra por pantalla los valores de la cola de fracciones

---
[GitHub - FerminVerdolini/SistemasDeTiempoReal2024: Sistemas de Tiempo Real 2024 - UAH - EPS](https://github.com/FerminVerdolini/SistemasDeTiempoReal2024)
