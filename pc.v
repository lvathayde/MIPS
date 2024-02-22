

module pc (nextPC, pc, clock); //contador de programa
	// Declaração de entradas e saída
	input clock;
	input wire [31:0] nextPC; //proximo valor do pc 
	output reg [31:0] pc; // valor atual do pc
	// Declaração de flag
	reg reset; 

	// Inicializando reset e pc com 0
	initial begin 
		reset = 0;
		pc = 32'b0;
	end
	
	
	always @(posedge clock) begin //sincrono (sensivel ao clock) 
		if(reset) begin //aqui atribuimos o valor de nextPC ao pc
			pc = nextPC;
		end else begin //aqui resetamos o valor de PC para zero e setamos reset como 1
			pc = 32'b0;
			reset = 1;
		end
	end
endmodule
