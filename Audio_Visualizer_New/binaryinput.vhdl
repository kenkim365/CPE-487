--Input 1 or 0 for current audio piece
-- Sample input serial data process
   SHFT_IN: process(clk_i) 
   begin 
      if rising_edge(clk_i) then
         if pdm_clk_rising = '1' then 
            pdm_tmp <= pdm_tmp(C_NR_OF_BITS-2 downto 0) & pdm_m_data_i;
         end if; 
      end if;
   end process SHFT_IN;
