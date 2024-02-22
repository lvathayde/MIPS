
module Mips (clock, reset, nextPC, result_ula, data_mem);

	input wire clock,reset;
	output wire [31:0] nextPC, result_ula, data_mem;
	
	
	//instanciando o modulo de controle
	wire MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, isJAL, isSigned;
	wire [1:0] PcOp, RegDest, Branch;
	control mips_control(
		instruction[31:26],
		MemRead,
		MemtoReg,
		MemWrite,		
		ALUSrc,
		RegWrite,
		isJAL,	
		isSigned,
		ula_operation,
		RegDest,
		PcOp,
		Branch
	);
	
	wire [2:0] ula_operation;
	//instanciando o modulo ula_control
	
	ula_control mips_ula_control(ula_operation, instruction[5:0], operation);
	
	//instanciando o modulo ula
	wire [31:0] regfile_mux_to_ula_In2;
	wire [3:0] OP;
	wire ula_zero_flag;
	
	ula mips_ula(ReadData1, regfile_mux_to_ula_In2, operation, instruction[10:6], result_ula, ula_zero_flag);
	
	//isntanciando o modulo pc
	
	wire [31:0] pc;
	
	pc mips_pc(nextPC,pc,clock);

	//instanciando um add
	wire [31:0] pc_increment;
	
	// adicionando 4 ao pc :x
	adder4 pcp4(pc,pc_increment);
	
	//instanciando o modulo de memoria de instrucao
	wire [31:0] instruction;
	i_mem instruction_memory(pc, instruction);
	
	//isntanciando o modulo d_mem
	d_mem mips_d_mem(result_ula, ReadData2, MemWrite, MemRead, data_mem, clock);
	
	wire[31:0] WriteData;
	//instanciando um mux_32
	mux_32 mux_32_d_mem(result_ula, data_mem, MemtoReg, WriteData);
	
	//instanciando mux para a output do imem  - ESTRANHO
	wire [4:0] imem_mux_to_write_register;
	mux_4_4 imem_reg_mux(instruction[20:16], instruction[15:11], RegDest, imem_mux_to_write_register);
	
	// Mux 
	wire [31:0] to_write_data_mux_in2;
	wire [31:0] to_write_data;
	adder4 jal (pc_increment, to_write_data_mux_in2);
	mux_32 write_data_mux(WriteData, to_write_data_mux_in2, isJAL, to_write_data);
	
	// Instaciando modulo regfile
	regfile mips_regfile(
		instruction[25:21], 
		instruction[20:16], 
		to_write_data,
		imem_mux_to_write_register,
		clock,  
		reset,
		RegWrite,
		ReadData1, 
		ReadData2 
	);
	
	//instaciando mux 32 entre regfile e ula
	mux_32 regfile_mux(ReadData2, sign_extend_to_mux, ALUSrc, regfile_mux_to_ula_In2);
	
	
	// instanciando um signed extend de 16 p 32
	wire [31:0] sign_extend_to_mux;
	extend_sign mips_sign_extend(instruction[15:0], isSigned, sign_extend_to_mux);
	
	//instaciando um somador p branching :)
	wire [31:0] add_branching_to_mux;
	add32 branching(pc_increment, (sign_extend_to_mux << 2), add_branching_to_mux);
	 
	//instanciando o pc source control :]
	pc_source_control pc_control(PcOp, ula_zero_flag, PCSource);

       
	//instanciando modulo jump
	wire [31:0] jump_module_to_mux;
	jump mips_jump(pc_increment[31:28], instruction[25:0], jump_module_to_mux);
	
	//instanciando o jr pc
	wire [31:0] jr_PC;
	jr_control mips_jr_control(instruction[31:26], instruction[5:0], ReadData1, pc, jr_PC);
	
	// instanciando o pc source {:)
	wire [1:0] PCSource;
	mux_32_4 pc_mux (pc_increment, add_branching_to_mux, add_branching_to_mux, jr_PC, PCSource, nextPC);

endmodule








