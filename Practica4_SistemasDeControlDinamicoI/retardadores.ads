generic
   Retardo: Float := 1.0; -- Segundos
   type Elementos is private;
   Tamanio: Positive := 10; -- 10 elementos
package Retardadores is
   procedure Escribir (el_Elemento: Elementos);
   procedure Leer (un_Elemento: out Elementos);
   procedure Parar;
end Retardadores;