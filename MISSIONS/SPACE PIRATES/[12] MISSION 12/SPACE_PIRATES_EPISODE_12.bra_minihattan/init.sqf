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

//ENABLE FORTIFY TOOL!
if (isServer) then {
  [west, 50, [
    ["Land_SandbagBarricade_01_half_F", 1],
    ["Land_SandbagBarricade_01_hole_F", 1],
    ["Land_MEOP_build_Turian_Barrier", 1],
    ["Land_OPTRE_M72_barrierBlk", 1],
    ["land_TIOW_Skyshield_Wall_short", 1],
    ["Land_PortableLight_single_F", 1],
    ["RF_Bunker", 1],
    ["Land_Bunker_01_blocks_3_F", 1],
    ["Land_Bunker_01_small_F", 1],
    ["Land_Bunker_01_tall_F", 1],
    ["Land_Bunker_01_HQ_F", 1],
    ["Land_Bunker_01_big_F", 1],
    ["Land_ToiletBox_F", 1]
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

/*
//LIGHT'S FUCKING WEIRD
staticLightPoint = "#lightpoint" createVehicleLocal [0,0,0];
staticLightPoint setLightColor [0,0,0];
staticLightPoint setLightAmbient [0.3, 0.1, 1.0];
staticLightPoint setLightAttenuation [20000,0,0,0];
staticLightPoint setLightIntensity 50;
*/

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

deepStrike = {
  params ["_location"];
  _dropPod = "TIOW_Drop_Pod_WB" createVehicle [542.293,1132.58,0];
  _firstHalf = [[542.293,1132.58,0], EAST, (configfile >> "CfgGroups" >> "East" >> "TIOW_ChaosSpaceMarines" >> "TIOW_CSM_WB_Squads" >> "TIOW_Group_SM_WB_Tact_1")] call BIS_fnc_spawnGroup;
  {
    _x moveInAny _dropPod;
  } forEach (units _firstHalf);
  _dropPod setPosASL _location;
};

listOfLightsabers = [
  "WBK_lightsaber4_jedi",
  "WBK_lightsaber4_green",
  "WBK_lightsaber4_purple",
  "WBK_lightsaber4_sith",
  "WBK_lightsaber4_yellow",
  "WBK_lightsaber3_jedi",
  "WBK_lightsaber3_green",
  "WBK_lightsaber3_pink",
  "WBK_lightsaber3_purple",
  "WBK_lightsaber3_sith",
  "WBK_lightsaber3_white",
  "WBK_lightsaber3_yellow",
  "WBK_lightsaber2_jedi",
  "WBK_lightsaber2_green",
  "WBK_lightsaber2_pink",
  "WBK_lightsaber2_purple",
  "WBK_lightsaber2_sith",
  "WBK_lightsaber2_white",
  "WBK_lightsaber2_yellow",
  "WBK_lightsaber1_jedi",
  "WBK_lightsaber1_green",
  "WBK_lightsaber1_pink",
  "WBK_lightsaber1_purple",
  "WBK_lightsaber1_sith",
  "WBK_lightsaber1_white",
  "WBK_lightsaber1_yellow",
  "WBK_lightsaber_jedi",
  "WBK_lightsaber_green",
  "WBK_lightsaber_pink",
  "WBK_lightsaber_purple",
  "WBK_lightsaber_sith",
  "WBK_lightsaber_white",
  "WBK_lightsaber_yellow"
];



emperorAttackBar = {
  _location = getPos empLightning;
  _snackrifice = "Land_HelipadEmpty_F" createVehicle _location;
  [_snackrifice, nil, true] spawn BIS_fnc_moduleLightning;
  _theIllustriousGroup = [getPos empLightning_1, INDEPENDENT, ["O_soldier_Melee_SW"]] call BIS_fnc_spawnGroup;
  _theEmperor = (units _theIllustriousGroup) select 0;
  _theEmperor setUnitLoadout [[],[],[selectRandom listOfLightsabers, "", "", "", ["WBK_Cybercrystal",30],[],""], ["Hum_Defender_alRed_F_CombatUniform",[["WBK_Cybercrystal",3,30],["Force_tir_3",1,30]]], [], [], "Tur_helmet_TechArmHeavyBlue", "IC_sos_mask_01", [], ["","","","","","TIOW_Bionic_Eye"]];
  [_theEmperor, "WhiteHead_15_Husk"] remoteExec ["setFace", 0, false];
  _waypointEmpire = _theIllustriousGroup addWaypoint [[3134.6,3089.28,0], 0];
};

empireAttackBar = {
  _empireGroup = [(selectRandom chapter6StartingPoints), INDEPENDENT, ["SC_SE_Guard_Rifleman_H","SC_SE_Guard_Rifleman_H","SC_SE_Guard_Rifleman_H","SC_SE_Guard_Medic","SC_SE_Guard_Marksman"]] call BIS_fnc_spawnGroup;
  _waypointEmpire = _empireGroup addWaypoint [[3134.6,3089.28,0], 0];
  _waypointEmpire setWaypointType "SAD";
};

empire2AttackBar = {
  _empireGroup = [(selectRandom chapter6StartingPoints), INDEPENDENT, ["SC_SE_Urban_Rifleman_H","SC_SE_Urban_Rifleman_H","SC_SE_Urban_Rifleman_AT","SC_SE_Urban_Rifleman_AA","SC_SE_Urban_Medic","SC_SE_Urban_Marksman"]] call BIS_fnc_spawnGroup;
  _waypointEmpire = _empireGroup addWaypoint [[3134.6,3089.28,0], 0];
  _waypointEmpire setWaypointType "SAD";
};

empireTankAttackBar = {
  _empireTank = "SC_Mantis" createVehicle _startLoc;
  _empireGroup = [[542.293,1132.58,0], INDEPENDENT, ["SC_SE_Crewman","SC_SE_Crewman","SC_SE_Crewman"]] call BIS_fnc_spawnGroup;
  {
    _x moveInAny _empireTank;
  } forEach (units _empireGroup);
  _waypointEmpire = _empireGroup addWaypoint [[3134.6,3089.28,0], 0];
};

//-----------

musicTester addAction ["Stop Music", {playMusic ""}, [], 20, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Man the Cannons' · Galactikraken/Jonathan Young · Starship Velociraptor", {playMusic "manTheCannons"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Army of Tigers' · Galactikraken/Jonathan Young · Starship Velociraptor", {playMusic "armyOfTigers"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Glory or Gold' · Galactikraken/Jonathan Young · Starship Velociraptor", {playMusic "gloryOrGold"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Storm the Castle' · Galactikraken/Jonathan Young · Starship Velociraptor", {playMusic "stormTheCastle"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Take Control' · Old Gods of Asgard · Control OST", {playMusic "takeControl"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Puritania' · Dimmu Borgir · Puritanical Euphoric Misanthropia", {playMusic "puritania"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Puritania (Remix)' · Dimmu Borgir/The Enigma TNG", {playMusic "puritaniaRemix"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Sexualizer (Metal)' · Perturbator/Alex Yarmak", {playMusic "sexualizer"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Paris (Metal)' · M|O|O|N/Alex Yarmak", {playMusic "paris"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Decade Dance (Metal)' · Jasper Byrne/Alex Yarmak", {playMusic "decadeDance"}, [], 1.5, true, true, "", "true", 10, false, "", ""];
musicTester addAction ["'Ready To Die' · Andrew W.K. · I Get Wet", {playMusic "readyToDie"}, [], 1.5, true, true, "", "true", 10, false, "", ""];

titanList = [
  "TIOW_Warhound_MP_PBG_OP_T",
  "TIOW_Warhound_MP_TLD_OP_T",
  "TIOW_Warhound_MP_VMB_OP_T"
];

chapter6StartingPoints = [
  [2261.5,2690.5,0], //South West (park)
  [3164.75,2600.5,0], //South
  [3782.75,3072,0], //very east
  [3172,3621.75,0], //north
  [2338.88,3514.42,0] //north west
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
  _waypointBANEBLADE = _BANEBLADEgroup addWaypoint [[3143.71,3097.11,0], 0];
  //_waypointBANEBLADE setWaypointType "SAD";
};
//baneblade is actually invincible? lol?


marineTankAttackBar = {
  _startLoc = selectRandom chapter6StartingPoints;
  if ((floor random 2) < 1) then {
    _marineTank = "TIOW_SM_Predator_WB" createVehicle _startLoc;
    _BANEBLADEgroup = [[542.293,1132.58,0], EAST, ["TIOW_Tactical_WB_1","TIOW_Tactical_WB_1"]] call BIS_fnc_spawnGroup;
    {
      _x moveInAny _marineTank;
    } forEach (units _BANEBLADEgroup);
    _waypointBANEBLADE = _BANEBLADEgroup addWaypoint [[3143.71,3097.11,0], 0];
  } else {
    _marineAPC = "TIOW_SM_Razorback_LC_WB" createVehicle _startLoc;
    _APCGroup = [[542.293,1132.58,0], EAST, ["TIOW_Tactical_WB_1","TIOW_Tactical_WB_1","TIOW_Tactical_WB_2","TIOW_Tactical_WB_1","TIOW_Tactical_WB_1","STEVE_30k_MK4_Rotor_WB"]] call BIS_fnc_spawnGroup;
    {
      _x moveInAny _marineAPC;
    } forEach (units _APCGroup);
    _waypointAPC = _APCGroup addWaypoint [[3143.71,3097.11,0], 0];
  };
};

chaosMarines = [
  //(configfile >> "CfgGroups" >> "East" >> "TIOW_ChaosSpaceMarines" >> "TIOW_CSM_WB_Squads" >> "TIOW_Group_SM_WB_Tact_1"),
  //(configfile >> "CfgGroups" >> "East" >> "TIOW_ChaosSpaceMarines" >> "TIOW_CSM_DG_Squads" >> "TIOW_Group_SM_DG_Tact_1")
  ["TIOW_Sergeant_DG_1", "TIOW_HeavyBolter_DG_4", "TIOW_Tactical_DG_1","TIOW_Tactical_DG_1","TIOW_Tactical_DG_1"],
  ["TIOW_Sergeant_WB_1", "TIOW_HeavyBolter_WB_4", "TIOW_Tactical_WB_1","TIOW_Tactical_WB_1","TIOW_Tactical_WB_1"]
];

marinesAttackBar = {
    _marinesGroup = [(selectRandom chapter6StartingPoints), EAST, (selectRandom chaosMarines)] call BIS_fnc_spawnGroup;
    _waypointMarines = _marinesGroup addWaypoint [[3134.6,3089.28,0], 0];
    _waypointMarines setWaypointType "SAD";
};

meleeMarinesAttackBar = {
    _marinesGroup = [(selectRandom chapter6StartingPoints), EAST, ["STeve_Melee_Troops_DG","STeve_Melee_Troops_DG"]] call BIS_fnc_spawnGroup;
    _waypointMarines = _marinesGroup addWaypoint [[3134.6,3089.28,0], 0];
    _waypointMarines setWaypointType "SAD";
};

chapter6SpawnCodes = [
  titanAttackBar,
  marinesAttackBar,
  meleeMarinesAttackBar,
  marineTankAttackBar,
  //emperorAttackBar,
  empireAttackBar,
  empire2AttackBar,
  empireTankAttackBar
];

chapter6SpawnCodesOPFOR = [
  titanAttackBar,
  marinesAttackBar,
  marinesAttackBar,
  marinesAttackBar,
  meleeMarinesAttackBar,
  marineTankAttackBar
];

somethingAttackBar = {
  [] call (selectRandom chapter6SpawnCodes);
};

somethingNotEmpireAttackBar = {
  [] call (selectRandom chapter6SpawnCodesOPFOR);
};


startBarTele addAction ["[1-WAY] Under Fox Beer Sign", {player setPosASL [3168.54,3071.32,23.5504]}, [], 1.5, true, true, "", "true", 10, false, "", ""];
startBarTele addAction ["[1-WAY] Roof of this Pub", {player setPosASL [3166.07,3120.75,24.6351]}, [], 1.5, true, true, "", "true", 10, false, "", ""];
startBarTele addAction ["[1-WAY] Near Waffle House", {player setPosASL [3183.42,3150.61,5.00144]}, [], 1.5, true, true, "", "true", 10, false, "", ""];
startBarTele addAction ["[1-WAY] Roof of Building North of Pub", {player setPosASL [3163.07,3167.59,83.0177]}, [], 1.5, true, true, "", "true", 10, false, "", ""];
startBarTele addAction ["[1-WAY] Ground Floor of Building South of Pub", {player setPosASL [3175.47,3067.04,5.05041]}, [], 1.5, true, true, "", "true", 10, false, "", ""];

continueSpawning = true;
softCapNPCs = 12;
timeBetweenSpawns = 90;

startThisShit = {
  if (isServer) then {
    [] spawn {
      while {continueSpawning} do {
        sleep timeBetweenSpawns;
        if (count units INDEPENDENT < softCapNPCs && count units EAST < softCapNPCs) then {
          [] call somethingAttackBar;
        } else {
          if (count units EAST < softCapNPCs) then {
            [] call somethingNotEmpireAttackBar;
          } else {
            //do nothing
          };
        };
      };
    };
  };
};
