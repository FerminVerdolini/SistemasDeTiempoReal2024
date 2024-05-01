with Ada.Execution_Time; use Ada.Execution_Time;
with Ada.Real_Time; use Ada.Real_Time;

package body Proc is
    procedure P1 is
        Start_Time, Stop_Time  : CPU_Time;
        Elapsed_Time : Time_Span;
        dur: Duration;
    begin
        Start_Time := Clock;
        loop
            Stop_Time := Clock;
            Elapsed_Time := Stop_Time - Start_Time; 
            dur:= To_Duration(Elapsed_Time);
            exit when dur >= 0.4;
    end loop;        
    end P1;

    procedure P2 is
        Start_Time, Stop_Time  : CPU_Time;
        Elapsed_Time : Time_Span;
        dur: Duration;
    begin
        Start_Time := Clock;
        loop
            Stop_Time := Clock;
            Elapsed_Time := Stop_Time - Start_Time; 
            dur:= To_Duration(Elapsed_Time);
            exit when dur >= 0.6;
        end loop;        
    end P2;

    procedure P3 is
        Start_Time, Stop_Time  : CPU_Time;
        Elapsed_Time : Time_Span;
        dur: Duration;
    begin
        Start_Time := Clock;
        loop
            Stop_Time := Clock;
            Elapsed_Time := Stop_Time - Start_Time; 
            dur:= To_Duration(Elapsed_Time);
            exit when dur >= 0.8;
        end loop;  
    end P3;

    procedure P4 is
        Start_Time, Stop_Time  : CPU_Time;
        Elapsed_Time : Time_Span;
        dur: Duration;
    begin
        Start_Time := Clock;
        loop
            Stop_Time := Clock;
            Elapsed_Time := Stop_Time - Start_Time; 
            dur:= To_Duration(Elapsed_Time);
            exit when dur >= 0.8;
        end loop;  
    end P4;
end Proc;



