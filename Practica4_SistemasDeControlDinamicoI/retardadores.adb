with Ada.Real_Time; use Ada.Real_Time;
package body Retardadores is
   type array_Elementos is array (1..Tamanio) of Elementos;

   protected Linea_de_Retardo is
      procedure Escribir (el_Elemento: Elementos);
      procedure Leer (un_Elemento: out Elementos);
      procedure Desplazar;
   private
      Linea: array_Elementos;
      Entrada, Salida: Elementos;
   end Linea_de_Retardo;
   protected body Linea_de_Retardo is
      procedure Escribir (el_Elemento: Elementos) is
      begin
         Entrada := el_Elemento;
      end Escribir;
      procedure Leer (un_Elemento: out Elementos) is
      begin
         un_Elemento := Salida;
      end Leer;
      procedure Desplazar is
      begin
         Salida := Linea (Linea'Last);
         Linea (Linea'First+1..Linea'Last) :=
                          Linea (Linea'First..Linea'Last-1);
         Linea (Linea'First) := Entrada;
      end Desplazar;
   end Linea_de_Retardo;

   task Centinela;
   task body Centinela is
      Periodo: constant Time_Span :=
          To_Time_Span (Duration(Retardo)/Duration(Tamanio));
      Instante_Siguiente: Time := Clock;
   begin
      loop
         delay until Instante_Siguiente;
         Linea_de_Retardo.Desplazar;
         Instante_Siguiente := Instante_Siguiente + Periodo;
      end loop;
   end Centinela;

   procedure Escribir (el_Elemento: Elementos) is
   begin
      Linea_de_Retardo.Escribir (el_Elemento);
   end Escribir;
   procedure Leer (un_Elemento: out Elementos) is
   begin
      Linea_de_Retardo.Leer (un_Elemento);
   end Leer;
   procedure Parar is
   begin
      abort Centinela;
   end Parar;
end Retardadores;