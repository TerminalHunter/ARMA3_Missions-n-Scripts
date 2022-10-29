koreanUniform = "LOP_U_Fatigue_BDU_KOR_BRW_01";
koreanHelmets = ["H_LIB_SOV_RA_Helmet","","H_LIB_SOV_Ushanka","PO_H_Fieldcap_NK"];
koreanVests = "V_LIB_SOV_RAZV_PPShBelt";
koreanBackpack = "B_LIB_SOV_RA_Rucksack2_Shinel";

koreanBurp = "LIB_PPSh41_m";
koreanBurpAmmo = "LIB_71Rnd_762x25_t";

koreanSurplus = "fow_w_type99";
koreanSurplusAmmo = "fow_5Rnd_77x58";

koreanRifle = "rhs_weap_m38";
koreanRifleAmmo = "rhsgref_5Rnd_762x54_m38";

koreanLMG = "LIB_DP28";
koreanLMGAmmo = "LIB_47Rnd_762x54";

koreanSniper = "LIB_M9130PU";
koreanSniperAmmo = "LIB_5Rnd_762x54_t46";

koreanGrenade = "rhs_grenade_sthgr43_mag";

koreanLoadouts = [
  //no gun only grenades
  [[],[],[],["LOP_U_Fatigue_BDU_KOR_BRW_01",[]],["V_LIB_SOV_RAZV_PPShBelt",[["rhs_grenade_sthgr43_mag",2,1]]],["B_LIB_SOV_RA_Rucksack2_Shinel",[["rhs_grenade_sthgr43_mag",8,1]]],"H_LIB_SOV_RA_Helmet","fow_g_gloves4",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
  //burpGun repeated 3x
  [["LIB_PPSh41_m","","","",["LIB_71Rnd_762x25_t",71],[],""],[],[],["LOP_U_Fatigue_BDU_KOR_BRW_01",[]],["V_LIB_SOV_RAZV_PPShBelt",[["rhs_grenade_sthgr43_mag",2,1]]],["B_LIB_SOV_RA_Rucksack2_Shinel",[["LIB_71Rnd_762x25_t",10,71],["rhs_grenade_sthgr43_mag",1,1]]],"H_LIB_SOV_RA_Helmet","fow_g_gloves4",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
  [["LIB_PPSh41_m","","","",["LIB_71Rnd_762x25_t",71],[],""],[],[],["LOP_U_Fatigue_BDU_KOR_BRW_01",[]],["V_LIB_SOV_RAZV_PPShBelt",[["rhs_grenade_sthgr43_mag",2,1]]],["B_LIB_SOV_RA_Rucksack2_Shinel",[["LIB_71Rnd_762x25_t",10,71],["rhs_grenade_sthgr43_mag",1,1]]],"H_LIB_SOV_RA_Helmet","fow_g_gloves4",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
  [["LIB_PPSh41_m","","","",["LIB_71Rnd_762x25_t",71],[],""],[],[],["LOP_U_Fatigue_BDU_KOR_BRW_01",[]],["V_LIB_SOV_RAZV_PPShBelt",[["rhs_grenade_sthgr43_mag",2,1]]],["B_LIB_SOV_RA_Rucksack2_Shinel",[["LIB_71Rnd_762x25_t",10,71],["rhs_grenade_sthgr43_mag",1,1]]],"H_LIB_SOV_RA_Helmet","fow_g_gloves4",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
  //surplus japanese rifles
  [["fow_w_type99","","","",["fow_5Rnd_77x58",5],[],""],[],[],["LOP_U_Fatigue_BDU_KOR_BRW_01",[]],["V_LIB_SOV_RAZV_PPShBelt",[["rhs_grenade_sthgr43_mag",2,1]]],["B_LIB_SOV_RA_Rucksack2_Shinel",[["fow_5Rnd_77x58",15,5]]],"H_LIB_SOV_RA_Helmet","fow_g_gloves4",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
  //standard mosin rifles
  [["rhs_weap_m38","","","",["rhsgref_5Rnd_762x54_m38",5],[],""],[],[],["LOP_U_Fatigue_BDU_KOR_BRW_01",[]],["V_LIB_SOV_RAZV_PPShBelt",[["rhs_grenade_sthgr43_mag",2,1]]],["B_LIB_SOV_RA_Rucksack2_Shinel",[["rhsgref_5Rnd_762x54_m38",15,5]]],"H_LIB_SOV_RA_Helmet","fow_g_gloves4",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
  //lmg
  [["LIB_DP28","","","",["LIB_47Rnd_762x54",47],[],""],[],[],["LOP_U_Fatigue_BDU_KOR_BRW_01",[]],["V_LIB_SOV_RAZV_PPShBelt",[["rhs_grenade_sthgr43_mag",2,1]]],["B_LIB_SOV_RA_Rucksack2_Shinel",[["LIB_47Rnd_762x54",8,47]]],"H_LIB_SOV_RA_Helmet","fow_g_gloves4",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
  //sniper mosin
  [["LIB_M9130PU","","","",["LIB_5Rnd_762x54",5],[],""],[],[],["LOP_U_Fatigue_BDU_KOR_BRW_01",[]],["V_LIB_SOV_RAZV_PPShBelt",[["rhs_grenade_sthgr43_mag",2,1]]],["B_LIB_SOV_RA_Rucksack2_Shinel",[["LIB_5Rnd_762x54_t46",15,5]]],"H_LIB_SOV_RA_Helmet","fow_g_gloves4",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
];

spawnNKGroup = {
  params ["_pos"];
  _newGroup = [_pos, EAST, ["LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman"]] call BIS_fnc_spawnGroup;
  _newGroup deleteGroupWhenEmpty true;
  {
    _x setUnitLoadout (selectRandom koreanLoadouts);
    _x addHeadgear (selectRandom koreanHelmets);
  } forEach units _newGroup;
  _newWaypoint = _newGroup addWaypoint [getPos (selectRandom allPlayers), 5];
  _newWaypoint setWaypointType "SAD";
  _newGroup
};

spawnNKGrenade = {
  params ["_pos"];
  _newGroup = [_pos, EAST, ["LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman"]] call BIS_fnc_spawnGroup;
  _newGroup deleteGroupWhenEmpty true;
  {
    _x setUnitLoadout (koreanLoadouts select 0);
    _x addHeadgear (selectRandom koreanHelmets);
  } forEach units _newGroup;
  _newWaypoint = _newGroup addWaypoint [getPos (selectRandom allPlayers), 5];
  _newWaypoint setWaypointType "SAD";
  _newGroup
};

spawnNKSingle = {
  params ["_pos"];
  _newGroup = [_pos, EAST, ["LOP_NK_Infantry_Rifleman"]] call BIS_fnc_spawnGroup;
  _newGroup deleteGroupWhenEmpty true;
  {
    removeHeadgear _x;
    _x setUnitLoadout (selectRandom koreanLoadouts);
    _x addHeadgear (selectRandom koreanHelmets);
  } forEach units _newGroup;
  _newGroup
};

/*
Ambush Zone 1 - CASTLE!
fortSpawn1
fortSpawn2
fortSpawn3
*/
