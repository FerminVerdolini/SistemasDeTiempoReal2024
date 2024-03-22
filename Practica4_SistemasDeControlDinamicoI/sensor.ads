package Sensor is
   type Temperaturas is new Float range -25.0..500.0;

   procedure Leer (la_Temperatura: out Temperaturas);
end Sensor;