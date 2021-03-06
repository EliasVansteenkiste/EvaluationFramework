// Jagadeesh Vasudevamurthy sv_chip3_hierarchy_no_mem_X99.v
// Please do not remove the header
// Char array passed is as follows
//--------------------------------------
//0:0000000 1
//1:0000001 1
//2:0000010 1
//3:0000011 0
//4:0000100 1
//5:0000101 0
//6:0000110 0
//7:0000111 1
//8:0001000 0
//9:0001001 0
//10:0001010 1
//11:0001011 0
//12:0001100 1
//13:0001101 0
//14:0001110 0
//15:0001111 1
//16:0010000 0
//17:0010001 0
//18:0010010 1
//19:0010011 0
//20:0010101 0
//21:0010110 1
//22:0010111 0
//23:0011000 1
//24:0011001 0
//25:0011010 0
//26:0011011 1
//27:0011100 0
//28:0011101 0
//29:0011110 1
//30:0011111 0
//31:0100000 0
//32:0100001 1
//33:0100010 0
//34:0100011 0
//35:0100100 1
//36:0100101 0
//37:0100110 0
//38:0100111 1
//39:0101000 0
//40:0101001 0
//41:0101010 1
//42:0101011 0
//43:0101100 0
//44:0101101 1
//45:0101110 0
//46:0101111 0
//47:0110000 1
//48:0110001 0
//49:0110010 0
//50:0110011 1
//51:0110100 0
//52:0110101 0
//53:0110110 1
//54:0110111 0
//55:0111000 0
//56:0111001 1
//57:0111010 0
//58:0111011 0
//59:0111100 1
//60:0111101 0
//61:0111110 0
//62:0111111 1
//63:1000000 0
//64:1000001 0
//65:1000010 1
//66:1000011 0
//67:1000100 0
//68:1000101 1
//69:1000110 0
//70:1000111 0
//71:1001000 1
//72:1001001 0
//73:1001010 0
//74:1001011 1
//75:1001100 0
//76:1001101 0
//77:1001110 1
//78:1001111 0
//79:1010000 1
//80:1010001 1
// default 1
// Parallel mux
//--------------------------------------
// PLA starts now
module sv_chip3_hierarchy_no_mem_X99(a,o);
	input[6:0]  a;
	output reg[0:0]  o;
	always @(a)
	begin
		case(a)
			7'b0000000: o = 1'b1;
			7'b0000001: o = 1'b1;
			7'b0000010: o = 1'b1;
			7'b0000011: o = 1'b0;
			7'b0000100: o = 1'b1;
			7'b0000101: o = 1'b0;
			7'b0000110: o = 1'b0;
			7'b0000111: o = 1'b1;
			7'b0001000: o = 1'b0;
			7'b0001001: o = 1'b0;
			7'b0001010: o = 1'b1;
			7'b0001011: o = 1'b0;
			7'b0001100: o = 1'b1;
			7'b0001101: o = 1'b0;
			7'b0001110: o = 1'b0;
			7'b0001111: o = 1'b1;
			7'b0010000: o = 1'b0;
			7'b0010001: o = 1'b0;
			7'b0010010: o = 1'b1;
			7'b0010011: o = 1'b0;
			7'b0010101: o = 1'b0;
			7'b0010110: o = 1'b1;
			7'b0010111: o = 1'b0;
			7'b0011000: o = 1'b1;
			7'b0011001: o = 1'b0;
			7'b0011010: o = 1'b0;
			7'b0011011: o = 1'b1;
			7'b0011100: o = 1'b0;
			7'b0011101: o = 1'b0;
			7'b0011110: o = 1'b1;
			7'b0011111: o = 1'b0;
			7'b0100000: o = 1'b0;
			7'b0100001: o = 1'b1;
			7'b0100010: o = 1'b0;
			7'b0100011: o = 1'b0;
			7'b0100100: o = 1'b1;
			7'b0100101: o = 1'b0;
			7'b0100110: o = 1'b0;
			7'b0100111: o = 1'b1;
			7'b0101000: o = 1'b0;
			7'b0101001: o = 1'b0;
			7'b0101010: o = 1'b1;
			7'b0101011: o = 1'b0;
			7'b0101100: o = 1'b0;
			7'b0101101: o = 1'b1;
			7'b0101110: o = 1'b0;
			7'b0101111: o = 1'b0;
			7'b0110000: o = 1'b1;
			7'b0110001: o = 1'b0;
			7'b0110010: o = 1'b0;
			7'b0110011: o = 1'b1;
			7'b0110100: o = 1'b0;
			7'b0110101: o = 1'b0;
			7'b0110110: o = 1'b1;
			7'b0110111: o = 1'b0;
			7'b0111000: o = 1'b0;
			7'b0111001: o = 1'b1;
			7'b0111010: o = 1'b0;
			7'b0111011: o = 1'b0;
			7'b0111100: o = 1'b1;
			7'b0111101: o = 1'b0;
			7'b0111110: o = 1'b0;
			7'b0111111: o = 1'b1;
			7'b1000000: o = 1'b0;
			7'b1000001: o = 1'b0;
			7'b1000010: o = 1'b1;
			7'b1000011: o = 1'b0;
			7'b1000100: o = 1'b0;
			7'b1000101: o = 1'b1;
			7'b1000110: o = 1'b0;
			7'b1000111: o = 1'b0;
			7'b1001000: o = 1'b1;
			7'b1001001: o = 1'b0;
			7'b1001010: o = 1'b0;
			7'b1001011: o = 1'b1;
			7'b1001100: o = 1'b0;
			7'b1001101: o = 1'b0;
			7'b1001110: o = 1'b1;
			7'b1001111: o = 1'b0;
			7'b1010000: o = 1'b1;
			7'b1010001: o = 1'b1;
//			 default 1
//			 Parallel mux
			default:  o = 1'b1;
		endcase
	end
endmodule
