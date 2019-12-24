`timescale 1ns/1ps


module pattern(
  input Clock,
  input reset,
  output HS_probe,
  output VS_probe,
  output hsync,
  output vsync,
  output reg [3:0]VGA_R,
  output reg [3:0]VGA_G,
  output reg [3:0]VGA_B
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
  
 
  always @( hpos)
  begin
  if (display_on) 
    begin
      if (hpos < 80) begin 
        VGA_R <= 16'hff;
        VGA_G <= 16'hff;
        VGA_B <= 16'hff;
      end else if ( hpos < 160) begin
        VGA_R <= 16'hff;
        VGA_G <= 16'hff;
        VGA_B <= 16'h00;
      end else if ( hpos < 240) begin
        VGA_R <= 16'h00;
        VGA_G <= 16'hff;
        VGA_B <= 16'hff;
      end else if ( hpos < 320) begin
        VGA_R <= 16'h00;
        VGA_G <= 16'hff;
        VGA_B <= 16'h00;
      end else if ( hpos < 400) begin
        VGA_R <= 16'hfe;
        VGA_G <= 16'h00;
        VGA_B <= 16'hff;
      end else if ( hpos < 480) begin
        VGA_R <= 16'hff;
        VGA_G <= 16'h00;
        VGA_B <= 16'h00;
      end else if ( hpos < 560) begin
        VGA_R <= 16'h00;
        VGA_G <= 16'h00;
        VGA_B <= 16'hff;
      end else begin
        VGA_R <= 16'h00;
        VGA_G <= 16'h00;
        VGA_B <= 16'h00;
      end
    end
  end
endmodule
