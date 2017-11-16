`timescale 1ns / 1ps

module bin2bcd32(
    input wire [31:0] value,
    output wire [3:0] dig0,
    output wire [3:0] dig1,
    output wire [3:0] dig2,
    output wire [3:0] dig3,
    output wire [3:0] dig4,
    output wire [3:0] dig5,
    output wire [3:0] dig6,
    output wire [3:0] dig7
    );

    assign dig0 = value % 10;
    assign dig1 = (value / 10) % 10;
    assign dig2 = (value / 100) % 10;
    assign dig3 = (value / 1000) % 10;
    assign dig4 = (value / 10000) % 10;
    assign dig5 = (value / 100000) % 10;
    assign dig6 = (value / 1000000) % 10;
    assign dig7 = (value / 10000000) % 10;
endmodule


// Multiplier module, default bus width: 32 bits
module multiplier #(parameter width = 32)(
    // Two data inputs
    input wire [width - 1:0] A, B,

    // Multiplier data output
    output wire [width - 1:0] out
    );

    assign out = A * B;
endmodule


// Counter module with load and enable
module cnt_down #(parameter width = 32)(
    // Control signal inputs
    input wire load, enable, clk,
    // Data input
    input wire [width - 1:0] D,

    // Data output
    output reg [width - 1:0] Q
    );

    // Assign output to internal register
    always@(posedge clk)
    begin
        // If load is enabled, load data input into internal register
        if (load) Q = D;

        // Count down if enable is enabled
        if (enable) Q = Q - 4'b0001;
    end
endmodule


// Compare module
module compare #(parameter width = 32)(
    // Two Data inputs
    input wire [width - 1:0] A, B,

    // Data output
    output wire out
    );

    assign out = A > B ? 1 : 0;
endmodule


// register module
module register #(parameter width = 32)(
    input wire [width - 1:0] D,
    input wire loadreg, clk,
    output reg [width - 1:0] Q
    );

    initial Q = 0;

    always@(posedge clk)
    begin
        if (loadreg) Q = D;
    end
endmodule


// 2-input AND gate
module and2 #(parameter width = 32)(
    input wire  [width-1:0] a, b,
    output wire [width-1:0] y
    );

    assign y = a & b;
endmodule


// Set_reset register
module set_reset #(parameter width = 32)(
    input wire [width-1:0] set, rst,
    input wire clk,
    output reg [width-1:0] q
    );

    always@(clk) q = rst ? 0 : set;
endmodule
