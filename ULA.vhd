LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity ULA is 
	port(
		A,B: in std_logic_vector(3 downto 0); -- variáveis de entrada para as operações.
		operacao: in std_logic_vector(1 downto 0); -- sinal de entrada para saber qual será a operação para ser usada no multiplexador
		DEC: out   std_logic_vector(6 downto 0) -- variavel que vai guardar o resultado dos display que serão acendidos.
		
	);
	
	end ULA;
	
	architecture Ope_ULA of ULA is -- sinais 
	
	signal D: std_logic_vector(3 downto 0); -- sinal usado para o multiplexador e usado para compração com o decodificador.
	signal x: std_logic;  -- só usado para diferenciar as operações.
	signal Y: boolean;  -- sinal usado para o multiplexador e comparação para o decodificador também
	
	begin
		process(A,B,operacao) -- processo do nosso case de multiplexador(operações).
		
		begin
		case(operacao) is
		   when "00" => D <= A+B; -- operação de soma
		   when "01" => D <= A-B; -- operação de subtração
		   when "10" => D <= std_logic_vector(to_unsigned(to_integer(unsigned(a)) * to_integer(unsigned(b)), 4)); -- operação de mult.
														--conversor de varios tipos
														--to_integer(unsigned(X))
														--std_logic_vector(to_unsigned(K, N))
		   when "11" => D <= std_logic_vector(to_unsigned(to_integer(unsigned(a)) / to_integer(unsigned(b)), 4)); -- operação de divis.
		  --when "00" => Y <= A = B; -- operação de igualdade.
		  --when "01" => Y <= A > B; -- operação de maior.
		  --when "11" => Y <= A < B; -- operação de menor.
		when others =>  D <= A+B; -- qualquer outro caso ele faz a soma.
		end case;
	end process;
	

		
	 
		process(D,x)       -- processo referente ao case do decodificador.
		begin
		x <= '1'; 
		if(x = '1') then
			case(D) is      -- case do decodificador.
				when "0000" => DEC <= "1000000"; --'0'
				when "0001" => DEC <= "1111001"; --'1'
				when "0010" => DEC <= "0100100"; --'2'
				when "0011" => DEC <= "0110000"; --'3'
				when "0100" => DEC <= "0011001"; --'4'
				when "0101" => DEC <= "0010010"; --'5'
				when "0110" => DEC <= "0000010"; --'6'
				when "0111" => DEC <= "1111000"; --'7'
				when "1000" => DEC <= "0000000"; --'8'
				when "1001" => DEC <= "0010000"; --'9'
				when "1010" => DEC <= "0001000"; --'A'
				when "1011" => DEC <= "0000011"; --'B'
				when "1100" => DEC <= "1000110"; --'C'
				when "1101" => DEC <= "0100001"; --'D'
				when "1110" => DEC <= "0000110"; --'E'
				when "1111" => DEC <= "0001110"; --'F'
				when others => DEC <= "1111111";
				end case;
				else 
				case(Y) is 
					when false =>  DEC <= "1000000"; --'0'
					when true  =>  DEC <= "1111001"; --'1'
					when others => DEC <= "1000000";
					end case;
				
			end if;
		
		end process;
		
end architecture;		
		
		
	