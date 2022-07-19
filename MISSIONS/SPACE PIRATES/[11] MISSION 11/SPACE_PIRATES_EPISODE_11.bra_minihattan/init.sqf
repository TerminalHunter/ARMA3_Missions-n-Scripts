#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "story.sqf"
#include "spacePirateShip.sqf"
//#include "carbonBetatronTreasureScanner.sqf"
//#include "spaceTeamDirector.sqf"
//#include "spaceTeamCustomActions.sqf"
enableSaving [false, false];

[jackShack] call makePirateArsenal;
[jackShack2] call makePirateArsenal;
[jackShack3] call makePirateArsenal;

//ENABLE FORTIFY TOOL!
if (isServer) then {
  [west, 25, [
    ["Land_VR_CoverObject_01_kneel_F", 1],
    ["Land_VR_CoverObject_01_stand_F", 1],
    ["TIOW_Dragons_teeth", 1],
    ["Land_MEOP_build_Turian_Barrier", 1],
    ["Land_ToiletBox_F", 2],
    ["Land_OPTRE_M72_barrierBlk", 3],
    ["Land_PortableLight_single_F", 1]
  ]] call ace_fortify_fnc_registerObjects;
};

if (isServer) then {
  _doorDeleterArray = theActualShip nearObjects 400;
  {
    if (typeOf _x isEqualTo "OPTRE_holotable_sm" or typeOf _x isEqualTo "OPTRE_Corvette_M910_Turret_u" or typeOf _x isEqualTo "OPTRE_Corvette_archer_system" or typeOf _x isEqualTo "OPTRE_Corvette_M910_Turret") then {
      deleteVehicle _x;
    };
  } forEach _doorDeleterArray;
};


//LIGHT'S FUCKING WEIRD
staticLightPoint = "#lightpoint" createVehicleLocal [0,0,0];
staticLightPoint setLightColor [0,0,0];
staticLightPoint setLightAmbient [0.3, 0.1, 1.0];
staticLightPoint setLightAttenuation [20000,0,0,0];
staticLightPoint setLightIntensity 25;

ohShitMoment = {
  _redBoi = 0.3;
  _bluBoi = 1.0;
  _greBoi = 0.1;
  while {_redBoi < 1} do {
    staticLightPoint setLightAmbient [_redBoi, _greBoi, _bluBoi];
    _redBoi = _redBoi + 0.01;
    if (_bluBoi > 0.02) then {
      _bluBoi = _bluBoi - 0.02;
    };
    if (_greBoi > 0.01) then {
      _greBoi = _greBoi - 0.01;
    };
    sleep 0.1;
  };
};

//oh shit moment should be
//staticLightPoint setLightAmbient [1.0, 0.0, 0.1];

//centerBunker 200m

sci_Fi_Civvie_People = [
  "SC_SE_Warbot_Heavy",
  "SC_SE_Crewman",
  "SC_SE_Guard_Officer",
  "SC_SE_Guard_Rifleman_H",
  "SC_SE_Warbot_Heavy",
  "SC_SE_Guard_Marksman",
  "SC_SE_Guard_Medic",
  "SC_SE_Guard_Ranger_H",
  "SC_SE_Guard_Rifleman_H",
  "SC_SE_Guard_Rifleman_M"
];

sci_Fi_Guard_People = [
  "SC_SE_Guard_Rifleman_H",
  "SC_SE_Guard_Rifleman_H",
  "SC_SE_Guard_Rifleman_H",
  "SC_SE_Guard_Officer",
  "SC_SE_Guard_Marksman",
  "SC_SE_Guard_Medic"
];

//THIS NEEDS A REFACTOR -- TERRIBLY!
//GOD I LOVE THIS SCRIPT BUT HOLY SHIT.
fillBuildingCivvie = {
  params ["_building", "_fractionNumber","_noAI"];
  _positionArray = _building buildingPos -1;
  if (count _positionArray > 1) then {
    _buildingGroup = [[542.293,1132.58,0], EAST, [selectRandom sci_Fi_Civvie_People]] call BIS_fnc_spawnGroup;
    _buildingGroup deleteGroupWhenEmpty true;
    for "_i" from 1 to ((count _positionArray) - 1) do {
        _buildingGroup createUnit [selectRandom sci_Fi_Civvie_People, [542.293,1132.58,0], [], 0, "NONE"];
    };
    {
        _currSoldier = (units _buildingGroup) select _forEachIndex;
        _currSoldier setPosASL (AGLtoASL _x);
        if (_noAI) then {
          _currSoldier disableAI "PATH";
        };
    } forEach _positionArray;
    {
      if (!(floor random _fractionNumber == 1)) then {
        deleteVehicle _x;
      };
    } forEach units _buildingGroup;
    if (!_noAI) then {
      [_buildingGroup, getPos _building, 50, 1, false, 0.1] call CBA_fnc_taskDefend;
    };
  };
};

fillBuildingGuard = {
  params ["_building", "_fractionNumber","_noAI"];
  _positionArray = _building buildingPos -1;
  if (count _positionArray > 1) then {
    _buildingGroup = [[542.293,1132.58,0], EAST, [selectRandom sci_Fi_Guard_People]] call BIS_fnc_spawnGroup;
    _buildingGroup deleteGroupWhenEmpty true;
    for "_i" from 1 to ((count _positionArray) - 1) do {
        _buildingGroup createUnit [selectRandom sci_Fi_Guard_People, [542.293,1132.58,0], [], 0, "NONE"];
    };
    {
        _currSoldier = (units _buildingGroup) select _forEachIndex;
        _currSoldier setPosASL (AGLtoASL _x);
        if (_noAI) then {
          _currSoldier disableAI "PATH";
        };
    } forEach _positionArray;
    {
      if (!(floor random _fractionNumber == 1)) then {
        deleteVehicle _x;
      };
    } forEach units _buildingGroup;
    if (!_noAI) then {
      [_buildingGroup, getPos _building, 50, 1, false, 0.1] call CBA_fnc_taskDefend;
    };
  };
};

fillTurret = {
  params ["_turret"];
  _turretGroup = [[542.293,1132.58,0], EAST, [selectRandom sci_Fi_Civvie_People]] call BIS_fnc_spawnGroup;
  _turretGroup deleteGroupWhenEmpty true;
  ((units _turretGroup) select 0) moveInAny _turret;
};

deepStrike = {
  params ["_location"];
  _dropPod = "TIOW_Drop_Pod_WB" createVehicle [542.293,1132.58,0];
  _firstHalf = [[542.293,1132.58,0], EAST, (configfile >> "CfgGroups" >> "East" >> "TIOW_ChaosSpaceMarines" >> "TIOW_CSM_WB_Squads" >> "TIOW_Group_SM_WB_Tact_1")] call BIS_fnc_spawnGroup;
  //_secondHalf = [[542.293,1132.58,0], EAST, (configfile >> "CfgGroups" >> "East" >> "TIOW_ChaosSpaceMarines" >> "TIOW_CSM_WB_Squads" >> "TIOW_Group_SM_WB_Tact_1")] call BIS_fnc_spawnGroup;
  {
    _x moveInAny _dropPod;
  } forEach (units _firstHalf);
  //{
  //  _x moveInAny _dropPod;
  //} forEach (units _secondHalf);
  _dropPod setPosASL _location;
};

orbitalCannonSpawnEnemies = {
  {
    [_x, 3, false] call fillBuildingCivvie;
  } forEach (nearestObjects [orbitCenter, ['TIOW_Walkway_Long','TIOW_Bastion_green','Land_PierWooden_01_16m_F','Land_Bunker_01_HQ_F','Land_Bunker_01_big_F'], 120]);
};

CBTrustSpawnEnemies = {
  {
    [_x, 7, false] call fillBuildingCivvie;
  } forEach (nearestObjects [centerBunker, ['BUILDING'], 250]);

  {
    [_x] call fillTurret;
  } forEach ((getPos centerBunker) nearObjects ["TIOW_IG_MissileLauncher_AA_836_Blu", 250]);
  //TIOW_IG_MissileLauncher_AA_836_Blu
  {
    [_x] call fillTurret;
  } forEach ((getPos centerBunker) nearObjects ["TIOW_IG_Autocannon_1489_Blu", 250]);
  //TIOW_IG_Autocannon_1489_Blu
};

justTheTip = [
  tip1,
  tip2,
  top1,
  top2
];

corners = [
  corn1,
  corn2,
  corn3,
  corn4,
  tow1,
  tow2,
  tow3,
  tow4
];

//centerCathedral
cathedralSpawnEnemies = {
  //cathedral proper spawns
  {
    [_x, 12, false] call fillBuildingGuard;
  } forEach (nearestObjects [centerCathedral, ["land_imp_cathedral_gothic_deadend1","land_imp_cathedral_gothic_entrance1","land_imp_cathedral_gothic_hallway1","land_imp_cathedral_gothic_junction1"], 250]);
  //just the tip of the towers
  {
    [_x, 6, false] call fillBuildingGuard;
  } forEach justTheTip;
  {
    [_x, 2, false] call fillBuildingGuard;
  } forEach corners;
  {
    [_x] call fillTurret;
  } forEach ((getPos centerBunker) nearObjects ["TIOW_IG_Lascannon_RenBlack_OP", 250]);
};
//FOR TESTING PUROSES THESE WERE SWITCHED TO FALSE. DURING MISSION ACTUAL THEY WERE TRUE

//first senpai strike @ cbt
firstSENPAI = {
  [[2012.35,1776.23,800]] call deepStrike;
  [[1938.4,1774.1,800]] call deepStrike;
  [[1820.06,1715.32,800]] call deepStrike;
  [[1909.2,1619.59,800]] call deepStrike;
  _itIsTheBANEBLADE = "chaosbaneblade" createVehicle [2125.6,1981.9,0];
  _BANEBLADEgroup = [[542.293,1132.58,0], EAST, ["TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher"]] call BIS_fnc_spawnGroup;
  {
    _x moveInAny _itIsTheBANEBLADE;
  } forEach (units _BANEBLADEgroup);
  _waypointBANEBLADE = _BANEBLADEgroup addWaypoint [[2029.76,1700.37,0.00143862], 0];
};

unlockTeleportersOrbital = {
  startBarTele addAction ["[Chapter 1] Teleport to Orbital Cannon", {player setPosASL (getPosASL orbitalTele)}, [], 1.5, true, true, "", "true", 10, false, "", ""];
};

unlockTeleportersCBT = {
  startBarTele addAction ["[Chapter 2] Teleport to Central Brain Trust", {player setPosASL (getPosASL CBTrustTele)}, [], 1.5, true, true, "", "true", 10, false, "", ""];
};

unlockTeleportersPalace = {
  startBarTele addAction ["[Chapter 4] Teleport to Summer Palace", {player setPosASL (getPosASL palaceTele)}, [], 1.5, true, true, "", "true", 10, false, "", ""];
};

spawnEmperor = {
  _theIllustriousGroup = [[4691.5,2322.25,0], EAST, ["O_soldier_Melee_SW"]] call BIS_fnc_spawnGroup;
  _theEmperor = (units _theIllustriousGroup) select 0;
  _theEmperor setUnitLoadout [[],[],["WBK_lightsaber_sith","","","",["WBK_Cybercrystal",30],[],""],["Hum_Defender_alRed_F_CombatUniform",[]],[],[],"Tur_helmet_TechArmHeavyBlue","IC_sos_mask_01",[],["","","","","","TIOW_Bionic_Eye"]];
  [_theEmperor, "WhiteHead_15_Husk"] remoteExec ["setFace", 0, false];
  //and add an extra spawn point
  [missionNamespace, [4690.68,2042.48,10.0114], "?????"] call BIS_fnc_addRespawnPosition;
  //WHY THE FUCK DOES THIS USE ATL?! EVERYTHING ELSE USES ASL AND AGL. FUCK.
};


//-----------

musicTester addAction ["Start Music Test", {playMusic "manTheCannons"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Man the Cannons' · Galactikraken · Jonathan Young · Starship Velociraptor", {}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["Stop Music", {playMusic ""}, [], 1.5, true, true, "", "true", 10, false, "", ""];

/*
easterEggBeerLabels2021/spacePiratesFinaler

list of teleporters:
startBarTele
orbitalTele
CBTrustTele
palaceTele

mission flow

hang at bar
take out the orbital cannon
take out the Central Brain Trust
repel first SENPAI raid
take out palace / assassinate emperor
defend the pub + ship

*/

orbitalTele addAction ["Teleport to Pub", {player setPosASL (getPosASL startBarTele)}, [], 1.5, true, true, "", "true", 10, false, "", ""];
CBTrustTele addAction ["Teleport to Pub", {player setPosASL (getPosASL startBarTele)}, [], 1.5, true, true, "", "true", 10, false, "", ""];
palaceTele addAction ["Teleport to Pub", {player setPosASL (getPosASL startBarTele)}, [], 1.5, true, true, "", "true", 10, false, "", ""];
extraTeleThrone addAction ["Teleport to Cathedral", {player setPosASL (getPosASL extraTeleCathedral)}, [], 1.5, true, true, "", "true", 10, false, "", ""];
extraTeleCathedral addAction ["Teleport to ?????", {player setPosASL (getPosASL extraTeleThrone)}, [], 1.5, true, true, "", "true", 10, false, "", ""];

//everyone hangs out at the bar until it's time to go
//when that is the case, [] call chapter1;

chapter1 = {
  if (isServer) then {
    //spawn enemies
    [] call orbitalCannonSpawnEnemies;
    //unlock the teleporters
    [] remoteExec ["unlockTeleportersOrbital", 0, true];
  };
};

//orbital cannon goes down - teleport back to bar - set up for CBT attack

chapter2 = {
  if (isServer) then {
    //spawn enemies
    [] call CBTrustSpawnEnemies;
    //unlock the teleporters
    [] remoteExec ["unlockTeleportersCBT", 0, true];
  };
};

//while still shutting down the CBT - SENPAI attacks

chapter3 = {
  if (isServer) then {
    //spawn enemies
    [] call firstSENPAI;
    //set lights to red
    [] remoteExec ["ohShitMoment", 0, true];
    [] remoteExec ["SENPAIStoryText", 0, false];
  };
};

//back to the pub and onto the palace while we still can!

chapter4 = {
  if (isServer) then {
    //spawn enemies
    [] call cathedralSpawnEnemies;
    //unlock teleporters
    [] remoteExec ["unlockTeleportersPalace", 0 ,true];
  };
};

//assassinate the emperor

chapter5 = {
  if (isServer) then {
    [] call spawnEmperor;
  };
};

//defend the pony express from SENPAI... if we can...
chapter6 = {
  if (isServer) then {
    [] remoteExec ["chapter6ShortRangeTele", 0, true];
  };
};

titanList = [
  "TIOW_Warhound_MP_PBG_OP_T",
  "TIOW_Warhound_MP_TLD_OP_T",
  "TIOW_Warhound_MP_VMB_OP_T"
];

chapter6StartingPoints = [
  [3128.55,3716.67,0],
  [2798,3592.5,0],
  [2518,3467.5,0],
  [2445.75,3247.5,0],
  [2498,2854.25,0],
  [2802,2598.75,0],
  [3134.48,2498.65,0]
];



titanAttackBar = {
  _startLoc = selectRandom chapter6StartingPoints;
  _newTitan = (selectRandom titanList) createVehicle _startLoc;
  _titanGroup = [[542.293,1132.58,0], EAST, ["TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher"]] call BIS_fnc_spawnGroup;
  {
    _x moveInAny _newTitan;
  } forEach (units _titanGroup);
  _waypointTitan = _titanGroup addWaypoint [[3134.6,3089.28,0], 0];
  _waypointTitan setWaypointType "SAD";
};

banebladeAttackBar = {
  _startLoc = selectRandom chapter6StartingPoints;
  _itIsTheBANEBLADE = "chaosbaneblade" createVehicle _startLoc;
  _BANEBLADEgroup = [[542.293,1132.58,0], EAST, ["TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher","TIOW_OP_Chaos_Preacher"]] call BIS_fnc_spawnGroup;
  {
    _x moveInAny _itIsTheBANEBLADE;
  } forEach (units _BANEBLADEgroup);
  _waypointBANEBLADE = _BANEBLADEgroup addWaypoint [[3134.6,3089.28,0], 0];
  //_waypointBANEBLADE setWaypointType "SAD";
};

chaosMarines = [
  (configfile >> "CfgGroups" >> "East" >> "TIOW_ChaosSpaceMarines" >> "TIOW_CSM_WB_Squads" >> "TIOW_Group_SM_WB_Tact_1"),
  (configfile >> "CfgGroups" >> "East" >> "TIOW_ChaosSpaceMarines" >> "TIOW_CSM_DG_Squads" >> "TIOW_Group_SM_DG_Tact_1")
];

marinesAttackBar = {
    _marinesGroup = [(selectRandom chapter6StartingPoints), EAST, (selectRandom chaosMarines)] call BIS_fnc_spawnGroup;
    _waypointMarines = _marinesGroup addWaypoint [[3134.6,3089.28,0], 0];
    _waypointMarines setWaypointType "SAD";
};

meleeMarinesAttackBar = {
    _marinesGroup = [(selectRandom chapter6StartingPoints), EAST, ["STeve_Melee_Troops_DG","STeve_Melee_Troops_DG","STeve_Melee_Troops_DG","STeve_Melee_Troops_DG"]] call BIS_fnc_spawnGroup;
    _waypointMarines = _marinesGroup addWaypoint [[3134.6,3089.28,0], 0];
    _waypointMarines setWaypointType "SAD";
};

chapter6SpawnCodes = [
  titanAttackBar,
  banebladeAttackBar,
  marinesAttackBar,
  marinesAttackBar,
  marinesAttackBar,
  meleeMarinesAttackBar
];

somethingAttackBar = {
  [] call (selectRandom chapter6SpawnCodes);
};

chapter6ShortRangeTele = {
  removeAllActions startBarTele;
  startBarTele addAction ["[1-WAY] Under Foxy Beer Sign", {player setPosASL [3168.54,3071.32,23.5504]}, [], 1.5, true, true, "", "true", 10, false, "", ""];
  startBarTele addAction ["[1-WAY] Roof of this Pub", {player setPosASL [3166.07,3120.75,24.6351]}, [], 1.5, true, true, "", "true", 10, false, "", ""];
  startBarTele addAction ["[1-WAY] Near Waffle House", {player setPosASL [3183.42,3150.61,5.00144]}, [], 1.5, true, true, "", "true", 10, false, "", ""];
  startBarTele addAction ["[1-WAY] Roof of Building North of Pub", {player setPosASL [3163.07,3167.59,83.0177]}, [], 1.5, true, true, "", "true", 10, false, "", ""];
  startBarTele addAction ["[1-WAY] Ground Floor of Building South of Pub", {player setPosASL [3175.47,3067.04,5.05041]}, [], 1.5, true, true, "", "true", 10, false, "", ""];
};

//dread1 and dread2 are just pre-loaded and I really hope that doesn't fuck

// -----------

//TESTING
if (isServer) then {
  //[] call CBTrustSpawnEnemies;
  //[] call orbitalCannonSpawnEnemies;
  //[] call firstSENPAI;
  //[] call cathedralSpawnEnemies
};
