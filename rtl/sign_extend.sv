module sign_extend(
    input logic clock,
    input logic reset,

    input logic [24:0] base_imm,
    input logic [1:0] imm_src,

    output logic [31:0] imm_ext
);

    always_comb begin
        case (imm_src)
            2'b00 : // I-type
                imm_ext = {20{base_imm[24]}, base_imm[24:13]};
            2'b01 : // S-type
                imm_ext = {20{base_imm[24]}, base_imm[24:18], base_imm[4:0]};
            2'b10 : // B-type
                imm_ext = {20{base_imm[24]}, base_imm[0], base_imm[23:19], base_imm[4:1], 1'b0}; // 32-bit so need zero
            2'b11 : // J-type
                imm_ext = {12{base_imm[24]}, base_imm[14:5], base_imm[15], base_imm[23:16], 1'b0};
        endcase
    end

endmodule