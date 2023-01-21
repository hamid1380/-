library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pipo is
    Port ( i : in  STD_LOGIC_VECTOR (1 downto 0);
           o : out  STD_LOGIC_VECTOR (1 downto 0);
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end pipo;

architecture Behavioral of pipo is

begin
process(clk, reset)
begin
	if(reset = '1') then
		o <= "00";
	elsif(clk' event and clk='1') then
		o <= i;
	end if;
end process;
end Behavioral;

