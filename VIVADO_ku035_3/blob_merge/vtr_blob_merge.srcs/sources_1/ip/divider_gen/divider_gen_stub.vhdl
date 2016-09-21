-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.3 (lin64) Build 1034051 Fri Oct  3 16:32:59 MDT 2014
-- Date        : Wed Jul  1 15:10:11 2015
-- Host        : paasei running 64-bit Scientific Linux release 6.5 (Carbon)
-- Command     : write_vhdl -force -mode synth_stub
--               /afs/elis.ugent.be/group/hes/projects/vivado_experiments/VIVADO_ku035_3/blob_merge/vtr_blob_merge.srcs/sources_1/ip/divider_gen/divider_gen_stub.vhdl
-- Design      : divider_gen
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku035-ffva1156-3-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divider_gen is
  Port ( 
    aclk : in STD_LOGIC;
    s_axis_divisor_tvalid : in STD_LOGIC;
    s_axis_divisor_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axis_dividend_tvalid : in STD_LOGIC;
    s_axis_dividend_tdata : in STD_LOGIC_VECTOR ( 55 downto 0 );
    m_axis_dout_tvalid : out STD_LOGIC;
    m_axis_dout_tdata : out STD_LOGIC_VECTOR ( 79 downto 0 )
  );

end divider_gen;

architecture stub of divider_gen is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,s_axis_divisor_tvalid,s_axis_divisor_tdata[23:0],s_axis_dividend_tvalid,s_axis_dividend_tdata[55:0],m_axis_dout_tvalid,m_axis_dout_tdata[79:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "div_gen_v5_1,Vivado 2014.3";
begin
end;
