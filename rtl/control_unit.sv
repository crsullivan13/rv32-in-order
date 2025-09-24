module control_unit(
    input logic clock,
    input logic reset,

    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic [6:0] funct7,

    output logic [2:0] alu_op,
    output logic reg_write_enable,
    output logic [1:0] imm_src,
    output logic alu_src,
    output logic mem_write,
    output logic [1:0] result_src,
    output logic branch,
    output logic jump
);
    logic controls [10:0];

    always_comb begin
        //regWrite_immSrc_alusrc_memwrite_resultsrc_branch_alu_jump
        case (op)
            7'b0110011 : // R type
                controls = 11'b1_xx_0_0_00_0_10_0;
            7'b0010011 : // I-type ALU
                controls = 11'b1_00_0_0_00_0_10_0;
            default:
                controls = 11'bx_xx_x_x_xx_x_xx_x;
        endcase
    end

    always_comb begin
        case (controls[8:9])
            2'b00 : // lw,sw add
                alu_op = 3'b000;
            2'b01 : // beq sub
                alu_op = 3'b001;
            2'b10 :
                case (funct3)
                    3'b000 : // add/sub
                        case ({op[5], funct7[5]})
                            2'b00 : // add
                                alu_op = 3'b000;
                            2'b01 : // add
                                alu_op = 3'b000;
                            2'b10 : // add
                                alu_op = 3'b000;
                            2'b11 : // sub
                                alu_op = 3'b001;
                            default:
                                alu_op = 3'bxxx;
                        endcase
                    3'b010 : // slt
                        alu_op = 3'b101;
                    3'b110 : // or
                        alu_op = 3'b011;
                    3'b111 : // and
                        alu_op = 3'b010;
                endcase
            default :
                alu_op = 3'bxxx;
        endcase
    end

endmodule