-- insert into LOCATIONS
START TRANSACTION;
DO
	$$BEGIN
		-- safe locations
		CALL add_location('Tantegel Castle');
		CALL add_location('Town of Tantegel');
		CALL add_location('Town of Galenholm');
		CALL add_location('Town of Kol');
		CALL add_location('Town of Rimuldar');
		CALL add_location('Town of Cantlin'); -- BOSS FIGHT with GOLEM
		CALL add_location('Rain Shrine');
		CALL add_location('Holy Sanctum');
		
		-- locations with monsters
		CALL add_location('Tantegel');
		CALL add_location('Galenholm');
		CALL add_location('Kol');
		CALL add_location('Rimuldar');
		CALL add_location('Damdara');
		CALL add_location('Cantlin');
		CALL add_location('Erdricks Cave');
		CALL add_location('Craggy Cave');
		CALL add_location('Quagmire Cave');
		CALL add_location('Quagmire Cave Grotto'); -- BOSS FIGHT with GREEN DRAGON
		CALL add_location('Galens Grave');
		CALL add_location('Dragonlord Castle');
		CALL add_location('Dragonlord Castle Throne Room'); -- BOSS FIGHT with DRAGONLORD
		CALL add_location('Destroyed Dragonlord Castle'); -- BOSS FIGHT with TRUE DRAGONLORD
	END$$;
COMMIT TRANSACTION;

-- insert data into ITEMS
START TRANSACTION;
DO
	$$BEGIN
		-- consumable items
		CALL add_item('Medicinal Herb', 'Restores 20-35 HP. One time use.', 10, 5, TRUE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);
		CALL add_item('Torch', 'Lights up dark dungeons. One time use.', 8, 4, FALSE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);
		CALL add_item('Chimaera Wing', 'Transports player back to Tantegel Castle. One time use.', 24, 12, FALSE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);
		CALL add_item('Holy Water', 'Removes weak encounters. One time use.', 12, 6, FALSE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);
		CALL add_item('Magic Key', 'Opens magically locked doors. One time use.', 32, 16, FALSE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);

		CALL add_item('Seed of Agility', 'Permanently boosts SPD by 1-3 points. One time use.', 10, 5, TRUE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);
		CALL add_item('Seed of Strength', 'Permanently boosts STR by 1-3 points. One time use.', 10, 5, TRUE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);
		CALL add_item('Seed of Resilience', 'Permanently boosts DEF by 4 points. One time use.', 10, 5, TRUE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);
		CALL add_item('Seed of Life', 'Permanently boosts maximum HP by 4-6 points. One time use.', 10, 5, TRUE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);
		CALL add_item('Seed of Magic', 'Permanently boosts maximum MP by 3-5 points. One time use.', 10, 5, TRUE, 'CONSUMABLE', 1, 'NONE', '', '', FALSE);

		-- equipment items
		-- weapons
		CALL add_item('Bamboo Spear', 'A spear made from fresh bamboo. +2 STR', 10, 5, FALSE, 'EQUIPMENT', 0, 'NONE', 'WEAPON', 'WEAPON', FALSE);
		CALL add_item('Oaken Club', 'A thick primitive club made of oak. +4 STR', 60, 30, FALSE, 'EQUIPMENT', 0, 'NONE', 'WEAPON', 'WEAPON', FALSE);
		CALL add_item('Copper Sword', 'A regular sword made of copper. +10 STR', 180, 90, FALSE, 'EQUIPMENT', 0, 'NONE', 'WEAPON', 'WEAPON', FALSE);
		CALL add_item('Iron Axe', 'A solid axe made of iron. +15 STR', 560, 280, FALSE, 'EQUIPMENT', 0, 'NONE', 'WEAPON', 'WEAPON', FALSE);
		CALL add_item('Steel Broadsword', 'A professional broadsword made of high-quality steel. +20 STR', 1500, 750, FALSE, 'EQUIPMENT', 0, 'NONE', 'WEAPON', 'WEAPON', FALSE);
		CALL add_item('Fire Sword', 'A magical sword coated in flames. +28 STR', 9800, 4900, TRUE, 'EQUIPMENT', 0, 'NONE', 'WEAPON', 'WEAPON', FALSE);
		CALL add_item('Erdricks Sword', 'A heroes sword made to drive out evil and darkness. +40 STR', 0, 0, FALSE, 'EQUIPMENT', 0, 'NONE', 'WEAPON', 'WEAPON', FALSE);
		
		-- armor
		CALL add_item('Plain Clothes', 'Normal village clothing made of cloth. +2 DEF', 10, 5, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ARMOR', FALSE);
		CALL add_item('Leather Suit', 'Leather clothing used by mercenaries. +4 DEF', 70, 35, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ARMOR', FALSE);
		CALL add_item('Chain Mail', 'Interwoven iron links forming armor and used by low ranking soldiers. +10 DEF', 300, 150, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ARMOR', FALSE);
		CALL add_item('Iron Armor', 'Iron and leather fitted together providing solid defense and flexibility. +16 DEF', 1000, 500, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ARMOR', FALSE);
		CALL add_item('Full Plate Armor', 'Steel plates fitted together to provide incredible defense, requires immense strength. +24 DEF', 3000, 1500, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ARMOR', FALSE);
		CALL add_item('Magic Armor', 'Ancient armor enchanted to aid the recovery of whomever wears it. Heals 1HP each step. +24 DEF', 7700, 3850, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ARMOR', FALSE);
		CALL add_item('Erdricks Armor', 'The armor of a hero, heals 1HP each step, immune to poison, reduce fire damage by 25%. +28 DEF', 0, 0, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ARMOR', FALSE);

		-- shields
		CALL add_item('Leather Shield', 'A primitive leather shield used by village guards. +4 DEF', 90, 45, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'SHIELD', FALSE);
		CALL add_item('Iron Shield', 'A standard iron shield used by soldiers. +10 DEF', 80, 400, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'SHIELD', FALSE);
		CALL add_item('Silver Shield', 'An ancient silver shield which has been enchanted to resist damage . +20 DEF', 14800, 7400, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'SHIELD', FALSE);
		
		-- accessories
		CALL add_item('Dragon Scale', 'A scale from a dragon, it makes you feel tougher. +2 DEF', 20, 10, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ACCESSORY', FALSE);
		CALL add_item('Warriors Ring', 'An ancient warriors ring, it fills you with new strength. +2 STR', 0, 0, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ACCESSORY', FALSE);
		
		CALL add_item('Wasterband', 'Cursed Item', 0, 180, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'ARMOR', FALSE);
		CALL add_item('Choker', 'Cursed Item.', 0, 1200, FALSE, 'EQUIPMENT', 0, 'NONE', 'ARMOR', 'HELMET', FALSE);

		-- key items
		CALL add_item('Faerie Lute', 'Induces sleep in certain enemies', 0, 0, TRUE, 'KEY_ITEM', 0, 'NONE', '', '', TRUE);
		CALL add_item('Lyre of Ire', 'Used to summon weak monsters.', 0, 0, FALSE, 'KEY_ITEM', 0, 'NONE', '', '', TRUE);
		CALL add_item('Sunstone', 'One of the three key artefacts of Erdrick. Needed to trade for the Rainbow Drop.', 0, 0, FALSE, 'KEY_ITEM', 0, 'NONE', '', '', TRUE);
		CALL add_item('Staff of Rain', 'One of the three key artefacts of Erdrick. Needed to trade for the Rainbow Drop.', 0, 0, FALSE, 'KEY_ITEM', 0, 'NONE', '', '', TRUE);
		CALL add_item('Princess Pledge', 'View how much experience you need to get to the next level.', 0, 0, FALSE, 'KEY_ITEM', 0, 'NONE', '', '', TRUE);
		CALL add_item('Mark of Erdrick', 'One of the three key artefacts of Erdrick. Needed to trade for the Rainbow Drop.', 0, 0, FALSE, 'KEY_ITEM', 0, 'NONE', '', '', TRUE);
		CALL add_item('Rainbow Drop', 'Used to make a bridge at the tip of the peninsula west of Rimuldar.', 0, 0, FALSE, 'KEY_ITEM', 0, 'NONE', '', '', TRUE);
		CALL add_item('Sphere of Light', 'Wipes all encounters from the map permanently.', 0, 0, FALSE, 'KEY_ITEM', 0, 'NONE', '', '', TRUE);
		
	END$$;
COMMIT TRANSACTION;

-- Insert data into SPELLS
START TRANSACTION;
DO
	$$BEGIN
		-- general spells
		CALL add_spells('NONE', '', 0);
		CALL add_spells('Heal', 'Restores 25-30 HP.', 3);
		CALL add_spells('Sizz', 'Shoots a fireball for 16-20 damage.', 2);
		CALL add_spells('Snooze', 'Puts a monster to sleep.', 2);
		CALL add_spells('Glow', 'Lights up dungeons. Lasts for 264 steps, Dims at 132 steps.', 2);
		CALL add_spells('Fizzle', 'Prevents monsters from casting spells.', 2);
		CALL add_spells('Evac', 'Exit instantly from a dungeon.', 6);
		CALL add_spells('Zoom', 'Warp instantly to Tantegel Castle.', 1);
		CALL add_spells('Holy Protection', 'Removes weak encounters. Lasts for 64 steps.', 2);
		CALL add_spells('Midheal', 'Restores 85-100 HP.', 8);
		CALL add_spells('Sizzle', 'Shoots a wall of fire for 50-65 damage.', 5);
		
		-- monster specific spells (dragons + bosses only)
		CALL add_spells('Fire Breath', 'Breathes fire at you for 12-20 damage.', 0);
		CALL add_spells('Torrent of Flames', 'Shoots out a torrent of flames for 16-22 damage.', 0);
		CALL add_spells('Blistering Flames', 'Belches out blistering flames for 64-72 damage.', 0);

	END$$;
COMMIT TRANSACTION;

-- insert data into PLAYER_LEVELS
START TRANSACTION;
DO
	$$BEGIN
		CALL add_player_levels('NONE', 1, 0, 0, 7, 0, 2, 0, 5, 0, 15, 0, 0);
		CALL add_player_levels('NONE', 2, 7, 2, 9, 0, 2, 0, 5, 6, 21, 0, 0);
		CALL add_player_levels('Heal', 3, 23, 2, 11, 1, 3, 2, 7, 2, 23, 4, 4);
		CALL add_player_levels('Sizz', 4, 47, 1, 12, 1, 4, 2, 9, 6, 29, 6, 10);
		CALL add_player_levels('NONE', 5, 110, 4, 16, 1, 5, 2, 11, 4, 33, 4, 14);
		CALL add_player_levels('NONE', 6, 220, 4, 20, 0, 5, 0, 11, 4, 37, 3, 17);
		CALL add_player_levels('Snooze', 7, 450, 5, 25, 3, 8, 7, 18, 1, 38, 2, 19);
		CALL add_player_levels('NONE', 8, 800, 4, 29, 2, 10, 3, 21, 5, 43, 3, 22);
		CALL add_player_levels('Glow', 9, 1300, 4, 33, 1, 11, 2, 23, 4, 47, 6, 28);
		CALL add_player_levels('Fizzle', 10, 2000, 5, 38, 4, 15, 9, 32, 3, 50, 4, 32);
		CALL add_player_levels('NONE', 11, 2900, 5, 43, 2, 17, 4, 36, 7, 57, 9, 41);
		CALL add_player_levels('Evac', 12, 4000, 8, 51, 3, 20, 5, 41, 1, 58, 7, 48);
		CALL add_player_levels('Zoom', 13, 5500, 4, 55, 4, 24, 8, 49, 7, 65, 5, 53);
		CALL add_player_levels('NONE', 14, 7500, 8, 63, 3, 27, 7, 56, 7, 72, 6, 59);
		CALL add_player_levels('Holy Protection', 15, 10000, 8, 71, 5, 32, 9, 65, 7, 79, 1, 60);
		CALL add_player_levels('NONE', 16, 13000, 4, 75, 3, 35, 6, 71, 5, 84, 21, 81);
		CALL add_player_levels('Midheal', 17, 17000, 0, 75, 4, 39, 8, 79, 8, 92, 5, 86);
		CALL add_player_levels('NONE', 18, 21000, 13, 88, 3, 42, 6, 85, 13, 105, 7, 93);
		CALL add_player_levels('Sizzle', 19, 25000, 2, 90, 1, 43, 2, 87, 14, 119, 6, 99);
		CALL add_player_levels('NONE', 20, 29000, 5, 95, 1, 44, 2, 89, 7, 126, 12, 111);
		CALL add_player_levels('NONE', 21, 33000, 5, 100, 1, 45, 2, 91, 10, 136, 7, 118);
		CALL add_player_levels('NONE', 22, 37000, 3, 103, 0, 45, 0, 91, 8, 144, 10, 128);
		CALL add_player_levels('NONE', 23, 41000, 2, 105, 2, 47, 4, 95, 6, 150, 6, 134);
		CALL add_player_levels('NONE', 24, 45000, 4, 109, 2, 49, 4, 99, 5, 155, 7, 141);
		CALL add_player_levels('NONE', 25, 49000, 10, 119, 1, 50, 2, 101, 3, 158, 0, 141);
		CALL add_player_levels('NONE', 26, 53000, 4, 123, 2, 52, 5, 106, 6, 164, 7, 148);
		CALL add_player_levels('NONE', 27, 57000, 8, 131, 1, 53, 2, 108, 8, 172, 6, 154);
		CALL add_player_levels('NONE', 28, 61000, 5, 136, 4, 57, 8, 116, 5, 177, 5, 159);
		CALL add_player_levels('NONE', 29, 65000, 5, 141, 3, 60, 5, 121, 5, 182, 9, 168);
		CALL add_player_levels('NONE', 30, 70000, 5, 146, 5, 65, 10, 131, 10, 192, 10, 178);
	END$$;
COMMIT TRANSACTION;

-- insert data into MONSTERS and MINIONS/BOSSES
START TRANSACTION;
DO
	$$BEGIN	
		-- MINIONS	
		CALL add_monsters('Slime', 3, 0, 5, 3, 15, 1, 1, 'Tantegel', 40, FALSE);
		CALL add_monsters('She-slime', 4, 0, 7, 3, 15, 1, 2,'Tantegel', 40, FALSE);
		CALL add_monsters('Metal Slime', 3, 8, 10, 255, 255, 775, 6,'Damdara', 20, FALSE);
		
		CALL add_monsters('Dracky', 6, 0, 9, 6, 15, 2, 2,'Tantegel', 50, FALSE);
		CALL add_monsters('Drackolyte', 15, 8, 14, 14, 15, 5, 12,'Craggy Cave,Galenholm,Kol', 50, FALSE);
		CALL add_monsters('Drackyma', 20, 10, 22, 22, 32, 11, 20,'Cragg Cave, Galens Grave', 50, FALSE);
		
		CALL add_monsters('Lunatick', 22, 0, 22, 18, 15, 7, 16,'Craggy Cave,Quagmire Cave', 50, FALSE);
		CALL add_monsters('Raving Lunatick', 35, 30, 47, 40, 240, 20, 85,'Galens Grave', 50, FALSE);
		
		CALL add_monsters('Scorpion', 20, 0, 18, 15, 16, 6, 16,'Quagmire Cave,Galenholm,Kol', 50, FALSE);
		CALL add_monsters('Iron Scorpion', 22, 0, 36, 15, 42, 14, 40,'Rimuldar,Craggy Cave,Galens Grave', 50, FALSE);
		CALL add_monsters('Death Scorpion', 35, 0, 60, 127, 90, 26, 110,'Damdara', 50, FALSE);
		
		CALL add_monsters('Prestidigitator', 12, 8, 11, 12, 15, 4, 11,'Quagmire Cave,Erdricks Cave,Galenholm,Kol', 50, FALSE);
		CALL add_monsters('Ledgerman', 30, 10, 28, 49, 14, 22, 35,'Rimuldar,Craggy Cave,Galens Grave', 50, FALSE);
		CALL add_monsters('Vis Mager', 65, 16, 80, 70, 247, 50, 65,'Cantlin,Dragonlord Castle,Damdara', 50, FALSE);
		
		CALL add_monsters('Drohl Drone', 25, 0, 24, 24, 14, 10, 25,'Craggy Cave', 50, FALSE);
		CALL add_monsters('Drohl Diabolist', 38, 10, 52, 50, 34, 22, 90,'Galens Grave', 50, FALSE);
		
		CALL add_monsters('Ghost', 7, 0, 11, 8, 15, 3, 4,'Quagmire Cave,Tantegel,Galenholm,Kol', 50, FALSE);
		CALL add_monsters('Fightgeist', 23, 10, 18, 15, 20, 7, 18,'Craggy Cave,Galens Grave', 50, FALSE);
		CALL add_monsters('Spitegeist', 36, 14, 40, 38, 49, 18, 70,'Galens Grave', 50, FALSE);
		
		CALL add_monsters('Chimaera', 42, 2, 56, 48, 79, 24, 100,'Damdara,Craggy Cave,Rimuldar', 50, FALSE);
		CALL add_monsters('Hocus Chimaera', 58, 12, 78, 68, 32, 34, 140,'Cantlin,Damdara', 50, FALSE);
		CALL add_monsters('Cosmic Chimaera', 65, 18, 86, 80, 128, 43, 160,'Cantlin,Damdara,Dragonlord Castle', 50, FALSE);
		
		CALL add_monsters('Bewarewolf', 34, 0, 40, 30, 31, 16, 45, 'Rimuldar', 50, FALSE);
		CALL add_monsters('Scarewolf', 38, 6, 50, 36, 71, 20, 80, 'Damdara,Rimuldar,Galens Grave', 50, FALSE);
		CALL add_monsters('Tearwolf', 60, 0, 86, 70, 127, 40, 155,'Cantlin,Damdara,Dragonlord Castle', 50, FALSE);
		
		CALL add_monsters('Knight Errant', 55, 8, 76, 78, 103, 33, 150,'Damdara', 50, FALSE);
		CALL add_monsters('Knight Aberrant', 70, 4, 94, 82, 243, 54, 165,'Dragonlord Castle,Damdara', 50, FALSE);
		CALL add_monsters('Knight Abhorrent', 90, 13, 105, 86, 147, 70, 140,'Dragonlord Castle', 50, FALSE);
		
		CALL add_monsters('Skeleton', 30, 0, 28, 22, 15, 11, 30,'Rimuldar,Craggy Cave,Galens Grave', 50, FALSE);
		CALL add_monsters('Skeleton Scrapper', 36, 9, 44, 34, 112, 17, 60,'Damdara,Rimuldar', 50, FALSE);
		CALL add_monsters('Skeleton Soldier', 46, 12, 68, 56, 80, 28, 120,'Damdara,Galens Grave', 50, FALSE);
		CALL add_monsters('Dark Skeleton', 50, 0, 79, 64, 255, 37, 150,'Damdara', 50, FALSE);
		
		CALL add_monsters('Gold Golem', 50, 0, 48, 40, 223, 6, 210,'Craggy Cave,Damdara,Rimuldar', 50, FALSE);
		CALL add_monsters('Stone Golem', 160, 0, 100, 40, 47, 65, 140,'Dragonlords Castle', 50, FALSE);
		
		CALL add_monsters('Green Dragon', 65, 0, 88, 74, 127, 45, 110,'Cantlin,Dragonlord Castle,Damdara', 50, FALSE);
		CALL add_monsters('Blue Dragon', 70, 0, 98, 84, 255, 60, 150,'Dragonlord Castle', 50, FALSE);
		CALL add_monsters('Dread Dragon', 100, 4, 120, 90, 247, 100, 140,'Dragonlord Castle', 50, FALSE);

		-- bosses
		CALL add_monsters('Golem', 150, 0, 120, 60, 255, 2500, 10,'Cantlin', 50, TRUE);
		CALL add_monsters('Ancient Green Dragon', 150, 0, 88, 74, 127, 950, 250,'Quagmire Cave', 50, TRUE);
		CALL add_monsters('Dragonlord', 100, 40, 120, 75, 200, 0, 0,'Dragonlord Castle', 50, TRUE);
		CALL add_monsters('True Dragonlord', 200, 0, 150, 100, 255, 0, 0,'Dragonlord Castle', 50, TRUE);
	END$$;
COMMIT TRANSACTION;


-- insert data into MONSTER_LOCATIONS 
START TRANSACTION;
DO
	$$BEGIN
		-- Tantegel
		CALL add_monster_to_location('Slime', 'Tantegel', 40.00);
		CALL add_monster_to_location('She-slime', 'Tantegel', 20.00);
		CALL add_monster_to_location('Dracky', 'Tantegel', 20.00);
		CALL add_monster_to_location('Ghost', 'Tantegel', 20.00);

		-- Galenholm
		CALL add_monster_to_location('Drackolyte', 'Galenholm', 37.50);
		CALL add_monster_to_location('Prestidigitator', 'Galenholm', 20.00);
		CALL add_monster_to_location('Scorpion', 'Galenholm', 22.50);
		CALL add_monster_to_location('Ghost', 'Galenholm', 20.00);

		-- Kol
		CALL add_monster_to_location('Drackolyte', 'Galenholm', 22.50);
		CALL add_monster_to_location('Prestidigitator', 'Galenholm', 30.00);
		CALL add_monster_to_location('Scorpion', 'Galenholm', 37.50);
		CALL add_monster_to_location('Ghost', 'Galenholm', 10.00);
		
		-- Rimuldar
		CALL add_monster_to_location('Iron Scorpion', 'Rimuldar', 15.00);
		CALL add_monster_to_location('Ledgerman', 'Rimuldar', 10.00);
		CALL add_monster_to_location('Chimaera', 'Rimuldar', 15.00);
		CALL add_monster_to_location('Bewarewolf', 'Rimuldar', 20.00);
		CALL add_monster_to_location('Scarewolf', 'Rimuldar', 10.00);
		CALL add_monster_to_location('Skeleton', 'Rimuldar', 20.00);
		CALL add_monster_to_location('Skeleton Scrapper', 'Rimuldar', 5.00);
		CALL add_monster_to_location('Gold Golem', 'Rimuldar', 5.00);

		-- Damdara
		CALL add_monster_to_location('Metal Slime', 'Damdara', 3.00);
		CALL add_monster_to_location('Death Scorpion', 'Damdara', 7.00);
		CALL add_monster_to_location('Chimaera', 'Damdara', 5.00);
		CALL add_monster_to_location('Hocus Chimaera', 'Damdara', 10.00);
		CALL add_monster_to_location('Cosmic Chimaera', 'Damdara', 5.00);
		CALL add_monster_to_location('Vis Mager', 'Damdara', 5.00);
		CALL add_monster_to_location('Scarewolf', 'Damdara', 10.00);
		CALL add_monster_to_location('Tearwolf', 'Damdara', 5.00);
		CALL add_monster_to_location('Knight Errant', 'Damdara', 18.00);
		CALL add_monster_to_location('Skeleton Scrapper', 'Damdara', 10.00);
		CALL add_monster_to_location('Skeleton Soldier', 'Damdara', 5.00);
		CALL add_monster_to_location('Dark Skeleton', 'Damdara', 5.00);
		CALL add_monster_to_location('Gold Golem', 'Damdara', 2.00);
		CALL add_monster_to_location('Green Dragon', 'Damdara', 10.00);

		-- Cantlin
		CALL add_monster_to_location('Vis Mager', 'Cantlin', 15.00);
		CALL add_monster_to_location('Hocus Chimaera', 'Cantlin', 25.00);
		CALL add_monster_to_location('Cosmic Chimaera', 'Cantlin', 15.00);
		CALL add_monster_to_location('Tearwolf', 'Cantlin', 35.00);
		CALL add_monster_to_location('Green Dragon', 'Cantlin', 10.00);
		
		-- Cantlin Town (BOSS Area)
		CALL add_monster_to_location('Golem', 'Cantlin', 100.00);

		-- Erdricks Cave
		CALL add_monster_to_location('Prestidigitator', 'Erdricks Cave', 50.00);
		CALL add_monster_to_location('Ghost', 'Erdricks Cave', 50.00);

		-- Craggy Cave
		CALL add_monster_to_location('Drackolyte', 'Craggy Cave', 15.00);
		CALL add_monster_to_location('Lunatick', 'Craggy Cave', 15.00);
		CALL add_monster_to_location('Iron Scorpion', 'Craggy Cave', 5.00);
		CALL add_monster_to_location('Ledgerman', 'Craggy Cave', 10.00);
		CALL add_monster_to_location('Drohl Drone', 'Craggy Cave', 16.00);
		CALL add_monster_to_location('Fightgeist', 'Craggy Cave', 5.00);
		CALL add_monster_to_location('Chimaera', 'Craggy Cave', 15.00);
		CALL add_monster_to_location('Skeleton', 'Craggy Cave', 15.00);
		CALL add_monster_to_location('Gold Golem', 'Craggy Cave', 4.00);

		-- Quagmire Cave
		CALL add_monster_to_location('Lunatick', 'Quagmire Cave', 35.00);
		CALL add_monster_to_location('Scorpion', 'Quagmire Cave', 15.00);
		CALL add_monster_to_location('Prestidigitator', 'Quagmire Cave', 25.00);
		CALL add_monster_to_location('Ghost', 'Quagmire Cave', 25.00);
		
		-- Quagmire Cave Grotto (BOSS Area)
		CALL add_monster_to_location('Ancient Green Dragon', 'Quagmire Cave Grotto', 100.00);

		-- Galens Grave
		CALL add_monster_to_location('Drackyma', 'Galens Grave', 10.00);
		CALL add_monster_to_location('Raving Lunatick', 'Galens Grave', 10.00);
		CALL add_monster_to_location('Iron Scorpion', 'Galens Grave', 10.00);
		CALL add_monster_to_location('Ledgerman', 'Galens Grave', 10.00);
		CALL add_monster_to_location('Drohl Diabolist', 'Galens Grave', 15.00);
		CALL add_monster_to_location('Fightgeist', 'Galens Grave', 15.00);
		CALL add_monster_to_location('Spitegeist', 'Galens Grave', 5.00);
		CALL add_monster_to_location('Scarewolf', 'Galens Grave', 10.00);
		CALL add_monster_to_location('Skeleton', 'Galens Grave', 10.00);
		CALL add_monster_to_location('Skeleton Soldier', 'Galens Grave', 5.00);

		-- Dragonlord Castle
		CALL add_monster_to_location('Vis Mager', 'Dragonlord Castle', 10.00);
		CALL add_monster_to_location('Cosmic Chimaera', 'Dragonlord Castle', 10.00);
		CALL add_monster_to_location('Tearwolf', 'Dragonlord Castle', 15.00);
		CALL add_monster_to_location('Knight Aberrant', 'Dragonlord Castle', 5.00);
		CALL add_monster_to_location('Knight Abhorrent', 'Dragonlord Castle', 15.00);
		CALL add_monster_to_location('Green Dragon', 'Dragonlord Castle', 10.00);
		CALL add_monster_to_location('Blue Dragon', 'Dragonlord Castle', 20.00);
		CALL add_monster_to_location('Dread Dragon', 'Dragonlord Castle', 15.00);
		
		-- Dragonlord Castle Throne 
		CALL add_monster_to_location('Dragonlord', 'Dragonlord Castle Throne Room', 100.00);
		
		-- Destroyed Dragonlord Castle
		CALL add_monster_to_location('True Dragonlord', 'Destroyed Dragonlord Castle', 100.00);

	END$$;
COMMIT TRANSACTION;

-- insert into MERCHANTS
START TRANSACTION;
DO
	$$BEGIN
		-- merchants in Tantegel
		CALL add_merchant('EQUIPMENT', 'Town of Tantegel');
		CALL add_merchant('ITEM', 'Town of Tantegel');
		CALL add_merchant('HOLY WATER', 'Town of Tantegel');

		-- merchants in Galenholm
		CALL add_merchant('EQUIPMENT', 'Town of Galenholm');
		CALL add_merchant('ITEM', 'Town of Galenholm');
		
		-- merchants in Kol
		CALL add_merchant('EQUIPMENT', 'Town of Kol');
		CALL add_merchant('ITEM', 'Town of Kol');
		
		-- merchants in Rimuldar
		CALL add_merchant('EQUIPMENT', 'Town of Rimuldar');
		CALL add_merchant('ITEM', 'Town of Rimuldar');
		CALL add_merchant('MAGIC KEY', 'Town of Rimuldar');
		
		
		-- merchants in Cantlin
		CALL add_merchant('EQUIPMENT', 'Town of Cantlin');
		CALL add_merchant('MAGIC KEY', 'Town of Cantlin');
		CALL add_merchant('HOLY WATER', 'Town of Cantlin');
	END$$;
COMMIT TRANSACTION;


-- insert into MERCHANT_INVENTORY
START TRANSACTION;
DO
	$$BEGIN
				
		-- Tantegel Merchant inventory
		CALL add_to_inventory('Bamboo Spear', 'EQUIPMENT', 'Town of Tantegel', 0, NULL, FALSE);
		CALL add_to_inventory('Oaken Club', 'EQUIPMENT', 'Town of Tantegel', 0, NULL, FALSE);
		CALL add_to_inventory('Copper Sword', 'EQUIPMENT', 'Town of Tantegel', 0, NULL, FALSE);
		CALL add_to_inventory('Plain Clothes', 'EQUIPMENT', 'Town of Tantegel', 0, NULL, FALSE);
		CALL add_to_inventory('Leather Suit', 'EQUIPMENT', 'Town of Tantegel', 0, NULL, FALSE);
		CALL add_to_inventory('Leather Shield', 'EQUIPMENT', 'Town of Tantegel', 0, NULL, FALSE);
		CALL add_to_inventory('Medicinal Herb', 'ITEM', 'Town of Tantegel', 0, NULL, FALSE);
		CALL add_to_inventory('Torch', 'ITEM', 'Town of Tantegel', 0, NULL, FALSE);
		CALL add_to_inventory('Dragon Scale', 'ITEM', 'Town of Tantegel', 0, NULL, FALSE);
		CALL add_to_inventory('Holy Water', 'HOLY WATER', 'Town of Tantegel', 0, NULL, FALSE);
		
		-- Galenholm Merchant inventory
		CALL add_to_inventory('Oaken Club', 'EQUIPMENT', 'Town of Galenholm', 0, NULL, FALSE);
		CALL add_to_inventory('Copper Sword', 'EQUIPMENT', 'Town of Galenholm', 0, NULL, FALSE);
		CALL add_to_inventory('Iron Axe', 'EQUIPMENT', 'Town of Galenholm', 0, NULL, FALSE);
		CALL add_to_inventory('Leather Suit', 'EQUIPMENT', 'Town of Galenholm', 0, NULL, FALSE);
		CALL add_to_inventory('Chain Mail', 'EQUIPMENT', 'Town of Galenholm', 0, NULL, FALSE);
		CALL add_to_inventory('Iron Shield', 'EQUIPMENT', 'Town of Galenholm', 0, NULL, FALSE);
		CALL add_to_inventory('Medicinal Herb', 'ITEM', 'Town of Galenholm', 0, NULL, FALSE);
		CALL add_to_inventory('Torch', 'ITEM', 'Town of Galenholm', 0, NULL, FALSE);
		CALL add_to_inventory('Dragon Scale', 'ITEM', 'Town of Galenholm', 0, NULL, FALSE);
		
		-- Kol Merchant inventory
		CALL add_to_inventory('Oaken Club', 'EQUIPMENT', 'Town of Kol', 0, NULL, FALSE);
		CALL add_to_inventory('Copper Sword', 'EQUIPMENT', 'Town of Kol', 0, NULL, FALSE);
		CALL add_to_inventory('Iron Axe', 'EQUIPMENT', 'Town of Kol', 0, NULL, FALSE);
		CALL add_to_inventory('Iron Armor', 'EQUIPMENT', 'Town of Kol', 0, NULL, FALSE);
		CALL add_to_inventory('Full Plate Armor', 'EQUIPMENT', 'Town of Kol', 0, NULL, FALSE);
		CALL add_to_inventory('Leather Shield', 'EQUIPMENT', 'Town of Kol', 0, NULL, FALSE);
		CALL add_to_inventory('Medicinal Herb', 'ITEM', 'Town of Kol', 0, NULL, FALSE);
		CALL add_to_inventory('Torch', 'ITEM', 'Town of Kol', 0, NULL, FALSE);
		CALL add_to_inventory('Dragon Scale', 'ITEM', 'Town of Kol', 0, NULL, FALSE);
		CALL add_to_inventory('Chimaera Wing', 'ITEM', 'Town of Kol', 0, NULL, FALSE);

		-- Rimuldar Merchant inventory
		CALL add_to_inventory('Copper Sword', 'EQUIPMENT', 'Town of Rimuldar', 0, NULL, FALSE);
		CALL add_to_inventory('Iron Axe', 'EQUIPMENT', 'Town of Rimuldar', 0, NULL, FALSE);
		CALL add_to_inventory('Steel Broadsword', 'EQUIPMENT', 'Town of Rimuldar', 0, NULL, FALSE);
		CALL add_to_inventory('Iron Armor', 'EQUIPMENT', 'Town of Rimuldar', 0, NULL, FALSE);
		CALL add_to_inventory('Full Plate Armor', 'EQUIPMENT', 'Town of Rimuldar', 0, NULL, FALSE);
		CALL add_to_inventory('Magic Armor', 'EQUIPMENT', 'Town of Rimuldar', 0, NULL, FALSE);
		CALL add_to_inventory('Medicinal Herb', 'ITEM', 'Town of Rimuldar', 0, NULL, FALSE);
		CALL add_to_inventory('Torch', 'ITEM', 'Town of Rimuldar', 0, NULL, FALSE);
		CALL add_to_inventory('Chimaera Wing', 'ITEM', 'Town of Rimuldar', 0, NULL, FALSE);
		CALL add_to_inventory('Magic Key', 'MAGIC KEY', 'Town of Rimuldar', 0, NULL, FALSE);

		-- Cantlin Merchant inventory
		CALL add_to_inventory('Fire Sword', 'EQUIPMENT', 'Town of Cantlin', 0, NULL, FALSE);
		CALL add_to_inventory('Silver Shield', 'EQUIPMENT', 'Town of Cantlin', 0, NULL, FALSE);
		CALL add_to_inventory('Holy Water', 'HOLY WATER', 'Town of Cantlin', 0, NULL, FALSE);
		CALL add_to_inventory('Magic Key', 'MAGIC KEY', 'Town of Cantlin', 0, NULL, FALSE);

	END$$;
COMMIT TRANSACTION;



-- insert into MONSTER_SPELLS
START TRANSACTION;
DO
	$$BEGIN	
		CALL add_spell_to_player_monster('Sizz', NULL, 'Prestidigitator', FALSE, 100);
		CALL add_spell_to_player_monster('Sizz', NULL, 'Drackolyte', FALSE, 100);
		CALL add_spell_to_player_monster('Sizz', NULL, 'Fightgeist', FALSE, 100);
		CALL add_spell_to_player_monster('Sizz', NULL, 'Drackyma', FALSE, 100);
		CALL add_spell_to_player_monster('Sizz', NULL, 'Ledgerman', FALSE, 100);
		CALL add_spell_to_player_monster('Sizz', NULL, 'Spitegeist', FALSE, 100);
		CALL add_spell_to_player_monster('Sizz', NULL, 'Raving Lunatick', FALSE, 100);
		CALL add_spell_to_player_monster('Sizz', NULL, 'Hocus Chimaera', FALSE, 100);
		CALL add_spell_to_player_monster('Sizz', NULL, 'Metal Slime', FALSE, 100);

		CALL add_spell_to_player_monster('Heal', NULL, 'Drackyma', FALSE, 100);
		CALL add_spell_to_player_monster('Heal', NULL, 'Skeleton Scrapper', FALSE, 100);
		CALL add_spell_to_player_monster('Heal', NULL, 'Raving Lunatick', FALSE, 100);
		CALL add_spell_to_player_monster('Heal', NULL, 'Skeleton Soldier', FALSE, 100);
		CALL add_spell_to_player_monster('Heal', NULL, 'Hocus Chimaera', FALSE, 100);

		CALL add_spell_to_player_monster('Snooze', NULL, 'Ledgerman', FALSE, 50);
		CALL add_spell_to_player_monster('Snooze', NULL, 'Spitegeist', FALSE, 50);
		CALL add_spell_to_player_monster('Snooze', NULL, 'Drohl Diabolist', FALSE, 50);
		CALL add_spell_to_player_monster('Snooze', NULL, 'Hocus Chimaera', FALSE, 50);
		CALL add_spell_to_player_monster('Snooze', NULL, 'Knight Aberrant', FALSE, 50);
		CALL add_spell_to_player_monster('Snooze', NULL, 'Dragonlord', FALSE, 50);

		CALL add_spell_to_player_monster('Midheal', NULL, 'Cosmic Chimaera', FALSE, 100);
		CALL add_spell_to_player_monster('Midheal', NULL, 'Knight Abhorrent', FALSE, 100);
		CALL add_spell_to_player_monster('Midheal', NULL, 'Dragonlord', FALSE, 100);

		CALL add_spell_to_player_monster('Sizzle', NULL, 'Vis Mager', FALSE, 100);
		CALL add_spell_to_player_monster('Sizzle', NULL, 'Knight Abhorrent', FALSE, 100);
		CALL add_spell_to_player_monster('Sizzle', NULL, 'Dragonlord', FALSE, 100);
	
		CALL add_spell_to_player_monster('Fire Breath', NULL, 'Cosmic Chimaera', FALSE, 100);
		CALL add_spell_to_player_monster('Fire Breath', NULL, 'Green Dragon', FALSE, 100);
		CALL add_spell_to_player_monster('Fire Breath', NULL, 'Ancient Green Dragon', FALSE, 100);
		CALL add_spell_to_player_monster('Fire Breath', NULL, 'Blue Dragon', FALSE, 100);
		CALL add_spell_to_player_monster('Fire Breath', NULL, 'Dread Dragon', FALSE, 100);
		CALL add_spell_to_player_monster('Fire Breath', NULL, 'True Dragonlord', FALSE, 100);

		CALL add_spell_to_player_monster('Torrent of Flames', NULL, 'True Dragonlord', FALSE, 100);
				
		CALL add_spell_to_player_monster('Blistering Flames', NULL, 'True Dragonlord', FALSE, 100);
	END$$;
COMMIT TRANSACTION;

-- insert into PLAYER_INFO
START TRANSACTION;
DO
	$$BEGIN	
		CALL add_player_info('Tantegel Castle','Newbie', 1, 15, 15, 0, 0, 7, 9, 2, 4, 5, 5, 0, 0);
		CALL add_player_info('Cantlin','Lancelot', 10, 50, 50, 32, 32, 38, 55, 15, 41, 32, 32, 2000, 1583);
		CALL add_player_info('Destroyed Dragonlord Castle','Gawain', 25, 158, 158, 141, 141, 119, 161, 50, 98, 101, 101, 49000, 6827);
	END$$;
COMMIT TRANSACTION;


-- insert into SAVE_SNAPSHOTS
START TRANSACTION;
DO
	$$BEGIN	
		CALL add_save_snapshots('Newbie', '2023-04-11');
		CALL add_save_snapshots('Lancelot', '2023-03-02');
		CALL add_save_snapshots('Gawain', '2023-02-11');
	END$$;
COMMIT TRANSACTION;


-- insert into HEROES_JOURNEY
START TRANSACTION;
DO
	$$BEGIN
		-- related to SAVE_SNAPSHOT for 'Newbie' (just started the game)
		CALL add_heroes_journey(1, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE);
		-- related to SAVE_SNAPSHOT for 'Lancelot' (in the middle of the game)
		CALL add_heroes_journey(2, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE);
		-- related to SAVE_SNAPSHOT for 'Gawain' (completed the game)
		CALL add_heroes_journey(3, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE);
	END$$;
COMMIT TRANSACTION;


-- insert into PLAYER_INVENTORY
START TRANSACTION;
DO
	$$BEGIN
		-- inventory for 'Newbie' player
		-- equipment
		CALL add_to_inventory('Bamboo Spear', NULL, NULL, 1, 'Newbie', TRUE);
		CALL add_to_inventory('Medicinal Herb', NULL, NULL, 1, 'Newbie', TRUE);
		CALL add_to_inventory('Plain Clothes', NULL, NULL, 1, 'Newbie', TRUE);
		-- consumables
		CALL add_to_inventory('Medicinal Herb', NULL, NULL, 3, 'Newbie', FALSE);


		-- inventory for 'Lancelot' player
		-- equipment
		CALL add_to_inventory('Iron Axe', NULL, NULL, 1, 'Lancelot', TRUE);
		CALL add_to_inventory('Iron Armor', NULL, NULL, 1, 'Lancelot', TRUE);
		CALL add_to_inventory('Iron Shield', NULL, NULL, 1, 'Lancelot', TRUE);		
		CALL add_to_inventory('Warriors Ring', NULL, NULL, 1, 'Lancelot', TRUE);
		CALL add_to_inventory('Bamboo Spear', NULL, NULL, 1, 'Lancelot', FALSE); -- old weapon in inventory, but not equipped
		-- consumables
		CALL add_to_inventory('Medicinal Herb', NULL, NULL, 9, 'Lancelot', FALSE);
		CALL add_to_inventory('Torch', NULL, NULL, 4, 'Lancelot', FALSE);
		CALL add_to_inventory('Holy Water', NULL, NULL, 2, 'Lancelot', FALSE);
		CALL add_to_inventory('Magic Key', NULL, NULL, 6, 'Lancelot', FALSE);
		-- key items
		CALL add_to_inventory('Faerie Lute', NULL, NULL, 1, 'Lancelot', FALSE);
		CALL add_to_inventory('Lyre of Ire', NULL, NULL, 1, 'Lancelot', FALSE);
		CALL add_to_inventory('Sunstone', NULL, NULL, 1, 'Lancelot', FALSE);
		CALL add_to_inventory('Staff of Rain', NULL, NULL, 1, 'Lancelot', FALSE);
		CALL add_to_inventory('Princess Pledge', NULL, NULL, 1, 'Lancelot', FALSE);
		
		-- inventory for 'Gawain' player
		-- equipment
		CALL add_to_inventory('Erdricks Sword', NULL, NULL, 1, 'Gawain', TRUE);
		CALL add_to_inventory('Erdricks Armor', NULL, NULL, 1, 'Gawain', TRUE);
		CALL add_to_inventory('Silver Shield', NULL, NULL, 1, 'Gawain', TRUE);
		CALL add_to_inventory('Warriors Ring', NULL, NULL, 1, 'Gawain', TRUE);
		-- old weapons and armor in inventory, but not equipped	
		CALL add_to_inventory('Magic Armor', NULL, NULL, 1, 'Gawain', FALSE);
		CALL add_to_inventory('Fire Sword', NULL, NULL, 1, 'Gawain', FALSE);
		CALL add_to_inventory('Iron Shield', NULL, NULL, 2, 'Gawain', FALSE);
		-- consumables
		CALL add_to_inventory('Medicinal Herb', NULL, NULL, 11, 'Gawain', FALSE);
		CALL add_to_inventory('Chimaera Wing', NULL, NULL, 2, 'Gawain', FALSE);
		CALL add_to_inventory('Torch', NULL, NULL, 4, 'Gawain', FALSE);
		CALL add_to_inventory('Holy Water', NULL, NULL, 4, 'Gawain', FALSE);
		CALL add_to_inventory('Magic Key', NULL, NULL, 6, 'Gawain', FALSE);
		-- key items 
		-- lyre traded for staff of rain; sunstone, staff of rain, and mark of erdrick traded for rainbow drop
		-- rainbow drop is one time use item to access final boss
		CALL add_to_inventory('Faerie Lute', NULL, NULL, 1, 'Lancelot', FALSE);
		CALL add_to_inventory('Sphere of Light', NULL, NULL, 1, 'Lancelot', FALSE);
		
	END$$;
COMMIT TRANSACTION;


-- insert into PLAYER_SPELLS
START TRANSACTION;
DO
	$$BEGIN
	
		-- no spells for player 'Newbie' who is at Level 1, since the first spell is learned at level 3
	
		-- spells for player 'Lancelot'
		CALL add_spell_to_player_monster('Heal','Lancelot',NULL,TRUE,100);
		CALL add_spell_to_player_monster('Sizz','Lancelot',NULL,TRUE,100);
		CALL add_spell_to_player_monster('Snooze','Lancelot',NULL,TRUE,100);
		CALL add_spell_to_player_monster('Glow','Lancelot',NULL,FALSE,100);
		CALL add_spell_to_player_monster('Fizzle','Lancelot',NULL,TRUE,100);

		-- spells for player 'Gawain'
		CALL add_spell_to_player_monster('Heal','Gawain',NULL,TRUE,100);
		CALL add_spell_to_player_monster('Sizz','Gawain',NULL,TRUE,100);
		CALL add_spell_to_player_monster('Snooze','Gawain',NULL,TRUE,100);
		CALL add_spell_to_player_monster('Glow','Gawain',NULL,FALSE,100);
		CALL add_spell_to_player_monster('Fizzle','Gawain',NULL,TRUE,100);
		CALL add_spell_to_player_monster('Evac','Gawain',NULL,FALSE,100);
		CALL add_spell_to_player_monster('Zoom','Gawain',NULL,FALSE,100);
		CALL add_spell_to_player_monster('Holy Protection','Gawain',NULL,FALSE,100);
		CALL add_spell_to_player_monster('Midheal','Gawain',NULL,TRUE,100);
		CALL add_spell_to_player_monster('Sizzle','Gawain',NULL,TRUE,100);								   
									   
	END$$;
COMMIT TRANSACTION;


--------------------------------------------------------------
-- Template
-- insert into TABLE_NAME
-- START TRANSACTION;
-- DO
-- 	$$BEGIN
-- 		CALL procedure_name()

-- 	END$$;
-- COMMIT TRANSACTION;
