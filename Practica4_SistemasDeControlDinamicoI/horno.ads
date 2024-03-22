package Horno is
   type Temperaturas is new Float;
   type Potencias is new Float;

   procedure Escribir (la_Potencia: Potencias);
   procedure Leer (la_Temperatura: out Temperaturas);
end Horno;