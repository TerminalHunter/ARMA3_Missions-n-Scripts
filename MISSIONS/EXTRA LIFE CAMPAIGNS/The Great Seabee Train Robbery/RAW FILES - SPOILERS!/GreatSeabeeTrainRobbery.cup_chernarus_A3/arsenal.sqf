playerArsenal = [
  //headgear
  "fow_h_us_daisy_mae_01",
  "fow_h_us_daisy_mae_02",
  "fow_h_us_daisy_mae_03",
  "fow_h_us_m1",
  "fow_h_us_m1_closed",
  "fow_h_us_m1_folded",
  "fow_h_us_m1_medic",
  "fow_h_us_m1_net",
  //facewear
  "G_Aviator",
  "G_Spectacles",
  "G_Squares_Tinted",
  "fow_g_gloves1",
  "fow_g_gloves2",
  "fow_g_gloves3",
  "fow_g_gloves4",
  "fow_g_gloves5",
  "fow_g_gloves6",
  "fow_g_glasses4",
  //uniform
  "fow_u_us_m37_02_private",
  //vest
  "fow_v_us_45",
  "fow_v_us_asst_mg",
  "fow_v_us_bar",
  "fow_v_us_carbine",
  "fow_v_us_carbine_eng",
  "fow_v_us_garand",
  "fow_v_us_garand_bandoleer",
  "fow_v_us_grenade",
  "fow_v_us_medic",
  "fow_v_us_thompson",
  //backpack
  "B_LIB_US_Backpack",
  "B_LIB_US_M36",
  "B_LIB_US_M36_ROPE",
  "fow_b_usa_m1919_support",
  "fow_b_usa_m1919_weapon",
  "RHS_M2_Gun_Bag",
  "RHS_M2_Tripod_Bag",
  "B_LIB_US_Backpack_RocketBag_Empty",
  //weapons and ammo
      //garand
  "rhs_weap_m1garand_sa43",
  "rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle",
  "rhsgref_8Rnd_762x63_M2B_M1rifle",
      //m1 carbine
  "LIB_M1_Carbine",
  "LIB_15Rnd_762x33",
  "LIB_15Rnd_762x33_t",
      //m1911 pistol
  "rhsusf_weap_m1911a1",
  "rhsusf_mag_7x45acp_MHP",
      //BAR
  "LIB_M1918A2_BAR",
  "lib_m1918a2_bar_handle",
  "lib_m1918a2_bar_bipod",
  "LIB_20Rnd_762x63",
  "LIB_20Rnd_762x63_M1",
      //Bazooka
  "LIB_M1A1_Bazooka",
  "LIB_1Rnd_60mm_M6",
      //springfield
  "LIB_M1903A4_Springfield",
  "LIB_5Rnd_762x63",
  "LIB_5Rnd_762x63_M1",
  "LIB_5Rnd_762x63_t",
      //m3
  "rhs_weap_m3a1",
  "rhsgref_30rnd_1143x23_M1T_SMG",
  "rhsgref_30rnd_1143x23_M1T_2mag_SMG",
  "rhsgref_30rnd_1143x23_M1911B_SMG",
  "rhsgref_30rnd_1143x23_M1911B_2mag_SMG",
      //thompson
  "LIB_M1A1_Thompson",
  "LIB_30Rnd_45ACP",
  "LIB_30Rnd_45ACP_t",
  //grenades
  "rhs_grenade_mkii_mag",
  "rhs_grenade_m15_mag",
  "rhs_grenade_anm8_mag",
  //explosives
  "ATMine_Range_Mag",
  "rhs_mine_m3_pressure_mag",
  "rhs_mine_mk2_pressure_mag",
  "LIB_US_TNT_4pound_mag",
  "ACE_DefusalKit",
  "ACE_LIB_LadungPM",
  //slot items
  "LIB_Binocular_US",
  "ItemMap",
  "TFAR_rf7800str",
  "ItemCompass",
  "ItemWatch",
  //item items
  "murshun_cigs_cigpack",
  "murshun_cigs_lighter",
  "murshun_cigs_matches",
  "immersion_pops_poppack",
  "acex_intelitems_notepad",
  "ACE_Banana",
  "ACE_fieldDressing",
  "ACE_packingBandage",
  "ACE_elasticBandage",
  "ACE_bloodIV_500",
  "ACE_EarPlugs",
  "ACE_EntrenchingTool",
  "ACE_epinephrine",
  "ACE_Fortify",
  "ACE_Flashlight_MX991",
  "ACE_MapTools",
  "ACE_morphine",
  "ACE_rope15",
  "ACE_splint",
  "ACE_SpottingScope",
  "ACE_surgicalKit",
  "ACE_tourniquet",
  "fow_i_whistle",
  "Toolkit",
  "ACE_bodyBag",
  "ACE_CableTie"
];

koreanArsenal =
[
  "LIB_PPSh41_m",
  "LIB_71Rnd_762x25_t",
  "fow_w_type99",
  "fow_5Rnd_77x58",
  "rhs_weap_m38",
  "rhsgref_5Rnd_762x54_m38",
  "LIB_DP28",
  "LIB_47Rnd_762x54",
  "LIB_M9130PU",
  "LIB_5Rnd_762x54_t46",
  "rhs_grenade_sthgr43_mag",
  "B_LIB_SOV_RA_Rucksack2_Shinel",
  "H_LIB_SOV_RA_Helmet",
  "H_LIB_SOV_Ushanka",
  "PO_H_Fieldcap_NK",
  "EAW_Hanyang88_Base",
  "EAW_Type24_Rifle_Base",
  "EAW_Hanyang88_Magazine",
  "EAW_Type38_Magazine",
  "EAW_Type30_Rifle"
];

comboArsenal = [];
comboArsenal append playerArsenal;
comboArsenal append koreanArsenal;

//INITS

saveLoadout = {
  profileNamespace setVariable["EXTRALIFE2022_savedLoadout",getUnitLoadout player];
  player setVariable["EXTRALIFE2022_savedLoadout2",getUnitLoadout player];
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

makeStartingArsenal = {
  params ["_jackShack"];

  [_jackShack, playerArsenal] call ace_arsenal_fnc_initBox;

  _jackShack addAction ["Jack Shack Arsenal", {[(_this select 0), player] call ace_arsenal_fnc_openBox;},[],6,true,true,"","true",9,false,"",""];
  _jackShack addAction ["Save Current Loadout as Respawn Loadout",saveLoadout,[],5,true,true,"","true",9,false,"",""];
  _jackShack addAction ["Toggle Loadout Autosave",toggleLoadoutAutosave,[],4,true,true,"","true",9,false,"",""];

};

makeArsenal = {
  params ["_jackShack"];

  [_jackShack, comboArsenal] call ace_arsenal_fnc_initBox;

  _jackShack addAction ["Jack Shack Arsenal", {[(_this select 0), player] call ace_arsenal_fnc_openBox;},[],6,true,true,"","true",9,false,"",""];
  _jackShack addAction ["Save Current Loadout as Respawn Loadout",saveLoadout,[],5,true,true,"","true",9,false,"",""];
  _jackShack addAction ["Toggle Loadout Autosave",toggleLoadoutAutosave,[],4,true,true,"","true",9,false,"",""];

};

makeTrainArsenal = {
  params ["_jackShack"];

  [_jackShack, comboArsenal] call ace_arsenal_fnc_initBox;

  _jackShack addAction ["Mobile Jack Shack Arsenal", {[(_this select 0), player] call ace_arsenal_fnc_openBox;},[],6,true,true,"","true",9,false,"",""];
  _jackShack addAction ["Save Current Loadout as Respawn Loadout",saveLoadout,[],5,true,true,"","true",9,false,"",""];
  _jackShack addAction ["Toggle Loadout Autosave",toggleLoadoutAutosave,[],4,true,true,"","true",9,false,"",""];

};

[arseStart] call makeStartingArsenal;
[arseSwitch] call makeArsenal;
[arseEnd] call makeStartingArsenal;
