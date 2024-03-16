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

 
