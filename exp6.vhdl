library ieee;
use ieee.std_logic_1164.all;



entity exp6 is
generic(
operand_width : integer:=4);
port (
A: in std_logic_vector(operand_width-1 downto 0);
B: in std_logic_vector(operand_width-1 downto 0);
op: out std_logic_vector(5 downto 0)) ;
end exp6;


architecture a1 of exp6 is
function add(A: in std_logic_vector(4 downto 0);
B: in std_logic_vector(4 downto 0))
return std_logic_vector is

variable sum : std_logic_vector(5 downto 0):=(others => '0');
variable carry : std_logic_vector(4 downto 0):=(others=> '0');

-- Declare "sum" and "carry" variable
-- you can use aggregate to initialize the variables as shown below
-- variable variable_name : std_logic_vector(3 downto 0) := (others => '0');

begin

L1 : for i in 0 to 4 loop
         if i=0 then
			  sum(i) := A(i) Xor B(i) Xor '0';
			  carry(i) := A(i) and B(i);
			else 
			   sum(i) := A(i) xor B(i) xor carry(i-1);
				carry(i) := (A(i) and B(i)) or (carry(i-1) and (A(i) or B(i)));
			end if;
		end loop L1;
		sum(5):=carry(4);
			

-- write logic for addition
-- Hint: Use for loop
return sum; --according to your logic you can change what you want to return
end add;



begin
alu : process( A, B)
variable sel : std_logic_vector(1 downto 0);
variable max : std_logic_vector(3 downto 0);
variable out1: std_logic_vector(3 downto 0);
variable C: std_logic_vector(4 downto 0);
variable D: std_logic_vector(4 downto 0);

--declare other variables
begin
-- complete VHDL code for various outputs of ALU based on select lines
sel(1) := A(3);
sel(0) := B(3);
case sel is
when "00" =>

				if (A(2)='1' and B(2)='0') then
					 max := A;
				elsif (A(2)='0' and B(2)='1') then
					 max := B;
				elsif (A(1)='0' and B(1)='1') then
					 max := B;
				elsif (A(1)='1' and B(1)='0') then
					 max := A;
				elsif(A(0)='1' and B(0)='0') then
					 max := A;
				elsif(A(0)='0' and B(0)='1') then
					 max := B;
				else
					 max := ('0','0','0','0');
					 end if;

    op(5) <= '0';
    op(4) <= '0';
    op(3) <= '0';
    op(2) <= max(2);
    op(1) <= max(1);
    op(0) <= max(0);


when "01" =>

L2: for i in 0 to 3 loop
          op(i) <= A(i) and B(i);
	 end loop L2;
	 op(5)<='0';
	 op(4)<='0';
	 

when "10" =>
     C(4) := '0';
	  D(0) := '0';
	 
	  L3:for i in 0 to 3 loop
	     C(i) := A(i);
		   D(i+1):=A(i);
			
		end loop L3;
   op <= add(C,D);
           
		     


when "11" =>
 
 op <= ('0', '0', '0', '0', '0', '0');
			if ((A(2)=B(2)) and (A(1)=B(1)) and (A(0)=B(0))) then
				 op(5) <= '0';
				 op(4) <= '0';
				 L4: for i in 0 to 3 loop
						 op(i)<=A(i);
				 end loop L4;
			end if;

when others =>
    max := A;

end case;
end process ; -- alu
end a1 ; -- a1