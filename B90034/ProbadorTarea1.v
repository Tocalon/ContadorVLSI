module Probador(CLK,ENB, MODO, D, Q, RCO, Paridad); 
//SALIDAS
output  CLK;
output  ENB; 
output  [15:0]D;
output   [1:0]MODO;
//ENTRADA
input [15:0]Q;
input RCO;
input Paridad;
//Registros
reg CLK, MODO, ENB, D; 
wire Q, RCO, Paridad; 

initial begin
    // Prueba #1, prueba ascendente
    $display("Prueba #1: Cuenta ascendente");
        CLK = 0;   
        ENB = 1;   
        MODO = 2'b11;   
        D = 0;    
        #10;    
        MODO = 2'b00;   
        #10;
        #200;
        ENB = 0;
        #40; //Tiempo de espera

      // Prueba #2, prueba descendente 
      $display("Prueba #2: Cuenta descendente");
        ENB = 1; 
        D = 15;
        MODO = 2'b11;
        #10;
        MODO = 2'b01;
        #200; 
        ENB = 0;
        #40 //Tiempo de espera

      // Prueba #3: Cuenta de tres en tres hacia arriba
      $display("Prueba #3: Cuenta de tres en tres hacia arriba");
        ENB = 1;
        D = 0; 
        MODO = 2'b11;
        #10;
        MODO = 2'b10;
        #200;
        ENB = 0;
        #40; //Tiempo de espera 

      // Prueba #4: Carga en paralelo
    $display("Prueba #4: Carga en paralelo");
    	ENB = 1;
        D = 4'bxxxx;
        #10;
        MODO = 2'b11;
        #20;
        D = 4'b1001;
        #20;
        MODO = 2'b11;
        #20;
        MODO =2'b00;
        #250; 
        ENB = 0;
        #40;//Tiempo de espera
    
      //Prueba #5, contador de 16 bits
      $display("Prueba #5:Contador de 16 bits");
        ENB = 1;
        D = 0;
        MODO = 2'b11;
        #10;
        MODO = 2'b00;
        #120;
        MODO = 2'b01;
        #120;
        MODO = 2'b10;
        #120;
        D = 30;
        MODO = 2'b11;
        #250;
        D = 0;
        MODO = 2'b11;
        #60 $finish;
    end

always 
begin
    #5 CLK=!CLK; //cambiar la unidad de retardo para el cambio del reloj, ayuda a definir el periodo de la señal 
end

endmodule
