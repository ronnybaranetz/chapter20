library ieee;
use ieee.std_logic_1164.all;

entity twos_complement is
	port (CK, N: in std_logic;
	 num: in std_logic_vector(0 to 15);
	 complement: out std_logic_vector(0 to 15)
	);
end entity twos_complement;

architecture arch of twos_complement is
signal start: bit;
signal change: bit;
signal Z: std_logic;
signal X: std_logic;
signal K: std_logic;
signal Sh: std_logic;
signal count: integer := 0;
signal new_num: std_logic_vector(0 to 15) := num;
begin
Sh <= not K;
process (N)
	begin
	if N = '1' then start <= '1'; K <= '0';
	end if;
	end process;

	process (CK)
	begin
	if CK'event and CK = '1' and start = '1' then 
	if Sh = '1' then 
		X <= new_num(15);
	 	new_num <= Z & new_num(0 to 14); 
	 	count <= count + 1;end if;
	if X = '1' then change <= '1'; end if;
	if change = '1' then Z <= not X;
	else Z <= X; end if;
	if count = 15 then K <= '1';
	complement <= new_num; end if;
	Sh <= not K;
	end if;
	 
	end process;
end architecture arch;
