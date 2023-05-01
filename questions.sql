
-- Question 1: What items are available for sale by merchants at a particular location? 
select m.merchant_type, i.item_name, i.item_effect, i.buy_price
from MERCHANT_INVENTORY inv 
JOIN ITEMS i ON inv.item_id = i.items_id
JOIN MERCHANTS m ON inv.merchant_id = m.merchant_id
JOIN LOCATIONS l ON m.location_id = l.locations_id
WHERE l.location_name = 'Town of Kol'
ORDER BY m.merchant_type;


-- Question 2:  What items do the player have currently equipped?
select i.item_name, inv.is_equipped, e.equip_type, e.equip_slot, i.item_effect, i.sell_price, inv.quantity 
FROM PLAYER_INVENTORY inv 
JOIN ITEMS i ON inv.item_id = i.items_id
JOIN EQUIPMENT e ON e.items_id = i.items_id
JOIN PLAYER_INFO pi ON inv.player_info_id = pi.player_info_id
WHERE pi.player_name = 'Lancelot'
AND inv.is_equipped = TRUE;


-- Questions 3: What MINIONS and BOSSES are in a particular location and any related sub-locations it may have?

DROP VIEW retrieve_monsters;

-- returns each monster_id, monster_name, its assocated location_name, then an identifier as MINION or BOSS
CREATE OR REPLACE VIEW retrieve_monsters AS
	SELECT mon.monsters_id, mon.monster_name, l.location_name, ml.encounter_percentage,
		CASE 
			WHEN (SELECT min.monsters_id from MINIONS min WHERE mon.monsters_id = min.monsters_id) IS NOT NULL THEN 'MINION'
			ELSE 'BOSS'
		END AS monster_type
	FROM MONSTERS mon
	JOIN MONSTER_LOCATIONS ml ON mon.monsters_id = ml.monsters_id
	JOIN LOCATIONS l ON l.locations_id = ml.locations_id;
	
-- filter results of view to only return monsters found in a certain area
-- in this example these three locations ("Dragonlord Castle", "Dragonlord Castle Throne Room", "Destroyed Dragonlord Castle")
SELECT * FROM retrieve_monsters 
WHERE location_name LIKE '%Dragonlord%'
ORDER BY monster_type ASC;

