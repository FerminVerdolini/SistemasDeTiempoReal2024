## SRTPractica2

# Bibliotecas

    Con esta práctica se pretende que el alumno:

* empiece a estructurar las aplicaciones usando el concepto de biblioteca 

* implemente una biblioteca usando los paquetes de Ada.

### 2.1 Requisitos

1. Entorno de programación en Ada. Para ello conviene recordar la práctica nro. 2 pág. 3.

2. Programación a pequeña escala en lenguaje Ada.

3. Implementación de paquetes y de tipos privados limitados. (Toda esta teoría se desarrolla en la L25 «*Programación a gran escala*» de la asignatura).

### 2.2 Introducción teórica

    En esta práctica vamos a escribir una biblioteca para trabajar con números fraccionarios. Estos números se construyen como parejas de números enteros: $Q = Z × Z = {(n, d); n ∈ Z \wedge d ∈ Z}$. Los elementos de la pareja se llaman numerador y denominador respectivamente, y se suelen escribir de la forma n/d

    Las operaciones aritméticas con fracciones se definen de la forma siguiente:

* Suma de fracciones [**+**]:
  
  $$
  \frac{a}{b} + \frac{c}{d} = \frac{a × d + c × b}{b×d} 
  $$

* Elemento opuesto [**− unario**]:
  
  $$
  - \frac{a}{b} = \frac{-a }{b} 
  $$

* Resta de fracciones [**−**]:
  
  $$
  \frac{a}{b} - \frac{c}{d} = \frac{a}{b} +(- \frac{c}{d}) 
  $$

* Producto de fracciones [**×**]: 
  
  $$
  \frac{a}{b} × \frac{c}{d} = \frac{a×c}{b×d}
  $$

* Elemento inverso [**()−1**]: 
  
  $$
  (\frac{a}{b}) ^{-1} = \frac{b}{a}
  $$

* División de fracciones[**÷**]:
  
  $$
  \frac{a}{b} ÷ \frac{c}{d} = \frac{a}{b} × (\frac{c}{d})^{-1}
  $$

    Como vemos, la operaciones suma, elemento opuesto, producto y elemento inverso se definen a partir de operaciones con números enteros. Se dice que son operaciones primitivas, en oposición a la resta y la división que se definen a partir de las operaciones anteriores. A la hora de implementar la biblioteca de fracciones, se puede optar por implementar todas las operaciones como primitivas.

    El conjunto ***Q*** se divide en clases de equivalencia con el siguiente criterio:   

$$
\frac{a}{b} = \frac{c}{d} ⇔ a × d = b × c
$$

    Estas clases de equivalencia son la forma de definir la igualdad entre fracciones. 

    Una fracción se llama reductible cuando se cumple:

$$
\frac{a}{b} = \frac{n×c}{n×d}, ∈ N, n \neq1, c ∈ Z \wedge d ∈ Z
$$

    Toda clase de equivalencia tiene una única fracción irreductible. Como todas las fracciones que pertenecen a una misma clase de equivalencia representan al mismo número racional, se suele elegir como representante de esa clase a su fracción irreductible.

    Si $\frac{a}{b}$ y $\frac{c}{d}$ pertenecen a la misma clase de equivalencia y $\frac{c}{d}$ es irreductible, entonces se cumple que:

$$
\frac{a}{b} = \frac{mcd(a,b)× c}{mcd(a,b)× d}
$$

donde $mcd(a, b)$ es el máximo común divisor de a y b. Esto se puede ver más claro con el ejemplo siguiente: $\frac{10}{4} = \frac{5}{2}$ donde $\frac{5}{2}$ es irreductible; como $mcd(10, 4) = 2$, se cumple que:

$$
\frac{10}{4} = \frac{2× 5}{2 × 2}
$$

### 2.3 Tareas a realizar

Escribir un paquete de nombre Fracciones que se ajuste a la especificación siguiente:

> **Fichero 2.1:** Especificación del paquete `Fracciones (fracciones.ads)`

```ada
package Fracciones is
    type fraccion_t is private;

    function "+" (X, Y: fraccion_t) return fraccion_t;
    function "-" (X: fraccion_t) return fraccion_t;
    function "-" (X, Y: fraccion_t) return fraccion_t;
    function "*" (X, Y: fraccion_t) return fraccion_t;
    function "/" (X, Y: fraccion_t) return fraccion_t;
    function "=" (X, Y: fraccion_t) return Boolean;

    -- Operaciones de entrada/salida con la consola
    procedure Leer (F: out fraccion_t);
    procedure Escribir (F: fraccion_t);

    -- Constructor de números fraccionarios a partir de números enteros
    function "/" (X, Y: Integer) return fraccion_t;

    -- Operaciones para obtener las partes de una fracción
    function Numerador (F: fraccion_t) return Integer;
    function Denominador(F:fraccion_t) return Positive;

private
    type fraccion_t is record
        Num: Integer;
        Den: Positive;
    end record;
end Fracciones;
```

    Para probar este paquete se utilizará el programa siguiente:

> **Programa 2.2:** Prueba del paquete `Fraciones (prueba.adb)`

```ada
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
```

---

[GitHub - FerminVerdolini/SRTPractica2: Bibliotecas](https://github.com/FerminVerdolini/SRTPractica2))
