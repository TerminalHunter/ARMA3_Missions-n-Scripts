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
  params ["_pos", "_chasePlayers", "_destination"];
  _newGroup = [_pos, EAST, ["LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman"]] call BIS_fnc_spawnGroup;
  _newGroup deleteGroupWhenEmpty true;
  {
    _x setUnitLoadout (selectRandom koreanLoadouts);
    _x addHeadgear (selectRandom koreanHelmets);
  } forEach units _newGroup;
  if (_chasePlayers) then {
    _newWaypoint = _newGroup addWaypoint [getPos (selectRandom allPlayers), 5];
    _newWaypoint setWaypointType "SAD";
  } else {
    _newWaypoint = _newGroup addWaypoint [_destination, 5];
    _newWaypoint setWaypointType "SAD";
  };
  _newGroup
};

spawnNKEasy = {
  params ["_pos"];
  _newGroup = [_pos, EAST, ["LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman","LOP_NK_Infantry_Rifleman"]] call BIS_fnc_spawnGroup;
  _newGroup deleteGroupWhenEmpty true;
  {
    _x setUnitLoadout (koreanLoadouts select 1);
    _x addHeadgear (selectRandom koreanHelmets);
  } forEach units _newGroup;
  _newGroup setFormDir 190;
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

spawnNKSingleSniper = {
  params ["_pos"];
  _newGroup = [_pos, EAST, ["LOP_NK_Infantry_Rifleman"]] call BIS_fnc_spawnGroup;
  _newGroup deleteGroupWhenEmpty true;
  {
    removeHeadgear _x;
    _x setUnitLoadout (koreanLoadouts select 5);
    _x addHeadgear (selectRandom koreanHelmets);
    _x disableAI "PATH";
    _x setPosASL (getPosASL dongSniper);
  } forEach units _newGroup;
  _newGroup
};

spawnMarines = {
  params ["_pos", "_chasePlayers", "_destination"];
  _newGroup = [_pos, INDEPENDENT, (configfile >> "CfgGroups" >> "Indep" >> "fow_usmc" >> "Infantry" >> "fow_usmc_RifleSquad")] call BIS_fnc_spawnGroup;
  _newGroup deleteGroupWhenEmpty true;
  if (_chasePlayers) then {
    _newWaypoint = _newGroup addWaypoint [getPos (selectRandom allPlayers), 5];
    _newWaypoint setWaypointType "SAD";
  } else {
    _newWaypoint = _newGroup addWaypoint [_destination, 5];
    _newWaypoint setWaypointType "SAD";
  };
  _newGroup
};


/*
Ambush Zone 1 - CASTLE!
fortSpawn1
fortSpawn2
fortSpawn3
*/


//MISSION AI SPAWNING - ENEMY DIRECTOR

generalMissionDifficulty = 100;
generalMissionEnemyGroups = 8;
serverTriggerAmbush1 = false;
serverTriggerAmbush2 = false;
serverTriggerAmbush3 = false;
serverTriggerAmbush4 = false;

ambush1Locs = [
  fortSpawn1,
  fortSpawn2,
  fortSpawn3,
  fortSpawn4
];

ambush1Dests = [
  ambush1Dest
];

ambush2Dests = [
  sabo2_3
];

ambush3Dests = [
  sabo3_1
];

finaleDests = [
  finaleDest01,
  finaleDest02,
  finaleDest03,
  finaleDest04
];

ambush2Locs = [
  lumberSpawn1,
  lumberSpawn2,
  lumberSpawn3
];

ambush3Locs = [
  wonson1,
  wonson2,
  wonson3,
  wonson4,
  wonson5
];

ambush4Locs = [
  finale01,
  finale02,
  finale03,
  finale04
];

marineLocs = [
  marineSpawn
];

startDirectorAI = {
  params ["_ambushLocationArray", "_defaultAmbushDestination"];
  //clean up all previous enemies
  {
    deleteVehicle _x;
  } forEach (units east);
  // I guess that's 20ish minutes
  private _stopTime = time + 1337;
  //loop until ambush over
  while {time < _stopTime} do {
    if (east countSide allGroups < generalMissionEnemyGroups) then {
      [getPos (selectRandom _ambushLocationArray), true, ""] call spawnNKGroup;
    };
    sleep (generalMissionDifficulty + floor (random generalMissionDifficulty));
  };
  {
    [getPos _x, false, (getPos (selectRandom _defaultAmbushDestination))] call spawnNKGroup;
  } forEach _ambushLocationArray;
};

startMarineAI = {
  params ["_ambushLocationArray", "_defaultAmbushDestination"];
  // I guess that's 20ish minutes
  private _stopTime = time + 1337;
  //spawn a bunch of enemies
  {
    [getPos _x, false, (getPos (selectRandom _defaultAmbushDestination))] call spawnMarines;
  } forEach _ambushLocationArray;
  //loop until ambush over
  while {time < _stopTime} do {
    sleep ((generalMissionDifficulty*3) + floor (random generalMissionDifficulty));
    [getPos (selectRandom _ambushLocationArray), true, ""] call spawnMarines;
  };
};

if (isServer) then {
  [] spawn {
    waitUntil {sleep 5; serverTriggerAmbush1};
    [ambush1Locs, ambush1Dests] spawn startDirectorAI;
  };

  [] spawn {
    waitUntil {sleep 5; serverTriggerAmbush2};
    [ambush2Locs, ambush2Dests] spawn startDirectorAI;
  };

  [] spawn {
    waitUntil {sleep 5; serverTriggerAmbush3};
    [ambush3Locs, ambush3Dests] spawn startDirectorAI;
  };

  [] spawn {
    waitUntil {sleep 5; serverTriggerAmbush4};
    [ambush4Locs, finaleDests] spawn startDirectorAI;
    [marineLocs, finaleDests] spawn startMarineAI;
  };
};

spiceUpAmbush1 = {
  //the castle
  {
    [getPos _x, true, ""] call spawnNKGroup;
  } forEach ambush1Locs;
};

spiceUpAmbush2 = {
  //the lumberyard
  {
    [getPos _x, true, ""] call spawnNKGroup;
  } forEach ambush2Locs;
};

spiceUpAmbush3 = {
  //wonson
  {
    [getPos _x, true, ""] call spawnNKGroup;
  } forEach ambush3Locs;
};

spiceUpAmbush4 = {
  //coastal finale
  {
    [getPos _x, false, (getPos (selectRandom finaleDests))] call spawnNKGroup;
  } forEach ambush4Locs;
};

/*
general plan - trigger spawns enemies at all spawners, for the next 20-ish minutes they keep spawning every now and then

idea: if a player is too close to spawner - offset spawn area away from player- recurse away from all players
*/
