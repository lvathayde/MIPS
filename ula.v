module ula(In1, In2, operation, shamt, result, zero_flag);
	input wire [31:0] In1, In2; //entradas de 32 bits para operandos
	input wire [3:0] operation; // aluop 4 bits
	input wire [4:0] shamt;
	output wire [31:0] result; //saida de 32 bits para ula
	output wire zero_flag; // saida indicando se o resultado e 0

	reg [31:0] result_ula; // registrador interno para armazenar o resultado
	assign result = result_ula; //atribui o resultado ao sinal de saida

	always @(*) begin
		case (operation)
			4'b0000: result_ula <= In1 & In2; //and
			4'b0001: result_ula <= In1 | In2; //or
			4'b0010: result_ula <= In1 + In2; //add
			4'b0011: result_ula <= In2 << shamt; //sll
			4'b0100: result_ula <= $signed($signed(In2) >>> shamt); //sra
			4'b0101: result_ula <= In2 >> shamt; //srl
			4'b0110: result_ula <= In1 - In2; //sub
			4'b0111: result_ula <= ($signed(In1) < $signed(In2)) ? 32'd1 : 32'd0; // slt
			4'b1000: result_ula <= (In1 < In2) ? 32'd1 : 32'd0; // sltu
			4'b1011: result_ula <= {In2[15:0], 16'h0000}; //lui
			4'b1100: result_ula <= ~ (In1 | In2); //nor
			4'b1101: result_ula <= In1 ^ In2; //xor
			4'b1110: result_ula <= In2 << In1; //sllv
			4'b1111: result_ula <= In2 >> In1; //srlv
			4'b1010: result_ula <= $signed($signed(In2) >>> $signed(In1)); //srav
			default: result_ula <= In1 + In2; //pula p add 
		endcase
	end

	assign zero_flag = (result == 0) ? 1'b1 : 1'b0; //define a flag como 0 baseado no resultado

endmodule