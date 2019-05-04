--testbench
library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity g18_FIR_tb is
end g18_FIR_tb;

architecture test of g18_FIR_tb is
--Declare the component under test
component g18_lab3 
	port (x			: in std_logic_vector (15 downto 0);
			clk		: in std_logic;
			rst		: in std_logic;
			y			: out std_logic_vector (16 downto 0));
end component;

--testbench internal signals
file file_COEFF : text;
file file_IN : text;
file file_RESULTS : text;

constant clk_PERIOD : time := 20 ns;

signal x_in			: std_logic_vector (15 downto 0);
signal clk_in		: std_logic;
signal rst_in		: std_logic;
signal y_out		: std_logic_vector (16 downto 0);

begin
--instantiate FIR
	g18_FIR_INST: g18_lab3
		port map(
			x => x_in,
			clk => clk_in,
			rst => rst_in,
			y => y_out);

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
		variable v_Oline : line;
		variable v_x_in : std_logic_vector (15 downto 0);
		variable v_y_out: std_logic_vector (16 downto 0);
	begin
	--reset the circuit
	rst_in <= '1';
	wait until rising_edge(clk_in);
	wait until rising_edge(clk_in);
	rst_in <= '0';
	
	file_open(file_IN, "P:\ECSE 325\lab3\lab3-In-fixed-point.txt", read_mode);
	file_open(file_RESULTS, "P:\ECSE 325\lab3\lab3-out.txt", write_mode);
	
	while not endfile(file_IN) loop
		readline(file_IN, v_lline1);
		read(v_lline1, v_x_in);
		
		x_in <= v_x_in;
		
		wait until rising_edge(clk_in);
	--end loop;
	

		write(v_Oline, y_out);
		writeline(file_RESULTS, v_Oline);
	end loop;
	wait;
	end process;
end test;