spawnEnemyGroup = {
	params["_number", "_position"];
	_kindToSpawn = floor (random 7);
	_dumbArray = [];

	if (_kindToSpawn == 1) then {
		for "_i" from 1 to _number do {
			_dumbArray pushback "obh_man_adventurer";
		};
	} else {
		for "_i" from 1 to _number do {
			_dumbArray pushback "CUP_O_RU_Survivor_Ratnik_Winter";
		};
	};

	_newGroup = [_position, east, _dumbArray] call BIS_fnc_spawnGroup;

	{
		[_x] call unequipAll;
		switch (_kindToSpawn) do {
			case 0: { //elf
				_x addUniform (selectRandom elfUniforms);
				_x addVest (selectRandom elfVests);
				_x addBackpack ("bc036_invisible_carryall");
				_x addGoggles (selectRandom elfFaces);
				_x addHeadgear (selectRandom elfHelms);
				[_x] call equipXmas;
			};
			case 1: { //LEGO man
				_x addUniform (selectRandom legoUniforms);
				_x addVest (selectRandom legoVests);
				_x addBackpack ("bc036_invisible_carryall");
				_x addHeadgear (selectRandom legoHelms);
				[_x] call equipXmas;
			};
			case 2: { //nicer santas
				_x addUniform (selectRandom niceUniforms);
				_x addVest ("bc036_invisible_carrier");
				_x addBackpack ("bc036_invisible_bergen");
				_x addHeadgear ("bc036_invisible_combat");
				[_x] call equipXmas;
			};
			/*
			case 3: { //shitty santas WHY SO MANY UNIFORMS BREAK!?
				_x addUniform (selectRandom shittyUniforms);
				_x addVest ("bc036_invisible_tacvest");
				_x addBackpack ("bc036_invisible_kitbag");
				_x addGoggles (selectRandom shittyFaces);
				_x addHeadgear (selectRandom shittyHelms);
				[_x] call equipXmasCheap;
			};
			*/
			case 3: { //grinches
				_x addUniform ("uniform_toxic");
				_x addVest ("cox_camovest_cr_toxic");
				_x addBackpack ("cox_APack_toxic");
				_x addGoggles ("grinch_mask");
				_x addHeadgear (selectRandom grinchHelms);
				[_x] call equipXmas;
			};
			case 4: { //reindeer
				//_x addVest ("bc036_invisible_carrier_lite");
				_x addBackpack ("bc036_invisible_kitbag");
				_x addHeadgear (selectRandom deerHelms);
				_x addUniform ("CUP_U_O_RUS_Ghillie");
				[_x] call equipXmas;
			};
			case 5: { //snowmen
				_x addUniform (selectRandom snowUniforms);
				_x addVest ("bc036_invisible_kitbag");
				_x addBackpack ("bc036_invisible_kitbag");
				_x addHeadgear (selectRandom snowHelms);
				[_x] call equipXmas;
			};
			case 6: { //mariah fans
				_x addUniform ("uniform_full_red");
				_x addVest ("bc036_invisible_tacvest");
				_x addBackpack ("bc036_invisible_kitbag");
				_x addGoggles ("mariah_01");
				_x addHeadgear ("Christmas_Hat_Side_Wearable");
				[_x] call equipXmasCheap;
			};
		};
	} forEach units _newGroup;
	_newGroup deleteGroupWhenEmpty true;
	_newGroup
};



/*

"xs_Snowmobile_combat" 
"jean_sleigh" 
"B_MRAP_F_Christmas"
"MRAP_GMG_Christmas"
"MRAP_HMG_Christmas"
"BTR_K_Christmas"

*/

spawnEnemyTransport = {
	params["_position"];
	_newVic = (selectRandom xmasTransportTrucks) createVehicle _position;
	_newGroup = [10,_position] call spawnEnemyGroup;
	{
		_x moveInAny _newVic;
	} forEach units _newGroup;
};

spawnVicFullOfXmas = {
	params["_vic", "_position"];
	_newVic = _vic createVehicle _position;
	_newGroup = [([_vic, true] call BIS_fnc_crewCount),_position] call spawnEnemyGroup;
	{
		_x moveInAny _newVic;
	} forEach units _newGroup;
	_newGroup
};

unequipAll = {
	params["_unit"];
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;
};

equipXmas = {
	params["_unit"];
	_weaponToGive = selectRandom xmasPrimaries;
	for "_i" from 1 to 8 do {
		_unit addMagazine (_weaponToGive select 1);
	};
	_unit addWeapon (_weaponToGive select 0);
	_unit addItem "Snowball_EXP_Weapon";
	_unit addItem "Snowball_EXP_Weapon";
	_unit addItem "Snowball_EXP_Weapon";
	_unit addItem "Snowball_EXP_Weapon";
	_unit addItem "explosive_present_01";
	_unit addItem "explosive_present_01";
	_unit addItem "explosive_present_01";
	_unit addItem "SmokeShellGreen";
	_unit addItem "SmokeShellRed";
	if (floor(random 3) == 2) then {
		_launcherToGive = selectRandom xmasLaunchers;
		_unit addMagazine (_launcherToGive select 1);
		_unit addMagazine (_launcherToGive select 1);
		_unit addWeapon (_launcherToGive select 0);
	};
};

equipXmasCheap = {
	params["_unit"];
	_weaponToGive = selectRandom xmasHandguns;
	for "_i" from 1 to 8 do {
		_unit addMagazine (_weaponToGive select 1);
	};
	_unit addWeapon (_weaponToGive select 0);
	_unit addItem "Snowball_EXP_Weapon";
	_unit addItem "Snowball_EXP_Weapon";
	_unit addItem "Snowball_EXP_Weapon";
	_unit addItem "Snowball_EXP_Weapon";
	_unit addItem "Snowball_EXP_Weapon";
	_unit addItem "Snowball_EXP_Weapon";
};

xmasPrimaries = [
	//["srifle_LRR_F_Christmas","7Rnd_408_Mag","optic_DMS"],
	["MK18_Christmas","CUP_20Rnd_TE1_Green_Tracer_762x51_DMR"],
	["MK20_black_plain_Christmas","30Rnd_556x45_Stanag_green"],
	//["MK20_black_gl_Christmas","30Rnd_556x45_Stanag_green","1Rnd_HE_Grenade_shell"],
	["45KO_MX_SW_Christmas","100Rnd_65x39_caseless_khaki_mag_tracer"],
	["45KO_MXc_camo_Christmas","100Rnd_65x39_caseless_khaki_mag_tracer"],
	["MXM_Christmas","30Rnd_65x39_caseless_khaki_mag_Tracer"],
	["arifle_SDAR_F_Christmas","30Rnd_556x45_Stanag_Tracer_Green"],
	["TRG20_Christmas","CUP_100Rnd_TE1_Green_Tracer_556x45_BetaCMag_ar15"],
	["45KO_SMG_christmas","30Rnd_45ACP_Mag_SMG_01_Tracer_Green"],
	["Xmas_Rifle_Xmas200","Xmas_Rifle_Xmas200_200Rnd"]
];

xmasHandguns = [
	["45ACP_BLK_F_Christmas","11Rnd_45ACP_Mag"],
	["hgun_ACPC2_F_Christmas","9Rnd_45ACP_Mag"],
	["P07_Christmas","16Rnd_9x21_green_Mag"],
	["PM_F_Christmas","10Rnd_9x21_Mag"],
	["ZUBR_F_Christmas","6Rnd_45ACP_Cylinder"]
];

xmasLaunchers = [
	["launch_RPG32_ghex_F_Christmas","RPG32_HE_F"],
	["launch_B_Titan_short_F_Ammo_Christmas","launch_B_Titan_short_F_Ammo_Christmas"],
	["launch_RPG32_ghex_F_Ammo_Christmas","Snowball_Missile_Weapon"],
	["launch_B_Titan_short_F_Christmas","Titan_AP"],
	["launch_B_Titan_Christmas","launch_B_Titan_Christmas"]
];

elfHelms = [
	"christmass_hat_r",
	"christmass_hat_g",
	"christmass_hat_r",
	"christmass_hat_g",
	"H_Hat_Tinfoil_F"
];

elfFaces = [
	"cox_bandana_avi_batch",
	"cox_bandana_avi_green",
	"CUP_PMC_Facewrap_Red",
	"CUP_PMC_Facewrap_Tropical",
	"",
	""
];

elfUniforms = [
	"uniform_xocpat_green",
	"camo_santy2",
	"uniform_full_red",
	"camo_erdl",
	"camo_cox_erdl_green",
	"jumpsuit_green"
];

elfVests = [
	"V_DeckCrew_green_F",
	"V_DeckCrew_red_F",
	"cox_tacvest_green",
	"cox_tacvest_red"
];

legoHelms = [
	"",
	"",
	"obh_item_cap_blue",
	"obh_item_cap_green",
	"obh_item_cap_red"
];

legoUniforms = [
	"obh_item_pants_blue",
	"obh_item_pants_red",
	"obh_item_pants_green"
];

legoVests = [
	"obh_item_chest_adventurer_green",
	"obh_item_chest_blue",
	"obh_item_chest_green",
	"obh_item_chest_red"
];

niceUniforms = [
	//"xs_ded",
	"xmas_santa_opfor_uniform",
	"xmas_santa_uniform",
	"xmas_santa_ind_uniform",
	"xmas_santa_blufor_uniform"
];

shittyFaces = [
	"beard_w",
	"Gold_Beard_GE",
	"Grey_Beard_GE",
	"Santa_Beard_GE",
	"cane_mouth",
	"cane_nose",
	"rudolf"
];

shittyHelms = [
	"Christmas_Hat_Mistake_Wearable",
	"Christmas_Hat_Plain_Wearable",
	"Christmas_Hat_Reindeer_Wearable",
	"Christmas_Hat_Side_Wearable",
	"Christmas_Hat_Stars_Wearable",
	"Christmas_Hat_Plain_Wearable",
	"Christmas_Hat_Reindeer_Wearable",
	"Christmas_Hat_Side_Wearable",
	"Christmas_Hat_Stars_Wearable",
	"COX_SANTY_MASK"
];

shittyUniforms = [
	"CUP_U_C_Villager_01",
	"CUP_U_C_Villager_02",
	"CUP_U_C_Villager_03",
	"CUP_U_C_Villager_04",
	"CUP_U_C_Profiteer_04",
	//"camo_santy",
	"camo_santy2"
];

grinchHelms = [
	"CUP_H_C_Ushanka_03",
	"CUP_H_C_Ushanka_02",
	"rhsgref_M56",
	""
];

deerHelms = [
	"rhs_xmas_antlers",
	"Deer_Helmet_GE",
	"NWTS_Deer",
	"NWTS_Deer_bloody",
	"NWTS_Deer_glow",
	"NWTS_Deer_Mossy"
];

deerUniforms = [
	"CUP_U_B_CZ_WDL_Ghillie",
	"CUP_U_I_Ghillie_Top"
];

snowHelms = [
	"Snowman_Bucket_Wearable",
	"Snowman_Hat_Wearable",
	"Snowman_Enemy_Wearable",
	"Snowman_Bucket_Wearable_M",
	"Snowman_Enemy_Wearable_M",
	"Snowman_Hat_Wearable_M"
];

snowUniforms = [
	//"Christmas_Sweater_Friend_Item",
	//"Christmas_Sweater_Hostile_Item"
	"U_C_CBRN_Suit_01_White_F"
];

xmasTransportTrucks = [
	"B_Truck_01_transport_F_Christmas",
	"B_Truck_01_covered_F_Christmas",
	"Truck_03_F_Christmas",
	"Truck_03_covered_F_Christmas",
	"Truck_02_transport_F_Christmas",
	"Truck_02_covered_F_Christmas"
];



/*


"Elves" - just dudes in red and green 
Lego Men
Mall Santa
	Nicer
	Slobbier (pmc + civvie clothes)
Grinch Army
Reindeer
Snowmen
Mariah Carey Fans

Christmas Textured Vehicles
Kicksled!
Snowmobiles
Flying Sleighs (don't use SAD, just move them randomly?)

ELVES
	face
		cox_bandana_avi_batch
		cox_bandana_avi_green
		CUP_PMC_Facewrap_Red
		CUP_PMC_Facewrap_Tropical
	head
		christmass_hat_r
		christmass_hat_g
	uniform
		uniform_xocpat_green
		Christmas_Sweater_Santa_Item
		uniform_full_red
		camo_erdl
		camo_cox_erdl_green
		jumpsuit_green
	vest
		V_DeckCrew_green_F
		V_DeckCrew_red_F
		cox_tacvest_green
		cox_tacvest_red
	backpack

LEGO MEN
	Heads
		""
		"obh_item_cap_blue"
		"obh_item_cap_green"
		"obh_item_cap_red"
	Uniform
		obh_item_pants_blue
		obh_item_pants_red
		obh_item_pants_green
	Vest
		obh_item_chest_adventurer_green
		obh_item_chest_blue
		obh_item_chest_green
		obh_item_chest_red
	backpack
		bc036_invisible_carryall

BAD MALL SANTA
	face
		beard_w
		Gold_Beard_GE
		Grey_Beard_GE
		Santa_Beard_GE
		""
	head
		Christmas_Hat_Mistake_Wearable
		Christmas_Hat_Plain_Wearable
		Christmas_Hat_Reindeer_Wearable
		Christmas_Hat_Side_Wearable
		Christmas_Hat_Stars_Wearable
		COX_SANTY_MASK
	vest
		bc036_invisible_tacvest
	uniform
		CUP_U_C_Villager_01
		CUP_U_C_Villager_02
		CUP_U_C_Villager_03
		CUP_U_C_Villager_04
		Christmas_Sweater_Merry_Christmas_Item
		Christmas_Sweater_Mooses_Item
		Christmas_Sweater_Reindeers_Item
		Christmas_Sweater_Santa_Item
		Christmas_Sweater_Trees_Item
		CUP_U_C_Profiteer_04
		camo_santy
		camo_santy2
	backpack
		bc036_invisible_kitbag

NICER SANTA
	head
		"bc036_invisible_combat"
	vest
		"bc036_invisible_carrier"
	uniform
		"xs_ded"
		"xmas_santa_opfor_uniform"
		"xmas_santa_uniform"
		"xmas_santa_ind_uniform"
		"xmas_santa_blufor_uniform"
	backpack
		"bc036_invisible_bergen"

GRINCH
	face
		grinch_mask
	Head
		CUP_H_C_Ushanka_03
		CUP_H_C_Ushanka_02
		rhsgref_M56
		""
	vest
		cox_camovest_cr_toxic
	uniform
		uniform_toxic
	backpack
		cox_APack_toxic

REINDEER
	head
		"rhs_xmas_antlers"
		Deer_Helmet_GE
		"NWTS_Deer"
		"NWTS_Deer_bloody"
		"NWTS_Deer_glow"
		"NWTS_Deer_Mossy"
	vest
		"bc036_invisible_carrier_lite"
	uniform
		"CUP_U_B_CZ_WDL_Ghillie"
		"CUP_U_I_Ghillie_Top"
	backpack
		"bc036_invisible_kitbag"

SNOWMEN
	head
		Snowman_Bucket_Wearable
		Snowman_Hat_Wearable
		Snowman_Enemy_Wearable
		Snowman_Bucket_Wearable_M
		Snowman_Enemy_Wearable_M
		Snowman_Hat_Wearable_M
	vest
		"bc036_invisible_carrier_lite"
	uniform
		Christmas_Sweater_Friend_Item
		Christmas_Sweater_Hostile_Item
	backpack
		"bc036_invisible_kitbag"

MARIAH CAREY FAN
	face
		mariah_01
	head
		Christmas_Hat_Side_Wearable
	uniform
		Christmas_Sweater_Santa_Item
	vest
		bc036_invisible_tacvest
	backpack
		bc036_invisible_kitbag

WEAPONS!
	"srifle_LRR_F_Christmas","7Rnd_408_Mag","optic_DMS"
	"MK18_Christmas","CUP_20Rnd_TE1_Green_Tracer_762x51_DMR"
	"MK20_black_plain_Christmas","30Rnd_556x45_Stanag_green"
	"MK20_black_gl_Christmas","30Rnd_556x45_Stanag_green","1Rnd_HE_Grenade_shell"
	"45KO_MX_SW_Christmas","100Rnd_65x39_caseless_khaki_mag_tracer"
	"45KO_MXc_camo_Christmas","100Rnd_65x39_caseless_khaki_mag_tracer"
	"MXM_Christmas","30Rnd_65x39_caseless_khaki_mag_Tracer"
	"arifle_SDAR_F_Christmas","30Rnd_556x45_Stanag_Tracer_Green"
	"TRG20_Christmas","CUP_100Rnd_TE1_Green_Tracer_556x45_BetaCMag_ar15"
	"45KO_SMG_christmas","30Rnd_45ACP_Mag_SMG_01_Tracer_Green"
	"Xmas_Rifle_Xmas200","Xmas_Rifle_Xmas200_200Rnd"

	"45ACP_BLK_F_Christmas","11Rnd_45ACP_Mag"
	"hgun_ACPC2_F_Christmas","9Rnd_45ACP_Mag"
	"P07_Christmas","16Rnd_9x21_green_Mag"
	"PM_F_Christmas","PM_F_Christmas"
	"ZUBR_F_Christmas","6Rnd_45ACP_Cylinder"

	"launch_RPG32_ghex_F_Christmas","RPG32_HE_F"
	"launch_B_Titan_short_F_Ammo_Christmas","launch_B_Titan_short_F_Ammo_Christmas"
	"launch_RPG32_ghex_F_Ammo_Christmas","Snowball_Missile_Weapon"
	"launch_B_Titan_short_F_Christmas","Titan_AP"
	"launch_B_Titan_Christmas","launch_B_Titan_Christmas"

//////////
THINGS TO BLOW UP
sbp_xmas gifts (as like, caches)
xmas Tree
nice sleigh (a3fact)
christmas pack stuff


0	"Elves" - just dudes in red and green 
1	Lego Men
2	Nicer Santa
3	Slobbier Santa (pmc + civvie clothes)
4	Grinch Army
5	Reindeer
6	Snowmen
7	Mariah Carey Fans

*/