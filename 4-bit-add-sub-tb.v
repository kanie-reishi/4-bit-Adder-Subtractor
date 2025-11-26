`timescale 1ns/1ps

module tb_four_bit_adder_sub;

  reg [3:0] a;
  reg [3:0] b;
  reg [1:0] op;
  wire [3:0] y;
  wire cf;

  localparam [1:0] OP_ADD = 2'b00;
  localparam [1:0] OP_SUB = 2'b01;

  // --- PHẦN SỬA LỖI MONITOR ---
  // Tạo một biến string để hiển thị tên phép tính
  reg [8*3:1] op_string; // 3 ký tự (ADD/SUB), mỗi ký tự 8 bit

  // Cập nhật string mỗi khi op thay đổi
  always @* begin
    if (op == OP_ADD) op_string = "ADD";
    else              op_string = "SUB";
  end
  // -----------------------------

  four_bit_adder_sub uut (
    .a(a), .b(b), .op(op), .y(y), .cf(cf)
  );

  initial begin
    // Đổi tên thành dump.vcd để EDA Playground tự nhận diện
    $dumpfile("dump.vcd"); 
    $dumpvars(0, tb_four_bit_adder_sub); 
  end

  initial begin
    $display("Time\t OP\t A\t B\t|\t Y\t CF");
    $display("----------------------------------------------------");
    
    // SỬA LỖI: Dùng biến op_string thay vì biểu thức điều kiện
    $monitor("%0t\t %s\t %d\t %d\t|\t %d\t %b", 
             $time, op_string, a, b, y, cf);

    // --- TRƯỜNG HỢP 1: PHÉP CỘNG ---
    op = OP_ADD;
    
    a = 4'd3; b = 4'd2;
    #10;

    a = 4'd15; b = 4'd1;
    #10;

    a = 4'd7; b = 4'd7;
    #10;

    // --- TRƯỜNG HỢP 2: PHÉP TRỪ ---
    op = OP_SUB;

    a = 4'd8; b = 4'd3;
    #10;

    a = 4'd5; b = 4'd5;
    #10;

    a = 4'd3; b = 4'd5;
    #10;

    $display("----------------------------------------------------");
    $finish;
  end

endmodule