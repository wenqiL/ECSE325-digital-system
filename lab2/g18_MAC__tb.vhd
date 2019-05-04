--testbench
library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity g18_MAC_tb is
end g18_MAC_tb;

architecture test of g18_MAC_tb is
--Declare the component under test
component g18_lab2 
	port (x			: in std_logic_vector (9 downto 0);
			y			: in std_logic_vector (9 downto 0);
			N			: in std_logic_vector (9 downto 0);
			clk		: in std_logic;
			rst		: in std_logic;
			mac		: out std_logic_vector (20 downto 0);
			ready		: out std_logic);
end component;

--testbench internal signals
file file_VECTORS_X : text;
file file_VECTORS_Y : text;
file file_RESULTS : text;

constant clk_PERIOD : time := 100 ns;

signal x_in			: std_logic_vector (9 downto 0);
signal y_in			: std_logic_vector (9 downto 0);
signal N_in			: std_logic_vector (9 downto 0);
signal clk_in		: std_logic;
signal rst_in		: std_logic;
signal mac_out		: std_logic_vector (20 downto 0);
signal ready_out	: std_logic;

begin
--instantiate MAC
	g18_MAC_INST: g18_lab2
		port map(
			x => x_in,
			y => y_in,
			N => N_in,
			clk => clk_in,
			rst => rst_in,
			mac => mac_out,
			ready => ready_out);
			
--clock generation
clk_generation : process
begin
	clk_in <= '1';
	wait for clk_PERIOD/2;
	clk_in <= '0';
	wait for clk_PERIOD/2;
end process;

--feeding inputs
feeding_instr : process is
		variable v_lline1 : line;
		variable v_lline2 : line;
		variable v_Oline : line;
		variable v_x_in : std_logic_vector (9 downto 0);
		variable v_y_in : std_logic_vector (9 downto 0);
	begin
	--reset the circuit
	N_in <= "1111101000";--N=1000
	rst_in <= '1';
	wait until rising_edge(clk_in);
	wait until rising_edge(clk_in);
	rst_in <= '0';
	
	file_open(file_VECTORS_X, "P:\ECSE 325\lab2\lab2-x-fixed-point.txt", read_mode);
	file_open(file_VECTORS_Y, "P:\ECSE 325\lab2\lab2-y-fixed-point.txt", read_mode);
	file_open(file_RESULTS, "P:\ECSE 325\lab2\lab2-out.txt", write_mode);
	
	while not endfile(file_VECTORS_X) loop
		readline(file_VECTORS_X, v_lline1);
		read(v_lline1, v_x_in);
		readline(file_VECTORS_Y, v_lline2);
		read(v_lline2, v_y_in);
		
		x_in <= v_x_in;
		y_in <= v_y_in;
		
		wait until rising_edge(clk_in);
	end loop;
	
	if ready_out = '1' then
		write(v_Oline, mac_out);
		writeline(file_RESULTS, v_Oline);
		end if;
		wait;
	end process;
end test;