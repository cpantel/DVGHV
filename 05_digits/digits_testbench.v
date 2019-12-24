`timescale 1ns/1ps

module digits_testbench;
  reg simul_Clock;
  reg simul_reset_button;
  wire simul_hsync;
  wire simul_vsync;
  wire simul_GREEN;
  wire simul_RED;
  wire simul_BLUE;

  initial begin
    simul_Clock = 1'b0;
    forever simul_Clock = #1 ~simul_Clock;
   // $display("0x%0h 0x%0h 0x%0h 0x%0h", simul_Clock, simul_hsync, simul_vsync, simul_GREEN);
  end

  initial begin
    simul_reset_button = 1'b1;
    #100 simul_reset_button = 1'b0;
  end

  initial begin
    repeat(100) @(negedge simul_Clock);
    $finish;
  end


 always @(negedge simul_Clock)
    $strobe("%b %b %b #%h%h%h%h%h%h" , simul_Clock, simul_hsync, simul_vsync,
       simul_RED, simul_RED, simul_GREEN, simul_GREEN, simul_BLUE, simul_BLUE
    );

  digits digits (
    .Clock(simul_Clock),
    .reset(simul_reset_button),
    .hsync(simul_hsync),
    .vsync(simul_vsync),
    .GREEN(simul_GREEN),
    .RED(simul_RED),
    .BLUE(simul_BLUE)
  );


endmodule
