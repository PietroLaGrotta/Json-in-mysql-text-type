-- This function search an INT value in a list of INT values
-- The array of INT is represented by a TEXT containig the array of int in json format

-- INPUT : 
-- --  search_ INT: INT to search
-- --  json_int_array_ TEXT: array of INT in json format eg: '[27, 5, 4]'

-- OUTPUT: 
-- -- INT : position of first occurrence found into array 
--          or negative value if array don't contais the searched INT

-- 
 
DROP FUNCTION IF EXISTS `is_into_json_in_array`;
DELIMITER $$
CREATE FUNCTION `is_into_json_in_array` (search_ INT, json_int_array_ TEXT)  RETURNS INT BEGIN


declare com_list TEXT;  -- array of INT in json format
declare loc INT; -- position in string
declare single_val_ INT; -- one element of array
declare x_ INT; -- position of INT element in array
	
	SET com_list = json_int_array_;
	SET x_ = 0;
	
	WHILE LENGTH(com_list) > 0 DO  -- c'è almeno una occorrenza di ga
            
		SET loc = LOCATE(',', com_list);
		
		IF  loc > 0 THEN -- ci sono almeno due occorrenze
		
			SET single_val_ = CAST(LEFT(com_list, loc - 1) AS SIGNED);
			SET com_list = SUBSTRING(com_list, loc + 1);
		
		ELSE  -- c'è una sola occorrenza
		
			SET single_val_ = CAST(com_list AS SIGNED);
			SET com_list = '';
			
		END IF;

		IF single_val_ = search_ THEN RETURN x_; END IF;
		
		SET x_ = x_ + 1;
	
	END WHILE;
	
	RETURN -100;
	
end$$

DELIMITER ;