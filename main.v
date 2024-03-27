//1200031 Dana Ghnimat Section 2 
module counter(input clk,go,reset,output reg [4:0]numbers);
		 
	always@(posedge clk)
		begin
		if(reset == 1'b0)begin// if reset is 0 , count
			if(go == 1'b1) begin
				numbers <= numbers + 5'd1;
			end
		else begin
			numbers <= numbers;	
			end
		end

		else
			numbers <= 5'd0;	//else reset counter 
		end
		
endmodule 
module counter_tb();
	reg clk,go,reset;
	wire [4:0]counts;
	
counter c(clk,go,reset,counts);
initial
	begin
	 reset =1'b1; go = 1'b0; clk = 1'b0;
	#1s reset =1'b0; go = 1'b1;
	#10s go = 1'b0;
	
  end
always  #0.5s clk = ~clk;	
	initial #50s $stop;	
endmodule

//=============================== End of Counter ==============================//	

module traffic_light_controller (
    input clk, go, reset ,[4:0]delay, output reg [1:0] highway_sig1, reg[1:0] highway_sig2, reg [1:0] farm_sig1, reg[1:0] farm_sig2);

parameter G = 2'b00, // green,
		 YG = 2'b01, // yellow from green
		 R = 2'b10, //red
		 RY = 2'b11; // yellow from red	 
		 
reg [4:0] current_state, next_state;
always @(posedge clk)
begin
 if(reset==1) 
 current_state <= 0;// when reset=1, reset the state  to "Zero" State
 else
	 if(go)begin
	 current_state <= next_state; // otherwise, next state
	 end
 
end	 
//check to go to the next state  
always @(current_state,delay,posedge clk )begin
           case (current_state)
            5'b00000: begin // State S0
				next_state <= 5'b00001;	 //since the delay is 1 the output will be correct 
				if(delay == 5'b00001)
                	next_state <= 5'b00001;
				
			  end
            5'b00001: begin // State S1
				next_state <= 5'b00010; //same goes to this states. 
				if(delay == 5'b00010)
					next_state <= 5'b00010;
            end
            5'b00010: begin // State S2
				if(delay == 5'b11110)
                    next_state <= 5'b00011;
				end
       
			// ==============================================
           	5'b00011: begin // State S3
				if(delay == 5'b00010)
                	next_state <= 5'b00100;
            end
            5'b00100: begin // State S4
				if(delay == 5'b01010)
                	next_state <= 5'b00101;
            end
            5'b00101: begin // State S5
				if(delay == 5'b00010)
                	next_state <= 5'b00110;
			end
			// ==============================================
			5'b00110: begin // State S6;
				if(delay == 5'b00001)
                	next_state <= 5'b00111;
            end
            5'b00111: begin // State S7
				if(delay == 5'b00010)

                	next_state <= 5'b01000;
            end
            5'b01000: begin // State S8
				if(delay == 5'b01111)

                	next_state <= 5'b01001;
			end
			// ==============================================
			5'b01001: begin // State S9
				if(delay == 5'b00001)

                	
					next_state <= 5'b01010;
            end
            5'b01010: begin // State S10
				if(delay == 5'b00101)

               		next_state <= 5'b01011;
            end
            5'b01011: begin // State S11
				if(delay == 5'b00010)

                	next_state <= 5'b01100;
			end
			// ==============================================
			5'b01100: begin // State S12
				if(delay == 5'b01010)

                	next_state <= 5'b01101;
            end
            5'b01101: begin // State S13
				if(delay == 5'b00010)

                	next_state <= 5'b01110;
            end
            5'b01110: begin // State S14
				if(delay == 5'b00001)

                	next_state <= 5'b01111; 
			end
			// ==============================================
			5'b01111: begin // State S15
				if(delay == 5'b00010)

                	next_state <= 5'b10000;
            end
            5'b10000: begin // State S16
				if(delay == 5'b01111)
                	next_state <= 5'b10001;
            end
            5'b10001: begin // State S17
				if(delay == 5'b00011)
					next_state <= 5'b00000;
            end
			
        endcase		
end
 //put the output of each state 
always @ (current_state) begin
        case (current_state)
            5'b00000: begin // State S0
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;					
			  end
            5'b00001: begin // State S1
                highway_sig1 <= RY;
                highway_sig2 <= RY;
                farm_sig1 <= R;
                farm_sig2 <= R;
            end
            5'b00010: begin // State S2
                highway_sig1 <= G;
                highway_sig2 <= G;
                farm_sig1 <= R;
                farm_sig2 <= R;
						
				end
       
			// ==============================================
           	5'b00011: begin // State S3
                highway_sig1 <= G;
                highway_sig2 <= YG;
                farm_sig1 <= R;
                farm_sig2 <= R;
            end
            5'b00100: begin // State S4
                highway_sig1 <= G;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
            end
            5'b00101: begin // State S5
                highway_sig1 <= YG;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;

			end
			// ==============================================
			5'b00110: begin // State S6
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;

            end
            5'b00111: begin // State S7
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= RY;
                farm_sig2 <= RY;

            end
            5'b01000: begin // State S8
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= G;
                farm_sig2 <= G;

			end
			// ==============================================
			5'b01001: begin // State S9
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= G;
                farm_sig2 <= YG;
            end
            5'b01010: begin // State S10
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= G;
                farm_sig2 <= R;

            end
            5'b01011: begin // State S11
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= YG;
                farm_sig2 <= RY;

			end
			// ==============================================
			5'b01100: begin // State S12
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= G;

            end
            5'b01101: begin // State S13
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= YG;

            end
            5'b01110: begin // State S14
                highway_sig1 <= R;
                highway_sig2 <= R;
                farm_sig1 <= R;
                farm_sig2 <= R;
 
			end
			// ==============================================
			5'b01111: begin // State S15
                highway_sig1 <= R;
                highway_sig2 <= RY;
                farm_sig1 <= R;
                farm_sig2 <= R;

            end
            5'b10000: begin // State S16
                highway_sig1 <= R;
                highway_sig2 <= G;
                farm_sig1 <= R;
                farm_sig2 <= R;

            end
            5'b10001: begin // State S17
                highway_sig1 <= R;
                highway_sig2 <= YG;
                farm_sig1 <= R;
                farm_sig2 <= R;

            end
			
        endcase

    end
 

endmodule

 //==================================== End of traffic light controler =========================//	
 
module test_system(input clk,go,reset,output reg [1:0] highway_sig1, reg[1:0] highway_sig2, reg [1:0] farm_sig1, reg[1:0] farm_sig2);
wire [4:0]delays;	
counter c1(clk,go,reset,delays);
traffic_light_controller tlc(clk,go,reset,delays,highway_sig1,highway_sig2,farm_sig1,farm_sig2);
endmodule
	
module testb_forsystem();
	reg clk,go,reset;
	wire [1:0] highway_sig1, highway_sig2, farm_sig1,farm_sig2;	
reg [4:0]delays;	
counter c1(clk,go,reset,delays);
traffic_light_controller tlc(clk,go,reset,delays,highway_sig1,highway_sig2,farm_sig1,farm_sig2);
initial
begin
	{clk,go,reset} = 3'b111;
	#1s go = 1'b1;reset = 1'b0;
	#1s go = 1'b0;
	#1s go = 1'b1;	
end

always  #0.5s clk = ~clk;	
	initial #200s $stop;

endmodule
//===================== end of test bench =====================//

module analyzer_systemCompare();
	reg clk,go,reset;
	wire [1:0] highway_sig1, highway_sig2, farm_sig1,farm_sig2,highway_sig1c,highway_sig2c,farm_sig1c,farm_sig2c;	
wire [4:0]delays;	
counter c1(clk,go,reset,delays);
traffic_light_controller tlc(clk,go,reset,delays,highway_sig1,highway_sig2,farm_sig1,farm_sig2);
test_system c(clk,go,reset,highway_sig1c,highway_sig2c,farm_sig1c,farm_sig2c);

initial
begin
	{clk,go,reset} = 3'b111;
	#1s go = 1'b1;reset = 1'b0;
	#1s go = 1'b0;
	#1s go = 1'b1;	
end
always@(posedge clk)
	begin
	if((highway_sig1 != highway_sig1c)|| (highway_sig2 != highway_sig2c) || (farm_sig1 != farm_sig1c) ||(farm_sig2 != farm_sig2c))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%0t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end	
		
		
end


always  #0.5s clk = ~clk;	
	initial #200s $stop;

endmodule  

//============================ end of two system comparing analyzer ==================///

module analyser_forsystemTime();
	reg clk,go,reset;
	wire [1:0] highway_sig1, highway_sig2, farm_sig1,farm_sig2;	
wire [4:0]delays;	
counter c1(clk,go,reset,delays);
traffic_light_controller tlc(clk,go,reset,delays,highway_sig1,highway_sig2,farm_sig1,farm_sig2);
initial
begin
	{clk,go,reset} = 3'b111;
	#1s go = 1'b1;reset = 1'b0;
	#1s go = 1'b0;
	#1s go = 1'b1;	
end
always@(posedge clk)
	begin
//case 0 
if(delays == 5'b00000)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%0t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end


//case 1 
if(delays == 5'b00001)
	begin
	if((highway_sig1 != 2'b11)|| (highway_sig2 != 2'b11) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end

//case 2 
if(delays == 5'b11110)
	begin
	if((highway_sig1 != 2'b00)|| (highway_sig2 != 2'b00) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 3
if(delays == 5'b00010)
	begin
	if((highway_sig1 != 2'b00)|| (highway_sig2 != 2'b01) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 4
if(delays == 5'b01010)
	begin
	if((highway_sig1 != 2'b00)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 5
if(delays == 5'b00010)
	begin
	if((highway_sig1 != 2'b01)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 6
if(delays == 5'b00001)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 7
if(delays == 5'b00010)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b11) ||(farm_sig2 != 2'b11))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 8
if(delays == 5'b01111)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b00) ||(farm_sig2 != 2'b00))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 9
if(delays == 5'b00010)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b00) ||(farm_sig2 != 2'b01))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 10
if(delays == 5'b00101)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b00) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 11
if(delays == 5'b00010)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b01) ||(farm_sig2 != 2'b11))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end	
//case 12
if(delays == 5'b01010)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b00))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end	
//case 13
if(delays == 5'b00010)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b01))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end	
//case 14
if(delays == 5'b00001)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b10) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 15
if(delays == 5'b00010)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b11) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 16
if(delays == 5'b01111)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b00) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end
//case 17
if(delays == 5'b00011)
	begin
	if((highway_sig1 != 2'b10)|| (highway_sig2 != 2'b01) || (farm_sig1 != 2'b10) ||(farm_sig2 != 2'b10))
	begin															  
		$display("error ");			   
		
	end
	else
		begin
		$monitor("time=%t   ligh1=%b ,ligh2=%b ligh1=%b ,ligh2=%b , ", $time ,highway_sig1,  highway_sig2,   farm_sig1, farm_sig2);
	end
end

end



always  #0.5s clk = ~clk;	
	initial #200s $stop;

endmodule 

//=============== End of time comparing analyzer =========================//
	