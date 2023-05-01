-- DROP Procedures 
DROP PROCEDURE IF EXISTS add_location;
DROP PROCEDURE IF EXISTS add_merchant;
DROP PROCEDURE IF EXISTS add_monsters;
DROP PROCEDURE IF EXISTS add_monster_to_location;
DROP PROCEDURE IF EXISTS add_spells;
DROP PROCEDURE IF EXISTS add_spell_to_player_monster;
DROP PROCEDURE IF EXISTS add_player_levels;
DROP PROCEDURE IF EXISTS add_to_inventory;
DROP PROCEDURE IF EXISTS add_item;
DROP PROCEDURE IF EXISTS add_player_info;
DROP PROCEDURE IF EXISTS add_save_snapshots;
DROP PROCEDURE IF EXISTS add_heroes_journey;


-- Creating Procedures 

-- creates data for LOCATIONS
CREATE OR REPLACE PROCEDURE add_location(v_location_name in VARCHAR(64))
LANGUAGE plpgsql AS
$proc$
	BEGIN
		IF v_location_name IS NOT NULL THEN
			INSERT INTO LOCATIONS(location_name) VALUES (v_location_name);
		ELSE
			RAISE EXCEPTION 'Invalid location name.';
		END IF;
	END;
$proc$;

-- creates data for MERCHANTS
CREATE OR REPLACE PROCEDURE add_merchant(v_merchant_type in VARCHAR(16), v_location_name in VARCHAR(64))
LANGUAGE plpgsql AS
$proc$
	DECLARE
		v_location_id BIGINT;
	BEGIN
		SELECT locations_id 
		INTO v_location_id
		FROM locations WHERE location_name = v_location_name;
		
		IF v_merchant_type IS NOT NULL AND v_location_id > 0 THEN
			INSERT INTO MERCHANTS (location_id, merchant_type) VALUES (v_location_id, v_merchant_type);
		ELSE
			RAISE EXCEPTION 'Invalid merchant information.';
		END IF;
	END;
$proc$;

-- create data for MONSTERS, also inserts into MINIONS / BOSSES 
CREATE OR REPLACE PROCEDURE add_monsters(v_monster_name in VARCHAR(64), v_monster_hp in BIGINT, v_monster_mp in BIGINT, v_monster_str in BIGINT,
										v_monster_def in BIGINT, v_monster_spd in BIGINT, v_monster_experience in BIGINT, v_monster_gold_dropped in BIGINT,
										v_location_name in VARCHAR(64), v_encounter_percentage in DECIMAL(4,2), v_is_boss in BOOLEAN)
LANGUAGE plpgsql AS
$proc$
	DECLARE
		v_new_monster_id BIGINT;
		v_location_id BIGINT;
	BEGIN
	
		IF v_monster_name IS NOT NULL AND v_monster_hp > 0 AND v_monster_mp >= 0 AND v_monster_str > 0 AND v_monster_def > 0 AND v_monster_spd > 0 AND
			v_monster_experience >= 0 AND v_monster_gold_dropped >= 0 THEN
			
			INSERT INTO MONSTERS (monster_name, monster_hp, monster_mp, monster_str, monster_def, monster_spd, experience, gold_dropped)
			VALUES(v_monster_name, v_monster_hp, v_monster_mp, v_monster_str, v_monster_def, v_monster_spd, v_monster_experience, v_monster_gold_dropped)
			RETURNING monsters_id INTO v_new_monster_id;

			-- determine type of monster
			IF v_is_boss then
				INSERT INTO BOSSES (monsters_id) VALUES (v_new_monster_id);
			ELSE
				INSERT INTO MINIONS (monsters_id) VALUES (v_new_monster_id);	
			END IF;
		ELSE
			RAISE EXCEPTION 'Invalid monster information.';
		END IF;
	END;
$proc$;


-- create data for MONSTERS, also inserts into MINIONS / BOSSES 
CREATE OR REPLACE PROCEDURE add_monster_to_location(v_monster_name in VARCHAR(64), v_location_name in VARCHAR(64), v_encounter_percentage in DECIMAL(4,2))
LANGUAGE plpgsql AS
$proc$
	DECLARE
		v_monster_id BIGINT;
		v_location_id BIGINT;
	BEGIN
		SELECT monsters_id 
		INTO v_monster_id
		FROM MONSTERS WHERE monster_name = v_monster_name;
		
		SELECT locations_id 
		INTO v_location_id 
		FROM LOCATIONS WHERE location_name = v_location_name;
		
		IF v_monster_id IS NOT NULL AND v_monster_id > 0 AND v_location_id IS NOT NULL AND v_location_id > 0 THEN
			INSERT INTO MONSTER_LOCATIONS (locations_id, monsters_id, encounter_percentage)
				VALUES (v_location_id, v_monster_id, v_encounter_percentage);		
		ELSE 
			RAISE EXCEPTION 'Invalid monster location information.';
		END IF;
	END;
$proc$;

-- create data for SPELLS
CREATE OR REPLACE PROCEDURE add_spells(v_spell_name in VARCHAR(32), v_spell_effect in VARCHAR(128), v_mp_cost in BIGINT)
LANGUAGE plpgsql AS
$proc$
	BEGIN
	
		IF v_spell_name IS NOT NULL AND v_spell_effect IS NOT NULL AND v_mp_cost >= 0 THEN
			-- creates placeholder spell, used when creating PLAYER_LEVELS data for levels that do not unlock a spell
			IF v_spell_name = 'NONE' THEN
				INSERT INTO SPELLS (spells_id, spell_name, spell_effect, mp_cost) 
				VALUES (0, v_spell_name, v_spell_effect, v_mp_cost);
			ELSE 
				INSERT INTO SPELLS (spell_name, spell_effect, mp_cost) 
				VALUES (v_spell_name, v_spell_effect, v_mp_cost);
			END IF;
		ELSE 
			RAISE EXCEPTION 'Invalid spell information provided.';
		END IF;
	END;
$proc$;

-- inserts data into the PLAYER_SPELLS and MONSTER_SPELLS using provided info
CREATE OR REPLACE PROCEDURE add_spell_to_player_monster(v_spell_name in VARCHAR(32), v_player_name in VARCHAR(64), v_monster_name in VARCHAR(64), 
									   v_usable_in_battle in BOOLEAN, v_chance_to_hit in BIGINT)
LANGUAGE plpgsql AS
$proc$
	DECLARE
		v_spell_id BIGINT;
		v_player_id BIGINT;
		v_monster_id BIGINT;
	BEGIN
	
		IF v_spell_name IS NOT NULL THEN
			SELECT spells_id 
			INTO v_spell_id 
			FROM SPELLS WHERE spell_name = v_spell_name;
		
			IF v_spell_id IS NOT NULL THEN
				IF v_player_name IS NOT NULL AND v_usable_in_battle IS NOT NULL THEN
					
					SELECT player_info_id FROM PLAYER_INFO
					INTO v_player_id
					WHERE player_name = v_player_name;
				
					IF v_player_id IS NOT NULL THEN 
						INSERT INTO PLAYER_SPELLS (spells_id, player_info_id, usable_in_battle) 
							VALUES (v_spell_id, v_player_id, v_usable_in_battle);
					ELSE 
						RAISE EXCEPTION 'Invalid player name.';
					END IF;

				ELSEIF v_monster_name IS NOT NULL AND v_chance_to_hit > 0 THEN
				
					SELECT monsters_id 
					INTO v_monster_id
					FROM MONSTERS WHERE monster_name = v_monster_name;

					IF v_monster_id IS NOT NULL THEN 
						INSERT INTO MONSTER_SPELLS (spells_id, monsters_id, chance_to_hit) 
							VALUES (v_spell_id, v_monster_id, v_chance_to_hit);
					ELSE 
						RAISE EXCEPTION 'Invalid monster name.';
					END IF;

				ELSE
					RAISE EXCEPTION 'Please provide either a player_id or monster_id greater than 0';
				END IF;
			ELSE 
				RAISE EXCEPTION 'Invalid spell id.';
			END IF;
		ELSE
			RAISE EXCEPTION 'Unrecognized spell name.';
		END IF;
	END;
$proc$;


-- create data for PLAYER_LEVELS
CREATE OR REPLACE PROCEDURE add_player_levels(v_spell_name in VARCHAR(32), v_level in BIGINT, v_exp_needed BIGINT, v_str_gain in BIGINT, v_str_base in BIGINT, 
											  v_def_gain in BIGINT, v_def_base in BIGINT, v_spd_gain in BIGINT, v_spd_base in BIGINT, 
											  v_hp_gain in BIGINT, v_hp_base in BIGINT, v_mp_gain in BIGINT, v_mp_base in BIGINT)
LANGUAGE plpgsql AS
$proc$
	DECLARE
		v_spells_id BIGINT;
	BEGIN
		IF v_spell_name = 'NONE' THEN
			v_spells_id := 0;
		ELSE 
			SELECT spells_id INTO v_spells_id 
			FROM SPELLS  WHERE spell_name = v_spell_name;
		END IF;
		
		IF v_spells_id IS NOT NULL AND v_spells_id >= 0 AND v_level > 0 AND v_exp_needed >= 0 AND v_str_gain >= 0 AND v_str_base >= 0 AND v_def_gain >= 0 AND 
			v_def_base >= 0 AND v_spd_gain >= 0 AND v_spd_base >= 0 AND v_hp_gain >= 0 AND v_hp_base >= 0 AND v_mp_gain >= 0 AND v_mp_base  >= 0 THEN
			INSERT INTO PLAYER_LEVELS (unlocked_spell_id, level, exp_needed, str_gain, str_base, def_gain, def_base, 
							   spd_gain, spd_base, hp_gain, hp_base, mp_gain, mp_base)
			VALUES (v_spells_id, v_level, v_exp_needed, v_str_gain, v_str_base, v_def_gain, v_def_base, 
					v_spd_gain, v_spd_base, v_hp_gain, v_hp_base, v_mp_gain, v_mp_base);
		ELSE 
			RAISE EXCEPTION 'Invalid player level information provided.';
		END IF;

	END;
$proc$;

-- create data for MERCHANT_INVENTORY or PLAYER_INVENTORY depending on parameters provided
CREATE OR REPLACE PROCEDURE add_to_inventory(v_item_name in VARCHAR(64), v_merchant_type in VARCHAR(16), v_location_name in VARCHAR(64),
												  v_quantity in BIGINT, v_player_name in VARCHAR(128), v_is_equipped in BOOLEAN)
LANGUAGE plpgsql AS
$proc$
	DECLARE
		v_item_id BIGINT;
		v_merchant_id BIGINT;
		v_location_id BIGINT;
		v_player_id BIGINT;
		v_player_inventory_id BIGINT;
	BEGIN
	
		SELECT items_id 
		INTO v_item_id
		FROM ITEMS WHERE item_name = v_item_name;
		
		SELECT locations_id 
		INTO v_location_id 
		FROM LOCATIONS WHERE location_name = v_location_name;
		
		IF v_merchant_type IS NOT NULL AND v_location_id IS NOT NULL THEN
			SELECT merchant_id 
			INTO v_merchant_id
			FROM MERCHANTS WHERE merchant_type = v_merchant_type AND location_id = v_location_id;	

			INSERT INTO MERCHANT_INVENTORY (item_id, merchant_id) VALUES (v_item_id, v_merchant_id);
			
		ELSEIF v_player_name IS NOT NULL THEN
			
			SELECT player_info_id 
			INTO v_player_id
			FROM PLAYER_INFO WHERE player_name = v_player_name;
			
			SELECT player_inventory_id 
			INTO v_player_inventory_id 
			FROM PLAYER_INVENTORY WHERE player_info_id = v_player_id AND item_id = v_item_id;
			
			IF v_player_inventory_id IS NOT NULL AND v_player_id IS NOT NULL THEN
			-- if player inventory record already exists, then increment quantity
				UPDATE PLAYER_INVENTORY SET quantity = quantity + v_quantity
				WHERE player_inventory_id = v_player_inventory_id;
			ELSEIF v_player_inventory_id IS NULL AND v_player_id IS NOT NULL THEN
			-- if player inventory not found, then create new record
				INSERT INTO PLAYER_INVENTORY (item_id, player_info_id, quantity, is_equipped) 
				VALUES (v_item_id, v_player_id, v_quantity, v_is_equipped);
			ELSE 
				RAISE EXCEPTION 'Invalid  player name value provided.';
				END IF;
		END IF;
	END;
$proc$;

-- create data for ITEMS, also creates records in EQUIPMENT, CONSUMABLES, KEY_ITEMS
CREATE OR REPLACE PROCEDURE add_item(v_item_name in VARCHAR(64), v_item_effect in VARCHAR(128), v_buy_price in BIGINT, v_sell_price in BIGINT, 
									v_is_usable_in_battle in BOOLEAN, v_item_type in VARCHAR(10), v_buff_length in BIGINT, v_cures_condition in VARCHAR(24),
									v_equip_type in VARCHAR(24), v_equip_slot in VARCHAR(24), v_is_key_item in BOOLEAN)
LANGUAGE plpgsql AS
$proc$
	DECLARE
		v_item_id BIGINT;
	BEGIN
		IF v_item_name IS NOT NULL AND v_item_effect IS NOT NULL THEN
			INSERT INTO ITEMS (item_name, item_effect, buy_price, sell_price, is_usable_in_battle)
				VALUES (v_item_name, v_item_effect, v_buy_price, v_sell_price, v_is_usable_in_battle)
				RETURNING items_id INTO v_item_id;
		ELSE
			RAISE EXCEPTION 'Invalid item information provided.';
		END IF;
		
		IF v_item_type = 'EQUIPMENT' THEN
			INSERT INTO EQUIPMENT (items_id, equip_type, equip_slot) VALUES (v_item_id, v_equip_type, v_equip_slot);
		ELSEIF v_item_type = 'CONSUMABLE' THEN
			INSERT INTO CONSUMABLES (items_id, buff_length, cures_condition) VALUES (v_item_id, v_buff_length, v_cures_condition);
		ELSEIF v_item_type = 'KEY_ITEM' THEN
			INSERT INTO KEY_ITEMS (items_id, is_key_item) VALUES (v_item_id, v_is_key_item);
		ELSE
			RAISE EXCEPTION 'Invalid item type provided.';
		END IF;
	END;
$proc$;

-- create data for PLAYER_INFO
CREATE OR REPLACE PROCEDURE add_player_info(v_location_name in VARCHAR(64), v_player_name in VARCHAR(128), v_player_level in BIGINT, v_hp_max in BIGINT, 
											v_hp_current in BIGINT, v_mp_max in BIGINT, v_mp_current in BIGINT, v_str_base in BIGINT, v_str_with_equip in BIGINT,
										   	v_def_base in BIGINT, v_def_with_equip in BIGINT, v_spd_base in BIGINT, v_spd_with_equip in BIGINT,
										    v_total_experience in BIGINT, v_total_gold in BIGINT)
LANGUAGE plpgsql AS
$proc$
	DECLARE
		v_location_id BIGINT;
	BEGIN
		SELECT locations_id 
		INTO v_location_id
		FROM locations WHERE location_name = v_location_name;
		
		IF v_location_id IS NOT NULL AND v_player_name IS NOT NULL AND v_player_level >= 1 AND v_hp_max > 0 AND v_hp_current > 0 AND v_mp_max >= 0 AND
			v_mp_current >= 0 AND v_str_base > 0 AND v_str_with_equip > 0 AND v_def_base > 0 AND v_def_with_equip > 0 AND v_spd_base > 0 AND 
			v_spd_with_equip > 0 AND v_total_experience >= 0 AND v_total_gold >= 0 THEN
			
			INSERT INTO PLAYER_INFO (location_id, player_name, player_levels_id, hp_max, hp_current, mp_max, mp_current, str_base, str_with_equip, def_base,
									def_with_equip, spd_base, spd_with_equip, total_experience, total_gold)
			VALUES (v_location_id, v_player_name, v_player_level, v_hp_max, v_hp_current, v_mp_max, v_mp_current, v_str_base, v_str_with_equip, v_def_base,
									v_def_with_equip, v_spd_base, v_spd_with_equip, v_total_experience, v_total_gold);
		ELSE 
			RAISE EXCEPTION 'Invalid player info information provided.';
		END IF;
	END;
$proc$;

-- create data for SAVE_SNAPSHOTS
CREATE OR REPLACE PROCEDURE add_save_snapshots(v_player_name in VARCHAR(128), v_date_of_save in DATE)
LANGUAGE plpgsql AS
$proc$
	DECLARE
		v_player_id BIGINT;
	BEGIN
		SELECT player_info_id FROM PLAYER_INFO
		INTO v_player_id
		WHERE player_name = v_player_name;
		
		IF v_player_name IS NOT NULL AND v_date_of_save IS NOT NULL THEN
			INSERT INTO SAVE_SNAPSHOTS (player_info_id, date_of_save) VALUES (v_player_id, v_date_of_save);
		ELSE
			RAISE EXCEPTION 'Invalid save snapshot information provided.';
		END IF;
	END;
$proc$;

-- create data for HEROES_JOURNEY
CREATE OR REPLACE PROCEDURE add_heroes_journey(v_save_snapshot_id in BIGINT, v_defeated_green_dragon in BOOLEAN, v_defeated_golem in BOOLEAN, 
											   v_defeated_dragon_lord in BOOLEAN, v_found_faerie_flute in BOOLEAN, v_found_lyre_of_ire in BOOLEAN, 
											  v_found_sunstone in BOOLEAN, v_found_staff_of_rain in BOOLEAN, v_found_princess_pledge in BOOLEAN, 
											  v_found_mark_of_edrick in BOOLEAN, v_found_rainbow_drop in BOOLEAN, v_found_sphere_of_light in BOOLEAN)
LANGUAGE plpgsql AS
$proc$
	BEGIN
	
		IF v_save_snapshot_id > 0 THEN
		
			INSERT INTO HEROES_JOURNEY (save_snapshot_id, defeated_green_dragon, defeated_golem, defeated_dragon_lord, found_faerie_flute, 
										found_lyre_of_ire, found_sunstone, found_staff_of_rain, found_princess_pledge, found_mark_of_edrick,
										found_rainbow_drop, found_sphere_of_light)
			VALUES (v_save_snapshot_id, v_defeated_green_dragon, v_defeated_golem, v_defeated_dragon_lord, v_found_faerie_flute, 
										v_found_lyre_of_ire, v_found_sunstone, v_found_staff_of_rain, v_found_princess_pledge, v_found_mark_of_edrick,
										v_found_rainbow_drop, v_found_sphere_of_light);
		ELSE
			RAISE EXCEPTION 'Invalid hero journey information provided.'; 
		END IF;
	END;
$proc$;