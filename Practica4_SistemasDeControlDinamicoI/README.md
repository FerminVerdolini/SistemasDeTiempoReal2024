## SRTPractica4

# Sistemas de control dinámico I

    Esta práctica es la primera de dos prácticas dedicadas a la implementación de un sistema de control de la temperatura de un horno. Su objetivo es implementar dos programas para medir las características dinámicas de un horno que se modela con la ecuación:

$$
Ct \cfrac{dT(t)}{dt} = P(t-L) - Cp [T(t) - Te]
$$

donde,

$T(t) (C)$ es la temperatura en funcion del tiempo,

$P(t)(W)$ es la potencia aplicada en funcion del tiempo,

$Ct (J/K)$ es la capacidad térmica,

$L(s)$ es el reardo en la respuesta,

$Cp (W/K)$ es el coeficiente de pérdidas y

$Te (C)$ es la temperatura del exterior del horno o temperatura ambiente

    El comportameinto del horno se simula con un paquete de nombre `Horno` que exporta las operaciones `Leer` y `Escribir` que aparecen en la especificación siguiente:

> **Fichero 4.1:** Especificación del paquete `Horno` (`Horno.ads`)

```ada
package Horno is
    type Temperaturas is new Float;
    type Potencias is new Float;

    procedure Escribir (la_Potencia: Potencias);
    procedure Leer (la_Temperatura: out Temperaturas);
end Horno;
```

    El cuerpo de este paquete encierra los detalles del simulador y el objeto de esta práctica es calcular los parámetros con los que ha sido diseñado el simulador. En concreto, hay que calcular los parámetros: $Te$ , $L$, $Cp$ y $Ct$ .

### 4.1 Tareas a realizar

1.    Escribir un paquete de nombre `Sensor` que se ajuste a la especificación siguiente:

> **Fichero 4.2:** Especificación del paquete `Sensor` (`Sensor.ads`)

```ada
package Sensor is
    type Temperaturas is new Float range -25.0..500.0;
    procedure Leer (la_Temperatura: out Temperaturas);
end Sensor;
```

    En el cuerpo de este paquete se implementará la operación Leer, encargada de leer la temperatura actual del horno. Esta implementación se hará usando el paquete Horno.

2.    Escribir un paquete de nombre `Calefator` que se ajuste a la especificación siguiente:

> **Fichero 4.3**: Especificación del paquete `Calefactor` (`Calefact.ads`)

```ada
package Calefactor is
    type Potencias is new Float range 0.0 .. 10_000.0;

    procedure Escribir (la_Potencia: Potencias);
end Calefactor;
```

    En el cuerpo de este paquete se implementará la operación `Escribir`, encargada de escribir la potencia que se le suministra al horno. Esta implementación se hará usando el paquete `Horno`.

3.    Escribir un programa de nombre `Medir1` que mida el valor de los parámetros: $Te$ , $L$ y $Cp$ . La medida de $Te$ es directa y se corresponde con la temperatura del horno en reposo. La medida de $L$ se obtiene viendo el tiempo que tarda el horno en responder cuando le aplicamos una potencia cualquiera, por ejemplo $1000 W$. La medida de `Cp` se puede hacer cuando el horno alcanza el régimen permanente después de aplicarle una potencia cualquiera. El régimen permanente se corresponde con $t → ∞$ y se verifica que $dT /dt = 0$. En estas condiciones $0 = P − Cp (T − Te )$. Despejando la formula: 

$$
Cp = \cfrac{P}{T-Te}
$$

4.    Dibujar el diagrema de componentes del programa `Medir1`.

5.    Escribir un programa de nombre `Medir2` que utilice los valores obtenidos con el programa anterior y que mida el parámetro $Ct$ . La medida de $Ct$ se debe hacer durante el régimen transitorio. Para ello hay que excitar el horno con una potencia y ver cómo evoluciona la temperatura. Si aproximamos la derivada por un cociente de incrementos tenemos:

$$
Ct \cfrac{∆T}{∆t} = P - Cp (T - Te)
$$

de donde se obtiene

$$
Ct = \cfrac{P- Cp (T-Te)}{∆T}∆t 
$$

Ambos programas utilizan el simulador del horno. El simulador se compone de varias tareas concurrentes y para que los programas `Medir1` y `Medir2` terminen correctamente y devuelvan el control
es necesario apagar el horno. Esto se consigue escribiendo la potencia 0.0 en el horno al final de los programas `Medir1` y `Medir2`.

Una vez realizadas todas las medidas se completará la tabla siguente:

| Parámetro | Valor y unidades |
| --------- | ---------------- |
| $Te$      |                  |
| $L$       |                  |
| $Cp$      |                  |
| $Ct$      |                  |
