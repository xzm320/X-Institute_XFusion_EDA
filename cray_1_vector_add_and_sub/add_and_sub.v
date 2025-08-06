// Vector Addition and Subtraction Unit
// Translated from Logisim circuit add_and_sub.circ

module alu (
    input [7:0] vec1_1,    // First element of vector 1
    input [7:0] vec1_2,    // Second element of vector 1  
    input [7:0] vec1_3,    // Third element of vector 1
    input [7:0] vec1_4,    // Fourth element of vector 1
    input [7:0] vec2_1,    // First element of vector 2
    input [7:0] vec2_2,    // Second element of vector 2
    input [7:0] vec2_3,    // Third element of vector 2
    input [7:0] vec2_4,    // Fourth element of vector 2
    input opcode,          // Operation select: 0=add, 1=subtract
    output [7:0] vec3_1,   // First element of result vector
    output [7:0] vec3_2,   // Second element of result vector
    output [7:0] vec3_3,   // Third element of result vector
    output [7:0] vec3_4    // Fourth element of result vector
);

    // Internal wires for addition results
    wire [7:0] add_result_1, add_result_2, add_result_3, add_result_4;
    
    // Internal wires for subtraction results  
    wire [7:0] sub_result_1, sub_result_2, sub_result_3, sub_result_4;
    
    // Perform addition for all elements
    assign add_result_1 = vec1_1 + vec2_1;
    assign add_result_2 = vec1_2 + vec2_2;
    assign add_result_3 = vec1_3 + vec2_3;
    assign add_result_4 = vec1_4 + vec2_4;
    
    // Perform subtraction for all elements
    assign sub_result_1 = vec1_1 - vec2_1;
    assign sub_result_2 = vec1_2 - vec2_2;
    assign sub_result_3 = vec1_3 - vec2_3;
    assign sub_result_4 = vec1_4 - vec2_4;
    
    // Select between addition and subtraction results based on opcode
    assign vec3_1 = opcode ? sub_result_1 : add_result_1;
    assign vec3_2 = opcode ? sub_result_2 : add_result_2;
    assign vec3_3 = opcode ? sub_result_3 : add_result_3;
    assign vec3_4 = opcode ? sub_result_4 : add_result_4;

endmodule

module main (
    input clk,             // Clock signal
    input [7:0] in_vec1_1, // Input vector 1, element 1
    input [7:0] in_vec1_2, // Input vector 1, element 2
    input [7:0] in_vec1_3, // Input vector 1, element 3
    input [7:0] in_vec1_4, // Input vector 1, element 4
    input [7:0] in_vec2_1, // Input vector 2, element 1
    input [7:0] in_vec2_2, // Input vector 2, element 2
    input [7:0] in_vec2_3, // Input vector 2, element 3
    input [7:0] in_vec2_4, // Input vector 2, element 4
    input opcode,          // Operation control
    output reg [7:0] out_vec3_1, // Output vector, element 1
    output reg [7:0] out_vec3_2, // Output vector, element 2
    output reg [7:0] out_vec3_3, // Output vector, element 3
    output reg [7:0] out_vec3_4  // Output vector, element 4
);

    // Input registers for vector 1
    reg [7:0] reg_vec1_1, reg_vec1_2, reg_vec1_3, reg_vec1_4;
    
    // Input registers for vector 2
    reg [7:0] reg_vec2_1, reg_vec2_2, reg_vec2_3, reg_vec2_4;
    
    // Input register for opcode - FIX: Add synchronization for opcode
    reg reg_opcode;
    
    // ALU output wires
    wire [7:0] alu_out_1, alu_out_2, alu_out_3, alu_out_4;
    
    // Instantiate ALU
    alu alu_inst (
        .vec1_1(reg_vec1_1),
        .vec1_2(reg_vec1_2),
        .vec1_3(reg_vec1_3),
        .vec1_4(reg_vec1_4),
        .vec2_1(reg_vec2_1),
        .vec2_2(reg_vec2_2),
        .vec2_3(reg_vec2_3),
        .vec2_4(reg_vec2_4),
        .opcode(reg_opcode),  // FIX: Use registered opcode
        .vec3_1(alu_out_1),
        .vec3_2(alu_out_2),
        .vec3_3(alu_out_3),
        .vec3_4(alu_out_4)
    );
    
    // Input registers - store input vectors and opcode on clock edge
    always @(posedge clk) begin
        reg_vec1_1 <= in_vec1_1;
        reg_vec1_2 <= in_vec1_2;
        reg_vec1_3 <= in_vec1_3;
        reg_vec1_4 <= in_vec1_4;
        reg_vec2_1 <= in_vec2_1;
        reg_vec2_2 <= in_vec2_2;
        reg_vec2_3 <= in_vec2_3;
        reg_vec2_4 <= in_vec2_4;
        reg_opcode <= opcode;  // FIX: Register opcode for proper timing
    end
    
    // Output registers - store ALU results on clock edge
    always @(posedge clk) begin
        out_vec3_1 <= alu_out_1;
        out_vec3_2 <= alu_out_2;
        out_vec3_3 <= alu_out_3;
        out_vec3_4 <= alu_out_4;
    end

endmodule