
module d_mem (Address,WriteData,MemWrite,MemRead,ReadData, clock);
    	
    parameter ADDR_WIDTH = 8; //parametro de tamanho da memoria
	 input wire [31:0] Address; //endereco 
    input wire [31:0] WriteData; //o que sera escrito
    input wire MemWrite,MemRead,clock; //flags para saber se pode escrever/ler e o clock
    output wire [31:0] ReadData;//saida do valor lido
	
    reg [31:0] memory [0:2**ADDR_WIDTH-1]; // declarando a memoria com tamanho parametrizavel
	 
	 assign ReadData = MemRead? memory[Address] : 32'dz; //leitura assincrona da memoria
	 
    always @(posedge clock)begin
    
        if (MemWrite == 1'b1)
            memory[Address] <= WriteData; // escrita sincrona da memoria

    end

endmodule