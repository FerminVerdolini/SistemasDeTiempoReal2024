with Ada.Real_Time; use Ada.Real_Time;
with Retardadores;
package body Horno is

   -- Retardo
   L: constant Float := 1.5;
   -- Periodo de la simulaci�n;
   Ts: constant := 0.1;
   package Retardador_de_Potencias is new
                   Retardadores (Retardo => L,
                               Elementos => Potencias,
                                  Tamanio => Positive(L/Ts));


   Ct: constant := 1_500.0; -- J/C Capacidad termica
   Cp: constant := 15.0; -- J/(C*s) Coeficiente de perdidas
   T_Ambiente: constant Temperaturas := 20.0;

   -- Objeto protegido que almacena el estado del horno
   protected Estado is
      procedure Leer (la_Temperatura: out Temperaturas);
      procedure Escribir (la_Potencia: Potencias);
      procedure Leer (la_Potencia: out Potencias);
      procedure Recalcular;
   private
      T: Temperaturas := T_Ambiente;
      P: Potencias := 0.0;
   end Estado;

   -- Tarea que se encarga de cambiar peri�dicamente
   -- el estado del horno.
   task Centinela;

   -- Cuerpo de los objetos
   protected body Estado is
      procedure Leer (la_Temperatura: out Temperaturas) is
      begin
         la_Temperatura := T;
      end Leer;
      procedure Escribir (la_Potencia: Potencias) is
      begin
         P := la_Potencia;
      end Escribir;
      procedure Leer (la_Potencia: out Potencias) is
      begin
         la_Potencia := P;
      end Leer;
      procedure Recalcular is
      begin
         T := T + (Temperaturas(P) - Cp*(T-T_Ambiente))/Ct*Ts;
      end Recalcular;
   end Estado;

   task body Centinela is
      Periodo: constant Time_Span := To_Time_Span(Ts);
      Siguiente_Instante: Time := Clock;
      Potencia: Potencias;
   begin
      loop
         delay until Siguiente_Instante;
         Retardador_de_Potencias.Leer (Potencia);
         Estado.Escribir (Potencia);
         Estado.Recalcular;
         Siguiente_Instante := Siguiente_Instante + Periodo;
      end loop;
   end Centinela;

   -- Operaciones que se exportan      
   procedure Escribir (la_Potencia: Potencias) is
   begin
      if la_Potencia = 0.0 then -- Apagar el horno
         Retardador_de_Potencias.Parar;
         abort Centinela;
      else
         Retardador_de_Potencias.Escribir (la_Potencia);
      end if;
   end Escribir;
   procedure Leer (la_Temperatura: out Temperaturas) is
   begin
    Estado.Leer (la_Temperatura);
   end Leer;
end Horno;