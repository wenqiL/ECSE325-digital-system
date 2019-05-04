library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use IEEE.STD_LOGIC_textio.ALL;
use ieee.std_logic_unsigned.all;
entity g18_lab2 is
	Port (	x					: in std_logic_vector (9 downto 0);--first input
				y					: in std_logic_vector (9 downto 0);--second input
				N					: in std_logic_vector (9 downto 0);--total number of inputs
				clk				: in std_logic;--clock
				rst				: in std_logic;--asynchronous active-high reset
				mac				: out std_logic_vector (20 downto 0);--output of MAC units
				ready				: out std_logic);--denotes the validity of the mac signal
end g18_lab2;

architecture MAC of g18_lab2 is 
signal count: std_logic_vector(9 downto 0);
signal mac_signal: std_logic_vector (20 downto 0);
begin
	macunit: process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then 
				mac_signal <= (others => '0');
				count <= (others => '0');
				ready <= '0';
			elsif count >= 0 then 
				mac_signal <= mac_signal + std_logic_vector(signed(x)*signed(y));
				count <= count + 1;
				if count = "1111101000" then
					ready <= '1';
				end if; --if count
			end if; --if rst
		end if; --if clk
	end process;
	mac <= mac_signal;
end MAC;