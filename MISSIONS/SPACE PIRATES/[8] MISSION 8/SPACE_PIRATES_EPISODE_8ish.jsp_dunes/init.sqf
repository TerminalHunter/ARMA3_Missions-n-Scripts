#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "story.sqf"
#include "spacePirateShip.sqf"
#include "carbonBetatronTreasureScanner.sqf"
#include "spaceTeamDirector.sqf"
#include "spaceTeamCustomActions.sqf"

enableSaving [false, false];

[jackShack] call makePirateArsenal;
[jackShack2] call makePirateArsenal;

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
