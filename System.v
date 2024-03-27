//Dana 1200031
module counter(input clk,go,reset,output reg [4:0]numbers);

	always@(posedge clk)
		begin
		if(reset == 1'b0)begin	  // if reset is 0 , count
			numbers <= numbers + 5'd1; 
		end
		if ( go == 1'b0)begin	  //if go is 0 freeze 
			numbers <= numbers;		 
		end
		else
			numbers <= 5'd0;	//else reset counter 
		end
		
endmodule 

module traffic_light_controller (
    input clk, go, reset ,delay, output reg [1:0] highway_sig1, reg[1:0] highway_sig2, reg [1:0] farm_sig1, reg[1:0] farm_sig2);
reg [4:0]count ;
reg [4:0] state; 
parameter G = 2'b00, // green,
		 YG = 2'b01, // yellow from green
		 R = 2'b10, //red
		 RY = 2'b11; // yellow from red 
always @ (posedge clk) begin
    if(reset) begin 
		count <= 0;
        state <= 0;
    end else if(go) begin
		count <= delay;
        case (state)
            5'b00000: begin // State S0	
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b00001)
                	state <= 5'b00001;
				
            end
            5'b00001: begin // State S1
                highway_sig1 <= RY;
                highway_sig2 <= RY;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b00010)
                	state <= 5'b00010;
            end
            5'b00010: begin // State S2
                highway_sig1 <= G;
                highway_sig2 <= G;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b11110)
                	state <= 5'b00011;
            end
			// ==============================================
           	5'b00011: begin // State S3
                highway_sig1 <= G;
                highway_sig2 <= YG;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b00010)
                	state <= 5'b00100;
            end
            5'b00100: begin // State S4
                highway_sig1 <= G;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b01010)
                	state <= 5'b00101;
            end
            5'b00101: begin // State S5
                highway_sig1 <= YG;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b00010)
                	state <= 5'b00110;
			end
			// ==============================================
			5'b00110: begin // State S6
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b00001)
                	state <= 5'b00111;
            end
            5'b00111: begin // State S7
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= RY;
                farm_sig2 <= RY;
				if(count == 5'b00010)
                	state <= 5'b01000;
            end
            5'b01000: begin // State S8
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= G;
                farm_sig2 <= G;
				if(count == 5'b01111)
                	state <= 5'b01001;
			end
			// ==============================================
			5'b01001: begin // State S9
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= G;
                farm_sig2 <= YG;
				if(count == 5'b00001)
                	state <= 5'b01010;
            end
            5'b01010: begin // State S10
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= G;
                farm_sig2 <= R;
				if(count == 5'b00101)
               		state <= 5'b01011;
            end
            5'b01011: begin // State S11
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= YG;
                farm_sig2 <= RY;
				if(count == 5'b00010)
                	state <= 5'b01100;
			end
			// ==============================================
			5'b01100: begin // State S12
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= G;
				if(count == 5'b01010)
                	state <= 5'b01101;
            end
            5'b01101: begin // State S13
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= YG;
				if(count == 5'b00010)
                	state <= 5'b01110;
            end
            5'b01110: begin // State S14
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b00001)
                	state <= 5'b01111; 
			end
			// ==============================================
			5'b01111: begin // State S15
                highway_sig1 <= R;
                highway_sig2 <= RY;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b00010)
                	state <= 5'b10000;
            end
            5'b10000: begin // State S16
                highway_sig1 <= R;
                highway_sig2 <= G;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b01111)
                	state <= 5'b10001;
            end
            5'b10001: begin // State S17
                highway_sig1 <= R;
                highway_sig2 <= YG;
                farm_sig1 <= R;
                farm_sig2 <= R;
				if(count == 5'b00011)
					state <= 5'b00000;
            end
        endcase
    end
end

endmodule
module traffic_light_Static (
    input clk, go, reset ,delay, output reg [1:0] highway_sig1, reg[1:0] highway_sig2, reg [1:0] farm_sig1, reg[1:0] farm_sig2);
reg [4:0]count ;
reg [4:0] state; 
parameter G = 2'b00, // green,
		 YG = 2'b01, // yellow from green
		 R = 2'b10, //red
		 RY = 2'b11; // yellow from red 
always @ (posedge clk) begin
    if(reset) begin 
		count <= 0;
        state <= 0;
    end else if(go) begin
		count <= delay;
        case (state)
            5'b00000: begin // State S0	
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #1ns state <= 5'b00001;
				
            end
            5'b00001: begin // State S1
                highway_sig1 <= RY;
                highway_sig2 <= RY;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #2ns state <= 5'b00010;
            end
            5'b00010: begin // State S2
                highway_sig1 <= G;
                highway_sig2 <= G;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #30ns state <= 5'b00011;
            end
			// ==============================================
           	5'b00011: begin // State S3
                highway_sig1 <= G;
                highway_sig2 <= YG;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #2ns state <= 5'b00100;
            end
            5'b00100: begin // State S4
                highway_sig1 <= G;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #10ns state <= 5'b00101;
            end
            5'b00101: begin // State S5
                highway_sig1 <= YG;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #2ns state <= 5'b00110;
			end
			// ==============================================
			5'b00110: begin // State S6
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #1ns state <= 5'b00111;
            end
            5'b00111: begin // State S7
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= RY;
                farm_sig2 <= RY;
                #2ns state <= 5'b01000;
            end
            5'b01000: begin // State S8
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= G;
                farm_sig2 <= G;
                #15ns state <= 5'b01001;
			end
			// ==============================================
			5'b01001: begin // State S9
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= G;
                farm_sig2 <= YG;
                #2ns state <= 5'b01010;
            end
            5'b01010: begin // State S10
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= G;
                farm_sig2 <= R;
               	#5ns state <= 5'b01011;
            end
            5'b01011: begin // State S11
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= YG;
                farm_sig2 <= RY;
                #2ns state <= 5'b01100;
			end
			// ==============================================
			5'b01100: begin // State S12
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= G;
                #10ns state <= 5'b01101;
            end
            5'b01101: begin // State S13
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= YG;
                #2ns state <= 5'b01110;
            end
            5'b01110: begin // State S14
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #1ns state <= 5'b01111; 
			end
			// ==============================================
			5'b01111: begin // State S15
                highway_sig1 <= R;
                highway_sig2 <= RY;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #2ns state <= 5'b10000;
            end
            5'b10000: begin // State S16
                highway_sig1 <= R;
                highway_sig2 <= G;
                farm_sig1 <= R;
                farm_sig2 <= R;
                #15ns state <= 5'b10001;
            end
            5'b10001: begin // State S17
                highway_sig1 <= R;
                highway_sig2 <= YG;
                farm_sig1 <= R;
                farm_sig2 <= R;
				#3ns state <= 5'b00000;
            end
        endcase
    end
end

endmodule

module 
(input clk,go,reset,output reg [1:0] highway_sig1, reg[1:0] highway_sig2, reg [1:0] farm_sig1, reg[1:0] farm_sig2);
// the original system we want to use.
wire [4:0]delays;

counter c1(clk,go,reset,delays);
traffic_light_controller tlc(clk,go,reset,delays,highway_sig1,highway_sig2,farm_sig1,farm_sig2);

endmodule

module com_system(input clk,go,reset,output reg [1:0] highway_sig1, reg[1:0] highway_sig2, reg [1:0] farm_sig1, reg[1:0] farm_sig2);
// a test system we want to compare to.
wire [4:0]delays;

counter c1(clk,go,reset,delays);
traffic_light_controller tlc(clk,go,reset,delays,highway_sig1,highway_sig2,farm_sig1,farm_sig2);

endmodule	

module analyser(input clk,go,reset,output reg test);	  
	
wire  [1:0] highway_sig1So, highway_sig2So, farm_sig1So,farm_sig2So;	// signals from original system
wire [1:0] highway_sig1Sc; wire[1:0] highway_sig2Sc; wire [1:0] farm_sig1Sc; wire[1:0] farm_sig2Sc;	// signals from comparable system

og_system So(clk,go,reset,  highway_sig1So,  highway_sig2So,   farm_sig1So, farm_sig2So);
com_system Sc(clk,go,reset, highway_sig1Sc,  highway_sig2Sc,   farm_sig1Sc, farm_sig2Sc);
always@(posedge clk)
	begin
if(	 ( highway_sig1So[1:0] != highway_sig1Sc[1:0]) || (  highway_sig2So != highway_sig2Sc) || ( farm_sig1So != farm_sig1Sc ) || ( farm_sig2So != farm_sig2Sc) )
	begin															  
		$display("error ");
		$finish;
	end
else
	begin
	$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1So,  highway_sig2So,   farm_sig1So, farm_sig2So);
	end
end	


endmodule


	
