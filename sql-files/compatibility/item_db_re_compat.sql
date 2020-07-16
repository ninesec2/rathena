#
# View structure for view `item_db_re_compat`
#

DROP VIEW IF EXISTS `item_db_re_compat`;
CREATE VIEW `item_db_re_compat` AS (
	SELECT
		`id`,
		`name_aegis` AS `name_english`,
		`name_english` AS `name_japanese`,
		case
			when `type` = 'Healing' then
				0
			when `type` = 'Usable' then
				2
			when `type` = 'Etc' then
				3
			when `type` = 'Armor' then
				4
			when `type` = 'Weapon' then
				5
			when `type` = 'Card' then
				6
			when `type` = 'Petegg' then
				7
			when `type` = 'Petarmor' then
				8
			when `type` = 'Ammo' then
				10
			when `type` = 'Delayconsume' then
				11
			when `type` = 'Shadowgear' then
				12
			when `type` = 'Cash' then
				18
			else
				3 -- etc
		end as `type`,
		`price_buy`,
		case
			when `price_sell` > 0 then
				`price_sell`
			else
				`price_buy` / 2
		end as `price_sell`,
		`weight`,
		case
			when `attack` > 0 and `magic_attack` > 0 then
				CONCAT( `attack`, ':', `magic_attack` )
			when `attack` > 0 then
				`attack`
			when `magic_attack` > 0 then
				CONCAT( '0:', `magic_attack` )
			else
				null
		end as `atk:matk`,
		`defense` as `defence`,
		`range`,
		`slots`,
		case
			when `job_all` > 0 then
				0xFFFFFFFF
			else
				IF( `job_acolyte` > 0, 0x00000010, 0 ) +
				IF( `job_alchemist` > 0, 0x00040000, 0 ) +
				IF( `job_archer` > 0, 0x00000008, 0 ) +
				IF( `job_assassin` > 0, 0x00001000, 0 ) +
				IF( `job_barddancer` > 0, 0x00080000, 0 ) +
				IF( `job_blacksmith` > 0, 0x00000400, 0 ) +
				IF( `job_crusader` > 0, 0x00004000, 0 ) +
				IF( `job_gunslinger` > 0, 0x01000000, 0 ) +
				IF( `job_hunter` > 0, 0x00000800, 0 ) +
				IF( `job_kagerouoboro` > 0, 0x20000000, 0 ) +
				IF( `job_knight` > 0, 0x00000080, 0 ) +
				IF( `job_mage` > 0, 0x00000004, 0 ) +
				IF( `job_merchant` > 0, 0x00000020, 0 ) +
				IF( `job_monk` > 0, 0x00008000, 0 ) +
				IF( `job_ninja` > 0, 0x02000000, 0 ) +
				IF( `job_novice` > 0, 0x00000001, 0 ) +
				IF( `job_priest` > 0, 0x00000100, 0 ) +
				IF( `job_rebellion` > 0, 0x40000000, 0 ) +
				IF( `job_rogue` > 0, 0x00020000, 0 ) +
				IF( `job_sage` > 0, 0x00010000, 0 ) +
				IF( `job_soullinker` > 0, 0x00800000, 0 ) +
				IF( `job_stargladiator` > 0, 0x00400000, 0 ) +
				IF( `job_summoner` > 0, 0x80000000, 0 ) +
				IF( `job_supernovice` > 0, 0x00000001, 0 ) +
				IF( `job_swordman` > 0, 0x00000002, 0 ) +
				IF( `job_taekwon` > 0, 0x00200000, 0 ) +
				IF( `job_thief` > 0, 0x00000040, 0 ) +
				IF( `job_wizard` > 0, 0x00000200, 0 )
		end as `equip_jobs`,
		case
			when `class_all` > 0 then
				63
			else
				IF( `class_normal` > 0, 1, 0 ) +
				IF( `class_upper` > 0, 2, 0 ) +
				IF( `class_baby` > 0, 4, 0 ) +
				IF( `class_third` > 0, 8, 0 ) +
				IF( `class_third_upper` > 0, 16, 0 ) +
				IF( `class_third_baby` > 0, 32, 0 )
		end as `equip_upper`,
		case
			when `gender` = 'Female' then
				0
			when `gender` = 'Male' then
				1
			when `gender` = 'Both' then
				2
			else
				null
		end as `equip_genders`,
		IF( `location_head_top` > 0, 256, 0 ) +
		IF( `location_head_mid` > 0, 512, 0 ) +
		IF( `location_head_low` > 0, 1, 0 ) +
		IF( `location_armor` > 0, 16, 0 ) +
		IF( `location_weapon` > 0, 2, 0 ) +
		IF( `location_shield` > 0, 32, 0 ) +
		IF( `location_garment` > 0, 4, 0 ) +
		IF( `location_shoes` > 0, 64, 0 ) +
		IF( `location_right_accessory` > 0, 8, 0 ) +
		IF( `location_left_accessory` > 0, 128, 0 ) +
		IF( `location_costume_head_top` > 0, 1024, 0 ) +
		IF( `location_costume_head_mid` > 0, 2048, 0 ) +
		IF( `location_costume_head_low` > 0, 4096, 0 ) +
		IF( `location_costume_garment` > 0, 8192, 0 ) +
		IF( `location_ammo` > 0, 32768, 0 ) +
		IF( `location_shadow_armor` > 0, 65536, 0 ) +
		IF( `location_shadow_weapon` > 0, 131072, 0 ) +
		IF( `location_shadow_shield` > 0, 262144, 0 ) +
		IF( `location_shadow_shoes` > 0, 524288, 0 ) +
		IF( `location_shadow_right_accessory` > 0, 1048576, 0 ) +
		IF( `location_shadow_left_accessory` > 0, 2097152, 0 )
		as `equip_locations`,
		`weapon_level`,
		case
			when `equip_level_min` > 0 and `equip_level_max` > 0 then
				CONCAT( `equip_level_min`, ':', `equip_level_max` )
			when `equip_level_min` > 0 then
				`equip_level_min`
			when `equip_level_min` > 0 then
				`equip_level_min`
			else
				null
		end as `equip_level`,
		`refineable`,
		case
			when `view` > 0 then
				`view`
			else
				null
		end as `view`,
		`script`,
		`equip_script`,
		`unequip_script`
	FROM `item_db_re`
);
