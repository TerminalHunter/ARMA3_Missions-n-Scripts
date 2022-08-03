//MISSION 5 CHANGES

//Main map preparation.
//Send hint messages to players to inform them of map prep and do said map prep
mapApocalypsizing = {
	_worldObjects = [];
	{
		if (not (toLower(str _x) find 'castle' > -1)) then {
			if (not (toLower(str _x) find 'wall_stone' > -1)) then {
				if (not (toLower(str _x) find 'ruin' > -1)) then {
					if (not (toLower(str _x) find 'wreck' > -1)) then {
						_worldObjects pushBack (getPos _x);
						hideObject _x;
					};
				};
			};
		};
	} forEach nearestTerrainObjects [partyInventory,["BUILDING","HOUSE","FENCE","WALL", "VIEW-TOWER","HIDE","FOUNTAIN"],worldSize*2,false];
	_worldObjects
};

//Part of map apocalypsize'ing - spreads new ruins/destroyed items and spawns loot for players to find
//requires array of world objects that were hidden - replaces some objects with randomized ruins
spreadFixedLoot = {
	params ["_worldObjects"];
	_objectNumber = 0;
	_num = 0;
	{
		if (!((_x) isFlatEmpty [1, -1, 0.03, 8, -1] isEqualTo[])) then{ //THIS WORKS: if (!((getPos _x) isFlatEmpty [1, -1, 0.01, 9, -1] isEqualTo[])) then{
			_objectNumber = _objectNumber - 1;
			if (_objectNumber < 0) then {
				_ruin = createVehicle [(selectRandom ruinsList),(_x)];
				_ruin setDir (random 360);
				_ruin setPos [(getPos _ruin) select 0, (getPos _ruin) select 1, 0];
				//debug markers
				//"|marker_"+ str _num +"|"+str(getPos _x)+"|mil_pickup|ICON|[1,1]|0|Solid|Default|1|Placed_Ruin"+str(_num) call BIS_fnc_stringToMarker;
				_num = _num + 1;
				_objectNumber = random 3; // this line means only approx 1/3 of possible positions have ruins in them
				for "_lootboi" from 0 to (random 2) step 1 do{
					_randLootPos = [((getPos _ruin select 0) - 10 + (random 20)), ((getPos _ruin select 1) - 10 + (random 20)), 0];
					//debug markers
					//"|marker_"+ str (random 10000) +"|"+str(_randLootPos)+"|mil_dot|ICON|[1,1]|0|Solid|Default|1|Loot_Boi" call BIS_fnc_stringToMarker;
					[_randLootPos, true] spawn createLootBox;
				};
			};
		};
	} forEach _worldObjects;
};

//Part of map apocalypsize'ing - spreads loot caches in completely random areas away from ruins
spreadLootCaches = {
	_density = 16;
	_spread = worldSize/_density;
	//the '1 to 13' and '4 to 15' numbers are to avoid the ice sheets that probably shouldn't have camps/caches on them - map specific tweak
	for "_i" from 0 to 12 step 1 do{
		for "_j" from 4 to 15 step 1 do{
			_cacheLocation = [(_spread*_i)-_spread+random(_spread*2),(_spread*_j)-_spread+random(_spread*2),0];
			//debug markers
			//"|marker_"+ str _i + "-" + str _j +"|"+str(_cacheLocation)+"|mil_dot|ICON|[1,1]|0|Solid|Default|1|Cache_Boi" call BIS_fnc_stringToMarker;
			[_cacheLocation, true] spawn createLootBox;
			for "_campObjectNumber" from 0 to (random 4) step 1 do{
				_campObjectLocation = [(_cacheLocation select 0) - 5 + (random 10),(_cacheLocation select 1) - 5 + (random 10), 0];
				_campObject = createVehicle [(selectRandom campList),_campObjectLocation];
				_campObjectLootLoc = [(_cacheLocation select 0) - 5 + (random 10),(_cacheLocation select 1) - 5 + (random 10), 0];
				[_campObjectLootLoc, false] spawn createLootBox;
			};
		};
	};
};

//Part of map apocalypsize'ing - creates singular box with loot in it
//requires a location be passed to it AND bool - true if it needs to spawn 5 meters in the air to ensure it doesn't clip into ruins/false if no position adjustment needed
//has special cases for medical loot and ammunition.... actually all cases are special cases, but residual code exists in case an item in a box need be passed in
createLootBox = {
	params ["_location","_adjust"];
	if (_adjust) then{
		_location = _location vectorAdd [0,0,5];
	};
	_cacheLootBox = selectRandom lootBoxen;
	_cacheLootBoxBox = createVehicle [(_cacheLootBox select 0), _location];
	_cacheLootBoxBox setDir (random 360);
	clearItemCargoGlobal _cacheLootBoxBox;
	//_cacheLootBoxBox enableDynamicSimulation true;
	//1 in 10 chance of a few spare bottlecaps
	if ((floor (random 10)) == 1) then {
		//"|marker_"+str (random 20000)+"|"+str(getPos _cacheLootBoxBox)+"|mil_dot|ICON|[1,1]|0|Solid|Default|1|EXTRA_THICC" call BIS_fnc_stringToMarker;
		_cacheLootBoxBox addItemCargoGlobal ["AM_BCap",(floor (random 3)) + 1];
	};
	//the big switch statement that actually parses the loot and adds it to the loot box box
	//reminder that a loot box is an abstract pile of loot while the loot box box is the actual box containing said abstracted group of loot
	//try and not make that mistake if you ever come back to this
	for "_k" from 1 to ((count _cacheLootBox) - 1) step 1 do{
		switch (_cacheLootBox select _k) do{
			case "medicalLootCommon": {
				_cacheLootBoxBox addItemCargoGlobal ([]call medicalLootCommon);
			};
			case "medicalLootUncommon": {
				_cacheLootBoxBox addItemCargoGlobal ([]call medicalLootUncommon);
			};
			case "medicalLootRare": {
				_cacheLootBoxBox addItemCargoGlobal ([]call medicalLootRare);
				_extraLoot = floor random [0,1,4];
				if (_extraLoot > 0) then{
					//"|marker_"+str (random 20000)+"|"+str(getPos _cacheLootBoxBox)+"|mil_dot|ICON|[1,1]|0|Solid|Default|1|EXTRA_THICC" call BIS_fnc_stringToMarker;
					for "_extra" from 1 to _extraLoot step 1 do{
						_cacheLootBoxBox addItemCargoGlobal ([]call medicalLootUncommon);
					};
				};
			};
			case "ammoLoot":{
				_cacheLootBoxBox addItemCargoGlobal ([]call ammunitionCivilian);
			};
			case "gunLoot":{
				_gunType = selectRandom gunCivilianList;
				_gun = _gunType select 0;
				_ammo = _gunType select 1;
				_numAmmo = floor random [8,12,18];
				_numGun = (floor (random 1)) + 1;
				_cacheLootBoxBox addItemCargoGlobal [_gun,_numGun];
				_cacheLootBoxBox addItemCargoGlobal [_ammo,_numAmmo];
				if (count _gunType > 2) then {
					_cacheLootBoxBox addItemCargoGlobal [(_gunType select 2),_numGun];
				};
			};
			case "betterGunLoot":{
				_gunType = selectRandom gunMilitaryList;
				_gun = _gunType select 0;
				_ammo = _gunType select 1;
				_numAmmo = floor random [8,12,18];
				_numGun = (floor (random 1)) + 1;
				_cacheLootBoxBox addItemCargoGlobal [_gun,_numGun];
				_cacheLootBoxBox addItemCargoGlobal [_ammo,_numAmmo];
				if (count _gunType > 2) then {
					_cacheLootBoxBox addItemCargoGlobal [(_gunType select 2),_numGun];
				};
			};
			case "RARELOOT":{ //this is bad. you should have a better system. you should feel bad.
				_rareLootBox = selectRandom rareLootBoxen;
				_rareLootBoxBox = createVehicle [(_rareLootBox select 0), _location];
				_rareLootBoxBox setDir (random 360);
				clearItemCargoGlobal _rareLootBoxBox;
				for "_k" from 1 to ((count _rareLootBox) - 1) step 1 do{
					_rareLootBoxBox addItemCargoGlobal (_rareLootBox select _k);
				};
				deleteVehicle _cacheLootBoxBox;
			};
			default {
				_cacheLootBoxBox addItemCargoGlobal (_cacheLootBox select _k);
			};
		};
	};

	[_cacheLootBoxBox, autoDeleteLootBoxenEventHandler] remoteExec ["addEventHandler",0,true];

};

autoDeleteLootBoxenEventHandler = ["ContainerClosed",{
		params ["_container", "_unit"];
		_items =  getItemCargo _container;
		_mags = getMagazineCargo _container;
		_guns = weaponsItemsCargo _container;
		if (count (_items select 0) == 0 && count (_mags select 0) == 0 && count _guns == 0) then {
			deleteVehicle _container;
		};
}];

grabRandomPosition = {
    params ["_marker"];
    _sizeArray = getMarkerSize _marker;
    _width = _sizeArray select 0;
    _height = _sizeArray select 1;
    _position = getMarkerPos _marker;
    _randomWidth = (floor random (_width*2)) - _width;
    _randomHeight = (floor random (_height*2)) - _height;
    _return = _position vectorAdd [_randomWidth, _randomHeight, 0];
    _return
};

ruinsList = [
"Land_WW2_Posed_Ruins_w",
"Land_WW2_Corner_House_3_Ruins_w",
"Land_WW2_Corner_House_1b_Ruins_w",
"Land_WW2_House_2e_1_Ruins_w",
"Land_WW2_Dom_Pl_Avrg_Ruins_w",
"Land_WW2_Cr_Mid_Ruins_w",
"Land_WW2_Kladovka2_Ruins_w",
"Land_WW2_Dom_Pol2_Ruins_w",
"Land_WW2_House_2e_Arc1_Ruins_w",
"Land_WW2_Corner_House_1b_Ruins_w",
"Land_WW2_House_2e_Arc2_Ruins_w",
"Land_WW2_Sarai_Mid_Ruins_w",
"Land_WW2_Central_3e_1_Ruins_w",
"Land_WW2_Hata_1_Ruins_w",
"Land_WW2_City_Shop_1e_2_Ruins_w",
"Land_WW2_Shed_M01_Ruins_w",
"Land_WW2_Chik_House2_Ruins_w",
"Land_WW2_Chik_House_Ruins_w",
"Land_WW2_City_House_2e_Lone_2_Ruins_w",
"Land_WW2_Dom_Pl_Big2_Ruins_w",
"Land_WW2_Dom_Pl_Big_Ruins_w",
"Land_WW2_City_House_2e_shops_Ruins_w",
"Land_WW2_House_1floor_Pol_Ruins_w",
"Land_WW2_Corner_House_1c_Ruins_w",
"Land_WW2_Shed_W03_Ruins_w",
"Land_WW2_Shed_W02_Ruins_w",
"Land_WW2_City_Shop_1e_Ruins_w",
"Land_WW2_Apteka_Ruins_w",
//"Props_AM_diner",
"Land_HouseBlock_A1_ruins",
"Land_HouseBlock_A2_ruins",
"Land_HouseBlock_A3_ruins",
"Land_HouseBlock_B1_ruins",
"Land_HouseBlock_B2_ruins",
"Land_HouseBlock_B3_ruins",
"Land_HouseBlock_B4_ruins",
"Land_HouseBlock_B5_ruins",
"Land_HouseBlock_B6_ruins",
"Land_HouseBlock_C1_ruins",
"Land_HouseBlock_C2_ruins",
"Land_HouseBlock_C3_ruins",
"Land_HouseBlock_C4_ruins",
"Land_HouseBlock_C5_ruins",
"Land_HouseBlock_D1_ruins"
];

campList = [
"Props_AM_mobilehome_white",
"Land_Props_AM_truc02_4",
"Props_AM_APC_Open_Burned",
"Props_AM_nv_truck_white",
"Land_Props_AM_mcycleBroken_2",
"Land_Props_AM_Car02_4",
"Land_Props_AM_mobilehomeSmall_white",
"Props_AM_Campfire01",
"Props_AM_Campfire03",
"Props_AM_tent2",
"Props_AM_tent2",
"Land_CampingChair_V2_white_F",
"Land_WoodenTable_small_F",
"Land_CampingTable_small_white_F",
"Props_AM_tent2S",
"Props_AM_Mattress",
"Props_AM_MetalBarrel",
"Props_AM_toilet",
"Props_AM_barrel",
"Props_AM_am_table02",
"Land_bathtub01",
"Land_cookingstove_dirty",
"Land_displaycase04",
"Land_fridgedirty",
"Props_AM_barrelfirelightBurn",
"Props_AM_tvsetdirty",
"Props_AM_tirepile02",
"Land_Barricade_01_4m_F",
"Land_Barricade_01_10m_F",
"Land_JunkPile_F",
"Land_TentA_F",
"Land_WoodPile_F",
"Land_WoodPile_large_F",
"Land_HumanSkeleton_F",
"AM_MineFrag_Ammo",
"AM_MineFrag_Ammo",
"AM_MineFrag_Ammo"
];

medicalLootCommon = {
	_return = [selectRandom [
		"ACE_packingBandage",
		"ACE_elasticBandage",
		"ACE_quikclot",
		"Aftermath_Healing_Powder",
		"Aftermath_Healing_Powder"
		],(floor random [0,2,5])];
	_return

};

medicalLootUncommon = {
	_return = [selectRandom [
		"ACE_packingBandage",
		"ACE_elasticBandage",
		"ACE_quikclot",
		"Aftermath_Duct_Tape",
		"Aftermath_Healing_Powder",
		"ACE_morphine",
		"ACE_epinephrine",
		"ACE_tourniquet",
		"ACE_adenosine",
		"ACE_splint",
		"ACE_salineIV_500",
		"ACE_plasmaIV_500",
		"Aftermath_RadawayIV_500",
		"Aftermath_AutoInject_Stimpak",
		"Aftermath_Jet",
		"Aftermath_Medx",
		"Aftermath_Psycho"
		],1];
	_return
};

medicalLootRare = {
	_return = [selectRandom [
		"ACE_surgicalKit",
		"ACE_splint",
		"ACE_salineIV_500",
		"ACE_plasmaIV_500",
		"Aftermath_RadawayIV_500",
		"Aftermath_AutoInject_Stimpak",
		"Aftermath_Stimpak",
		"Aftermath_Jet",
		"Aftermath_Medx",
		"Aftermath_Psycho",
		"Aftermath_Slasher",
		"Aftermath_Weapon_Binder",
		"AM_RadX",
		"AM_mentats",
		"AM_antivenom",
		"AM_Buffout"
		],1];
	_return
};

ammunitionCivilianList = [
"8Rnd_45x70_HP",
"8Rnd_357",
"10Rnd_308_Mag",
"10Rnd_308_AP_Mag",
"5Rnd_12ga_pel_Mag",
"5Rnd_12ga_sl_Mag",
"8Rnd_44Magnum_Mag",
"8Rnd_556x45_Mag",
"LIB_8Rnd_762x63",
"LIB_10Rnd_770x56",
"30Rnd_9x21_Mag",
"6Rnd_357_Cyl",
"16Rnd_9x21_Mag",
"16Rnd_10mm_Mag",
"LIB_6Rnd_9x19_Welrod",
"ACE_40mm_Flare_white",
"ACE_HandFlare_White",
"AM_frag_throw",
"AM_dynamiteL_throw",
"SmokeShell",
"LIB_No77",
"24Rnd_MicroFusionCell_Mag",
"CUP_20Rnd_TE1_White_Tracer_762x51_DMR",
"24Rnd_556x45_Mag",
"1Rnd_HE_Grenade_shell",
"30Rnd_PlasmaCartridge_Mag",
"12Rnd_2mm_Mag"
];

gunCivilianList = [
["AM_BrushGun", "8Rnd_45x70_HP"],
["AM_CowboyRepeater","8Rnd_357","optic_am_cr"],
["AM_HuntingRifle","10Rnd_308_Mag"],
["AM_HuntingShotgun","5Rnd_12ga_pel_Mag"],
["AM_LeverShotgun","5Rnd_12ga_pel_Mag"],
["AM_ShortSG","5Rnd_12ga_pel_Mag"],
["AM_TrailCarbineW","8Rnd_44Magnum_Mag","optic_am_ps"],
["AM_VarmintRifleOld","8Rnd_556x45_SRP_Mag"],
["LIB_M1_Garand","LIB_8Rnd_762x63","lib_acc_m1_bayo"],
["LIB_LeeEnfield_No4","LIB_10Rnd_770x56","lib_acc_no4_mk2_bayo"],
["LIB_LeeEnfield_No4","LIB_10Rnd_770x56","lib_acc_no4_mk2_bayo"],
["LIB_LeeEnfield_No4","LIB_10Rnd_770x56","lib_acc_no4_mk2_bayo"],
//["LIB_Sten_Mk2","LIB_32Rnd_9x19_Sten"],
//["LIB_M3_GreaseGun","LIB_30Rnd_M3_GreaseGun_45ACP"],
["AM_9mmSMG","30Rnd_9x21_Mag"],
["AM_M79","ACE_40mm_Flare_white"],
["AM_357Rev_HDShort","6Rnd_357_Cyl"],
["AM_browning9mm","16Rnd_9x21_Mag"],
["AM_10mmPistol","16Rnd_10mm_Mag"],
["LIB_Welrod_mk1","LIB_6Rnd_9x19_Welrod"]
];
// WW2 STEN + M3 Grease do not play nice with the jam system. Consider replacements. They have been replaced.

gunMilitaryList = [
["AM_FNFALMod","CUP_20Rnd_TE1_White_Tracer_762x51_DMR"],
["AM_FNFALMod","CUP_20Rnd_TE1_White_Tracer_762x51_DMR"],
["AM_G3AssaultRifle","24Rnd_556x45_Mag","optic_mcro"],
["AM_G3AssaultRifleWooden","24Rnd_556x45_SRP_Mag"],
["AM_12_7mmSMG", "21Rnd_127_Mag"],
["AM_LaserRifleModFA", "24Rnd_MicroFusionCell_Mag", "optic_am_lrs"],
["AM_LaserRifle", "24Rnd_MicroFusionCell_Mag", "optic_am_lrs"],
["AM_TriBeamLaserRifle", "24Rnd_MicroFusionCell_Mag"],
["AM_LaserRifle", "24Rnd_MicroFusionCell_Mag", "optic_am_lrs"],
["AM_AntiMatRifleB", "8Rnd_127x99_EXP_Mag", "optic_am_lrpsb"],
["AM_BAR", "CUP_20Rnd_TE1_White_Tracer_762x51_DMR"],
["AM_LMGb", "200Rnd_556x45_Box_Mag_F"],
["AM_M79","1Rnd_HE_Grenade_shell"],
["AM_MultiPlas", "30Rnd_PlasmaCartridge_Mag"],
["AM_PlasmaRifle", "30Rnd_PlasmaCartridge_Mag"],
["AM_SniperRifle", "10Rnd_308_AP_Mag", "optic_am_srs"],
["AM_CARifle", "24Rnd_556x45_Mag"]
];

ammunitionCivilian = {
	_numberOfMags = random [4,8,18];
	_magType = selectRandom ammunitionCivilianList;
	_return = [_magType, _numberOfMags];
	_return
};

lootBoxen = [
["Land_PaperBox_01_small_closed_white_med_F","medicalLootCommon","medicalLootUncommon","medicalLootUncommon","medicalLootRare"],
["Land_PaperBox_01_small_closed_white_med_F","medicalLootCommon","medicalLootCommon","medicalLootUncommon","medicalLootUncommon"],
["ACE_medicalSupplyCrate_advanced","medicalLootCommon","medicalLootUncommon","medicalLootUncommon","medicalLootRare"],
["Land_PlasticCase_01_small_idap_F","medicalLootCommon","medicalLootUncommon","medicalLootUncommon","medicalLootRare"],
["Land_PlasticCase_01_small_idap_F","medicalLootCommon","medicalLootCommon","medicalLootUncommon","medicalLootUncommon"],
["Props_AM_AmmoBox","ammoLoot"],
["Props_AM_AmmoBox","ammoLoot"],
["Props_AM_AmmoBox","ammoLoot"],
["Props_AM_AmmoBox","ammoLoot"],
["Land_MetalCase_01_medium_F","gunLoot"],
["Land_MetalCase_01_medium_F","gunLoot"],
["Land_MetalCase_01_large_F","betterGunLoot"],
["Land_MetalCase_01_large_F","betterGunLoot"],
["Land_HelipadEmpty_F","RARELOOT"],
["Land_HelipadEmpty_F","RARELOOT"],
["Land_HelipadEmpty_F","RARELOOT"],
["Land_HelipadEmpty_F","RARELOOT"],
["Land_HelipadEmpty_F","RARELOOT"],
["Land_HelipadEmpty_F","RARELOOT"]
];

rareLootBoxen = [
["Land_WoodenCrate_01_F",["murshun_cigs_cigpack",10],["murshun_cigs_lighter",3]],
["Land_WoodenCrate_01_F",["murshun_cigs_cigpack",10],["murshun_cigs_lighter",3]],
["Land_WoodenCrate_01_F",["TCGM_BikePack_win",1]],
["Land_MetalCase_01_small_F",["AM_BBGun",1],["100Rnd_BB_Mag",5]],
["Land_WoodenCrate_01_F",["LIB_Bagpipes",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_9battery",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_abraxo",6]],
["Land_PaperBox_01_small_closed_brown_F",["AM_ashtray",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_baseball",3],["AM_baseballglove",10]],
["Land_PaperBox_01_small_closed_brown_F",["AM_basketball",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_bigplate",5]],
["Land_PaperBox_01_small_closed_brown_F",["AM_bobbypin",2]],
["Land_PaperBox_01_small_closed_brown_F",["AM_surbonesaw",1]],
["Land_PaperBox_01_small_closed_brown_F",["_AM_bubblegum",20]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Camera",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_chessboard",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_counductor",2]],
["Land_PaperBox_01_small_closed_brown_F",["AM_clipboard",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_coffeemug01",10]],
["Land_PaperBox_01_small_closed_brown_F",["_AM_cram",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_dandyboyapples",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_gardengnomedestroyed",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_dinotoy",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_ductape",6]],
["Land_PaperBox_01_small_closed_brown_F",["Land_syringe",random 100]],
["Land_PaperBox_01_small_closed_brown_F",["AM_evilgnome",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_fancyladsnackcakes",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_fingergachimuchi",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_fork",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_flour",5]],
["Land_PaperBox_01_small_closed_brown_F",["AM_gumdrops",50]],
["Land_PaperBox_01_small_closed_brown_F",["AM_hammer",3]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Holotape",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_instamash",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_laundrydetergent",4]],
["Land_PaperBox_01_small_closed_brown_F",["AM_lunchbox",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_macNcheese",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_MePe",1],["AM_nv_head",1],["AM_nv_head3",1],["AM_nv_head2",1],["AM_nv_head6",1],["AM_nv_head4",1],["AM_nv_head5",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_microskope",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_moonshinejug",4]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Nuka_Empty",24]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Nuka_Empty",23],["AM_Nuka_Full",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_potatocrisps",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_scrapelectronics",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_spoon",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Ingot",8]],
["Land_PaperBox_01_small_closed_brown_F",["AM_sugarbombs",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_timer",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_toycar",4]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Wine",4]],
["Land_PaperBox_01_small_closed_brown_F",["AM_yumyumdeviledeggs",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Tequila",2],["AM_whiskeybottle01",2],["AM_Scotch_New",2],["AM_Tequila",2],["partyhat",12],["ACE_Chemlight_HiRed",20],["ACE_Chemlight_HiGreen",20],["ACE_Chemlight_HiBlue",20]],
["Land_moonshinedistillery",["AM_whiskeybottle01",5]],
["Land_moonshinedistillery",["AM_moonshinejug",5]],
["Land_PaperBox_01_small_closed_brown_F",["ACE_Banana",6]],
["Land_PaperBox_01_small_closed_white_med_F",["surgical_mask",24]],
["Land_PaperBox_01_small_closed_white_med_F",["ACE_bodyBag",4]],
["Props_AM_Old_FootLocker",["boomerhat01",1]],
["Props_AM_Old_FootLocker",["boomerhat02",1]],
["Props_AM_Old_FootLocker",["boomerhat03",1]],
["Props_AM_Old_FootLocker",["hatwastelandmerchant",1]],
["Props_AM_Old_FootLocker",["cowboy_hat_02",1]],
["Props_AM_Old_FootLocker",["cowboy_hat_01",1]],
["Props_AM_Old_FootLocker",["PlagueMask_Head",1]],
["Props_AM_Old_FootLocker",["cowboy_hat_05",1]],
["Props_AM_Old_FootLocker",["1950_style_hat",1]],
["Props_AM_Old_FootLocker",["1950_style_hat02",1]],
["Props_AM_Old_FootLocker",["cowboy_hat_04",1]],
["Props_AM_Old_FootLocker",["cowboy_hat_03",1]],
["Props_AM_Old_FootLocker",["lucassimms_hat",1]],
["Props_AM_Old_FootLocker",["hat_wasteland_clothing_02",1]],
["Props_AM_Old_FootLocker",["constructionhat",1]],
["Props_AM_Old_FootLocker",["clownmask",1]],
["Props_AM_Old_FootLocker",["mask",8]],
["Props_AM_Old_FootLocker",["1950stylesuit_outfit_benny_uniform",1]],
["Props_AM_Old_FootLocker",["republican_01_uniform",1]],
["Props_AM_Old_FootLocker",["republican_03_uniform",1]],
["Props_AM_Old_FootLocker",["republican_04_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylesuit_outfit03_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylesuit_outfit01_uniform",1]],
["Props_AM_Old_FootLocker",["leatherarmor_01_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylecasual01_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylecasual01_mold_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylecasual02_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylecasual02_mold_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylecasual03_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylecasual03_mold_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylecasual04_uniform",1]],
["Props_AM_Old_FootLocker",["1950stylecasual04_mold_uniform",1]],
["Props_AM_Old_FootLocker",["radiationsuit_uniform",1]],
["Props_AM_Old_FootLocker",["wastelandmerchant01_uniform",1]],
["Props_AM_Old_FootLocker",["wasteland_doctor_01_uniform",1]],
["Props_AM_Old_FootLocker",["wastelandsettler03_uniform",1]],
["Props_AM_Old_FootLocker",["wasteland_clothing_05_uniform",1]],
["Props_AM_MetalBox",["ACE_CableTie",24]],
["Props_AM_MetalBox",["ACE_HandFlare_White",12]],
["Props_AM_MetalBox",["ACE_Cellphone",1]],
["Props_AM_MetalBox",["ACE_EntrenchingTool",4]],
["Props_AM_MetalBox",["ACE_EntrenchingTool",4]],
["Props_AM_MetalBox",["ACE_DefusalKit",1]],
["Props_AM_MetalBox",["MineDetector",1]],
["Props_AM_MetalBox",["Binocular",2]],
["Props_AM_MetalBox",["Binocular",3]],
["Props_AM_MetalBox",["Binocular",1]],
["Props_AM_MetalBox",["optic_am_varmintscope",1]],
["Props_AM_MetalBox",["optic_am_hrs",1]],
["Props_AM_MetalBox",["ACE_Flashlight_Maglite_ML300L",4]],
["Props_AM_Safe",["AM_BCap",1]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap10",1],["AM_BCap",random 9]],
["Props_AM_Safe",["AM_BCap100",1],["AM_BCap",random 9]]
];


cultistMines = {
	for "_i" from 1 to 800 step 1 do {
		_position = ["southMines"] call grabRandomPosition;
		"AM_MineFrag_Ammo" createVehicle _position;
	};
	for "_i" from 1 to 800 step 1 do {
		_position = ["eastMines"] call grabRandomPosition;
		"AM_MineFrag_Ammo" createVehicle _position;
	};
};

grabRandomPosition = {
    params ["_marker"];
    _sizeArray = getMarkerSize _marker;
    _width = _sizeArray select 0;
    _height = _sizeArray select 1;
    _position = getMarkerPos _marker;
    _randomWidth = (floor random (_width*2)) - _width;
    _randomHeight = (floor random (_height*2)) - _height;
    _return = _position vectorAdd [_randomWidth, _randomHeight, 0];
    _return
};
