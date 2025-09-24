module core(
    input logic clock,
    input logic reset,
    output logic [31:0] pc
);

    instruction_fetch fetch(.clock (clock), .reset (reset), .pc (pc));

endmodule
