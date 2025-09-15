module core(
    input logic clock,
    input logic reset,
    output logic [31:0] pc
);

    always_ff @(posedge reset or posedge clock)
        if ( reset )
            pc <= 32'h0;
        else
            pc <= pc + 32'h4;

endmodule
