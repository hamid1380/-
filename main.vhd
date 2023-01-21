library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
    Port ( i_a : in  STD_LOGIC_VECTOR (1 downto 0);
           i_b : in  STD_LOGIC_VECTOR (1 downto 0);
           i_op : in  STD_LOGIC_VECTOR (1 downto 0);
           o_c : inout  STD_LOGIC_VECTOR (3 downto 0);
           seven_seg : out  STD_LOGIC_VECTOR (6 downto 0);
			  main_clock : in STD_LOGIC;
			  main_reset : in STD_LOGIC;
           z : out  STD_LOGIC;
           n : out  STD_LOGIC);
end main;

architecture Behavioral of main is
signal x, y, sub, add, andd, mul, out_reg, subb : STD_LOGIC_VECTOR (3 downto 0);
component pipo is
    Port ( i : in  STD_LOGIC_VECTOR (1 downto 0);
           o : out  STD_LOGIC_VECTOR (1 downto 0);
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end component;

component pipo_4bit is
    Port ( ii : in  STD_LOGIC_VECTOR (3 downto 0);
           oo : out  STD_LOGIC_VECTOR (3 downto 0);
           clock : in  STD_LOGIC;
           res : in  STD_LOGIC);
end component;

begin
r1: pipo port map
(
	i => i_a,
	o => x(1 downto 0),
	clk => main_clock,
	reset => main_reset
);

r2: pipo port map
(
	i => i_b,
	o => y(1 downto 0),
	clk => main_clock,
	reset => main_reset
);

r3: pipo_4bit port map
(
	ii => out_reg,
	oo => o_c,
	clock => main_clock,
	res => main_reset
);

x(3 downto 2) <= "00";
y(3 downto 2) <= "00";

sub <= std_logic_vector(unsigned(x) - unsigned(y));
subb <= sub when sub(3) = '0' else std_logic_vector(unsigned(not sub) + 1);
andd <= x and y;
add <= std_logic_vector(unsigned(x) + unsigned(y));
mul <= std_logic_vector(unsigned(x(1 downto 0)) * unsigned(y(1 downto 0)));

out_reg <= subb when i_op = "00" else
			  andd when i_op = "01" else
			  add when i_op = "10" else
			  mul;
			  
seven_seg <="1111110" when out_reg = "0000" else -- "0"     
				"0110000" when out_reg = "0001" else -- "1" 
				"1101101" when out_reg = "0010" else -- "2" 
				"1111001" when out_reg = "0011" else -- "3" 
				"0110011" when out_reg = "0100" else -- "4" 
				"1011011" when out_reg = "0101" else -- "5" 
				"1011111" when out_reg = "0110" else -- "6" 
				"1110000" when out_reg = "0111" else -- "7" 
				"1111111" when out_reg = "1000" else -- "8"     
				"1111011" when out_reg = "1001" else -- "9"
				"1001111"; -- "E" means ERROR!
				
z <= '1' when out_reg = "0000" else '0';
n <= '1' when (sub(3) = '1' and i_op = "00") else '0';
end Behavioral;

