`timescale 1ns/1ps


module pattern_testbench;
  reg simul_Clock;
  reg simul_reset;
  wire simul_hsync;
  wire simul_vsync;
  wire [3:0]simul_RED;
  wire [3:0]simul_GREEN;
  wire [3:0]simul_BLUE;
  
  initial begin
     $display("clock ok");
     simul_Clock = 1'b0;  
     forever simul_Clock =  #1 ~simul_Clock;
  end
  
  initial begin
     $display("reset set");
     simul_reset = 1'b1;
     #100 simul_reset = 1'b0;
     $display("reset unset");
  end
  
  initial begin
     $display("run");
     repeat(40000) @(negedge simul_Clock);
     $finish;
     $display("finish");
  end
  
  /*
always @(negedge simul_Clock)
     $strobe("%b %b %b #%2h%2h%2h2h%2h%2h" , simul_Clock, simul_hsync, simul_vsync,
        simul_RED, simul_RED, simul_GREEN, simul_GREEN, simul_BLUE, simul_BLUE
     );
     
  
  */
  
   // Monitor
 always @(negedge simul_Clock)
   $strobe("%b %b %b #%h%h%h%h%h%h" , simul_Clock, simul_hsync, simul_vsync,
      simul_RED, simul_RED, simul_GREEN, simul_GREEN, simul_BLUE, simul_BLUE
   );
 

pattern pattern(
  .Clock(simul_Clock),
  .reset(simul_reset),
  .hsync(simul_hsync),
  .vsync(simul_vsync),
  .VGA_R(simul_RED),
  .VGA_G(simul_GREEN),
  .VGA_B(simul_BLUE)
);


endmodule