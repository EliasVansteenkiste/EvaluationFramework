`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2014 05:48:18 PM
// Design Name: 
// Module Name: lpm_add_sub
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lpm_add_sub(
    aclr,
    add_sub,
    cin,
    clken,
    clock,
    dataa,
    datab,
    cout,
    overflow,
    result
    );
    
    parameter lpm_width = 48;
    parameter lpm_direction = "DEFAULT";
    parameter lpm_representation = "SIGNED";
    parameter lpm_pipeline = 1;
    parameter lpm_hint = "UNUSED";
    parameter lpm_type = "UNUSED";
    parameter one_input_is_constant = 0;
    parameter maximize_speed = 0;
    parameter intended_device_family = "UNUSED";
    

    input aclr;
    input add_sub;
    input cin;
    input clken;
    input clock;
    input [lpm_width-1:0] dataa;
    input [lpm_width-1:0] datab;
    
    output [lpm_width-1:0] result;
    output cout;
    output overflow;
    
    reg [lpm_width:0] result_reg;

// 2DO implement signed operation
//    //for signed operation
//    reg [lpm_width:0] add_boundary = 0;
//    add_boundary[lpm_width] = 1;
//    add_boundary[0] = 1;
    
    assign overflow = result_reg[lpm_width];
    assign cout = result_reg[lpm_width];
    assign result = result_reg[lpm_width-1:0];
    
    //only for the unsigned case
    
    
    always @ (aclr) 
        result_reg = 0;
        
    generate
            if (lpm_pipeline == 0) 
            begin
                if (lpm_direction == "SUB") 
                begin 
                    always @ (dataa or datab or cin) 
                        result_reg = dataa - datab + cin;
                end
                else
                if (lpm_direction == "ADD") 
                begin
                    always @ (dataa or datab or cin)
                        result_reg = dataa + datab + cin;
                end
                else
                begin
                    always @ (dataa or datab or cin or add_sub)
                    begin
                        if(add_sub)
                            result_reg = dataa + datab + cin;
                        else
                            result_reg = dataa - datab + cin; 
                    end  
                end
            end
            else
            begin 
                if (lpm_direction == "SUB") 
                begin 
                    always @ (posedge clock) 
                    begin
                        if(aclr)
                            result_reg = 0;
                        else
                        begin
                            if(clken)
                                result_reg <= dataa - datab + cin;
                        end
                    end  
                end
                else
                if (lpm_direction == "ADD") 
                begin
                    always @ (posedge clock) 
                    begin
                        if(aclr)
                            result_reg = 0;
                        else
                        begin
                            if(clken)
                                result_reg <= dataa + datab + cin;
                        end
                    end  
                end
                else
                begin
                    always @ (posedge clock) 
                    begin
                        if(aclr)
                            result_reg = 0;
                        else
                        begin
                            if(clken)
                            begin
                                if(add_sub)
                                    result_reg <= dataa + datab + cin;
                                else
                                    result_reg <= dataa - datab + cin; 
                            end
                        end
                    end  
                end
            end
    endgenerate
    
endmodule

module lpm_add_sub_bmspec #(
    
parameter lpm_width = 48,
parameter lpm_direction = "DEFAULT",
parameter lpm_representation = "SIGNED",
parameter lpm_pipeline = 0,
parameter lpm_hint = "UNUSED",
parameter lpm_type = "UNUSED",
parameter one_input_is_constant = 0,
parameter maximize_speed = 0,
parameter intended_device_family = "UNUSED"

) (
    add_sub,
    cin,
    dataa,
    datab,
    result
    );

    

    input add_sub;
    input cin;
    input [lpm_width-1:0] dataa;
    input [lpm_width-1:0] datab;
    output reg [lpm_width-1:0] result;
       
    //assign cout = result_reg[lpm_width];
    
    always @ *
        begin
            if(add_sub)
                result <= dataa + datab + cin;
            else
                result <= dataa - datab - cin; 
        end
    
endmodule


module lpm_mux #(
parameter lpm_pipeline = 0,
parameter lpm_size = 16,
parameter lpm_width = 32,
parameter lpm_widths = clog2(lpm_size),
parameter lpm_type = "unused"
)(
    aclr,
    clken,
    clock,
    data,
    sel,
    result
    );
    
    function integer clog2;
        input integer value;
        begin
            value = value-1;
            for (clog2=0; value>0; clog2=clog2+1)
            value = value>>1;
        end
    endfunction
     

    input aclr;
    input clken;
    input clock;
    input [lpm_size-1:0][lpm_width-1:0] data;
    input [lpm_widths-1:0] sel;
    
    output [lpm_width-1:0] result;
    
    reg [lpm_width-1:0] result_reg;
    
    assign result = result_reg;
    
    always @ (aclr) 
        result_reg = 0;
        
    generate
        if (lpm_pipeline == 0) 
        begin
            always @ (data or sel)
                result_reg = data[sel];
        end
        else
        begin 
            always @ (posedge clock)
            begin
                if(aclr)
                    result_reg <= 0;
                else
                begin
                    if(clken)
                        result_reg <= data[sel];
                end
            end
        end
    endgenerate
    
endmodule

module lpm_compare #(
parameter chain_size = 8, //not yet implemented
parameter lpm_pipeline = 0,
parameter lpm_representation = "unsigned", //
parameter lpm_width = 8,
parameter one_input_is_constant = "NO",
parameter lpm_type = "UNUSED"
)(
    aclr,
    clken,
    clock,
    dataa,
    datab,
    alb,
    aeb,
    agb,
    ageb,
    aneb,
    aleb
    );
     

    input aclr;
    input clken;
    input clock;
    input [lpm_width-1:0] dataa;
    input [lpm_width-1:0] datab;
    
    output alb;
    output aeb;
    output agb;
    output ageb;
    output aneb;
    output aleb;
    
    reg ralb;
    reg raeb;
    reg ragb;
    reg rageb;
    reg raneb;
    reg raleb;
    
    assign alb = ralb;
    assign aeb = raeb;
    assign agb = ragb;
    assign ageb = rageb;
    assign aneb = raneb;
    assign aleb = raleb;
    
    always @ (aclr) 
    begin
        ralb <= 0;
        raeb <= 0;
        ragb <= 0;
        rageb <= 0;
        raneb <= 0;
        raleb <= 0;
    end
        
    generate
        if (lpm_pipeline == 0) 
        begin
            always @ (dataa or datab)
            begin
                ralb = (dataa < datab);
                raeb = (dataa == datab);
                ragb = (dataa > datab);
                rageb = (dataa >= datab);
                raneb = (dataa != datab);
                raleb = (dataa <= datab);
            end
        end
        else
        begin 
            always @ (posedge clock)
            begin
                if(aclr)
                begin
                    ralb <= 0;
                    raeb <= 0;
                    ragb <= 0;
                    rageb <= 0;
                    raneb <= 0;
                    raleb <= 0;
                end
                else
                begin
                    if(clken)
                    begin
                        ralb <= (dataa < datab);
                        raeb <= (dataa == datab);
                        ragb <= (dataa > datab);
                        rageb <= (dataa >= datab);
                        raneb <= (dataa != datab);
                        raleb <= (dataa <= datab);
                    end
                end
            end
        end
    endgenerate
    
endmodule

module lpm_mult #(
parameter lpm_widtha = 1,
parameter lpm_widthb = 1,
parameter lpm_widths = 1,
parameter lpm_widthp = 1,
parameter lpm_representation = "UNSIGNED", //only unsigned is implemented
parameter lpm_pipeline = 0,
parameter input_b_fixed_value = "NO"
) ( 
    sum,
    result, 
    dataa, 
    datab, 
    clock, 
    clken, 
    aclr );
    
//parameter lpm_type = "lpm_mult";
//parameter lpm_widtha = 1;
//parameter lpm_widthb = 1;
//parameter lpm_widths = 1;
//parameter lpm_widthp = 1;
//parameter lpm_representation = "UNSIGNED"; //only unsigned is implemented
//parameter lpm_pipeline = 0;
//parameter input_b_fixed_value = "NO";

input clock;
input clken;
input aclr;
input [lpm_widtha-1:0] dataa;
input [lpm_widthb-1:0] datab;
input [lpm_widthb-1:0] sum;

output reg [lpm_widthp-1:0] result;
        
generate
    if (lpm_pipeline == 0) 
    begin
        always @ (dataa or datab)
            result = dataa * datab;
    end
    else
    begin 
        always @ (posedge clock)
        begin
            if(clken)
                result <= dataa * datab + sum;
        end
    end
endgenerate


endmodule


//module lpm_mult ( result, dataa, datab, sum, clock, clken, aclr ) ;

//  parameter lpm_type       = "lpm_mult" ;
//  parameter lpm_widtha     = 8 ;
//  parameter lpm_widthb     = 8 ;
//  parameter lpm_widths     = 8 ;
//  parameter lpm_widthp     = 16 ;
//  parameter lpm_representation  = "UNSIGNED" ;
//  parameter lpm_pipeline   = 0 ;
//  parameter lpm_hint = "UNUSED" ;

//  input  clock ;
//  input  clken ;
//  input  aclr ;
//  input  [lpm_widtha-1:0] dataa ;
//  input  [lpm_widthb-1:0] datab ;
//  input  [lpm_widths-1:0] sum ;
//  output [lpm_widthp-1:0] result;

//  // inernal reg
//  reg   [lpm_widthp-1:0] tmp_result ;
//  reg   [lpm_widthp-1:0] tmp_result2 [lpm_pipeline-3:0];
//  reg   [lpm_widtha-1:0] a_int ;
//  reg   [lpm_widthb-1:0] b_int ;
//  reg   [lpm_widths-1:0] s_int ;
//  reg   [lpm_widthp-1:0] p_reg ;
//  integer p_int;
//  integer i, j, k, m, n, p, maxs_mn ;
//  integer int_dataa, int_datab, int_sum, int_result ;


//  always @( dataa or datab or sum)
//      begin
//              if (lpm_representation == "UNSIGNED")
//                      begin
//                              int_dataa = dataa ;
//                              int_datab = datab ;
//                              int_sum = sum ;
//                      end
//              else 
//                      if (lpm_representation == "SIGNED")
//                              begin
//                                      // convert signed dataa
//                                      if(dataa[lpm_widtha-1] == 1)
//                                              begin
//                                                      int_dataa = 0 ;
//                                                      for(i = 0; i < lpm_widtha - 1; i = i + 1)
//                                                              a_int[i] = dataa[i] ^ 1;
//                                                      int_dataa = (a_int + 1) * (-1) ;
//                                              end
//                                      else int_dataa = dataa ;

//                                      // convert signed datab
//                                      if(datab[lpm_widthb-1] == 1)
//                                              begin
//                                                      int_datab = 0 ;
//                                                      for(j = 0; j < lpm_widthb - 1; j = j + 1)
//                                                              b_int[j] = datab[j] ^ 1;
//                                                      int_datab = (b_int + 1) * (-1) ;
//                                              end
//                                      else int_datab = datab ;

//                                      // convert signed sum
//                                      if(sum[lpm_widths-1] == 1)
//                                              begin
//                                                      int_sum = 0 ;
//                                                      for(k = 0; k < lpm_widths - 1; k = k + 1)
//                                                              s_int[k] = sum[k] ^ 1;
//                                                      int_sum = (s_int + 1) * (-1) ;
//                                              end
//                                      else int_sum = sum ;
//                              end
//                      else 
//                              begin
//                                      int_dataa = {lpm_widtha{1'bx}} ;
//                                      int_datab = {lpm_widthb{1'bx}} ;
//                                      int_sum   = {lpm_widths{1'bx}} ;
//                              end

//              p_int = int_dataa * int_datab + int_sum ;
//              maxs_mn = ((lpm_widtha+lpm_widthb)>lpm_widths)?lpm_widtha+lpm_widthb:lpm_widths ;
//              if(lpm_widthp >= maxs_mn)
//                      tmp_result = p_int ;
//              else
//                      begin
//                              p_reg = p_int;
//                              for(m = 0; m < lpm_widthp; m = m +1)
//                                      tmp_result[lpm_widthp-1-m] = p_reg[maxs_mn-1-m] ;
//                      end 
//      end

//      always @(posedge clock or posedge aclr)
//      begin
//        if(aclr)
//              begin
//                      for(p = 0; p <= lpm_pipeline; p = p + 1)
//                              tmp_result2[p] = 'b0;
//              end
//        else if (clken == 1)
//        begin :syn_block
//              tmp_result2[lpm_pipeline] = tmp_result ;
//              for(n = 0; n < lpm_pipeline; n = n +1)
//              tmp_result2[n] = tmp_result2[n+1] ;
//        end
//      end

//  assign result = (lpm_pipeline > 0) ? tmp_result2[0] : tmp_result ;

//endmodule // lpm_mult



//module altsyncram (
//    wren_a,
//    rden_a,
//    wren_b,
//    rden_b,
//    data_a,
//    data_b,
//    address_a,
//    address_b,
//    clock0,
//    clock1,
//    clocken0,
//    clocken1,
//    clocken2,
//    clocken3,
//    aclr0,
//    aclr1,
//    byteena_a,
//    byteena_b,
//    addressstall_a,
//    addressstall_b,
//    q_a,
//    q_b,
//    eccstatus
//    );
      
    
//    parameter address_aclr_a = "NOT_IMPLEMENTED";
//    parameter address_aclr_b = "NONE";
//    parameter address_reg_b = "CLOCK0";
//    parameter byte_size = 8;
//    parameter byteena_aclr_a = "NOT_IMPLEMENTED";
//    parameter byteena_aclr_b = "NOT_IMPLEMENTED";
//    parameter byteena_reg_b = "NOT_IMPLEMENTED";
//    parameter clock_enable_core_a = "NOT_IMPLEMENTED";
//    parameter clock_enable_core_b = "NOT_IMPLEMENTED";
//    parameter clock_enable_input_a = "BYPASS";
//    parameter clock_enable_input_b = "BYPASS";
//    parameter clock_enable_output_a = "NORMAL";
//    parameter clock_enable_output_b = "BYPASS";
//    parameter enable_ecc = "NOT_IMPLEMENTED";
//    parameter implement_in_les = "NOT_IMPLEMENTED";
//    parameter indata_aclr_a = "NOT_IMPLEMENTED";
//    parameter indata_aclr_b = "NOT_IMPLEMENTED";
//    parameter indata_reg_b = "NOT_IMPLEMENTED";
//    parameter init_file = "NOT_IMPLEMENTED";
//    parameter init_file_layout = "NOT_IMPLEMENTED";
//    parameter intended_device_family = "UNUSED";
//    parameter lpm_type = "altsyncram";
//    parameter maximum_depth = "NOT_IMPLEMENTED";
//    parameter outdata_aclr_a = "NONE";
//    parameter outdata_aclr_b = "NOT_IMPLEMENTED";
//    parameter outdata_reg_a = "NOT_IMPLEMENTED";
//    parameter outdata_reg_b = "NOT_IMPLEMENTED";
//    parameter operation_mode = "DUAL_PORT";
//    parameter power_up_uninitialized  = "NOT_IMPLEMENTED";
//    parameter ram_block_type = "NOT_IMPLEMENTED";
//    parameter rdcontrol_aclr_b = "NOT_IMPLEMENTED";
//    parameter rdcontrol_reg_b = "NOT_IMPLEMENTED";
//    parameter read_during_write_mode_mixed_ports = "NOT_IMPLEMENTED";
//    parameter read_during_write_mode_port_a = "NOT_IMPLEMENTED";
//    parameter read_during_write_mode_port_b = "NOT_IMPLEMENTED";
//    parameter width_a = 1;
//    parameter width_b = 1;
//    parameter width_byteena_a = 1;//WIDTH_B / BYTE_SIZE.
//    parameter width_byteena_b = 1;//WIDTH_B / BYTE_SIZE.
//    parameter widthad_a = 1;
//    parameter widthad_b = 1;    
//    parameter wrcontrol_aclr_a = "NOT_IMPLEMENTED";
//    parameter wrcontrol_aclr_b = "NOT_IMPLEMENTED";
//    parameter wrcontrol_wraddress_reg_b = "NOT_IMPLEMENTED";
    
    
//    function integer pow2;
//    input integer exp;
//        begin
//            pow2 = 2 ** exp;
//        end
//    endfunction
    
////    function integer log2;
////      input integer value;
////      begin
////        value = value-1;
////        for (log2=0; value>0; log2=log2+1)
////          value = value>>1;
////      end
////    endfunction
    
//    function integer log2;
//    input integer value;
//    reg [31:0] shifted;
//    integer res;
//    begin
//        if (value < 2)
//            log2 = value;
//        else
//        begin
//            shifted = value-1;
//            for (res=0; shifted>0; res=res+1)
//                shifted = shifted>>1;
//            log2 = res;
//        end
//    end
//    endfunction

    
////    parameter numwords_a = pow2(widthad_a);
////    parameter numwords_b = pow2(widthad_b);

//    `define max(a,b) {(a) > (b) ? (a) : (b)}
//    `define min(a,b) {(a) < (b) ? (a) : (b)}

//    parameter numwords_a = pow2(widthad_a);
//    parameter numwords_b = pow2(widthad_b);
//    parameter ramdepth_a = 1 << widthad_a;
//    parameter ramdepth_b = 1 << widthad_b;
        
//    input wren_a;
//    input rden_a;
//    input wren_b;
//    input rden_b;
//    input [width_a-1:0] data_a;
//    input [width_b-1:0] data_b;
//    input [widthad_a-1:0] address_a;
//    input [widthad_b-1:0] address_b;
//    input clock0;
//    input clock1;
//    input clocken0;
//    input clocken1;
//    input clocken2;
//    input clocken3;
//    input aclr0;
//    input aclr1;
//    input [width_byteena_a-1:0] byteena_a;
//    input [width_byteena_b-1:0] byteena_b;
//    input addressstall_a;
//    input addressstall_b;
    
//    output reg [width_b-1:0] q_a;
//    output reg [width_b-1:0] q_b;
//    output eccstatus;
    
//    localparam maxSIZE = `max(ramdepth_a,ramdepth_b);
//    localparam maxWIDTH = `max(width_a,width_b);
//    localparam minWIDTH = `min(width_a,width_b);
//    localparam RATIO = maxWIDTH / minWIDTH;
//    localparam log2RATIO = log2(RATIO);
    
//    reg [width_a-1:0] q_a_r;
//    reg [width_b-1:0] q_b_r;

        
//    assign eccstatus = 1'b0; //not implemented yet
//    assign q_a_r = 1; //not implemented yet
    
    
//    //reg [width_a-1:0] mem [ramdepth_a-1:0];
//    reg [minWIDTH-1:0] mem [0:maxSIZE];
    
//    //currently only write for a is implemented
//    always @ (posedge clock0)
//    begin
//        if (wren_a)
//            mem[address_a] <= data_a;
//    end
    
//    always @ (posedge clock1)
//    begin
//        if (wren_b)
//            mem[address_b] <= data_b;
//    end
    
    
    
//    //currently only read for b is implemented
//    always @ (posedge clock1)
//    begin
//        q_b <= q_b_r;
//    end
    
//    genvar i;
//    generate for (i = 0; i<RATIO; i=i+1)
//        begin: memread
//            localparam [log2RATIO-1:0] lsbaddr = i;
//            always @ (posedge clock1)
//            begin
//                q_b_r[(i+1)*minWIDTH-1:i*minWIDTH] <= mem[{address_b, lsbaddr}];
//            end
//         end
//    endgenerate

    
//endmodule

module altsyncram_uniwidth #(
parameter byte_size = 8,
parameter clock_enable_input_a = "BYPASS",
parameter clock_enable_input_b = "BYPASS",
parameter clock_enable_output_a = "NORMAL",
parameter clock_enable_output_b = "BYPASS",
parameter width = 32,
parameter width_byteena = 4,//WIDTH_B / BYTE_SIZE.
parameter numwords = 256,   
parameter widthad = 8
) 
(
    wren_a,
    rden_a,
    wren_b,
    rden_b,
    data_a,
    data_b,
    address_a,
    address_b,
    clock0,
    clock1,
    clocken0,
    clocken1,
    clocken2,
    clocken3,
    aclr0,
    aclr1,
    byteena_a,
    byteena_b,
    addressstall_a,
    addressstall_b,
    q_a,
    q_b,
    eccstatus
    );
      
    
//    parameter address_aclr_a = "NOT_IMPLEMENTED";
//    parameter address_aclr_b = "NONE";
//    parameter address_reg_b = "CLOCK0";
//    parameter byte_size = 8;
//    parameter byteena_aclr_a = "NOT_IMPLEMENTED";
//    parameter byteena_aclr_b = "NOT_IMPLEMENTED";
//    parameter byteena_reg_b = "NOT_IMPLEMENTED";
//    parameter clock_enable_core_a = "NOT_IMPLEMENTED";
//    parameter clock_enable_core_b = "NOT_IMPLEMENTED";
//    parameter clock_enable_input_a = "BYPASS";
//    parameter clock_enable_input_b = "BYPASS";
//    parameter clock_enable_output_a = "NORMAL";
//    parameter clock_enable_output_b = "BYPASS";
//    parameter enable_ecc = "NOT_IMPLEMENTED";
//    parameter implement_in_les = "NOT_IMPLEMENTED";
//    parameter indata_aclr_a = "NOT_IMPLEMENTED";
//    parameter indata_aclr_b = "NOT_IMPLEMENTED";
//    parameter indata_reg_b = "NOT_IMPLEMENTED";
//    parameter init_file = "NOT_IMPLEMENTED";
//    parameter init_file_layout = "NOT_IMPLEMENTED";
//    parameter intended_device_family = "UNUSED";
//    parameter lpm_type = "altsyncram";
//    parameter maximum_depth = "NOT_IMPLEMENTED";
//    parameter outdata_aclr_a = "NONE";
//    parameter outdata_aclr_b = "NOT_IMPLEMENTED";
//    parameter outdata_reg_a = "NOT_IMPLEMENTED";
//    parameter outdata_reg_b = "NOT_IMPLEMENTED";
//    parameter operation_mode = "DUAL_PORT";
//    parameter power_up_uninitialized  = "NOT_IMPLEMENTED";
//    parameter ram_block_type = "NOT_IMPLEMENTED";
//    parameter rdcontrol_aclr_b = "NOT_IMPLEMENTED";
//    parameter rdcontrol_reg_b = "NOT_IMPLEMENTED";
//    parameter read_during_write_mode_mixed_ports = "NOT_IMPLEMENTED";
//    parameter read_during_write_mode_port_a = "NOT_IMPLEMENTED";
//    parameter read_during_write_mode_port_b = "NOT_IMPLEMENTED";
//    parameter width = 32;
//    parameter width_byteena = 4;//WIDTH_B / BYTE_SIZE.
//    parameter widthad = 8;   
//    parameter wrcontrol_aclr_a = "NOT_IMPLEMENTED";
//    parameter wrcontrol_aclr_b = "NOT_IMPLEMENTED";
//    parameter wrcontrol_wraddress_reg_b = "NOT_IMPLEMENTED";
    
    
    function integer pow2;
    input integer exp;
        begin
            pow2 = 2 ** exp;
        end
    endfunction
    
//    function integer log2;
//      input integer value;
//      begin
//        value = value-1;
//        for (log2=0; value>0; log2=log2+1)
//          value = value>>1;
//      end
//    endfunction
    
    function integer log2;
    input integer value;
    reg [31:0] shifted;
    integer res;
    begin
        if (value < 2)
            log2 = value;
        else
        begin
            shifted = value-1;
            for (res=0; shifted>0; res=res+1)
                shifted = shifted>>1;
            log2 = res;
        end
    end
    endfunction

    //localparameter numwords = pow2(widthad);
    //localparameter ramdepth = 2 ** widthad;
        
    input wren_a;
    input rden_a;
    input wren_b;
    input rden_b;
    input [width-1:0] data_a;
    input [width-1:0] data_b;
    input [widthad-1:0] address_a;
    input [widthad-1:0] address_b;
    input clock0;
    input clock1;
    input clocken0;
    input clocken1;
    input clocken2;
    input clocken3;
    input aclr0;
    input aclr1;
    input [width_byteena-1:0] byteena_a;
    input [width_byteena-1:0] byteena_b;
    input addressstall_a;
    input addressstall_b;
    
    output reg [width-1:0] q_a;
    output reg [width-1:0] q_b;
    output eccstatus;
           
    assign eccstatus = 1'b0; //not implemented yet
    
    reg [width-1:0] temp_a;   
    reg [width-1:0] temp_b;
    reg [width-1:0] mem [numwords-1:0];
    
    always @ (posedge clock0)
    begin
         if (rden_a)
            q_a <= mem[address_a];
    end
    
    always @ (posedge clock1)
    begin
         if (rden_b)
            q_b <= mem[address_b];
    end
 
    localparam bytesizea = width / (width_byteena);          
    genvar i;
    generate
        for(i=0; i < width_byteena; i=i+1)
        begin
        always @ (byteena_a or data_a)
            if (byteena_a[i])
                temp_a[bytesizea*(i+1)-1:bytesizea*i] = data_a[bytesizea*(i+1)-1:bytesizea*i];
        end
    endgenerate
    
    localparam bytesizeb = width / (width_byteena);
    genvar j;
    generate
        for(j=0; j < width_byteena; j=j+1)
        begin
        always @ (byteena_b or data_b)
            if (byteena_b[j])
                temp_b[bytesizeb*(j+1)-1:bytesizeb*j] = data_b[bytesizeb*(j+1)-1:bytesizeb*j];
        end
    endgenerate
    
    always @ (posedge clock0)
    begin
        if (wren_a)
            mem[address_a] <= temp_a;
    end
    
    always @ (posedge clock1)
    begin
        if (wren_b)
            mem[address_b] <= temp_b;
    end
   
endmodule







module dcfifo_mixed_widths #(
    parameter lpm_numwords = 16,
    parameter lpm_showahead = "OFF",
    parameter lpm_width = 128,
    parameter lpm_widthu = 4,
    parameter lpm_widthu_r = 6,
    parameter lpm_width_r = 32,
    parameter overflow_checking = "OFF",
    parameter rdsync_delaypipe = 5, //not implemented
    parameter underflow_checking = "OFF",
    parameter use_eab = "ON",//not implemented
    parameter wrsync_delaypipe = 5//not implemented
) (
            wrclk,
            rdreq,
            rdclk,
            wrreq,
            data,
            rdempty,
            q,
            wrusedw,
            wrempty
);

function integer log2;
  input integer value;
  begin
    value = value-1;
    for (log2=0; value>0; log2=log2+1)
      value = value>>1;
  end
endfunction

function integer spec_log2;
input integer value;
reg [31:0] shifted;
integer res;
begin
    if (value < 2)
        spec_log2 = value;
    else
    begin
        shifted = value-1;
        for (res=0; shifted>0; res=res+1)
            shifted = shifted>>1;
        spec_log2 = res;
    end
end
endfunction


localparam width_w = lpm_width;
localparam width_r = lpm_width_r;
localparam depth_w = lpm_numwords;
localparam depth_r = lpm_numwords * lpm_width / lpm_width_r;

localparam depth_w_u = log2(depth_w);
localparam depth_r_u = log2(depth_r);


input   [width_w-1:0]  data;
input     rdclk;
input     rdreq;
input     wrclk;
input     wrreq;
output reg [width_r-1:0]  q;
output reg rdempty = 1;
output reg [lpm_widthu-1:0]  wrusedw;
output reg wrempty;

assign wrusedw = 0;//not implemented yet
assign wrempty = 0;//not implemented yet

reg [width_r-1:0]  q_r;


if(width_w > width_r)
    begin
    reg [width_r-1:0] mem [depth_r-1:0];
    reg [depth_r-1:0] write_pointer = 0;
    reg [depth_r_u:0] counter = 0;
    reg [depth_r-1:0] read_pointer = 0;
    
    localparam wr_ratio = width_w/ width_r;
            
    //write operation
    always @ (posedge wrclk)
        begin: write_op1
         if (wrreq & (counter<=(depth_r-wr_ratio)))
            begin
            for(integer j = 0; j<wr_ratio; j=j+1)
                begin 
                mem[write_pointer+j] <= data[j*width_r +: width_r];
                end
            counter <= counter + wr_ratio;
            write_pointer <= write_pointer+wr_ratio;
            end
        end
    
    
    //read operation
    always @ (posedge rdclk)
    begin
        q <= q_r;
    end
    
    always @ (posedge rdclk)
        begin: read_op1
        if (rdreq & (counter > 0))
            begin
            q_r <= mem[read_pointer];
            read_pointer <= read_pointer + 1;
            counter <= counter + 1;
            end
        else
            rdempty <= 0;    
        end
    
    end
else
    begin
    reg [width_w-1:0] mem [depth_w-1:0];
    reg [depth_w-1:0] write_pointer = 0;
    reg [depth_w_u:0] counter = 0;
    reg [depth_w-1:0] read_pointer = 0;
    
    localparam rw_ratio = width_r / width_w;
                                  
    //write operation
    always @ (posedge wrclk)
        begin: write_op2
        if (wrreq & (counter<depth_w))
            begin
            mem[write_pointer] <= data;
            counter = counter + 1;
            write_pointer = write_pointer + 1;
            end
        end
        
    //read operation
    always @ (posedge rdclk)
    begin
        q <= q_r;
    end
    
    always @ (posedge rdclk)
        begin: read_op2
        if (rdreq & (counter >= rw_ratio))
            begin: read_op2
            for (integer j = 0; j<rw_ratio; j=j+1)
                q_r[j*width_w +: width_w] <= mem[read_pointer+j];
            counter <= counter - rw_ratio;
            read_pointer <= read_pointer+rw_ratio;
            end
        else
            rdempty <= 0;  
        end
   end
endmodule

module scfifo #(
parameter add_ram_output_register = "ON",
parameter lpm_numwords = 16,
parameter lpm_showahead = "OFF",
parameter lpm_width = 128,
parameter lpm_widthu = 4,
parameter overflow_checking = "OFF",
parameter underflow_checking = "OFF",
parameter use_eab = "ON"
) (
            aclr,
            data,
            clock,
            rdreq,
            sclr,
            wrreq,
            q,
            full,
            empty,
            almost_empty,
            almost_full,
            useddw
);

function integer log2;
  input integer value;
  begin
    value = value-1;
    for (log2=0; value>0; log2=log2+1)
      value = value>>1;
  end
endfunction

function integer spec_log2;
input integer value;
reg [31:0] shifted;
integer res;
begin
    if (value < 2)
        spec_log2 = value;
    else
    begin
        shifted = value-1;
        for (res=0; shifted>0; res=res+1)
            shifted = shifted>>1;
        spec_log2 = res;
    end
end
endfunction


localparam width = lpm_width;
localparam depth = lpm_numwords;

localparam depth_u = log2(depth);

input aclr;
input [width-1:0]  data;
input clock;
input rdreq;
input sclr;
input wrreq;
output reg [width-1:0]  q;
output reg full = 0;
output reg empty = 1;
output reg almost_full = 0;//not implemented yet
output reg almost_empty = 1;//not implemented yet
output reg [depth-1:0]  useddw  = 0;

reg [width-1:0] q_r;
reg [width-1:0] mem [depth-1:0];
reg [depth-1:0] write_pointer = 0;
reg [depth-1:0] counter = 0;
reg [depth-1:0] read_pointer = 0;
        
//write operation
always @ (posedge clock)
    begin 
    if (wrreq & (counter < depth))
        begin
        mem[write_pointer] <= data;
        write_pointer <= write_pointer+1;
        if(counter == (depth-1)) full <= 1;
        counter <= counter + 1;
        useddw <= counter + 1;
        end
    if (rdreq & (counter > 0))
        begin
        q <= mem[read_pointer];
        read_pointer <= read_pointer + 1;
        if(counter == 1) empty <= 0;
        counter <= counter - 1;
        useddw <= counter + 1;
        end
    end
endmodule


module lpm_counter #(
parameter lpm_width = 1,
parameter lpm_modulus = 0,
parameter lpm_direction = "UP",
parameter lpm_avalue = {lpm_width {1'b1}} ,
parameter lpm_svalue = "UNUSED",
parameter lpm_pvalue = "UNUSED",
parameter lpm_port_updown = "PORT_CONNECTIVITY"
) ( 
    q, 
    data, 
    clock, 
    cin, 
    cout, 
    clk_en, 
    cnt_en, 
    updown,
    aset, 
    aclr, 
    aload, 
    sset, 
    sclr, 
    sload, 
    eq 
    );


input cin;
input [lpm_width-1:0] data;
input clock;
input clk_en; 
input cnt_en; 
input updown;
input aset;
input aclr;
input aload;
input sset;
input sclr;
input sload;

output reg [lpm_width-1:0] q;
output reg [15:0] eq;
output reg cout;

reg [lpm_width-1:0] counter;

//do not uncomment, this makes everything optimized away
//always @ *
//    begin
//    if(aclr)
//        counter <= 0;
//    else if (aset)
//        counter <= lpm_avalue;
//    else if (aload)
//        counter <= data;
//    end

always @ (posedge clock)
    begin
    if(clk_en)
        begin
        if(sclr)
            begin
            counter <= 0;
            q <= 0;
            eq <= 0;
            end
        else if (sset)
            begin
            counter <= lpm_avalue;
            q <= lpm_avalue;
            eq <= 0;
            if(counter<16)
                eq[counter] <= 1; 
            end
        else if (sload)
            begin
            counter <= data;
            q <= data;
            eq <= 0;
            if(data<16)
                eq[data] <= 1; 
            end
        else if (cnt_en)
            begin
            if(updown)
                begin
                if(counter == ~0)
                    cout <= 1;
                counter <= counter + 1;
                q <= counter + 1;
                eq <= 0;
                if(counter<15)
                    eq[counter + 1] <= 1; 
                end
            else
                begin
                if(counter == 0)
                    cout <= 0;
                counter <= counter - 1;
                q <= counter - 1;
                eq <= 0;
                if(counter<17)
                    eq[counter - 1] <= 1; 
                end
            end
        end
    end        
endmodule