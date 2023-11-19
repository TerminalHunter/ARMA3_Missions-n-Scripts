playerArsenal = [
	//HELMS
	"rhsgref_helmet_pasgt_un",
	"CUP_H_CDF_H_PASGT_UN",
	"rhsgref_ssh68_un",
	"H_beret_UN",
	"H_helmet_crew_UN",
	"H_PASGT_UN",
	"rhsgref_un_beret",
	"CUP_H_CDF_Beret_UN",
	"bc036_invisible_light_combat",
	"H_Cap_blu",
	"H_MilCap_blue",
	"H_PASGT_basic_blue_F",
	"H_Cap_Black_IDAP_F",
	"H_Cap_Orange_IDAP_F",
	"H_Cap_White_IDAP_F",
	//UNIFORMS
	"U_civil_UN",
	"U_C_IDAP_Man_cargo_F",
	"U_C_IDAP_Man_Jeans_F",
	"U_C_IDAP_Man_casual_F",
	"U_C_IDAP_Man_shorts_F",
	"U_C_IDAP_Man_Tee_F",
	"U_C_IDAP_Man_TeeShorts_F",
	"uniform_nflwinter",
	"uniform_alt_nflwinter",
	"sweater_fl_winter",
	"white_uniform",
	"white_uniform_alt",
	"uniform_full_white",
	"uniform_alt_full_white",
	"sweater_plain_white",
	"sweater_b_white",
	"uniform_winterstripe",
	"uniform_alt_winterstripe",
	"sweater_winterstripe",
	"uniform_nxtaiga",
	"uniform_alt_nxtaiga",
	"camo_winter2",
	"camo_winter2_alt",
	"uniform_nxwinter",
	"uniform_alt_nxwinter",
	"sweater_navyblue",
	//VESTS
	"V_UN_blue_ballistic",
	"V_UN_blue_ballistic_medic",
	"V_UN_sand_light",
	"V_UN_tactical",
	"bc036_invisible_carrier_lite",
	"bc036_invisible_tacvest",
	"bc036_invisible_lbv",
	"V_Plain_crystal_F",
	"V_Plain_medical_F",
	"V_LegStrapBag_black_F",
	"V_LegStrapBag_coyote_F",
	"V_LegStrapBag_olive_F",
	"V_Safety_blue_F",
	//BACKPACKS
	"bc036_invisible_assaultpack",
	"bc036_invisible_carryall",
	"bc036_invisible_fieldpack",
	"bc036_invisible_kitbag",
	"bc036_invisible_tacticalpack",
	"ACE_TacticalLadder_Pack",
	"B_CivilianBackpack_01_Everyday_IDAP_F",
	"B_Messenger_IDAP_F",
	"B_Messenger_Black_F",
	"B_Messenger_Gray_F",
	"B_UAV_01_backpack_F",
	"cox_APack_white",
	"fl_APack_winter",
	"cox_APack_winterstripe",
	"xoc_APack_winter2",
	"xoc_APack_winter1",
	"CUP_O_RUS_Patrol_bag_Winter",
	"TFAR_rt1523g_black",
	//FACEWEAR
	"G_Aviator",
	"G_Balaclava_blk",
	"G_Balaclava_BlueStrips",
	"G_Balaclava_combat",
	"G_Bandanna_aviator",
	"G_Bandanna_blk",
	"G_Bandanna_khk",
	"G_Combat",
	"G_Squares",
	"G_Tactical_Black",
	"G_Spectacles_Tinted",
	"G_Respirator_blue_F",
	"G_Respirator_white_F",
	"G_EyeProtectors_F",
	"cox_bandana_White",
	"cox_bandana_avi_White",
	"CUP_G_RUS_Balaclava_Ratnik_winter",
	"CUP_G_RUS_Balaclava_Ratnik_winter_v2",
	"CUP_PMC_Facewrap_Winter",
	"CUP_G_PMC_Facewrap_Winter_Glasses_Dark_Headset",
	"CUP_G_PMC_Facewrap_Winter_Glasses_Dark",
	"CUP_G_PMC_Facewrap_Winter_Glasses_Ember",
	"CUP_G_Scarf_Face_White",
	"CUP_G_TK_RoundGlasses",
	"CUP_G_White_Scarf_Shades",
	"CUP_FR_NeckScarf4",
	"rhsusf_shemagh_white",
	"rhsusf_shemagh2_white",
	"rhsusf_shemagh_gogg_white",
	"rhsusf_shemagh2_gogg_white",
	//BINOS
	"Laserdesignator",
	"Binocular",
	//SUNDRIES
	"ItemMap",
	"ItemGPS",
	"B_UavTerminal",
	"TFAR_anprc152",
	"ItemCompass",
	"ItemWatch",
	
	//WEAPONS
	"rhs_weap_m4a1_carryhandle",
	"rhs_mag_30Rnd_556x45_M196_Stanag_Tracer_Red",
	"rhsusf_acc_harris_bipod",
	"rhsusf_acc_anpeq15side_bk",
	"optic_Yorris",
	"optic_ACO_grn",
	"optic_Aco",

	//"rhs_weap_m72a7",

	"rhsusf_weap_m9",
	"rhsusf_mag_15Rnd_9x19_FMJ",

	//ITEMS
	"ACE_EntrenchingTool",
	"ACE_Flashlight_XL50",
	"ToolKit",
	"ACE_elasticBandage",
	"ACE_packingBandage",
	"ACE_quikclot",
	"ACE_epinephrine",
	"ACE_morphine",
	"ACE_personalAidKit",
	"ACE_plasmaIV",
	"ACE_plasmaIV_250",
	"ACE_plasmaIV_500",
	"ACE_splint",
	"ACE_surgicalKit",
	"ACE_tourniquet",
	"ACE_CableTie"

];

allArsenals = [];

makeArsenal = {
params ["_jackShack"];

	[_jackShack, playerArsenal] call ace_arsenal_fnc_initBox;

	_jackShack addAction ["Jack Shack Arsenal", {[(_this select 0), player] call ace_arsenal_fnc_openBox;},[],6,true,true,"","true",9,false,"",""];
	_jackShack addAction ["Save Current Loadout as Respawn Loadout",saveLoadout,[],5,true,true,"","true",9,false,"",""];
	_jackShack addAction ["Toggle Loadout Autosave",toggleLoadoutAutosave,[],4,true,true,"","true",9,false,"",""];

	allArsenals pushBack _jackShack;
};

updateAllArsenals = {
	{
		[_x, playerArsenal, true] call ace_arsenal_fnc_addVirtualItems;
	} forEach allArsenals;
};

saveLoadout = {
  profileNamespace setVariable["EXTRALIFE2022_savedLoadout_FINAL",getUnitLoadout player];
  player setVariable["EXTRALIFE2022_savedLoadout2_FINAL",getUnitLoadout player];
  hintSilent "Respawn Loadout Saved!";
  sleep 3;
  hintSilent "";
};


//autosave toggle option init
if (isNil {profileNamespace getVariable "arseAutosavePref"}) then {
	profileNamespace setVariable ["arseAutosavePref", true];
};

//Event Handler that auto-saves the loadout when the ace arsenal is closed
if (!isServer) then {
	["ace_arsenal_displayClosed",{
		if (profileNamespace getVariable "arseAutosavePref") then {
			[] spawn saveLoadout;
		};
	}] call CBA_fnc_addEventHandler;
};

toggleLoadoutAutosave = {
	if (profileNamespace getVariable ["arseAutosavePref", true]) then {
		profileNamespace setVariable ["arseAutosavePref", false];
		hintSilent "Loadout Autosave OFF";
	}else{
		profileNamespace setVariable ["arseAutosavePref", true];
		hintSilent "Loadout Autosave ON";
	};
};