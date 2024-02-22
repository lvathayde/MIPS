//extende o sinal para tornar o numero ed 16bits em 32

module extend_sign (
    input wire [15:0] in,
    input wire is_signed,
    output wire [31:0] out
);

    
    assign out = is_signed ? {{16{in[15]}}, in} : {16'b0, in}; //se for signed extende o bit mais significativo caso contrario enche de 0s

endmodule
