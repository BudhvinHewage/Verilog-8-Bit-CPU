library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        clk             : in     vl_logic;
        res             : in     vl_logic;
        Reg1            : in     vl_logic_vector(7 downto 0);
        Reg2            : in     vl_logic_vector(7 downto 0);
        opcode          : in     vl_logic_vector(7 downto 0);
        Result          : out    vl_logic_vector(7 downto 0);
        RCheck          : out    vl_logic_vector(7 downto 0)
    );
end ALU;
