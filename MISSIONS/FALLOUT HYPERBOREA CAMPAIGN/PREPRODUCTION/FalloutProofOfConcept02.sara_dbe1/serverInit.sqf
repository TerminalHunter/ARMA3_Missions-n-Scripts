//Main map preparation. 
//Send hint messages to players to inform them of map prep and do said map prep
mapApocalypsizing = {
	missionNamespace setVariable ["mapInitFinished",false];
	missionNamespace setVariable ["magicNumber",0];

	//Send hint messages to players while loading
	[]spawn{
		while {not (missionNamespace getVariable ["mapInitFinished",false])} do {
			if ((missionNamespace getVariable ["magicNumber",0]) > 15) then {	
				if ((missionNamespace getVariable["magicNumber",0]) == 69) then {
					["Map Init In Progress\nDo not leave spawn area\n"+str(missionNamespace getVariable["magicNumber",0])+" seconds elapsed\nNice.","hint"] call BIS_fnc_MP;
				} else{
					if ((missionNamespace getVariable["magicNumber",0]) > 500) then {
						["Map Init In Progress\nDo not leave spawn area\n"+str(missionNamespace getVariable["magicNumber",0])+" seconds elapsed\nSomething probably fucked up.\nYell at Terminal.","hint"] call BIS_fnc_MP;
					} else{
						["Map Init In Progress\nDo not leave spawn area\n"+str(missionNamespace getVariable["magicNumber",0])+" seconds elapsed","hint"] call BIS_fnc_MP;
					};
				};
			};
			sleep 1;
			_newMagicNumber = (missionNamespace getVariable["magicNumber",0]) + 1;
			missionNamespace setVariable ["magicNumber",_newMagicNumber];
		};	
	};
	
	//start actually Apocalypsize'ing the map -- make more like an apocalypse
	[]spawn{
		private _worldObjects = [];
		{
			if (not (toLower(str _x) find 'castle' > -1)) then {
				if (not (toLower(str _x) find 'wall_stone' > -1)) then {
					if (not (toLower(str _x) find 'ruin' > -1)) then {
						if (not (toLower(str _x) find 'wreck' > -1)) then {
							_worldObjects pushBack _x;
						};
					};
				};
			};
		} forEach nearestTerrainObjects [initRespawnPoint,["BUILDING","HOUSE","FENCE","WALL", "VIEW-TOWER","HIDE","FOUNTAIN"],worldSize*2,true];
//TODO replace initRespawnPoint with better object
		_origOffset = 125;
		_currOffset = _origOffset;
		{
			if (_currOffset > 0) then {
				_currOffset = _currOffset - 1;
				hideObjectGlobal _x;
			} else{
				sleep 0.02;
				hideObjectGlobal _x;
				_currOffset = _origOffset;
			};
		} forEach _worldObjects;
		[_worldObjects] call spreadFixedLoot;
		[] call spreadLootCaches;
		missionNamespace setVariable ["mapInitFinished",true];
		sleep 1;
		["Map Init Finished - Begin Mission","hint"] call BIS_fnc_MP;
	};
};

//Part of map apocalypsize'ing - spreads new ruins/destroyed items and spawns loot for players to find
//requires array of world objects that were hidden - replaces some objects with randomized ruins
spreadFixedLoot = {
	params ["_worldObjects"];
	_objectNumber = 0;
	_num = 0;
	{
		if (!((getPos _x) isFlatEmpty [1, -1, 0.01, 9, -1] isEqualTo[])) then{
			_objectNumber = _objectNumber - 1;
			if (_objectNumber < 0) then {
				_ruin = createVehicle [(selectRandom ruinsList),(getPos _x)];
				_ruin setDir (random 360);
				_ruin setPos [(getPos _ruin) select 0, (getPos _ruin) select 1, 0];
				//debug markers
				//"|marker_"+ str _num +"|"+str(getPos _x)+"|mil_pickup|ICON|[1,1]|0|Solid|Default|1|Placed_Ruin" call BIS_fnc_stringToMarker;
				_num = _num + 1;
				_objectNumber = random 2;
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
//
spreadLootCaches = {
	_density = 40;
	_spread = worldSize / _density;
	for "_i" from 1 to _density step 1 do{
		for "_j" from 1 to _density step 1 do{
			_cacheLocation = [(_spread*_i)-_spread+random(_spread*2),(_spread*_j)-_spread+random(_spread*2),0];
			if (!(surfaceIsWater _cacheLocation)) then{
			//debug markers
			//"|marker_"+ str _i + "-" + str _j +"|"+str(_cacheLocation)+"|mil_dot|ICON|[1,1]|0|Solid|Default|1|Cache_Boi" call BIS_fnc_stringToMarker;
			[_cacheLocation, false] spawn createLootBox;
			for "_campObjectNumber" from 0 to (random 4) step 1 do{
				_campObjectLocation = [(_cacheLocation select 0) - 5 + (random 10),(_cacheLocation select 1) - 5 + (random 10), 0];
				_campObject = createVehicle [(selectRandom campList),_campObjectLocation];
				_campObjectLootLoc = [(_cacheLocation select 0) - 5 + (random 10),(_cacheLocation select 1) - 5 + (random 10), 0];
				[_campObjectLootLoc, false] spawn createLootBox;
				};
			};
		};
	};
};

//Part of map apocalypsize'ing - creates singular box with loot in it
//requires a location be passed to it AND bool - true if it needs to spawn 5 meters in the air to ensure it doesn't clip into ruins/false if no position adjustment needed
//has special cases for medical loot and ammunition
createLootBox = {
	params ["_location","_adjust"];
	if (_adjust) then{
		_location = _location vectorAdd [0,0,5];
	};
	_cacheLootBox = selectRandom lootBoxen;
	_cacheLootBoxBox = createVehicle [(_cacheLootBox select 0), _location];
	_cacheLootBoxBox setDir (random 360);
	clearItemCargoGlobal _cacheLootBoxBox;
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
				_extraLoot = random [0,1,4];
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
				_numAmmo = random [8,12,18];
				_cacheLootBoxBox addItemCargoGlobal [_gun,2];
				_cacheLootBoxBox addItemCargoGlobal [_ammo,_numAmmo];
				if (count _gunType == 3) then {
					_acc = _gunType select 2;
					_cacheLootBoxBox addItemCargoGlobal [_acc,2];
				};
			};
			case "RARELOOT":{ //this is bad. You should have a better system.
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
"Props_AM_diner",
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
"Land_Campfire_F",
"Props_AM_tent2",
"Props_AM_tent2",
"Land_CampingChair_V2_white_F",
"Land_WoodenTable_small_F",
"Land_CampingTable_small_white_F",
"Props_AM_tent2S",
"Land_moonshinedistillery",
"Props_AM_Mattress",
"Props_AM_MetalBarrel",
"Props_AM_toilet",
"Props_AM_barrel",
"Props_AM_am_table02",
"Land_tincan01",
"Land_tincan02"
];

medicalLootCommon = {
	_return = [selectRandom ["ACE_packingBandage","ACE_elasticBandage","ACE_quikclot","Aftermath_Duct_Tape","Aftermath_Healing_Powder"],1];
	_return
	
};

medicalLootUncommon = {
	_return = [selectRandom ["ACE_packingBandage","ACE_elasticBandage","ACE_quikclot","Aftermath_Duct_Tape","Aftermath_Healing_Powder","ACE_morphine","ACE_tourniquet","ACE_epinephrine","ACE_salineIV_500","ACE_splint","ACE_plasmaIV_500","Aftermath_RadawayIV_500","ACE_adenosine","Aftermath_AutoInject_Stimpak","Aftermath_Jet","Aftermath_Medx","Aftermath_Psycho"],1];
	_return
};

medicalLootRare = {
	_return = [selectRandom ["ACE_surgicalKit","ACE_salineIV_500","ACE_splint","ACE_plasmaIV_500","Aftermath_RadawayIV_500","ACE_adenosine","Aftermath_AutoInject_Stimpak","Aftermath_Stimpak","Aftermath_Jet","Aftermath_Medx","Aftermath_Psycho"],1];
	_return
};

ammunitionCivilianList = [
"8Rnd_45x70_HP",
"8Rnd_357",
"10Rnd_308_Mag",
"10Rnd_308_AP_Mag",
"5Rnd_12ga_pel_Mag",
"5Rnd_12ga_sl_Mag",
"5Rnd_12ga_pel_Mag",
"5Rnd_12ga_sl_Mag",
"8Rnd_44Magnum_Mag",
"8Rnd_556x45_Mag",
"8Rnd_556x45_SRP_Mag",
"LIB_8Rnd_762x63",
"LIB_10Rnd_770x56",
"LIB_10Rnd_770x56",
"LIB_10Rnd_770x56",
"LIB_32Rnd_9x19_Sten",
"LIB_30Rnd_M3_GreaseGun_45ACP",
"6Rnd_357_Cyl",
"16Rnd_9x21_Mag",
"16Rnd_10mm_Mag",
"ACE_40mm_Flare_white"
];

gunCivilianList = [
["AM_BrushGun", "8Rnd_45x70_HP"],
["AM_CowboyRepeater","8Rnd_357"],
["AM_HuntingRifle","10Rnd_308_Mag"],
["AM_HuntingShotgun","5Rnd_12ga_pel_Mag"],
["AM_LeverShotgun","5Rnd_12ga_pel_Mag"],
["AM_ShortSG","5Rnd_12ga_pel_Mag"],
["AM_TrailCarbineW","8Rnd_44Magnum_Mag"],
["AM_VarmintRifleOld","8Rnd_556x45_SRP_Mag"],
["LIB_M1_Garand","LIB_8Rnd_762x63","lib_acc_m1_bayo"],
["LIB_LeeEnfield_No4","LIB_10Rnd_770x56","lib_acc_no4_mk2_bayo"],
["LIB_LeeEnfield_No4","LIB_10Rnd_770x56","lib_acc_no4_mk2_bayo"],
["LIB_LeeEnfield_No4","LIB_10Rnd_770x56","lib_acc_no4_mk2_bayo"],
["LIB_Sten_Mk2","LIB_32Rnd_9x19_Sten"],
["LIB_M3_GreaseGun","LIB_30Rnd_M3_GreaseGun_45ACP"],
["AM_M79One","ACE_40mm_Flare_white"],
["AM_357Rev_HDShort","6Rnd_357_Cyl"],
["AM_browning9mm","16Rnd_9x21_Mag"],
["AM_10mmPistol","16Rnd_10mm_Mag"]
];

ammunitionCivilian = {
	_numberOfMags = random [4,8,18];
	_magType = selectRandom ammunitionCivilianList;
	_return = [_magType, _numberOfMags];
	_return
};

lootBoxen = [
["Land_PaperBox_01_small_closed_white_med_F","medicalLootCommon","medicalLootUncommon","medicalLootUncommon","medicalLootRare"],
["ACE_medicalSupplyCrate_advanced","medicalLootCommon","medicalLootUncommon","medicalLootUncommon","medicalLootRare"],
["Land_PlasticCase_01_small_idap_F","medicalLootCommon","medicalLootUncommon","medicalLootUncommon","medicalLootRare"],
["Props_AM_AmmoBox","ammoLoot"],
["Props_AM_AmmoBox","ammoLoot"],
["Props_AM_AmmoBox","ammoLoot"],
["Land_MetalCase_01_medium_F","gunLoot"],
["Land_MetalCase_01_medium_F","gunLoot"],
["Land_HelipadEmpty_F","RARELOOT"],
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
["Land_MetalCase_01_small_F",["AM_BBGun",1],["100Rnd_BB_Mag",5]],
["Land_WoodenCrate_01_F",["LIB_Bagpipes",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_abraxo",6]],
["Land_PaperBox_01_small_closed_brown_F",["AM_ashtray",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_baseball",3],["AM_baseballglove",10]],
["Land_PaperBox_01_small_closed_brown_F",["AM_basketball",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_bigplate",5]],
["Land_PaperBox_01_small_closed_brown_F",["AM_bobbypin",2]],
["Land_PaperBox_01_small_closed_brown_F",["AM_surbonesaw",1]],
["Land_PaperBox_01_small_closed_brown_F",["_AM_bubblegum",100]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Camera",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_chessboard",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_counductor",2]],
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
["Land_PaperBox_01_small_closed_brown_F",["AM_moonshinejug",3]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Nuka_Empty",24]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Nuka_Empty",23],["AM_Nuka_Full",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_potatocrisps",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_scrapelectronics",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_spoon",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Ingot",10]],
["Land_PaperBox_01_small_closed_brown_F",["AM_sugarbombs",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_timer",1]],
["Land_PaperBox_01_small_closed_brown_F",["AM_toycar",4]],
["Land_PaperBox_01_small_closed_brown_F",["AM_yumyumdeviledeggs",12]],
["Land_PaperBox_01_small_closed_brown_F",["AM_Tequila",2],["AM_whiskeybottle01",2],["AM_Scotch_New",2],["AM_Tequila",2],["partyhat",12],["ACE_Chemlight_HiRed",20],["ACE_Chemlight_HiGreen",20],["ACE_Chemlight_HiBlue",20]],
["Land_PaperBox_01_small_closed_brown_F",["ACE_Banana",6]],
["Land_PaperBox_01_small_closed_white_med_F",["surgical_mask",40]],
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
["Props_AM_MetalBox",["ACE_Cellphone",1]],
["Props_AM_MetalBox",["ACE_EntrenchingTool",4]],
["Props_AM_MetalBox",["ACE_wirecutter",1]],
["Props_AM_MetalBox",["Binocular",1]],
["Props_AM_Safe",["AM_BCap",1]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap",random 12]],
["Props_AM_Safe",["AM_BCap10",1],["AM_BCap",random 9]],
["Props_AM_Safe",["AM_BCap100",1],["AM_BCap",random 9]]
];