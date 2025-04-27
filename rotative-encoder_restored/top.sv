module top #(
            parameter int WIDTH = 8
        )
        (
          input logic CLOCK,
          input logic DT,
          input logic CLK,
          input logic RESET_n,
          output logic [7:0] LED
        );
    
  logic [WIDTH-1:0] pos;
  
  // Instanciation d'un encoder
  encoder #(.WIDTH(WIDTH)) my_encoder (
        .clock(CLOCK),
        .DT(DT),
        .CLK(CLK),
        .reset(~RESET_n), // pull-up sur le bouton reset, actif sur niveau bas
        .pos(pos)
  );


  assign LED = pos[7:0]; // compteur de position dirigé ves les 8 Leds

endmodule
