reinforcements = createHashMapFromArray [
	["UN",[["rhs_weap_m4a1_carryhandle","","","",["rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red",30],[],""],[],[],["U_civil_UN",[["FirstAidKit",1]]],["V_UN_blue_ballistic",[["rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red",10,30]]],["bc036_invisible_kitbag",[]],"rhsgref_helmet_pasgt_un","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]],
	["spooky",[["cox_weapon_berger50_lesslethal","","","",["40xtra_1Rnd_12g_buckshotdb",1],[],""],[],[],["CUP_U_CRYE_BLK_Full",[]],["cox_PlateCarrierSpec_colorado",[["CUP_6Rnd_12Gauge_HE",20,6],["SmokeShellOrange",2,1]]],["bc036_invisible_tacticalpack",[["MiniGrenade",5,1]]],"cox_modular_colorado","G_Bandanna_CandySkull",[],["","","","","",""]]],
	["kyle",[[],[],["CUP_hgun_Mac10","","","",["CUP_30Rnd_45ACP_Yellow_Tracer_MAC10_M",30],[],""],["U_OrestesBody",[]],["bc036_invisible_carrier",[["cox_item_bag_coke",1],["CUP_30Rnd_45ACP_Yellow_Tracer_MAC10_M",13,30]]],["bc036_invisible_carryall",[]],"","COX_ShutterShades_White",[],["","","","","",""]]],
	["science",[["SMG_03C_black","","","",["50Rnd_570x28_SMG_03",50],[],""],[],[],["CUP_U_C_Labcoat_01",[]],["bc036_invisible_carrier_special",[["CUP_50Rnd_570x28_Red_Tracer_P90_M",8,50]]],[],"xoc_ech_winter1","G_Spectacles",[],["","","","","","NVGogglesB_gry_F"]]],
	["veteran",[["CUP_arifle_M4A1_SOMMOD_ELCAN_snds_black","CUP_muzzle_snds_M16","CUP_acc_ANPEQ_15_Top_Flashlight_Black_L","CUP_optic_Elcan_SpecterDR_RMR_black",["CUP_30Rnd_556x45_PMAG_QP",30],[],""],[],["CUP_hgun_mk23_snds_lam","CUP_muzzle_snds_mk23","CUP_acc_mk23_lam_l","",["CUP_12Rnd_45ACP_mk23",12],[],""],["CUP_U_CRYE_G3C_M81_US_V2",[["CUP_30Rnd_556x45_PMAG_QP",4,30]]],["CUP_V_CPC_Fastbelt_coy",[["CUP_30Rnd_556x45_PMAG_QP",3,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_12Rnd_45ACP_mk23",1,12]]],[],"CUP_H_USA_Cap_MARSOC_DEF","CUP_G_White_Scarf_GPS",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	["antifa",[["CUP_arifle_AK12_GP34_winter","CUP_muzzle_mfsup_Flashhider_545x39_Black","acc_pointer_IR","optic_DMS",["CUP_30Rnd_TE1_Green_Tracer_545x39_AK12_Grey_M",30],["CUP_1Rnd_HE_GP25_M",1],""],[],[],["camo_gaypride",[]],["cox_PlateCarrierSpec_xpPink",[["CUP_30Rnd_TE1_Green_Tracer_545x39_AK12_Grey_M",12,30]]],["cox_APack_xpPink",[["CUP_1Rnd_HE_GP25_M",10,1],["SmokeShell",5,1],["MiniGrenade",5,1]]],"cox_modular_xppink","cox_bandana_avi_transpride",[],["","","","","","NVGogglesB_gry_F"]]],
	["revolutionary",[["rhs_weap_l1a1_wood","rhsgref_acc_falMuzzle_l1a1","","rhsgref_acc_l1a1_l2a2",["CUP_30Rnd_TE1_Red_Tracer_762x51_FNFAL_M",30],[],""],[],["hgun_Pistol_heavy_02_F","","","",["6Rnd_45ACP_Cylinder",6],[],""],["da_sweater_command",[]],["CUP_V_B_Ciras_Olive4",[["CUP_20Rnd_TE1_Red_Tracer_762x51_FNFAL_M",15,20]]],["bc036_invisible_tacticalpack",[["HandGrenade",5,1],["SmokeShell",5,1]]],"CUP_H_SLA_BeretRed","CUP_G_Scarf_Face_Red",[],["","","","","",""]]]
];

reinforcementUnlock = [
	"UN"
];

reinforcementHash = createHashMapFromArray [
	["spooky things", "spooky"],
	["hard drugs", "kyle"],
	["science things (drugs and rockets)", "science"],
	["some real firepower", "veteran"],
	["pride merch and heavy armor", "antifa"],
	["berets and revolutionary material", "revolutionary"]
];

fillGoodieBox = {
	params["_unlocks", "_box"];
	{
		_box addItemCargoGlobal [_x, 10];
	} forEach _unlocks;
};

addUnlocksToArsenal = {
	params["_unlocks", "_name", "_bonus"];
	playerArsenal append _unlocks;
	publicVariable "playerArsenal";
	_saying = "Unlocked " + _name + " in the arsenal!" + _bonus; 
	[_saying] remoteExec ["hint", 0, false];
	[] call updateAllArsenals;
	/*
	REINFORCEMENTS!
	*/
	reinforcementUnlock pushBack (reinforcementHash get _name);
};

setUpUnlock = {
	params["_box", "_unlockList", "_quip"];
	[_unlockList, _box] call fillGoodieBox;
	_newBoxTrigger = createTrigger ["EmptyDetector", _box, true];
	_newBoxTrigger setTriggerArea [5,5,0,true,5];
	_newBoxTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	//_isTrueStatement = "[_unlockList, _quip] call addUnlocksToArsenal;";
	_newBoxTrigger setTriggerStatements [
		"this",
		_quip,
		""
	];
};

noShaveUnlocks = [
	"CUP_Beard_Black",
	"CUP_Beard_Blonde",
	"CUP_Beard_Brown",
	"CUP_G_ESS_BLK_Scarf_White_Beard",
	"CUP_G_ESS_BLK_Scarf_White_Beard_Blonde",
	"CUP_G_White_Scarf_Shades_Beard",
	"CUP_G_White_Scarf_Shades_Beard_Blonde",
	"CUP_G_Beard_Shades_Black",
	"CUP_G_Beard_Shades_Blonde"
];

allSaintsUnlocks = [
	"G_Balaclava_Skull1",
	"G_Bandanna_CandySkull",
	"G_Bandanna_Skull1",
	"G_Bandanna_Syndikat1",
	"G_Bandanna_Skull2",
	"cox_bandana_avi_skull",
	"cox_bandana_skull",
	"cox_bandana_shades_skull",
	"cox_hockeymask_Skull",
	"CUP_G_ESS_RGR_Facewrap_Skull",
	"CUP_PMC_Facewrap_Skull",
	"cox_headgear_bandana_Skull",
	"rhsusf_hgu56p_mask_black_skull",
	"U_I_C_Soldier_Bandit_2_F"
];

maroonedUnlocks = [
	"ACE_MapTools",
	"ace_marker_flags_red"
];

bonfireUnlocks = [
	"ACE_M14",
	"rhs_mag_an_m14_th3",
	"40xtra_nade_in_thermite",
	"40xtra_nade_smoke_wp"
];

orangeUnlocks = [
	"ACE_Chemlight_Orange",
	"ACE_Chemlight_UltraHiOrange",
	"SmokeShellOrange",
	"40xtra_nade_ms_orange",
	"plp_bo_w_BottleLiqOrange"
];

freedomUnlocks = [
	"rhs_weap_SCARH_USA_CQC",
	"rhs_weap_SCARH_USA_LB",
	"rhs_weap_SCARH_USA_STD", 
	"CUP_50Rnd_TE1_Red_Tracer_762x51_SCAR",
	"CUP_50Rnd_TE1_White_Tracer_762x51_SCAR",
	"rhsusf_acc_tacsac_blue",
	"cox_headgear_bandana_USA",
	"rhsusf_hgu56p_usa",
	"rhsusf_hgu56p_visor_usa",
	"cox_bandana_avi_USA",
	"cox_bandana_shades_USA",
	"cox_bandana_USA",
	"cox_hockeymask_USA"
];

hunterUnlocks = [
	"optic_DMS",
	"sgun_HunterShotgun_01_F",
	"2Rnd_12Gauge_Pellets",
	"2Rnd_12Gauge_Slug",
	"sgun_HunterShotgun_01_sawedoff_F",
	"srifle_DMR_06_hunter_F",
	"ACE_20Rnd_762x51_Mag_Tracer",
	"cox_weapon_berger50_hunter",
	"40xtra_6Rnd_12g_buckshotdb",
	"40xtra_6Rnd_12g_buckshothe",
	"40xtra_6Rnd_12g_buckshotslug",
	"40xtra_6Rnd_12g_buckshotSpike",
	"40xtra_6Rnd_12g_buckshotlg",
	"U_B_GhillieSuit",
	"40xtra_nade_ms_white",
	"rhs_mag_rdg2_black",
	"bc036_invisible_bergen",
	"B_Bergen_mcamo_F"
];

guyUnlocks = [
	"ACE_DefusalKit",
	"ACE_M26_Clacker",
	"DemoCharge_Remote_Mag",
	"ATMine_Range_Mag",
	"SatchelCharge_Remote_Mag",
	"ClaymoreDirectionalMine_Remote_Mag",
	"APERSBoundingMine_Range_Mag",
	"APERSTripMine_Wire_Mag",
	"APERSMineDispenser_Mag",
	"ACE_DeadManSwitch"
];

kindUnlocks = [
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_SpraypaintWhite",
	"ACE_SpraypaintYellow"
];

kyleUnlocks = [
	"Combat_Stim_X",
	"ACE_Can_RedGull",
	"COX_ShutterShades_Pink"
];

STEMunlocks = [
	"Dermal_Repair_Matrix",
	"Space_Bandaid",
	"Casualty_Stim",
	"Combat_Stim_A",
	"Space_Painkiller",
	"ACE_bodyBag_white",
	"MineDetector",
	"launch_B_Titan_short_F",
	"Titan_AP",
	"Titan_AT"
];

saganUnlocks = [
	"optic_LRPS",
	"optic_Nightstalker",
	"arifle_MSBS65_UBS_black_F",
	"30Rnd_65x39_caseless_msbs_mag_Tracer",
	"6Rnd_12Gauge_Pellets",
	"6Rnd_12Gauge_Slug",
	"Laserdesignator",
	"Rangefinder",
	"NVGogglesB_blk_F"
];

immuneUnlocks = [
	"ACE_adenosine",
	"Casualty_Stim",
	"Combat_Stim_A",
	"Space_Painkiller"
];

vetUnlocks = [
	"rhs_weap_m249_light_S",
	"CUP_200Rnd_TE4_Red_Tracer_556x45_L110A1",
	"launch_NLAW_F",
	"launch_RPG32_F",
	"RPG32_HE_F",
	"RPG32_F",
	"rhs_weap_m4a1_carryhandle_m203S",
	"1Rnd_HE_Grenade_shell",
	"CUP_1Rnd_StarFlare_White_M203",
	"1Rnd_Smoke_Grenade_shell",
	"1Rnd_SmokeRed_Grenade_shell",
	"1Rnd_SmokeGreen_Grenade_shell",
	"rhs_weap_m1garand_sa43",
	"rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle",
	"rhs_weap_m3a1",
	"rhsgref_30rnd_1143x23_M1T_SMG",
	"rhs_weap_m24sws",
	"rhsusf_5Rnd_762x51_m62_Mag",
	"CUP_Famas_F1",
	"CUP_25Rnd_556x45_Famas_Tracer_Red",
	"rhs_weap_l1a1",
	"rhs_mag_20Rnd_762x51_m62_fnfal",
	"SMG_03C_black",
	"CUP_50Rnd_570x28_Red_Tracer_P90_M",
	"rhs_grenade_mki_mag",
	"rhs_mag_m7a3_cs",
	"CUP_hgun_Deagle",
	"CUP_7Rnd_50AE_Deagle",
	"rhsusf_weap_MP7A2_folded_winter",
	"CUP_40Rnd_46x30_MP7_Red_Tracer",
	"rhs_weap_rsp30_white",
	"rhs_mag_rsp30_white"
];

compUnlocks = [
	"B_UAV_01_backpack_F",
	"B_UAV_06_backpack_F",
	"B_UAV_06_medical_backpack_F",
	"cox_uavbag_xoc_mortar_tube",
	"cox_uavbag_xoc_mortar_bipod",
	"B_UavTerminal",
	"B_UGV_02_Demining_backpack_F",
	"B_UGV_02_Science_backpack_F",
	"B_W_Static_Designator_01_weapon_F",
	"B_Static_Designator_01_weapon_F"
];

transUnlocks = [
	"cox_hockeymask_Pink",
	"cox_hockeymask_rainbow",
	"cox_bandana_shades_transpride",
	"cox_bandana_avi_transpride",
	"cox_bandana_transpride",
	"camo_gaypride",
	"cox_headgear_bandana_transpride",
	"bc036_invisible_carrier_special",
	"V_UN_sand",
	"V_UN_wood",
	"cox_PlateCarrierSpec_xpPink",
	"cox_modular_xppink",
	"CUP_srifle_RSASS_Winter",
	"optic_Hamr",
	"CUP_20Rnd_TE1_White_Tracer_762x51_M110"
];

revolutionUnlocks = [
	"rhs_weap_akmn",
	"arifle_AKM_F",
	"rhs_acc_pso1m21",
	"30Rnd_762x39_Mag_Tracer_Green_F",
	"rhs_75Rnd_762x39mm_tracer",
	"H_Beret_blk",
	"CUP_H_SLA_BeretRed",
	"40xtra_nade_throw_knife",
	"CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_ar15",
	"rhs_weap_rpg7",
	"rhs_rpg7_OG7V_mag",
	"rhs_rpg7_PG7V_mag",
	"rhs_rpg7_PG7VL_mag",
	"rhs_rpg7_PG7VM_mag",
	"rhs_rpg7_PG7VR_mag",
	"rhs_rpg7_PG7VS_mag",
	"rhs_rpg7_TBG7V_mag",
	"rhs_rpg7_type69_airburst_mag",
	"rhs_acc_1pn93_2"
];

//SPAWN STUFF THE PLAYERS CAN PICK UP AS THEY TRAVEL AROUND
startingLootAndTriggers = {
	if (isServer) then {
		////////
		//WEEK 1
		////////

		//ALL SAINTS DAY
		[allSaintsLoot, allSaintsUnlocks, "[allSaintsUnlocks, 'spooky things', ' BONUS: Skeleton soldiers added to reinforcements'] call addUnlocksToArsenal;"] call setUpUnlock;

		//NO SHAVE NOVEMBER
		[beard, noShaveUnlocks, "[noShaveUnlocks, 'facial hair', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//BONFIRE NIGHT
		[bonfireCrate, bonfireUnlocks, "[bonfireUnlocks, 'fire', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//MAROON
		[maroonedCase, maroonedUnlocks, "[maroonedUnlocks, 'some map tools and blazes', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//guy fawkes day
		[guyBox, guyUnlocks, "[guyUnlocks, 'explosives for blowing up parliament', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//paint the world orange
		[orangeCrate, orangeUnlocks, "[orangeUnlocks, 'orange things', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		////////
		//WEEK 2
		////////

		//Hunter's Day
		[hunterBox, hunterUnlocks, "[hunterUnlocks, 'hunting supplies and things Hunter will like', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//World Immunization Day
		[immuneBox, immuneUnlocks, "[immuneUnlocks, 'injectables', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//freedom day
		[freedomBox, freedomUnlocks, "[freedomUnlocks, 'MURICA', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//kindness day
		[kindBox, kindUnlocks, "[kindUnlocks, 'bingo markers', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//kyle day
		[kyleCooler, kyleUnlocks, "[kyleUnlocks, 'hard drugs', ' BONUS: Kyles added to reinforcements'] call addUnlocksToArsenal;"] call setUpUnlock;

		//STEM STEAM DAY
		[STEMbox, STEMunlocks, "[STEMunlocks, 'science things (drugs and rockets)', ' BONUS: Science Team added to reinforcements'] call addUnlocksToArsenal;"] call setUpUnlock;

		//Sagan day
		[saganBox, saganUnlocks, "[saganUnlocks, 'science things (NVGs and a gun)', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//Veteran's day
		[vetBox, vetUnlocks, "[vetUnlocks, 'some real firepower', ' BONUS: Spare soldiers added to reinforcements'] call addUnlocksToArsenal;"] call setUpUnlock;

		////////
		//WEEK 3
		////////

		//Name your computer day
		[compBox, compUnlocks, "[compUnlocks, 'drones and computers without names', ''] call addUnlocksToArsenal;"] call setUpUnlock;

		//trans day of remembrance
		[transBox, transUnlocks, "[transUnlocks, 'pride merch and heavy armor', ' BONUS: Antifa Supersoldiers added to reinforcements'] call addUnlocksToArsenal;"] call setUpUnlock;

		//revolution day
		[revolutionBox, revolutionUnlocks, "[revolutionUnlocks, 'berets and revolutionary material', ' BONUS: Revolutionaries added to reinforcements'] call addUnlocksToArsenal;"] call setUpUnlock;
	};
};

if (isServer) then {
	[] call startingLootAndTriggers;
};

		/*
		KEEP THIS SHIT HERE JUST IN CASE FUCK AAAA
		//ALL SAINTS DAY 
		[allSaintsUnlocks, allSaintsLoot] call fillGoodieBox;
		_allSaintsTrigger = createTrigger ["EmptyDetector", allSaintsLoot, true];
		_allSaintsTrigger setTriggerArea [5,5,0,true,5];
		_allSaintsTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		_allSaintsTrigger setTriggerStatements [
			"this",
			"[allSaintsUnlocks, 'spooky things'] call addUnlocksToArsenal;",
			""
		];*/