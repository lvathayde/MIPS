

//module jr_control(opcode, func, read_data1, JR_control); 
	
//	input wire [2:0] opcode; //opcode da instrucao 3 bits
//	input wire [5:0] func; //campo de funcao da instrucao 6 bits
//	input wire [31:0] read_data1; //dado lido do registrador 1
//	output wire [31:0] JR_control;// saida de controle do JR
	
//	assign JR_control = ({opcode,func} == 9'b00001000) ? read_data1 : 32'bz; //caso a concatenacao do opcode e do func for igual aquilo ali, recebe read_data1, caso contrario vira 32 de alta impedancia

//endmodule

	
	
	
	
module jr_control(opcode, func, read_data1, pc, jr_PC);
	input wire [5:0] opcode, func; //campo de funcao da instrucao 6 bits
	input wire [31:0] read_data1; //dado lido do registrador 1
	input wire [31:0] pc;
	output wire [31:0] jr_PC;// saida de controle do JR
	
	assign jr_PC = ({opcode,func} == 12'b000000001000) ? pc + read_data1 : jr_PC; 

endmodule 