`include "ProbadorTarea1.v"
`include "ContadorTarea1.v"
`include "Contador4X4.v"
                                        
module Contador_TB;

	wire CLK;
	wire ENB;
	wire [15 :0] D;
	wire [1:0] MODO;
	wire [15 :0] Q;
	wire RCO;
	wire Paridad;
	
    initial begin
        $dumpfile("resultados_Tarea1.vcd");
        $dumpvars(0, F1);
        $monitor("D=%b,Q=%b,RCO=%b,Paridad=%b", D, Q, RCO, Paridad);
    end

    //counter U0 (
        //.CLK(CLK), 
        //.ENB(ENB), 
        //.D(D),  
        //.MODO(MODO),
        //.Q(Q),
        //.RCO(RCO), 
        //.Paridad(Paridad)
    //);
    
    Contador F1(
    	.CLK(CLK), 
        .ENB(ENB), 
        .D(D),
        .MODO(MODO),
        .Q(Q),
        .RCO(RCO), 
        .Paridad(Paridad)
    );

    Probador P0 (
        .CLK(CLK), 
        .ENB(ENB), 
        .D(D),
        .MODO(MODO),
        .Q(Q),
        .RCO(RCO), 
        .Paridad(Paridad)
    );
    
endmodule

