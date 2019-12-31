`timescale 1ns/1ps


// test module
module test_numbers_top(
  input Clock,
  input reset,
  output HS_probe,
  output VS_probe,
  output hsync,
  output vsync,
  output [3:0]VGA_R,
  output [3:0]VGA_G,
  output [3:0]VGA_B
);

  
  wire display_on;
  wire [9:0] hpos;
  wire [9:0] vpos;
  
  video_sync_generator hvsync_gen(
    .clk(Clock),
    .reset(reset),
    .hsync(hsync),
    .vsync(vsync),
    .display_on(display_on),
    .hpos(hpos),
    .vpos(vpos)
  );
  
  wire [3:0] digit = hpos[7:4];
  wire [2:0] xofs = hpos[3:1];
  wire [2:0] yofs = vpos[3:1];
  wire [4:0] bits;
  
  digits10_array numbers(
    .digit(digit),
    .yofs(yofs),
    .bits(bits)
  );

  assign VGA_R = {4{display_on && 0}};
  assign VGA_G = {4{display_on && bits[xofs  ^ 3'b111]}};
  assign VGA_B = {4{display_on && 0}};
endmodule

