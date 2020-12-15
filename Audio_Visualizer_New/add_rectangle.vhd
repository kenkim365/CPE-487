LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity add_rectangle is
PORT (
		v_sync    : IN STD_LOGIC;
		pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		red       : OUT STD_LOGIC;
		green     : OUT STD_LOGIC;
		blue      : OUT STD_LOGIC
	);
end add_rectangle;

architecture Behavioral of add_rectangle is
SIGNAL audio_level : INTEGER := 5; --use values from 0 to 15 as manual numerical input to replicate the possible data output from audio meter project
--position of drawn rectange on vga screen
SIGNAL rectangle_on : STD_LOGIC;
SIGNAL rectangle_x  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0, 11);
SIGNAL rectangle_y  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(100, 11);
SIGNAL rectangle_height_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := "0000000100"; --using gravity from ball lab to decrease rectangle height if no input is recieved overtime.

begin
bdraw : PROCESS (rectangle_x, rectangle_y, pixel_row, pixel_col) IS --drawing rectangle on screen
	BEGIN
		IF ((pixel_row >= rectangle_y - audio_level) AND
		 (pixel_row <= rectangle_y + audio_level)) THEN
				rectangle_on <= '1';
		ELSE
			rectangle_on <= '0';
		END IF;
		END PROCESS;

end Behavioral;
