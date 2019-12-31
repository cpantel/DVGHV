`timescale 1ns/1ps

module digits(
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

  assign HS_probe = hsync;
  assign VS_probe = vsync;
    
  video_sync_generator video_sync_generator (
   .clk(Clock),
   .reset(reset),
   .hsync(hsync),
   .vsync(vsync),
   .display_on(display_on),
   .hpos(hpos),
   .vpos(vpos)
  );
  
  
  wire [3:0] digit = hpos[7:4]; // 7:4 // 4
  wire [2:0] xofs  = hpos[3:1]; // 3:1 // 3
  wire [2:0] yofs  = vpos[3:1]; // 3:1 // 3
  wire [4:0] bits;              // 4:0 // 5
  wire [6:0] segments;          // 6:0 // 7
  
  seven_segment_decoder decoder(
    .digit(digit),
    .segments(segments)
  );
  
  segments_to_bitmap numbers(
    .segments(segments),
    .line(yofs),
    .bits(bits)
  );
  
  assign VGA_R = {4{display_on && 0}};
  assign VGA_G = {4{display_on && bits[~xofs]}};
  assign VGA_B = {4{display_on && 0}};
  
endmodule
