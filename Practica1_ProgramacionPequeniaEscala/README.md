## Práctica 1

# Programación a pequeña escala

Con esta práctica se pretende que el alumno:

- Adquiera soltura en la declaración de tipos y datos,

- Se familiarice con las funciones de entrada/salida de tipos enumerados, números enteros, números reales y cadenas de caracteres

- Se habitúe a la sintaxis de las estructuras de control y

- Adquiera el hábito de parametrizar los programas utilizando los atributos de los tipos.

### 1.1 Requisitos

1. Entorno de programación en Ada. Para ello conviene recordar la práctica nro. 0 pág. 1.

2. Componentes léxicos del lenguaje Ada, definición de tipos y declaración de objetos, tipos derivados y subtipos, conversión de tipos, atributos, expresiones, bloques, estructuras de control, subprogramas, arrays no restringidos y punteros. (Toda esta teoría se desarrolla en la lección número 2 «*Programación a pequeña escala*» de las transparencias de laboratorio).

### 1.2 Tareas a realizar

#### 1.2.1 Escritura de un programa con tipos estructurados

    Escribir un programa de nombre `registros.adb` en el que se gestione un  array de registros de películas creado dinámicamente. El número de registros del array es un dato que debe introducir el usuario en tiempo de ejecución. Cada registro se compondrá de los campos siguientes:

- **Título:** Variable variable de tipo `UNBOUNDED_STRING` que contiene el título de la película. Es una cadena de caracteres sin tamaño fijo. Su definición se encuentra en el paquete `ADA.STRINGS.UNBOUNDED`. Para manejar cadenas de caracteres sin tamaño se utiliza el  paquete `ADA.TEXT_IO.UNBOUNDED_IO`

- **Fecha:** Registro que define la fecha en la que se realizó el alquiler de la película.

- **Nota:** Número en coma fija definido en el rango *0..10* con una resolución de 0,1. Es la nota en IMDB de la película.
  
  El registro `Fecha` esta formado por los campos
  
  - **Dia:** número positivo definido en el rango *1..31*.
  
  - **Mes:** valor enumerado que puede tomar los valores (`enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre`).
  
  - **Año:** valor positivo definido en el rango *2000..2024*.

    En este programa, después de realizar la entrada de datos que consiste  en leer las películas, las fechas y las notas correspondientes, se deben calcular las notas mínima, máxima y media. Recuerda ordenar las fechas para la presentación de la media ya que las fechas no tienen porqué introducirse en orden cronológico.

    La presentación de los resultados puede ser como muestra el ejemplo

```
Número de registros: 6
Registro nro. 1
Título: El señor de los anillos
Fecha. Día: 20
Mes: agosto
Año: 2004
Nota: 8.9
Registro nro. 2
Título: Dune
Fecha. Día: 23
Mes: septiembre
Año: 2021
Nota: 8.0
Registro nro. 3
Título: Starship Troopers
Fecha. Día: 14
Mes: marzo
Año: 2000
Nota: 7.3
Registro nro. 4
Título: Tenet
Fecha. Día: 4
Mes: febrero
Año: 2021
Nota: 7.3
Registro nro. 5
Título: El Padrino
Fecha. Día: 7
Mes: febrero
Año: 2011
Nota: 9.2
Registro nro. 6
Título: No mires arriba
Fecha. Día: 22
Mes: abril
Año: 2021
Nota: 7.2
Nota mínima: 7.2 Película: No mires arriba alquilada el 22 de ABRIL de 2021
Nota Máxima: 9.2 Película: El Padrino alquilada el 7 de FEBRERO de 2011
La nota media del periodo 20 de AGOSTO de 2004 a 22 de ABRIL de 2021 ha sido de 8.0
```

    Para realizar la entrada/salida de objetos de un tipo enumerado y de un tipo real en coma fija debemos utilizar los paquetes genéricos `Ada.Text_Io.Enumeration_Io` y `Ada.Text_Io.Fixed_Io` respectivamente.
    La forma de crear ejemplares de estos paquetes es similar a la empleada para los tipos `Integer_Io` y `Float_Io`. Comparando con la práctica anterior, el alumno está en condiciones de deducir cómo se hace.
    Para manejar las cadenas de caracteeres sin tamaño hay que utilizar el paquete `ADA.TEXT_IO.UNBOUNDED_IO`.
    En este caso únicamente hay que incluir el paquete.

    <u>Para escribir este programa y los de las prácticas siguientes se **recomienda** utilizar de forma intensiva los **atributos** de los tipos y objetos.</u>

---
[GitHub - FerminVerdolini/SistemasDeTiempoReal2024: Sistemas de Tiempo Real 2024 - UAH - EPS](https://github.com/FerminVerdolini/SistemasDeTiempoReal2024)
