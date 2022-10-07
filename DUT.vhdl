-- A DUT entity is used to wrap your design so that we can combine it with testbench.
-- This example shows how you can do this for the OR Gate

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(7 downto 0);
       	output_vector: out std_logic_vector(5 downto 0));
end entity;

architecture DutWrap of DUT is
   component exp6 is
     port(A, B: in std_logic_vector(3 downto 0);
         op: out std_logic_vector(5 downto 0));
   end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: exp6
			port map (
					-- order of inputs B A
					A(3) => input_vector(7),
					A(2) => input_vector(6),
					A(1) => input_vector(5),
					A(0) => input_vector(4),
					B(3) => input_vector(3),
					B(2) => input_vector(2),
					B(1) => input_vector(1),
					B(0) => input_vector(0),
				
               -- order of output OUTPUT
					op(5)=> output_vector(5),
					op(4)=> output_vector(4),
					op(3)=> output_vector(3),
					op(2)=> output_vector(2),
					op(1)=> output_vector(1),
					op(0)=> output_vector(0));
end DutWrap;