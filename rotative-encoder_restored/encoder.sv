module encoder	#(
						parameter int WIDTH = 8
					 )
					 (
						input logic clock,					// horloge principale
						input logic DT, CLK, 				// signaux de l'encodeur en quadrature
						output logic [WIDTH-1:0] pos,		// position (relative)
						input reset								// reset asynchrone, position=0
);

    logic [2:0] chA, chB;	// pipelines channelA, channelB
	 logic edge_detection;	// détection de front
	 logic up_down;			// avance ou retard de phase ?
	 
	 always_ff @(posedge clock) begin
		chA <= {chA[1:0], DT}; 	// channel A, pipeline signal DT       
		chB <= {chB[1:0], CLK}; // channel B, pipeline signal CLK
	 end
	 	 
	 assign edge_detection = (chA[1] ^ chA[2]) || (chB[1] ^ chB[2]);	 
	 assign up_down = chA[1] ^ chB[2];
	 	 
	 always @(posedge clock or posedge reset) begin
		if (reset) begin
			pos <= 0;
		end
		else if (edge_detection) begin
			pos <= up_down ? pos + 1 : pos - 1; // incrémentation ou décrémentation de la position
		end 	
    end
	  
endmodule
