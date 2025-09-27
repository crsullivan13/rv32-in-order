module decode(
    input logic clock,
    input logic reset
    input logic [31:0] instruction,

    input logic [31:0] write_data,
    input logic [4:0] write_destination,
    input logic write_enable,

    output logic [6:0] op,
    output logic [2:0] funct3,
    output logic [6:0] funct7

    output logic [31:0] source_data1_o, source_data2_o
);
    logic [4:0] rs1, rs2;

    logic [31:0] source_data1, source_data2;

    register_file (.clock (clock), .reset (reset),
                   .read_source1 (rs1), .read_source2 (rs2), .write_destination (write_destination),
                   .write_data (write_data), .write_enable (write_enable),
                   .source_data1 (source_data1), .source_data2 (source_data2));

    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign source_data1_o = source_data1;
    assign source_data2_o = source_data2;
    assign op = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];


endmodule
