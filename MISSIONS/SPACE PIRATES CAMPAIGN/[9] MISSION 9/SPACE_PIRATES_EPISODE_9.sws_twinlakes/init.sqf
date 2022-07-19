#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "story.sqf"
#include "spacePirateShip.sqf"
//#include "carbonBetatronTreasureScanner.sqf"
#include "spaceTeamDirector.sqf"
#include "spaceTeamCustomActions.sqf"
enableSaving [false, false];

[jackShack] call makePirateArsenal;
[jackShack2] call makePirateArsenal;

intel01 addAction ["VENERATOR SCHEMATIC [TOP SECRET]", {
      _longString = "<t color='#22aa22' size='1'>This is a large schematic file that details a carrier-class starship. The schematic is annotated with weak points and other tactical information.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel02 addAction ["[REDACTED] SCHEMATIC [EXTRA TOP SECRET]", {
      _longString = "<t color='#22aa22' size='1'>This is a schematic file that details... something? It's extraordinarily complicated, but it seems to be some kind of weapon of mass destruction -- housed in and powered by a Venerator-class starship. Is this what's been glassing all those planets?</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

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
	//} forEach nearestTerrainObjects [theActualShip,["BUILDING","HOUSE","FENCE","WALL", "VIEW-TOWER","HIDE","FOUNTAIN"],worldSize*2,false];
  } forEach nearestTerrainObjects [theActualShip,
      ["BUILDING",
      "HOUSE",
      "CHURCH",
      "CHAPEL",
      "CROSS",
      "BUNKER",
      "FORTRESS",
      "FOUNTAIN",
      "VIEW-TOWER",
      "LIGHTHOUSE",
      "QUAY",
      "FUELSTATION",
      "HOSPITAL",
      "FENCE",
      "WALL",
      "HIDE",
      "BUSSTOP",
      "ROAD",
      "TRANSMITTER",
      "STACK",
      "TOURISM",
      "WATERTOWER",
      "TRACK",
      "MAIN ROAD",
      "ROCK",
      "ROCKS",
      "POWER LINES",
      "RAILWAY",
      "POWERSOLAR",
      "POWERWAVE",
      "POWERWIND",
      "SHIPWRECK",
      "TRAIL"
    ],worldSize*2,true];
	_worldObjects
};

[] call mapApocalypsizing;

//ENEMY CODE AND AI?

OPFORMedievalUniforms = [
  "HL_UNI_2",
  "DKoK_Gren_Uniform_1490th",
  "1715_slops_3_browngreenbrown",
  "1715_slops_3_browngreenwhite2",
  "1715_justa_3a_a_green"
];

medievalMeleeWeapons = [
  "WBK_SmallSword",
  "WBK_Spear",
  "WBK_Halbert",
  "WBK_SmallWarHammer_Hammer",
  "WBK_FeudalMaul"
];

medievalRangedWeapons = [
  "1715_LandPat",
  "1715_LandPatRifle",
  "1715_Seapat",
  "1715_Blunderbuss"
];

BLUFORMedievalUniforms = [
  "U_TIOW_Valhallan_brown_Blu",
  "U_TIOW_Valhallan_brown_Blu",
  "1715_slops_3_whitetanbrown",
  "1715_justa_3a_c_tan"
];

BLUFORHats = [
  "TIOW_Valhallan_Cap_brown_2",
  "1715_cockedhat_2_brown",
  "1715_headwrap_2_brown",
  "1715_cockedhat_3_brown",
  "IC_SL_HELMET_01"
];

equipMedievalBLUFOR = {
  params ["_dude"];
  removeAllWeapons _dude;
  removeGoggles _dude;
  removeHeadgear _dude;
  removeVest _dude;
  removeUniform _dude;
  removeAllAssignedItems _dude;
  clearAllItemsFromBackpack _dude;
  removeBackpack _dude;
  _dude forceAddUniform selectRandom BLUFORMedievalUniforms;
  _dude addHeadgear selectRandom BLUFORHats;
  _dude addBackpackGlobal "TIOW_VAlhallan_Bandolier";
  waitUntil {!isNull backpackContainer _dude};
  _dude addMagazines ["1715_cartridge_ball_69", 35];
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addWeapon (selectRandom medievalRangedWeapons);
};

equipMedievalOPFOR_ranged = {
  params ["_dude"];
  removeAllWeapons _dude;
  removeGoggles _dude;
  removeHeadgear _dude;
  removeVest _dude;
  removeUniform _dude;
  removeAllAssignedItems _dude;
  clearAllItemsFromBackpack _dude;
  removeBackpack _dude;
  _dude forceAddUniform selectRandom OPFORMedievalUniforms;
  _dude addHeadgear "Dos_Kettle_Helm_1";
  _dude addBackpackGlobal "TIOW_CadBackpack";
  waitUntil {!isNull backpackContainer _dude};
  _dude addMagazines ["1715_cartridge_ball_69", 50];
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addWeapon (selectRandom medievalRangedWeapons);
};

equipMedievalOPFOR_melee = {
  params ["_dude"];
  removeAllWeapons _dude;
  removeGoggles _dude;
  removeHeadgear _dude;
  removeVest _dude;
  removeUniform _dude;
  removeAllAssignedItems _dude;
  clearAllItemsFromBackpack _dude;
  removeBackpack _dude;
  _dude forceAddUniform "HL_Uni_1";
  _dude addVest "Vest_HL_1";
  _dude addHeadgear "HT_Sallet_Helm_2";
  _dude addWeapon (selectRandom medievalMeleeWeapons);
};

BLUFORGROUPGENERIC = [
  "I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F"
];

OPFORGROUPGENERIC = [
  "O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F"
];

OPFORGROUPMELEE = [
  "O_soldier_Melee","O_soldier_Melee","O_soldier_Melee","O_soldier_Melee"
];

spawnBLUFORGroup = {
  params ["_object"];
  _eventPos = getPos _object;
	_returnGroup = [_eventPos, INDEPENDENT, BLUFORGROUPGENERIC] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
  {
    [_x] call equipMedievalBLUFOR;
  } forEach units _returnGroup;
  sleep 0.5;
  _returnGroup setFormation "LINE";
};

spawnOPFORGroup = {
  params ["_object"];
  _eventPos = getPos _object;
	_returnGroup = [_eventPos, EAST, OPFORGROUPGENERIC] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
  {
    [_x] call equipMedievalOPFOR_ranged;
  } forEach units _returnGroup;
  sleep 0.5;
  _returnGroup setFormation "LINE";
};

spawnOPFORGroupStationary = {
  params ["_object"];
  _eventPos = getPos _object;
	_returnGroup = [_eventPos, EAST, OPFORGROUPGENERIC] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
  {
    [_x] call equipMedievalOPFOR_ranged;
    _x disableAI "PATH";
  } forEach units _returnGroup;
  sleep 0.5;
  _returnGroup setFormation "LINE";
};

spawnOPFORGroupMelee = {
  params ["_object"];
  _eventPos = getPos _object;
	_returnGroup = [_eventPos, EAST, OPFORGROUPMELEE] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
  {
    [_x] call equipMedievalOPFOR_melee;
  } forEach units _returnGroup;
  sleep 0.5;
  _returnGroup setFormation "LINE";
};

/* DUNNO BUT HERE'S EPISODE 8 CODE?

// enemy spawns and shit


createRandomEvent = {
	params ["_groupSelected"];
  //_actualDirection = selectRandom notNorthArray;
	//_eventPos = _playerPos getPos [(_playerSpread + 2000),_actualDirection];
  _eventPos = [] call findRandomSpotNotNearPlayers;
	_returnGroup = [_eventPos, EAST, _groupSelected] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
  //PAINT IT SANDY
  //getArray(configfile >> "CfgVehicles" >> "SC_SaurusAPC_SE" >> "TextureSources" >> "Sand" >> "textures")
  {
    if ((vehicle _x) isKindOf "LandVehicle") then {
      [vehicle _x] call dumbPaintVehicleSand;
    };
    }forEach units _returnGroup;
    _returnGroup addVehicle (vehicle ((units _returnGroup) select 0));
    sleep 0.5;
  //0th waypoint is a load?
  _loadWaypoint = _returnGroup addWaypoint [_eventPos, 0];
  _loadWaypoint setWaypointType "LOAD";
  sleep 15;
	//first waypoint is a seek and destroy at a random player's pos
  _poorSchmuck = selectRandom (call BIS_fnc_listPlayers);
	_firstWaypoint = _returnGroup addWaypoint [getPos _poorSchmuck, 0];
	_firstWaypoint setWaypointType "SAD";
	_firstWaypoint setWaypointCompletionRadius 200;
	//in case they don't find anything @ the previous position, second waypoint picks the CBT Scanner
  sleep 0.5;
	_secondWaypoint = _returnGroup addWaypoint [getPos CBTScanner,0];
	_secondWaypoint setWaypointType "SAD";
	_secondWaypoint setWaypointCompletionRadius 300;
  sleep 0.5;
  _returnGroup setFormation "LINE";
  sleep 0.5;
  _returnGroup setSpeedMode "FULL";
	_returnGroup
};

findRandomSpotNotNearPlayers = {
  _xVal = -10000;
  _yVal = -10000;
  _spotFound = false;
  while {!_spotFound} do {
    _allPlayers = call BIS_fnc_listPlayers;
    _xVal = random(floor(worldSize*1.25));
    _yVal = random(floor(worldSize*1.25));
    //if a player is too close, set to false so the while loops once more
    //but assume true
    _spotFound = true;
    {
      _playerDistance = _x distance [_xVal, _yVal];
      if (_playerDistance < 2100 || _playerDistance > 4200) then {
        _spotFound = false;
      };
      } forEach _allPlayers;
  };
  _returnPos = [_xVal, _yVal];
  _returnPos
};

animalArray = [
  ["WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee"],
  ["WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Gas","WBK_DOS_Squig_Gas","WBK_DOS_Squig_Gas"],
  ["WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_AT","WBK_DOS_Squig_AT","WBK_DOS_Squig_AT"]
];

enemyArray = [
  ["SC_SaurusAPC_SE", "SC_SE_Desert_Ranger_H","SC_SE_Desert_Ranger_H","SC_SE_Desert_Ranger_H","SC_SE_Desert_Ranger_H"],
  ["SC_SaurusAPC_AA_SE", "SC_SE_Desert_Ranger_H","SC_SE_Desert_Ranger_H","SC_SE_Desert_Ranger_H","SC_SE_Desert_Ranger_H"],
  ["SC_Mantis"],
  ["SC_Gator_TC_SE", "SC_SE_Desert_Rifleman_L","SC_SE_Desert_Rifleman_L","SC_SE_Desert_Rifleman_L"],
  ["SC_SE_SMR_Desert_Sniper", "SC_SE_SMR_Desert_Sniper", "SC_SE_SMR_Desert_Rifleman_AA"],
  ["SC_SE_SMR_Desert_Sniper", "SC_SE_SMR_Desert_Sniper", "SC_SE_SMR_Desert_Rifleman_AT"],
  ["SC_SE_SMR_Desert_Rifleman_H","SC_SE_SMR_Desert_Rifleman_H","SC_SE_SMR_Desert_Rifleman_H","SC_SE_SMR_Desert_Rifleman_H","SC_SE_SMR_Desert_Rifleman_AT","SC_SE_SMR_Desert_Rifleman_AA"],
  ["MEOP_Ocufighter_veh_reaper_F"],
  ["MEOP_Ocufighter_veh_reaper_F"]
];

if (isServer) then {
  while {true} do {
    //sleep 5;
    sleep 180;
    if (count (units east) < 55) then {
      [selectRandom enemyArray] spawn createRandomEvent;
    };
  };
};

*/
