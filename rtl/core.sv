module core(
    input logic clock,
    input logic reset,
    output logic [31:0] pc
);

    // if
    logic instr [31:0];
    instruction_fetch fetch(.clock (clock), .reset (reset), .pc (pc), .instr (instr));

    // decode
    logic alu_op [2:0];
    logic reg_write_enable;
    logic imm_src [1:0];
    logic alu_src;
    logic mem_write;
    logic result_src [1:0];
    logic branch;
    logic jump;

    logic op [6:0];
    logic funct3 [2:0];
    logic funct7 [6:0];
    logic source_data1_o [31:0];
    logic source_data2_o [31:0];

    logic imm_ext [31:0];

    control_unit control(.clock (clock), .reset (reset),
                        .op (op), .funct3 (funct3), .funct7 (funct7),
                        .alu_op (alu_op), reg_write_enable (reg_write_enable),
                        .imm_src (imm_src), .alu_src (alu_src), .mem_write (mem_write),
                        .result_src (result_src), .branch (branch), .jump (jump));

    decode decode(.clock (clock), .reset (reset), .instruction (instr),
                 .write_data (result), .write_destination (write_dest),
                 .write_enable (mem_write), .op (op), .funct3 (funct3),
                 .funct7 (funct7), .source_data1_o (source_data1_o),
                 .source_data2_o (source_data2_o)); // TODO: Fill in write data/dest

    sign_extend imm_extender(.clock (clock), .reset (reset)
                            .base_imm (instr[31:7]), .imm_src (imm_src),
                            .imm_ext (imm_ext));

    // exe

endmodule
