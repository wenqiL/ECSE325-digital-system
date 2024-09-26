library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use IEEE.STD_LOGIC_textio.ALL;
use ieee.std_logic_unsigned.all;
entity g18_lab3 is
port(	x		:in std_logic_vector (15 downto 0);--input signal
		clk	:in std_logic;--clock
		rst	:in std_logic;--asynchronous active-high reset
		y		:out std_logic_vector (16 downto 0));--output signal
end g18_lab3;

architecture FIR of g18_lab3 is 
--signal count: integer range 0 to 25;

  
type coeff_array is array (24 downto 0) of std_logic_vector (15 downto 0);
  constant coeff : coeff_array :=
            ("0000001001110011",
             "0000000000010001",
             "1111111111010010",
             "1111111011011101",
				 "0000001100011010",
				 "1111110110100111",
				 "1111110000001101",
				 "0000110110111101",
				 "1110110001110010",
				 "0000110111111000",
				 "0000001100001000",
				 "1110101000001010",
				 "0001111000110100",
				 "1110101000001010",
				 "0000001100001000",
				 "0000110111111000",
				 "1110110001110010",
				 "0000110110111101",
				 "1111110000001101",
				 "1111110110100111",
				 "0000001100011010",
				 "1111111011011101",
				 "1111111111010010",
				 "0000000000010001",
				 "0000001001110011");
type x_array is array (24 downto 0) of signed (15 downto 0);
	signal x_in : x_array;

type mul_array is array (24 downto 0) of signed (31 downto 0);
	signal mul_in : mul_array;
				 
begin

--	firpart1: process(clk,rst)
--	type sum_array is array (24 downto 0) of signed (31 downto 0);
--		variable sum: sum_array;
--	begin
--			if rst = '1' then 
--				--count <= 0;
--				sum := ((others => (others => '0')));
--				x_in <= ((others => (others => '0')));
--		
--			elsif rising_edge(clk) then
--			
--					x_in(0) <= signed(x);
--					x_loop: for j in 0 to 23 loop
--						x_in(j+1) <= x_in(j);
--					end loop x_loop;
--					
--					sum(0) := signed(x_in(0)) * signed(coeff(0));
--					
--					count_loop: for i in 1 to 24 loop
--						sum(i) := sum(i-1) + signed(x_in(i)) * signed(coeff(i));
--					end loop count_loop;
--					
--			end if; --if rst
--			y <= std_logic_vector(sum(24)(31 downto 15));
--	end process;
	 

	
	firpart2: process(clk,rst)
	begin
			if rst = '1' then 
				mul_in <= ((others => (others => '0')));
			elsif rising_edge(clk) then

					mul_in(0) <= signed(x) * signed (coeff(24));
			
					count_loop: for i in 0 to 23 loop
						mul_in(i+1) <= mul_in(i) + signed(x) * signed(coeff(23-i));
					end loop count_loop;
					
					y <= std_logic_vector(mul_in(24)(31 downto 15));
					
			end if; --if rst
		
	end process;
--	
end FIR;
