module mux_32 (
    input wire [31:0] in1, in2,
    input wire sel,
    output wire [31:0] out
);
    // determinação do multiplexador
    assign out = sel ? in2 : in1;
endmodule

module mux_32_4 (
    input wire [31:0] in1, in2, in3, in4,
    input wire [1:0] sel,
    output wire [31:0] out
);
    // determinação do multiplexador 4x1
    assign out = (sel[1] == 0) ? ((sel[0] == 0) ? in1 : in2) : ((sel[0] == 0) ? in3 : in4);
endmodule

module mux_src (
    input ALUsrc,
    input [31:0] ReadData2, SignExtended32,
    output reg [31:0] ALUin2
);
    // bloco que será executado a partir de todas as entradas
    always @* begin
        // casos possíveis para a flag de controle ALUsrc
        case (ALUsrc)
            0: ALUin2 = ReadData2;
            1: ALUin2 = SignExtended32;
        endcase
    end
endmodule

module mux_4_4 (
    input [4:0] inst0, inst1,
    input [1:0] RegDest, 
    output wire [4:0] imem_mux
);
    // determinação do multiplexador 5x1
    assign imem_mux = RegDest ? inst1 : inst0;
endmodule


module MUX_reg (
    input [4:0] rt,
    input [4:0] rd,
    input [1:0] RegDest,
    output wire [4:0] write_register
);

//usa o sinal do regdest para selecioanr entre rt e rd
assign WriteRegister = (RegDest ==  2'b00) ? rt : rd;

endmodule
