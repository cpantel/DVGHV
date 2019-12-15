`timescale 1ns/1ps


module pattern_testbench;
  reg simul_Clock;
  reg simul_reset;
  wire simul_hsync;
  wire simul_vsync;
  wire [3:0]simul_GREEN;
  
  initial begin
     $display("clock ok");
     simul_Clock = 1'b0;  
     forever simul_Clock = #2.5 ~simul_Clock;
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
  
   // Monitor
 //always @(*)
 //  $strobe("[@%0t] %b %b %b" , $time, {simul_reset, simul_Clock, simul_hsync}));
 

pattern pattern(
  .Clock(simul_Clock),
  .reset(simul_reset),
  .hsync(simul_hsync),
  .vsync(simul_vsync),
  .VGA_G(simul_GREEN)
);


endmodule