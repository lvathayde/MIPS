

module regfile (
         input [4:0] ReadAddr1, ReadAddr2, WriteAddr, //ReadAddr1 e 2 sao endereco dos registradores (leitura) e o WriteAddr e o endereco de escrita
         input [31:0] WriteData, // entrada de 32 bits do dado que vai ser escrito no writeaddress pela ula
         input Clock, Reset, RegWrite, // sinais de controle (Reset reseta todos os registradores) Regwrite permite a escrita  
         output [31:0] ReadData1, ReadData2 // Saida com os dados que foram lidos
    );

         // Declaração de um array de 32 registradores de  32 bits
         reg [31:0] registers [0:31];
 
         // Inicialização do registrador $0 com 0 
         initial begin
              registers[0] =  32'h00000000; 
         end

         // Ler dados de forma assíncrona
         assign ReadData1 = registers[ReadAddr1]; //pega o Valor que está no ReadAddr1 dos registradores e atribui a ReadData1
         assign ReadData2 = registers[ReadAddr2]; //pega o Valor que está no ReadAddr2 dos registradores e atribui a ReadData2

         // Escrever dados de forma síncrona
         always @(posedge Clock or posedge Reset) begin //isso e triggado no pulso do clock ou quando e pedido um reset
              if (Reset) begin //caso tenha sido pedido um reset
                    // Resetar todos os registradores para  0
                    integer i;
                    for (i =  0; i <  32; i = i +  1) begin
                         registers[i] <=  5'b00000; // Ajustado para  5 bits
                    end
              end else if (RegWrite) begin
                    // Escrever dados no registrador especificado, exceto $0
                    if (WriteAddr !=  5'b00000) begin 
                         registers[WriteAddr] <= WriteData;//escreve o valor no registrador adequado
                    end
              end
         end
    endmodule 