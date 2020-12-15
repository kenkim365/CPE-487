
--Count until 16 bits have been sampled from the onboard mic
-- Count the number of sampled bits
   cnt: process(clk_mic) begin
      if rising_edge(clk_mic) then
         if en_int = '0' then
            cnt_bits <= 0;
         else
            if pdm_clk_rising = '1' then
               if cnt_bits = (C_NR_OF_BITS-1) then
                  cnt_bits <= 0;
            else
               cnt_bits <= cnt_bits + 1;
   end process cnt;
