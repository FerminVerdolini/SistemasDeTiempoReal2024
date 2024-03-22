package Calefactor is
   -- No contemplamos la posibilidad de saturaci�n, es decir,
   -- al calefactor se le puede pedir que entregue toda la
   -- potencia que se necesite.
   type Potencias is new Float range 0.0 .. 10_000.0;

   procedure Escribir (la_Potencia: Potencias);
end Calefactor;