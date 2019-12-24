`timescale 1ns/1ps

module digits(
  input Clock,
  input reset,
  output hsync,
  output vsync,
  output HS_probe,
  output VS_probe,
  output RED,
  output GREEN,
  output BLUE
);
  assign HS_probe = hsync;
assign VS_probe = vsync;
  wire display_on = 0;
  wire [9:0] hpos = 0;
  wire [9:0] vpos = 0;
  
  video_sync_generator video_sync_generator (
   .clk(Clock),
   .reset(reset),
   .hsync(hsync),
   .vsync(vsync),
   .display_on(display_on),
   .hpos(hpos),
   .vpos(vpos)
  );
  
  
  wire [3:0] digit = hpos[7:4]; // era 7:4
  wire [2:0] xofs  = hpos[3:1];  // era 3:1
  wire [2:0] yofs  = vpos[4:2]; // era 3:1
  wire [4:0] bits;
  wire [6:0] segments;
  
  seven_segment_decoder decoder(
    .digit(digit),
    .segments(segments)
  );
  
  segments_to_bitmap numbers(
    .segments(segments),
    .line(yofs),
    .bits(bits)
  );

  assign RED   = display_on && 0;
  assign GREEN = display_on && bits[~xofs];
  assign BLUE  = display_on && 0;


endmodule
