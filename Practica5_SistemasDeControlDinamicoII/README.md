## Práctica 5

# Sistemas de Control Dinámico II

En esta práctica se implementará un sistema de control dinámico del horno analizado en la práctica nro. 4 *(pág. 1)*. El controlador debe seguir un esquema realimentado PID como el que se muestra en la figura 5.1.

<img src="file:///home/ferminv/snap/marktext/9/.config/marktext/images/2024-04-03-12-26-51-image.png" title="" alt="" data-align="center">

La ecuación de control, una vez discretizada, toma la forma:

$$
u(n) = k_p \left[e(n)+ \frac{1}{T} \sum_{k=1}^{n}e(k)T_s + T_d \frac{e(n) - e(n-1)}{T_s} \right]
$$

donde los coeficiente $k_p$ , $T_i$ y $T_d$ se calculan según la regla de *Ziegler–Nichols*  y $T_s$ es el periodo de muestreo.

### 5.1 Tareas a realizar

1. Utilizando el método de *Ziegler–Nichols* calcular los valores de las constantes $k_p$ , $T_i$ y $T_d$. Para ello, se obtendrá una gráfica como la siguiente introduciendo una potencia cualquiera al horno y sacando la temperatura. Después se calcularán, de forma aproximada, los parámetros $K$, $L$ y $τ$.
   
   <img src="file:///home/ferminv/snap/marktext/9/.config/marktext/images/2024-04-03-13-00-28-image.png" title="" alt="" data-align="center">
   
   Para calcular las constantes usar la siguiente tabla:
   
   | **Controlador** | $K_p$                | $\tau_i$        | $\tau_d$ |
   | --------------- | -------------------- | --------------- | -------- |
   | **P**           | $\frac{\tau}{KL}$    | $\infin$        | $0$      |
   | **PI**          | $0.9\frac{\tau}{KL}$ | $\frac{L}{0.3}$ | $0$      |
   | **PID**         | $1.2\frac{\tau}{KL}$ | $2L$            | $0.5L$   |

2. Escribir un paquete de nombre PID que se ajuste a la especificación siguiente:
   
   > **Fichero 5.1:** Especifición del paque **PID** (`pid.ads`) 
   
   ```ada
   generic
       type Real is digits <>;
       type Entrada is digits <>;
       type Salida is digits <>;
   package PID is
       type Controlador is limited private;
   
       procedure Programar (el_Controlador: in out Controlador;
                               Kp, Ki, Kd: Real);
       procedure Controlar(con_el_Controlador: in out Controlador;
                               R, C: Entrada;
                                   U: out Salida);
   private
       type Controlador is record
       -- Parámetros del controlador
       Kp, Ki, Kd: Real;
       -- Estado del controlador
       S_Anterior : Real := 0.0; -- s(n-1) Condiciones de
       Error_Anterior: Real := 0.0; -- e(n-1) reposo inicial
       end record;
   end PID;
   ```
   
   La operación `Programar` se encarga de inicializar un objeto de tipo `Controlador`. La operación `Controlar` realiza los cálculos para implementar con posterioridad un ciclo de control (recordamos que $e(n) = R(n) − C(n)$).

3. Usando el paquete PID y los paquetes Sensor y Calefactor de la práctica anterior, escribir un programa de nombre Principal donde se implemente el ciclo de control del horno. Este programa pedirá una temperatura de referencia y controlará el horno durante 10 minutos.
   
   El ciclo de control tiene la forma siguiente:
   
   ```ada
   loop -- Bucle con periodicidad Ts
       esperar al siguiente instante de muestreo
       leer T en el sensor
       e := T-Tref
       calcular u(t)=P(t)=PID(e)
       escribir P en el calefactor
       escribir T en pantalla
   end loop;
   ```
   
   El diagrama de componentes de la aplicación se muestra en la figura 5.2. Recordamos que los paquetes `Horno` y `Retardadores` no los tiene que el escribir el alumno.
   
   <img src="file:///home/ferminv/snap/marktext/9/.config/marktext/images/2024-04-03-13-14-39-image.png" title="" alt="" data-align="center">

4. Ejecutar el programa considerando las temperaturas de referencia 100 C y 200 C. A partir de los datos obtenidos realizar una representación gráfica de la evolución de la temperatura. Para obtener esta representación se puede utilizar cualquier herramienta de presentación de datos, por ejemplo Matlab. En la figura 5.3 podemos ver un ejemplo de los resultados que se obtienen. En [PID_Compensation_Animated.gif](https://castilloinformatica.es/wiki/index.php?title=Archivo:PID_Compensation_Animated.gif) puedes ver un ejemplo de cómo afectan las constantes a la respuesta del sistema.

<img src="file:///home/ferminv/snap/marktext/9/.config/marktext/images/2024-04-03-13-18-21-image.png" title="" alt="" data-align="center">


