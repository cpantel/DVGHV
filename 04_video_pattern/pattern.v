`timescale 1ns/1ps


module pattern(
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
  
  assign VGA_R = {4{display_on && (((hpos&7)==0) || ((vpos&7)==0))}};
  assign VGA_G = {4{display_on && vpos[4]}};
  assign VGA_B = {4{display_on && hpos[4]}};

  
endmodule
