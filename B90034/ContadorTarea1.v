module counter(
    input CLK,
    input ENB,
    input [3:0] D,
    input [1:0] MODO,
    output reg [3:0] Q,
    output reg RCO,
    output reg Paridad
);
    always @(posedge CLK) begin
        if (ENB == 1) begin
            case (MODO)
                2'b00: Q <= Q + 1; // Cuenta hacia arriba
                2'b01: Q <= Q - 1; // Cuenta hacia abajo
                2'b10: Q <= Q + 3; // Cuenta de tres en tres hacia arriba
                2'b11: Q <= D;      // Carga en paralelo
                default: Q <= Q;
            endcase
        end else begin
            Q = Q;
        end
    end

    always @(posedge CLK) begin
        if (ENB == 1) begin
            Paridad <= Paridad ^ Q[0] ^ Q[1] ^ Q[2] ^ Q[3];
        end
    end

    always @* begin
        if (Q == 4'b1111) begin
            RCO <= 1;
        end else begin
            RCO <= 0;
        end
    end
endmodule

