module sevenSeg(CLK, Seven0, Seven1, Seven2, Seven3, SevOut, Dig);
	input CLK;
	input [6:0] Seven0, Seven1, Seven2, Seven3;
	output reg [6:0] SevOut;
	output reg [3:0] Dig;
	reg [1:0] State, NextState;

	initial begin
		State <= 0;
	end

	always @* begin
		case (State)
			0: begin
				SevOut <= Seven0;
				Dig <= 4'b1110;
				NextState <= 1;
			end
			1: begin
				SevOut <= Seven1;
				Dig <= 4'b1101;
				NextState <= 2;
			end
			2: begin
				SevOut <= Seven2;
				Dig <= 4'b1011;
				NextState <= 3;
			end
			3: begin
				SevOut <= Seven3;
				Dig <= 4'b0111;
				NextState <= 0;
			end
		endcase
	end

	always @(posedge CLK) begin
		State <= NextState;
	end
endmodule

module fourBCDSeven(D, Seven0, Seven1, Seven2, Seven3);
    input [15:0] D;
    output [7:1] Seven0, Seven1, Seven2, Seven3;
    wire [3:0] Dig0, Dig1, Dig2, Dig3;

    assign Dig0 = D[3:0];
    assign Dig1 = D[7:4];
    assign Dig2 = D[11:8];
    assign Dig3 = D[15:12];

    bcd_seven bcd0(Dig0, Seven0);
    bcd_seven bcd1(Dig1, Seven1);
    bcd_seven bcd2(Dig2, Seven2);
    bcd_seven bcd3(Dig3, Seven3);
endmodule

module bcd_seven(bcd, seven);
    input [3:0] bcd;
    output reg [7:1] seven;

    always @(bcd) begin
        case (bcd)
            4'b0000 : seven = 7'b1000000;
            4'b0001 : seven = 7'b1111001;
            4'b0010 : seven = 7'b0100100;
            4'b0011 : seven = 7'b0110000;
            4'b0100 : seven = 7'b0011001;
            4'b0101 : seven = 7'b0010010;
            4'b0110 : seven = 7'b0000010;
            4'b0111 : seven = 7'b1111000;
            4'b1000 : seven = 7'b0000000;
            4'b1001 : seven = 7'b0010000;
            default : seven = 7'b1111111;
        endcase
    end
endmodule
