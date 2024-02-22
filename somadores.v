

module adder4 (input [31:0] pc,output [31:0] pc_increment); //entrada de 32 bits | saida de 32 bits

    // declaração do 4 para somar ao pc
    reg [31:0] four;

    // inicialização do four com o número 4 em hexadecimal
    initial begin
        four = 32'h00000004;
    end

    // atribuição da soma do pc
    assign pc_increment = four + pc;

endmodule

module add32 (input wire [31:0] in1, in2,output wire [31:0] out); //Realiza a adicao de 2 valores de 32 bits
    // atribuição da soma de 32 bits
    assign out = in1 + in2; //atribui à saida a soma dos 2 valores de entrada

endmodule

module AddressAdder (//realiza adicao de 2 valores
    input wire [31:0] pc_increment, 
    input wire [31:0] shift_left_two_saida,
    output wire [31:0] resultado
);
 assign resultado = pc_increment + shift_left_two_saida; //atribuicao da soma de pc_incremente e shift_left_two_saida ao resultado

endmodule