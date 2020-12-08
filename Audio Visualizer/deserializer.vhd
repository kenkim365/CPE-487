----------------------------------------------------------------------------------
-- Created by: Erik Schneider and Jared Kantor
-- Module Name: deserializer - Behavioral
-- Description: This module converts the sound from the microphone into 16 bit bundles
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;



ENTITY deserializer IS
    PORT ( 
        bit_number: INTEGER := 16;  --how many bits are used
        
        clk_mic : IN STD_LOGIC;     --clock
        pdm_data : IN STD_LOGIC; -- Input PDM data from the microphone
        data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); --16 bit value of the sound
        done : OUT STD_LOGIC; --signals that the 16 bit bundle is full
        lrsel : OUT STD_LOGIC
        
    );
END deserializer;

ARCHITECTURE Behavioral OF deserializer IS

    SIGNAL pdm_int : STD_LOGIC_VECTOR(15 DOWNTO 0); --shift register for incoming pdm bits
    SIGNAL cnt_bits : INTEGER RANGE 0 TO 20 := 0;
    SIGNAL done_int : STD_LOGIC;

BEGIN

    lrsel <= '0'; --Read on riding edge
    
    shift: PROCESS (clk_mic) --add incoming pdm data to 16 bit bundle
    BEGIN
        IF RISING_EDGE(clk_mic) THEN
            pdm_int <= pdm_int(14 DOWNTO 0) & pdm_data; 
        END IF;
    END PROCESS shift;

    cnt: PROCESS (clk_mic)  --count how many bits are in the current bundle
    BEGIN
        IF RISING_EDGE(clk_mic) THEN
            IF cnt_bits = (bit_number-1) THEN
                cnt_bits <= 0;
            ELSE
                cnt_bits <= cnt_bits + 1;
            END IF;
        END IF;
    END PROCESS cnt;
    
    fin: PROCESS (clk_mic)  -- Generates done signal and passes 16 bit bundle out of component
    BEGIN
        IF RISING_EDGE(clk_mic) THEN
            IF cnt_bits = 0 THEN
                done_int <= '1';
                data <= pdm_int;
            END IF;
        ELSE
            done_int <= '0';
        END IF;
    END PROCESS fin;

END Behavioral;
