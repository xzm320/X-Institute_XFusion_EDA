// Testbench for Vector Addition and Subtraction Unit
`timescale 1ns/1ps

module tb_add_and_sub;

    // Clock and reset
    reg clk;
    
    // Inputs to main module
    reg [7:0] in_vec1_1, in_vec1_2, in_vec1_3, in_vec1_4;
    reg [7:0] in_vec2_1, in_vec2_2, in_vec2_3, in_vec2_4;
    reg opcode;
    
    // Outputs from main module
    wire [7:0] out_vec3_1, out_vec3_2, out_vec3_3, out_vec3_4;
    
    // Instantiate the main module
    main uut (
        .clk(clk),
        .in_vec1_1(in_vec1_1),
        .in_vec1_2(in_vec1_2),
        .in_vec1_3(in_vec1_3),
        .in_vec1_4(in_vec1_4),
        .in_vec2_1(in_vec2_1),
        .in_vec2_2(in_vec2_2),
        .in_vec2_3(in_vec2_3),
        .in_vec2_4(in_vec2_4),
        .opcode(opcode),
        .out_vec3_1(out_vec3_1),
        .out_vec3_2(out_vec3_2),
        .out_vec3_3(out_vec3_3),
        .out_vec3_4(out_vec3_4)
    );
    
    // Clock generation (10ns period = 100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test stimulus
    initial begin
        // Initialize inputs
        in_vec1_1 = 0; in_vec1_2 = 0; in_vec1_3 = 0; in_vec1_4 = 0;
        in_vec2_1 = 0; in_vec2_2 = 0; in_vec2_3 = 0; in_vec2_4 = 0;
        opcode = 0;
        
        // Wait for a few clock cycles
        repeat(3) @(posedge clk);
        
        // Test Case 1: Vector Addition
        @(posedge clk);
        opcode = 0; // Addition
        in_vec1_1 = 8'h10; in_vec1_2 = 8'h20; in_vec1_3 = 8'h30; in_vec1_4 = 8'h40;
        in_vec2_1 = 8'h01; in_vec2_2 = 8'h02; in_vec2_3 = 8'h03; in_vec2_4 = 8'h04;
        
        // Wait for result
        repeat(3) @(posedge clk);
        
        // Test Case 2: Vector Subtraction
        @(posedge clk);
        opcode = 1; // Subtraction
        in_vec1_1 = 8'h50; in_vec1_2 = 8'h60; in_vec1_3 = 8'h70; in_vec1_4 = 8'h80;
        in_vec2_1 = 8'h05; in_vec2_2 = 8'h06; in_vec2_3 = 8'h07; in_vec2_4 = 8'h08;
        
        // Wait for result
        repeat(3) @(posedge clk);
        
        // Test Case 3: Test with larger numbers
        @(posedge clk);
        opcode = 0; // Addition
        in_vec1_1 = 8'hFF; in_vec1_2 = 8'hFE; in_vec1_3 = 8'hFD; in_vec1_4 = 8'hFC;
        in_vec2_1 = 8'h01; in_vec2_2 = 8'h02; in_vec2_3 = 8'h03; in_vec2_4 = 8'h04;
        
        // Wait for result
        repeat(3) @(posedge clk);
        
        // Test Case 4: Test underflow in subtraction
        @(posedge clk);
        opcode = 1; // Subtraction
        in_vec1_1 = 8'h05; in_vec1_2 = 8'h04; in_vec1_3 = 8'h03; in_vec1_4 = 8'h02;
        in_vec2_1 = 8'h10; in_vec2_2 = 8'h20; in_vec2_3 = 8'h30; in_vec2_4 = 8'h40;
        
        // Wait for result and finish
        repeat(5) @(posedge clk);
        
        $display("Simulation completed successfully!");
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor("Time=%0t clk=%b opcode=%b | Vec1=[%h,%h,%h,%h] Vec2=[%h,%h,%h,%h] | Result=[%h,%h,%h,%h]", 
                 $time, clk, opcode, 
                 in_vec1_1, in_vec1_2, in_vec1_3, in_vec1_4,
                 in_vec2_1, in_vec2_2, in_vec2_3, in_vec2_4,
                 out_vec3_1, out_vec3_2, out_vec3_3, out_vec3_4);
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("add_and_sub_waves.vcd");
        $dumpvars(0, tb_add_and_sub);
    end

endmodule