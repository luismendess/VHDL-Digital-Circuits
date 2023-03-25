--LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity ula is
  port(
  A, B      :   in std_logic_vector (3 downto 0);
  sel       :   in std_logic_vector (2 downto 0);
  saida     :   out std_logic_vector (3 downto 0)
  );
  end ula;

architecture main of ula is

  signal saidaBool: boolean;

begin
process(A, B, sel)
    begin
    case sel is

    when "0000" =>   saida     <= A + B;
    when "0001" =>   saida     <= A - B;
    when "0010" =>   saida     <= std_logic_vector(to_unsigned(to_integer(unsigned(A)) * to_integer(unsigned(B)), 4));
    when "0011" =>   saida     <= std_logic_vector(to_unsigned(to_integer(unsigned(A)) / to_integer(unsigned(B)), 4));
    when "0100" =>   saidaBool <= A = B;
    when "0101" =>   saidaBool <= A > B;
    when "0111" =>   saidaBool <= A >= B;
    when "1000" =>   saidaBool <= A < B;
    when "1001" =>   saidaBool <= A <= B;    
    when others =>   saidaBool <= A + B;

    end case;

end process;
end main;

entity memoria is
port ( dado_entrada : in unsigned(3 downto 0);
       dado_saida   : out unsigned(3 downto 0);
       endereco     : in unsigned(3 downto 0);
       we, ce       : in std_logic);
end memoria;

architecture hardware of memoria is
    type arranjo_memory is array(0 to 7) of unsigned(3 downto 0);
    signal memory : arranjo_memory;

begin

    process(ce, endereco)
    begin

        if rising_edge(ce) then
        if we = '0' then memory(to_integer(endereco)) <= dado_entrada; -- Load
        end if;
        end if;
    end process;

    dado_saida <= memory(to_integer(endereco));    --Store

end hardware
