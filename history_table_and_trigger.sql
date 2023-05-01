------------------
-- History Table
------------------

-- a player_item_usage table that tracks changes in item's quantity in a player's inventory
CREATE TABLE PLAYER_ITEM_USAGE (

	ITEM_USAGE_ID		SERIAL NOT NULL,
	PLAYER_NAME			VARCHAR(128) NOT NULL,
	ITEM_NAME			VARCHAR(64) NOT NULL,
	OLD_QUANTITY		BIGINT NOT NULL,
	NEW_QUANTITY		BIGINT NOT NULL,
	USAGE_TYPE			VARCHAR(8) NOT NULL,	-- VALUES = CONSUMED, BOUGHT, EMPTIED
	USAGE_DATE			TIMESTAMP NOT NULL,
	PRIMARY KEY (ITEM_USAGE_ID, USAGE_DATE)
);

DROP TABLE PLAYER_ITEM_USAGE;

-- get data needed for inserte into the PLAYER_ITEM_USAGE table,
-- if items quantity emptied (quantity 1 --> 0), then delete associated PLAYER_INVENTORY record
CREATE OR REPLACE FUNCTION PlayerItemUsageFunction()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$
	DECLARE
		v_player_name 	VARCHAR(128);
		v_item_name		VARCHAR(64);
		v_usage_type	VARCHAR(8);
	BEGIN
		-- get player name, set variable for insert statemetn
		SELECT player_name INTO v_player_name 
		FROM PLAYER_INFO WHERE player_info_id = NEW.player_info_id;
		
		-- get item name, set variable for insert statement
		SELECT item_name INTO v_item_name 
		FROM ITEMS WHERE items_id = NEW.item_id;
		
		-- determine usage type based on change in quantity value
		CASE 
			WHEN OLD.quantity = 1 AND NEW.quantity = 0 THEN v_usage_type := 'EMPTIED';
			WHEN NEW.quantity > OLD.quantity THEN v_usage_type := 'BOUGHT';
			WHEN NEW.quantity = OLD.quantity - 1 THEN v_usage_type := 'CONSUMED';
			ELSE v_usage_type := 'UNKNOWN';
		END CASE;
		
		-- insert record into history table using values found in the above statements
		INSERT INTO PLAYER_ITEM_USAGE (player_name, item_name, old_quantity, new_quantity, usage_type, usage_date)
		VALUES (v_player_name, v_item_name, OLD.quantity, NEW.quantity, v_usage_type, NOW());
		
		-- if item quantity changes from 1 --> 0, then delete record from player_inventory
		IF v_usage_type = 'EMPTIED' THEN
			DELETE FROM PLAYER_INVENTORY WHERE player_info_id = NEW.player_info_id AND item_id = NEW.item_id;
		END IF;
		
	RETURN NEW;
	END;
$trigfunc$;

-- on UPDATE to PLAYER_INVENTORY 'quantity' attribute, create a new record in the table
CREATE TRIGGER PlayerItemUsageTrigger
AFTER UPDATE OF quantity on PLAYER_INVENTORY
FOR EACH ROW
EXECUTE PROCEDURE PlayerItemUsageFunction();



-- TEST TRIGGER

-- get player's inventory (item_id, player_info_id, item_name and quantity)
select p_info.player_info_id, i.items_id, i.item_name, pi.quantity 
from player_inventory pi
join items i on pi.item_id = i.items_id
join player_info p_info on pi.player_info_id = p_info.player_info_id
where p_info.player_name = 'Gawain';

-- for this test we will be modifying quantities as follows: 
-- 		1. CONSUMED 'Medicinal Herb' 	quantity 11 --> 10 and 'Chimaera Wing' quantity 2 --> 1
--		2. EMPTIED	'Chimaera Wing' 	quantity 1 --> 0
--		3. BOUGHT	'Torch'				quantity 4 --> 5

---------------------------------------------
-- scenario 1 (CONSUMED test)
---------------------------------------------

-- modify quantity for 'Medicinal Herb'
update player_inventory set quantity = 10
where player_info_id = 3 and item_id = 1;

-- modify quantity for 'Chimaera Wing'
update player_inventory set quantity = 1
where player_info_id = 3 and item_id = 3;

-- verify that trigger called function to insert records into this table
select * from player_item_usage where player_name = 'Gawain'
and item_name in ('Medicinal Herb', 'Chimaera Wing');

---------------------------------------------
--  scenario 2 (EMPTIED test)
---------------------------------------------
-- modify quantity for 'Chimaera Wing' (again!)
update player_inventory set quantity = 0
where player_info_id = 3 and item_id = 3;

-- verify that trigger called function to insert records into this table
select * from player_item_usage where player_name = 'Gawain'
and item_name = 'Chimaera Wing';

-- second verification that PLAYER_INVENTORY record deleted
select * from player_inventory
where player_info_id = 3 and item_id = 3;

---------------------------------------------
-- scenario 3 (BOUGHT test)
---------------------------------------------
-- modify quantity for 'Torch'
update player_inventory set quantity = 5
where player_info_id = 3 and item_id = 2;

-- verify that trigger called function to insert records into this table
select * from player_item_usage where player_name = 'Gawain'
and item_name = 'Torch';