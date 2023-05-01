
-- determine which monsters? or locations are the most effective for grinding experience
-- (monster_hp / (player_str - monster_def) * (monster_exp) * encounter_percentage 
-- monsters that can be killed in one hit


-- MONSTERS (only minions), MONSTER_LOCATIONS, PLAYER_INFO

-- 1. find monsters that can be killed in one hit (monster_hp / (player_str - monster_def)
-- 2. with that list of monsters multiple their exp by encounter_percentage to get how much exp average exp you get per encounter
-- 3. group by location?

-- represent as multi-bar graph by location

-- using a provided player_info player_name attribute value, determine which locations would be the most effective places to get experience as quickly as possibe. 
select lo.location_name, SUM(monster_grind.weighted_exp_value) as weighted_exp_average, SUM(monster_grind.weighted_gold_value) as weighted_gold_average
from (
	select mo.monsters_id, mo.monster_name, mo.experience, mo.gold_dropped, ml.locations_id,
		ROUND(mo.experience * (ml.encounter_percentage / 100), 2) as weighted_exp_value, 
		ROUND(mo.gold_dropped * (ml.encounter_percentage / 100), 2) as weighted_gold_value,
		CASE
			WHEN ROUND(((pi.str_with_equip - mo.monster_def) / mo.monster_hp), 2) > 1 THEN TRUE
			WHEN ROUND(((pi.str_with_equip - mo.monster_def) / mo.monster_hp), 2) BETWEEN 0.5 AND 1 THEN TRUE
			ELSE FALSE
		END as easy_battle
	from player_info pi, monsters mo
	join minions mi on mo.monsters_id = mi.monsters_id
	join monster_locations ml on ml.monsters_id = mo.monsters_id
	where pi.player_name = 'Gawain' -- other values are 'Newbie' and 'Lancelot'
) as monster_grind
join locations lo on lo.locations_id = monster_grind.locations_id
where monster_grind.easy_battle = TRUE
group by location_name;


-----------------------
-- VISUALIZATION 1
-----------------------
-- using a provided player_info player_name attribute value, determine which locations would be the most effective places to get experience as quickly as possibe. 
select lo.location_name, SUM(monster_grind.weighted_exp_value) as weighted_exp_average, SUM(monster_grind.weighted_gold_value) as weighted_gold_average
from (
	select mo.monsters_id, mo.monster_name, mo.experience, mo.gold_dropped, ml.locations_id,
		ROUND(mo.experience * (ml.encounter_percentage / 100), 2) as weighted_exp_value, 
		ROUND(mo.gold_dropped * (ml.encounter_percentage / 100), 2) as weighted_gold_value,
		CASE
			WHEN ROUND(((pi.str_with_equip - mo.monster_def) / mo.monster_hp), 2) > 1 THEN TRUE
			WHEN ROUND(((pi.str_with_equip - mo.monster_def) / mo.monster_hp), 2) BETWEEN 0.5 AND 1 THEN TRUE
			ELSE FALSE
		END as easy_battle
	from player_info pi, monsters mo
	join minions mi on mo.monsters_id = mi.monsters_id
	join monster_locations ml on ml.monsters_id = mo.monsters_id
	where pi.player_name = 'Gawain'
) as monster_grind
join locations lo on lo.locations_id = monster_grind.locations_id
where monster_grind.easy_battle = TRUE
group by location_name;


select * from player_info;

-----------------------
-- VISUALIZATION 2
-----------------------
-- return a list of all significant 'levels' for the player where they either 
-- learn a spell or have a total stat gain greater than or equal to 30
select pl.level, 
	SUM(pl.str_gain + pl.def_gain + pl.spd_gain +  pl.hp_gain + pl.mp_gain) as total_stat_gain_for_level, 
	sp.spell_name as spell_learned_at_level
from player_levels pl
join spells sp on pl.unlocked_spell_id = sp.spells_id
where (pl.str_gain + pl.def_gain + pl.spd_gain +  pl.hp_gain + pl.mp_gain) >= 30 or sp.spell_name <> 'NONE'
group by sp.spell_name, pl.level, pl.exp_needed
order by pl.level;

select * from player_levels;
