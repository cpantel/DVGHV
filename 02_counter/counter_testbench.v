`timescale 1ns/1ps

module counter_testbench;
  reg simul_Clock;
  reg simul_reset_button;
  wire [3:0]simul_counter;

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
    $strobe("[@%0t] LEDS_n = %b", $time, {simul_Clock, simul_counter});

  counter counter (
   .clk(simul_Clock),
   .reset(simul_reset_button),
   .counter(simul_counter)
  );

endmodule