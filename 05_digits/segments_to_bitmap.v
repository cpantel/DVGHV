`timescale 1ns/1ps

module segments_to_bitmap(segments, line, bits);
  
  input [6:0] segments;
  input [2:0] line;
  output reg [4:0] bits;
  
  always @(*)
    case (line)
      0:bits = (segments[6]?5'b11111:0) 
             ^ (segments[5]?5'b00001:0) 
             ^ (segments[1]?5'b10000:0);
      1:bits = (segments[1]?5'b10000:0) 
             ^ (segments[5]?5'b00001:0);
      2:bits = (segments[0]?5'b11111:0) 
             ^ (|segments[5:4]?5'b00001:0) 
             ^ (|segments[2:1]?5'b10000:0);
      3:bits = (segments[2]?5'b10000:0) 
             ^ (segments[4]?5'b00001:0);
      4:bits = (segments[3]?5'b11111:0) 
             ^ (segments[4]?5'b00001:0) 
             ^ (segments[2]?5'b10000:0);
      5:bits = 5'b00000;
      6:bits = 5'b00000;
      7:bits = 5'b00000;
      
      default:bits = 5'b00000;
    endcase
  
endmodule
