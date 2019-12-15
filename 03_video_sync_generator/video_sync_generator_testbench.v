`timescale 1ns/1ps

module video_sync_generator_testbench;
  reg simul_Clock;
  reg simul_reset_button;
  wire simul_hsync;
  wire simul_vsync;
  wire simul_display_on;
  wire [8:0]simul_hpos;
  wire [8:0]simul_vpos;
  
  

  initial begin
    simul_Clock = 1'b0;
    forever simul_Clock = #2.5 ~simul_Clock;
  end

  initial begin
    simul_reset_button = 1'b1;
    #100 simul_reset_button = 1'b0;
  end

  initial begin
    repeat(4000000) @(negedge simul_Clock);
    $finish;
  end

   
  video_sync_generator video_sync_generator (
   .clk(simul_Clock),
   .reset(simul_reset_button),
   .hsync(simul_hsync),
   .vsync(simul_vsync),
   .display_on(simul_display_on),
   .hpos(simul_hpos),
   .vpos(simul_vpos)
  );

endmodule
