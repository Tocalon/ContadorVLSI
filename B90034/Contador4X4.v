module Contador#(parameter N=16)(
    input CLK,
    input ENB,
    input [15:0] D,
    input [1:0] MODO,
    output wire [15:0] Q,
    output reg RCO,
    output reg Paridad
);


// Declara las señales intermedias
    wire [3:0] D_reg[N/4-1:0];
    wire [3:0] Q_reg[N/4-1:0];
    wire RCO_reg[N/4-1:0];
    wire Paridad_reg[N/4-1:0];
   
    genvar i;
   
    generate
        for (i = 0; i < N/4; i = i + 1) begin : inst_counter
            assign D_reg[i] = D[i*4 +: 4];
           
counter uut (
    .CLK(CLK),
    .ENB(
    (i == 0) ?
  (
    (MODO == 2'b00 || MODO == 2'b10 || MODO == 2'b11) ?
    (
      (Q_reg[0] == 4'b0000 && Q_reg[1] == 4'b0000 &&
      Q_reg[2] == 4'b0000 && Q_reg[3] == 4'b0000) ?
      1'b1 : ENB
    ) :
    (
      (Q_reg[0] == 4'b0000 && Q_reg[1] == 4'b0000 &&
      Q_reg[2] == 4'b0000 && Q_reg[3] == 4'b0000) ?
      1'b0 : ENB
    )
  )
  :
  (
    (MODO == 2'b01 && Q_reg[i] == 4'b0000) ?
    1'b0 : RCO_reg[i-1]
  )
),
    .MODO((i == 0) ? MODO : ((MODO == 2'b10) ? 2'b00 : MODO)),
    .D(D_reg[i]),
    .Q(Q_reg[i]),  // Agregada la coma aquí
    .RCO(RCO_reg[i]),
    .Paridad(Paridad_reg[i])
);

           
            // Copia las salidas de los contadores individuales al vector de salida total
            assign Q[i*4 +: 4] = Q_reg[i];
        end
        
    endgenerate

    always @(posedge CLK) begin
        RCO <= RCO_reg[N/4-1]; // El último RCO será el RCO global, nota no se si hay que arreglar el rco
    end

    always @* begin
           // Paridad podría necesitar cálculo adicional, dependiendo de la especificación
        Paridad <= Paridad_reg[0] ^ Paridad_reg[1] ^ Paridad_reg[2] ^ Paridad_reg[3];
    end
endmodule
