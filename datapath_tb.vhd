LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY tb_datapath IS
END tb_datapath;
 
ARCHITECTURE behavior OF tb_datapath IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT datapath
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         memtoreg : IN  std_logic;
         pcsrc : IN  std_logic;
         alusrc : IN  std_logic;
         regdst : IN  std_logic;
         regwrite : IN  std_logic;
         jump : IN  std_logic;
         alucontrol : IN  std_logic_vector(2 downto 0);
         zero : OUT  std_logic;
         pc : OUT  std_logic_vector(31 downto 0);
         instr : IN  std_logic_vector(31 downto 0);
         aluout : OUT  std_logic_vector(31 downto 0);
         writedata : OUT  std_logic_vector(31 downto 0);
         readdata : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal memtoreg : std_logic := '0';
   signal pcsrc : std_logic := '0';
   signal alusrc : std_logic := '0';
   signal regdst : std_logic := '0';
   signal regwrite : std_logic := '0';
   signal jump : std_logic := '0';
   signal alucontrol : std_logic_vector(2 downto 0) := (others => '0');
   signal instr : std_logic_vector(31 downto 0) := (others => '0');
   signal readdata : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal zero : std_logic;
   signal pc : std_logic_vector(31 downto 0);
   signal aluout : std_logic_vector(31 downto 0);
   signal writedata : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: datapath PORT MAP (
          clk => clk,
          reset => reset,
          memtoreg => memtoreg,
          pcsrc => pcsrc,
          alusrc => alusrc,
          regdst => regdst,
          regwrite => regwrite,
          jump => jump,
          alucontrol => alucontrol,
          zero => zero,
          pc => pc,
          instr => instr,
          aluout => aluout,
          writedata => writedata,
          readdata => readdata
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
				
		memtoreg <= '0';
		pcsrc <= '0';
      alusrc <= '0';
      regdst <= '1';
      regwrite <= '1';
      jump <= '0';
      alucontrol <= b"001";
      readdata <= x"00000000";
		reset <= '1';
		wait for 22 ns;
		reset <= '0';
		instr <= x"20020005";
		wait for clk_period/2;
		instr <= x"2003000c";
		wait for clk_period/2;
		instr <= x"2067fff7";
		wait for clk_period/2;
		instr <= x"00e22025";
      -- insert stimulus here 

      wait;
   end process;

END;