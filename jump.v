

module jump (next_pc, address, new_pc); //bloco de salto para construcao do proximo pc

	input wire [3:0] next_pc; //proxima parte do pc
	input wire [25:0] address; //endereco de destino do salto
	output wire [31:0] new_pc; //proximo valor do pc apos o salto
	
	assign new_pc = {next_pc, address, 2'b00}; //concatenacao do pc
	
endmodule