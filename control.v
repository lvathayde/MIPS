

module control (input wire [5:0] opcode,//opcode da instrucao 
                output reg MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, isJAL, isSigned, //sinais de controle 
                output reg [3:0] ALUOp, output reg [1:0] RegDest, output reg [1:0] PcOp,
					 output reg Branch);
//recebe o opcode 
	
	always @(opcode) begin 
		case (opcode) 
			6'b0000000: begin //sll, srl, sra, sllv, srlv, jr, add, sub, and, or, xor, nor, slt, sltu
				RegDest = 2'b01;
            PcOp = 2'b00;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 4'b0010;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
				RegWrite = 1'b1;
            isJAL = 1'b0;
            isSigned = 1'b1;
				Branch = 1'b0;
			end
           
            6'b001000: begin //addi
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0000;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              isJAL = 1'b0;
              isSigned = 1'b1;
				  Branch = 1'b0;
            end
				 6'b001100: begin //andi
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0100;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              isJAL = 1'b0;
              isSigned = 1'b0;
				  Branch = 1'b0;
            end
            6'b001101: begin //ori
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0101;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              isJAL = 1'b0;
              isSigned = 1'b0;
				  Branch = 1'b0;
            end
            6'b001110: begin //xori
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0110;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              isJAL = 1'b0;
              isSigned = 1'b0;
				  Branch = 1'b0;
            end
            6'b001010: begin //slti
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0011;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              isJAL = 1'b0;
              isSigned = 1'b1;
				  Branch = 1'b0;
            end
            6'b001011: begin //sltiu
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b1000;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              isJAL = 1'b0;
              isSigned = 1'b1;
				  Branch = 1'b0;
            end
           
            6'b001111: begin //lui
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0111;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              isJAL = 1'b0;
              isSigned = 1'b0;
				  Branch = 1'b0;
            end
            6'b100011: begin //lw
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b1;
              MemtoReg = 1'b1;
              ALUOp = 4'b0000;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              isJAL = 1'b0;
              isSigned = 1'b1;
				  Branch = 1'b0;
            end
            6'b101011: begin //sw
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0000;
              MemWrite = 1'b1;
              ALUSrc = 1'b1;
              RegWrite = 1'b0;
              isJAL = 1'b0;
              isSigned = 1'b1;
				  Branch = 1'b0;
            end
            6'b000100: begin //beq
              RegDest = 2'b00;
              PcOp = 2'b01;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0001;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;
              isJAL = 1'b0;
              isSigned = 1'b1;
				  Branch = 1'b1;
            end
            6'b000101: begin //bne
              RegDest = 2'b00;
              PcOp = 2'b10;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0001;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;
              isJAL = 1'b0;
              isSigned = 1'b1;
				  Branch = 1'b1;
            end
				 6'b000011: begin //jal
              RegDest = 2'b10;
              PcOp = 2'b11;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0000;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b1;
              isJAL = 1'b1;
              isSigned = 1'b1;
				  Branch = 1'b0;
            end
				6'b000010: begin //j
             RegDest = 2'b00;
             PcOp = 2'b11;
             MemRead = 1'b0;
             MemtoReg = 1'b0;
             ALUOp = 4'b0000;
             MemWrite = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b0;
             isJAL = 1'b0;
             isSigned = 1'b1;
				 Branch = 1'b0;
            end
            default: begin //pula p nada 
              RegDest = 2'b00;
              PcOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 4'b0000;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;
              isJAL = 1'b0;
              isSigned = 1'b0;
				  Branch = 1'b0;
            end
        endcase
    end
    
endmodule
				
				
		
			
			
				
