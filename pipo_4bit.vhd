library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipo_4bit is
    Port ( ii : in  STD_LOGIC_VECTOR (3 downto 0);
           oo : out  STD_LOGIC_VECTOR (3 downto 0);
           clock : in  STD_LOGIC;
           res : in  STD_LOGIC);
end pipo_4bit;

architecture Behavioral of pipo_4bit is

begin
process(clock, res)
begin
	if(res = '1') then
		oo <= "0000";
	elsif(clock' event and clock='1') then
		oo <= ii;
	end if;
end process;

end Behavioral;

