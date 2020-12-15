--Generates signal that 16 bits have been counted, also passes the 16 bits via data_o
   process(clk_i) 
   begin
      if rising_edge(clk_i) then
         if pdm_clk_rising = '1' then
            if cnt_bits = 0 then
               if en_int = '1' then
                  done_int <= '1';
                  data_o <= pdm_tmp;
               end if;
            end if;
         else
            done_int <= '0';
         end if;
      end if;
   end process;
