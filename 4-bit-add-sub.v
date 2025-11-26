`timescale 1ns/1ps
module four_bit_adder_sub(
  input [3:0] a,
  input [3:0] b,
  input [1:0] op,
  output reg [3:0] y,
  output reg cf
);
  localparam [1:0]
  		OP_ADD = 2'b00,
  		OP_SUB = 2'b01;
  
  wire sub = (op == OP_SUB);
  
  wire [4:0] result5 = {1'b0, a} + {1'b0, (sub ? ~b : b)} + {4'b0000, sub};
  
  always @* begin
    y = result5[3:0];
    cf = sub ? ~result5[4] : result5[4];
  end
endmodule