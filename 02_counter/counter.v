`timescale 1ns/1ps


/*
A clock divider in Verilog, using the cascading
flip-flop method.
*/

module counter(
  input clk,
  input reset,
  output reg [3:0]counter

);

  // simple ripple clock divider
  always @(posedge reset)
  begin
     counter <= 0;
  end
  
  always @(posedge clk)
    if (reset) counter <= 0;
    else counter <= counter +1;

endmodule
