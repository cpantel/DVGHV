`timescale 1ns/1ps

module clock_divider_testbench;
  reg simul_Clock;
  reg simul_reset_button;
  wire simul_clk_div2;
  wire simul_clk_div4;
  wire simul_clk_div8;
  wire simul_clk_div16;

  initial begin
    simul_Clock = 1'b0;
    forever simul_Clock = #2.5 ~simul_Clock;
  end

  initial begin
    simul_reset_button = 1'b1;
    #100 simul_reset_button = 1'b0;
  end

  initial begin
    repeat(64) @(negedge simul_Clock);
    $finish;
  end

   // Monitor
  always @(*)
    $strobe("[@%0t] LEDS_n = %b", $time, {simul_Clock, simul_clk_div2, simul_clk_div4, simul_clk_div8, simul_clk_div16});

  clock_divider divider (
   .clk(simul_Clock),
   .reset(simul_reset_button),
   .clk_div2(simul_clk_div2),
   .clk_div4(simul_clk_div4),
   .clk_div8(simul_clk_div8),
   .clk_div16(simul_clk_div16)
  );

endmodule