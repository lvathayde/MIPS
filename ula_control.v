module ula_control (ula_operation, func, operation);
	input wire [3:0] ula_operation;//entrada de 4 bits para operacao da ula
	input wire [5:0] func; //entrada 6 bits para a funcao (em instrucoes do tipo r )
	output reg [3:0] operation; // saida de 4 bits para a operacao da ula
	
	always @(*) begin
		case (ula_operation)
			4'b0000: operation <= 4'b0010; //lw, sw => add
			4'b0001: operation <= 4'b0110; //branch => sub 
			4'b0010: //instrucoes do tipo r
				case (func) 
					6'b100000: operation <= 4'b0010; //add
					6'b100010: operation <= 4'b0110; //sub
					6'b100100: operation <= 4'b0000; //and
					6'b100101: operation <= 4'b0001; //or
					6'b100110: operation <= 4'b1101; //xor
					6'b100111: operation <= 4'b1100; //nor
					6'b101010: operation <= 4'b0111; //slt
					6'b101011: operation <= 4'b0111; //sltu
					6'b000000: operation <= 4'b0011; //sll
					6'b000010: operation <= 4'b0101; //srl
					6'b000011: operation <= 4'b0100; //sra
					6'b000100: operation <= 4'b1110; //sllv
					6'b000110: operation <= 4'b1111; //srlv
					6'b000111: operation <= 4'b1010; //srav
					default: operation <= 4'b0000; //caso nao seja nenhuma das esperada, da em AND
				endcase
			4'b0011: operation <= 4'b0111; //slti
			4'b1000: operation <= 4'b1000; //sltiu
			4'b0100: operation <= 4'b0000; //andi 
			4'b0101: operation <= 4'b0001; //ori
			4'b0110: operation <= 4'b1101; //xori
			4'b0111: operation <= 4'b1011; //lui
			default: operation <= 4'b0000; //default vai p and 
	   endcase
    end 
endmodule
