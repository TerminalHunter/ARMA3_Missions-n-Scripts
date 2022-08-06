//NOT ANYWHERE CLOSE TO DONE.

//INITS

playerArsenal = [ /* LIST ITEMS HERE */];

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

//FUNCTIONS

makeArsenal = {
  params ["_jackShack"];

  [_jackShack, playerArsenal] call ace_arsenal_fnc_initBox;

  _jackShack addAction ["Jack Shack Arsenal", {[(_this select 0), player] call ace_arsenal_fnc_openBox;},[],1.5,true,true,"","true",5,false,"",""];
  _jackShack addAction["Save Current Loadout as Respawn Loadout",saveLoadout,[],1.5,true,true,"","true",5,false,"",""];
  _jackShack addAction["Toggle Loadout Autosave",toggleLoadoutAutosave,[],1.5,true,true,"","true",5,false,"",""];
	_jackShack addAction["Empty Aluminator",areWeDoneYet,[],1.5,true,true,"","true",5,false,"",""];

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

saveLoadout = {

  //sets client-side variables saved to profile instead of mission namespace
  //should persist between missions
  profileNamespace setVariable["JUNK_Saved_Vest2", vest player];
  profileNamespace setVariable["JUNK_Saved_Uniform2", uniform player];
  profileNamespace setVariable["JUNK_Saved_Headgear2", headgear player];
  profileNamespace setVariable["JUNK_Saved_Backpack2", backpack player];
  profileNamespace setVariable["JUNK_Saved_Facewear2", goggles player];
  profileNamespace setVariable["JUNK_Saved_HMD2", hmd player];

  profileNamespace setVariable["JUNK_Saved_Loadout2",getUnitLoadout player];

  //keep the mission namespace variables just in case?

  player setVariable["JUNK_Saved_Vest2", vest player];
  player setVariable["JUNK_Saved_Headgear2", headgear player];
  player setVariable["JUNK_Saved_Uniform2", uniform player];
  player setVariable["JUNK_Saved_Backpack2", backpack player];
  player setVariable["JUNK_Saved_Facewear2", goggles player];
  player setVariable["JUNK_Saved_HMD2", hmd player];

  player setVariable["JUNK_Saved_Loadout2",getUnitLoadout player];

  hintSilent "Respawn Loadout Saved!";
  sleep 3;
  hintSilent "";

};


/*

EXAMPLE ARSENAL LIST

playerArsenal = [
//uniforms and clothes
"U_C_IDAP_Man_cargo_F",
"U_C_IDAP_Man_Jeans_F",
"U_C_IDAP_Man_casual_F",
"U_C_IDAP_Man_shorts_F",
"U_C_IDAP_Man_Tee_F",
"U_C_IDAP_Man_TeeShorts_F",
"U_I_C_Soldier_Bandit_2_F",
"U_I_C_Soldier_Bandit_5_F",
"U_I_C_Soldier_Bandit_3_F",
"U_C_ArtTShirt_01_v1_F",
"U_C_ArtTShirt_01_v2_F",
"U_C_ArtTShirt_01_v3_F",
"U_C_ArtTShirt_01_v4_F",
"U_C_ArtTShirt_01_v5_F",
"U_C_ArtTShirt_01_v6_F",
"U_C_Man_casual_1_F",
"U_C_Man_casual_2_F",
"U_C_Man_casual_3_F",
"U_C_Man_casual_4_F",
"U_C_Man_casual_5_F",
"U_C_Man_casual_6_F",
"U_C_Poloshirt_blue",
"U_C_Poloshirt_burgundy",
"U_C_Poloshirt_redwhite",
"U_C_Poloshirt_salmon",
"U_C_Poloshirt_stripped",
"U_C_Poloshirt_tricolor",
"U_Competitor",
"U_C_ConstructionCoverall_Black_F",
"U_C_ConstructionCoverall_Blue_F",
"U_C_ConstructionCoverall_Red_F",
"U_C_ConstructionCoverall_Vrana_F",
"U_C_Uniform_Farmer_01_F",
"U_OrestesBody",
"U_C_Journalist",
"U_I_L_Uniform_01_tshirt_black_F",
"U_I_L_Uniform_01_tshirt_skull_F",
"U_I_L_Uniform_01_tshirt_sport_F",
"U_Marshal",
"U_C_Mechanic_01_F",
"U_NikosBody",
"U_C_Paramedic_01_F",
"U_Rangemaster",
"U_C_Uniform_Scientist_01_formal_F",
"U_C_Uniform_Scientist_01_F",
"U_C_Uniform_Scientist_02_formal_F",
"U_C_Uniform_Scientist_02_F",
"U_C_man_sport_1_F",
"U_C_man_sport_2_F",
"U_C_man_sport_3_F",
"U_C_WorkerCoveralls",
"U_C_Poor_1",
"U_B_Wetsuit",
"U_BG_Guerilla2_1",
"U_BG_Guerilla2_2",
"U_BG_Guerilla2_3",

//helmets and hats
"H_Bandanna_gry",
"H_Bandanna_blu",
"H_Bandanna_cbr",
"H_Bandanna_khk",
"H_Bandanna_mcamo",
"H_Bandanna_sgg",
"H_Bandanna_sand",
"H_Bandanna_surfer",
"H_Bandanna_surfer_blk",
"H_Bandanna_surfer_grn",
"H_Bandanna_camo",
"H_PASGT_basic_black_F",
"H_PASGT_basic_blue_F",
"H_PASGT_basic_olive_F",
"H_PASGT_basic_white_F",
"H_Booniehat_mgrn",
"H_Booniehat_khk",
"H_Booniehat_mcamo",
"H_Booniehat_oli",
"H_Booniehat_tan",
"H_Booniehat_taiga",
"H_Booniehat_wdl",
"H_Booniehat_dgtl",
"H_Booniehat_eaf",
"H_Cap_grn_BI",
"H_Cap_blk",
"H_Cap_Black_IDAP_F",
"H_Cap_Orange_IDAP_F",
"H_Cap_blu",
"H_Cap_blk_CMMG",
"H_Cap_grn",
"H_Cap_blk_ION",
"H_Cap_grn_oli",
"H_Cap_press",
"H_Cap_red",
"H_Cap_surfer",
"H_Cap_tan",
"H_Cap_khaki_specops_UK",
"H_Cap_usblack",
"H_Cap_tan_specops_US",
"H_Cap_White_IDAP_F",
"H_Cap_blk_Raven",
"H_Cap_brn_SPECOPS",
"H_EarProtectors_black_F",
"H_EarProtectors_orange_F",
"H_EarProtectors_red_F",
"H_EarProtectors_white_F",
"H_EarProtectors_yellow_F",
"H_Construction_basic_black_F",
"H_Construction_basic_orange_F",
"H_Construction_basic_red_F",
"H_Construction_basic_vrana_F",
"H_Construction_basic_white_F",
"H_Construction_basic_yellow_F",
"H_Hat_blue",
"H_Hat_brown",
"H_Hat_camo",
"H_Hat_checker",
"H_Hat_grey",
"H_Hat_tan",
"H_PASGT_basic_blue_press_F",
"H_Hat_Safari_olive_F",
"H_Hat_Safari_sand_F",
"H_Helmet_Skate",
"H_StrawHat",
"H_StrawHat_dark",
"H_Hat_Tinfoil_F",
//vests
"V_Plain_crystal_F",
"V_Plain_medical_F",
"V_LegStrapBag_black_F",
"V_LegStrapBag_coyote_F",
"V_LegStrapBag_olive_F",
"V_Pocketed_black_F",
"V_Pocketed_coyote_F",
"V_Pocketed_olive_F",
"V_RebreatherB",
"V_Safety_blue_F",
"V_Safety_orange_F",
"V_Safety_yellow_F",
"1715_vest_engblk_cartouche",
"1715_vest_eng_cartouche",
"rhs_lifchik_light",
"rhs_chicom_khk",
"rhs_chicom",
"V_HarnessO_brn",
"V_BandollierB_blk",
"V_BandollierB_cbr",
"V_BandollierB_ghex_F",
"V_BandollierB_rgr",
"V_BandollierB_khk",
"V_BandollierB_oli",
//backpacks
"B_LegStrapBag_black_F",
"B_LegStrapBag_coyote_F",
"B_LegStrapBag_olive_F",
"B_CivilianBackpack_01_Everyday_IDAP_F",
"B_Messenger_IDAP_F",
"ACE_TacticalLadder_Pack",
"B_FieldPack_blk",
"B_FieldPack_cbr",
"B_FieldPack_green_F",
"B_FieldPack_khk",
"B_FieldPack_oli",
"B_Kitbag_cbr",
"B_Kitbag_rgr",
"B_Kitbag_sgg",
"B_Kitbag_tan",
//facewear
"G_Aviator",
"G_Lady_Blue",
"G_Respirator_blue_F",
"G_Respirator_white_F",
"G_Respirator_yellow_F",
"G_EyeProtectors_F",
"G_Shades_Black",
"G_Shades_Blue",
"G_Shades_Red",
"G_Shades_Green",
"G_Spectacles",
"G_Sport_Greenblack",
"G_Sport_Red",
"G_Sport_Blackyellow",
"G_Sport_BlackWhite",
"G_Sport_Checkered",
"G_Sport_Blackred",
"G_Squares_Tinted",
"G_Squares",
"G_Spectacles_Tinted",
//other
"Binocular",
"ItemMap",
"TFAR_anprc152",
"ItemCompass",
"ItemWatch",
"TFAR_microdagr",
//"weapons"
"ACE_VMM3",
"ACE_Flashlight_Maglite_ML300L",
//items
"plp_bo_w_AfterSun",
"ACE_Banana",
"ACE_fieldDressing",
"ACE_elasticBandage",
"ACE_packingBandage",
"ACE_quikclot",
"plp_bo_w_BeachBat",
"plp_bo_w_BocceBalls",
"ACE_bodyBag",
"ACE_CableTie",
"ACE_DefusalKit",
"ACE_EarPlugs",
"ACE_EntrenchingTool",
"ACE_epinephrine",
"plp_bo_w_GlassAperitif",
"plp_bo_w_GlassCocktail",
"plp_bo_w_GlassDrink",
"ACE_Humanitarian_Ration",
"ACE_Flashlight_XL50",
"ACE_MapTools",
"MineDetector",
"ACE_morphine",
"ACE_rope12",
"ACE_rope15",
"ACE_salineIV_500",
"ACE_splint",
"plp_bo_w_SunBlocker",
"plp_bo_w_SunMilk",
"ACE_surgicalKit",
"Toolkit",
"ACE_tourniquet",
"ACE_WaterBottle",
"ACE_wirecutter",
// "grenades"
"ACE_Chemlight_HiBlue",
"ACE_Chemlight_HiGreen",
"ACE_Chemlight_HiRed",
"ACE_Chemlight_HiWhite",
"ACE_Chemlight_HiYellow",
"ACE_Chemlight_UltraHiOrange",
"ACE_HandFlare_Green",
"ACE_HandFlare_Red",
"ACE_HandFlare_White",
"ACE_HandFlare_Yellow",
// the rest
"CSW_M26C",
"CSW_Taser_Probe_Mag",
"hgun_Pistol_Signal_F",
"6Rnd_GreenSignal_F",
"6Rnd_RedSignal_F",
"immersion_pops_poppack",
"acex_intelitems_notepad"
];

*/
