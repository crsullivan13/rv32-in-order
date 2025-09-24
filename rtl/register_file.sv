module register_file(
    input logic clock,
    input logic reset,
    input logic [4:0] read_source1, read_source2, write_destination,
    input logic [31:0] write_data,
    input logic write_enable,

    output logic [31:0] source_data1, source_data2
);

    logic [31:0] reg_file[31:0];

    always_ff @(posedge clock)
        if ( write_enable )
            reg_file[write_destination] <= write_data;

    assign source_data1 = read_source1 == 32'h0 ? 32'h0 : reg_file[read_source1];
    assign source_data2 = read_source2 == 32'h0 ? 32'h0 : reg_file[read_source2];
endmodule