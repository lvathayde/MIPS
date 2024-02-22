

module pc_source_control (pc_source, zero_flag, source); //controle de origem do pc 

	input wire [1:0] pc_source;//selecao da origem do pc
	input wire zero_flag; // sinal
	output reg [1:0] source; //saida da origem ajustada
	
	always @(*) begin 
		case (pc_source)
			2'b00: source <= 2'b00; //pc+4
			2'b01: source <= {1'b0, zero_flag}; //beq
			2'b10: source <= {1'b0, !zero_flag}; //bne
			2'b11: source <= 2'b10; //j e jal pc sourcing 
		endcase
	end
endmodule
		


