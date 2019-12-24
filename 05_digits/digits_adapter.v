module digits_adapter(
  input Clock,
  input reset,
  output hsync,
  output vsync,
  output HS_probe,
  output VS_probe,
  output [3:0]VGA_R,
  output [3:0]VGA_G,
  output [3:0]VGA_B
);

wire RED;
wire GREEN;
wire BLUE;

  digits digits (
    .Clock(Clock),
    .reset(reset),
    .hsync(hsync),
    .vsync(vsync),
    .RED(RED),
    .GREEN(GREEN),
    .BLUE(BLUE)
  );
    

  assign HS_probe = hsync;
  assign VS_probe = vsync;
  assign VGA_R = {4{RED}};
  assign VGA_G = {4{GREEN}};
  assign VGA_B = {4{BLUE}};
endmodule
