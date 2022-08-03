/*

3 states:
Inside a defenseTrigger (800m radius circle around a base)
Inside a territory (3750m radius circle around a base, but not inside a defenseTrigger)
Outside of all territories

final stand defense force triggers on a single player entering the area
everything else should only need the average location of the players
  get the furthest distance from player to average - double it for encounter spawning? with a minimum

bases, after an unsuccessful defense, don't spawn enemies for the remainer of the mission
only clean up defense forces if another spawns? only clean up defense forces when you leave the territory?

reference markers:
cultBase
domBase
townBase

*/

#include "lootSystem.sqf"

cultBasePos = getMarkerPos "cultBase";
domBasePos = getMarkerPos "domBase";
gangBasePos = getMarkerPos "townBase";
khanBasePos = getMarkerPos "khanBase";

shorterHint = {
	params ["_text"];
	hint _text;
	sleep 4;
	hint "";
};

findAveragePlayerPos = {
  _returnPos = [0,0,0];
  _allPlayers = call BIS_fnc_listPlayers;
  {
      _returnPos = _returnPos vectorAdd (getPos _x);
  }forEach _allPlayers;
  _returnPos = _returnPos vectorMultiply (1 / (count _allPlayers));
  _returnPos
};

findAveragePlayerDir = {
  _returnDir = 0;
  _rollingY = 0;
  _rollingX = 0;
  _allPlayers = call BIS_fnc_listPlayers;
  {
      _angle = getDir _x;
      _rollingX = _rollingX + cos(_angle);
      _rollingY = _rollingY + sin(_angle);
  }forEach _allPlayers;
  _returnDir = _rollingY atan2 _rollingX;
  _returnDir
};

findMaxPlayerSeperation = {
  _center = call findAveragePlayerPos;
  _allPlayers = call BIS_fnc_listPlayers;
  _maxDistance = 0;
  {
    _playerDistance = _x distance _center;
    if (_playerDistance > _maxDistance) then {
      _maxDistance = _playerDistance;
    };
  } forEach _allPlayers;
  _maxDistance
};

cannibalGroups = [
(configfile >> "CfgGroups" >> "East" >> "O_Cannibals" >> "Infantry" >> "o_none_infantry_cannibal_horde"),
(configfile >> "CfgGroups" >> "East" >> "O_Cannibals" >> "Infantry" >> "o_none_infantry_cannibal_fireteam")
];

cultGroups = [
  (configfile >> "CfgGroups" >> "East" >> "O_HyperCult" >> "Infantry" >> "o_hypercult_infantry_cultist_fresh_flock"),
  (configfile >> "CfgGroups" >> "East" >> "O_HyperCult" >> "Infantry" >> "o_hypercult_infantry_cultist_fuckery"),
  (configfile >> "CfgGroups" >> "East" >> "O_HyperCult" >> "Infantry" >> "o_hypercult_infantry_cultist_rifle_team"),
  (configfile >> "CfgGroups" >> "East" >> "O_HyperCult" >> "Infantry" >> "o_hypercult_infantry_cultist_shock_team"),
  (configfile >> "CfgGroups" >> "East" >> "O_HyperCult" >> "Infantry" >> "o_hypercult_infantry_cultist_weapon_team")
];

dominionGroups = [
  (configfile >> "CfgGroups" >> "East" >> "O_FreeDominion" >> "Infantry" >> "o_freedominion_infantry_rifle_group"),
  (configfile >> "CfgGroups" >> "East" >> "O_FreeDominion" >> "Infantry" >> "o_freedominion_infantry_weapon_group")
];

dominionSpecialGroups = [
  (configfile >> "CfgGroups" >> "East" >> "O_FreeDominion" >> "SpecOps" >> "o_freedominion_specops_fireteam"),
  (configfile >> "CfgGroups" >> "East" >> "O_FreeDominion" >> "SpecOps" >> "o_freedominion_specops_weapon_group")
];

gangGroups = [
  (configfile >> "CfgGroups" >> "East" >> "O_SwarfGang" >> "Infantry" >> "o_swarfgang_infantry_hit_squad"),
  (configfile >> "CfgGroups" >> "East" >> "O_SwarfGang" >> "Infantry" >> "o_swarfgang_infantry_more_punks"),
  (configfile >> "CfgGroups" >> "East" >> "O_SwarfGang" >> "Infantry" >> "o_swarfgang_infantry_punks"),
  (configfile >> "CfgGroups" >> "East" >> "O_SwarfGang" >> "Infantry" >> "o_swarfgang_infantry_vehicle_crew")
];

khanGroups = [
  (configfile >> "CfgGroups" >> "East" >> "O_IdahoKhans" >> "Infantry" >> "o_idaho_khans_infantry_drug_runners"),
  (configfile >> "CfgGroups" >> "East" >> "O_IdahoKhans" >> "Infantry" >> "o_idaho_khans_infantry_raiding_party"),
  (configfile >> "CfgGroups" >> "East" >> "O_IdahoKhans" >> "Infantry" >> "o_idaho_khans_infantry_scouting_party")
];

localsGroups = [
 (configfile >> "CfgGroups" >> "East" >> "O_HyperboreaArmedLocals" >> "Infantry" >> "o_hyperboreaarmed_locals_infantry_big_stumble"),
 (configfile >> "CfgGroups" >> "East" >> "O_HyperboreaArmedLocals" >> "Infantry" >> "o_hyperboreaarmed_locals_infantry_stumble"),
 (configfile >> "CfgGroups" >> "East" >> "O_HyperboreaArmedLocals" >> "Infantry" >> "o_hyperboreaarmed_locals_infantry_stumblefu"),
 (configfile >> "CfgGroups" >> "East" >> "O_HyperboreaArmedLocals" >> "Infantry" >> "o_hyperboreaarmed_locals_infantry_stumblefuck")
];

randomEventGroups = [
	(configfile >> "CfgGroups" >> "East" >> "O_HyperboreaArmedLocals" >> "Infantry" >> "o_hyperboreaarmed_locals_infantry_stumblefu"),
	(configfile >> "CfgGroups" >> "East" >> "O_HyperboreaArmedLocals" >> "Infantry" >> "o_hyperboreaarmed_locals_infantry_stumblefuck"),
	//(configfile >> "CfgGroups" >> "East" >> "O_IdahoKhans" >> "Infantry" >> "o_idaho_khans_infantry_drug_runners"),
	//(configfile >> "CfgGroups" >> "East" >> "O_IdahoKhans" >> "Infantry" >> "o_idaho_khans_infantry_scouting_party"),
	(configfile >> "CfgGroups" >> "East" >> "O_SwarfGang" >> "Infantry" >> "o_swarfgang_infantry_more_punks"),
  (configfile >> "CfgGroups" >> "East" >> "O_SwarfGang" >> "Infantry" >> "o_swarfgang_infantry_punks"),
	//(configfile >> "CfgGroups" >> "East" >> "O_FreeDominion" >> "Infantry" >> "o_freedominion_infantry_rifle_group"),
  //(configfile >> "CfgGroups" >> "East" >> "O_FreeDominion" >> "Infantry" >> "o_freedominion_infantry_weapon_group"),
	(configfile >> "CfgGroups" >> "East" >> "O_HyperCult" >> "Infantry" >> "o_hypercult_infantry_cultist_fresh_flock"),
  (configfile >> "CfgGroups" >> "East" >> "O_HyperCult" >> "Infantry" >> "o_hypercult_infantry_cultist_fuckery"),
	(configfile >> "CfgGroups" >> "East" >> "O_Cannibals" >> "Infantry" >> "o_none_infantry_cannibal_horde"),
	(configfile >> "CfgGroups" >> "East" >> "O_Cannibals" >> "Infantry" >> "o_none_infantry_cannibal_horde"),
	(configfile >> "CfgGroups" >> "East" >> "O_Cannibals" >> "Infantry" >> "o_none_infantry_cannibal_fireteam")
];

createRandomEvent = {
	params ["_groupSelected","_playerPos","_playerDir","_playerSpread"];
	_eventPos = _playerPos getPos [(_playerSpread + 600),_playerDir];
	_returnGroup = [_eventPos, EAST, _groupSelected] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
	//first waypoint is a seek and destroy at the group's average position
	_firstWaypoint = _returnGroup addWaypoint [_playerPos, 0];
	_firstWaypoint setWaypointType "SAD";
	_firstWaypoint setWaypointCompletionRadius 100;
	//in case they don't find anything @ the average position, or the players are split up pretty far, second waypoint picks a random player and goes after them
	_poorSchmuck = selectRandom (call BIS_fnc_listPlayers);
	_secondWaypoint = _returnGroup addWaypoint [(getPos _poorSchmuck),0];
	_secondWaypoint setWaypointType "SAD";
	_secondWaypoint setWaypointCompletionRadius 200;
	_returnGroup
};

isCultTriggered = {
	//"CULT TRIGGERED!" remoteExec ["shorterHint",0,false];
	_whyDoIHaveToDoThis = missionNamespace getVariable "cultTriggered";
	_isTriggered = false;
	if (_whyDoIHaveToDoThis == "true") then {
		_isTriggered = true;
	};
	if (!_isTriggered) then {
		{
				[(cultBasePos vectorAdd (call someBullshitRandomVector)), EAST, _x] call BIS_fnc_spawnGroup;
		}forEach cultGroups;
		[cultBasePos] call spawnBaseTreasure;
		missionNamespace setVariable ["cultTriggered", "true"];
	};
};

someBullshitRandomVector = {
	_bullshitX = (floor (random 100)) - 50;
	_bullshitY = (floor (random 100)) - 50;
	_returnValue = [_bullshitX,_bullshitY,0];
	_returnValue
};

isDomTriggered = {
	//"DOM TRIGGERED!" remoteExec ["shorterHint",0,false];
	_whyDoIHaveToDoThis = missionNamespace getVariable "domTriggered";
	_isTriggered = false;
	if (_whyDoIHaveToDoThis == "true") then {
		_isTriggered = true;
	};
	if (!_isTriggered) then {
		{
				[domBasePos, EAST, _x] call BIS_fnc_spawnGroup;
				[domBasePos, EAST, _x] call BIS_fnc_spawnGroup;
		}forEach dominionGroups;
		{
				_first = [domBasePos, EAST, _x] call BIS_fnc_spawnGroup;
				_poorSchmuck = selectRandom (call BIS_fnc_listPlayers);
				_firstWaypoint = _first addWaypoint [(getPos _poorSchmuck),0];
				_firstWaypoint setWaypointType "SAD";
				_firstWaypoint setWaypointCompletionRadius 400;
		}forEach dominionSpecialGroups;
		[getPos treasureTent] call spawnBaseTreasure;
		missionNamespace setVariable ["domTriggered", "true"];
	};
};

isKhanTriggered = {
	//"KHAN TRIGGERED!" remoteExec ["shorterHint",0,false];
	_whyDoIHaveToDoThis = missionNamespace getVariable "khanTriggered";
	_isTriggered = false;
	if (_whyDoIHaveToDoThis == "true") then {
		_isTriggered = true;
	};
	if (!_isTriggered) then {
		{
				[(khanBasePos vectorAdd (call someBullshitRandomVector)), EAST, _x] call BIS_fnc_spawnGroup;
				[(khanBasePos vectorAdd (call someBullshitRandomVector)), EAST, _x] call BIS_fnc_spawnGroup;
				[((getPos khanDrugLab) vectorAdd (call someBullshitRandomVector)), EAST, _x] call BIS_fnc_spawnGroup;
		}forEach khanGroups;
		[getPos treasureYurt] call spawnBaseTreasure;
		missionNamespace setVariable ["khanTriggered", "true"];
	};
};

spawnBaseTreasure = {
	params ["_position"];
	_numTreasure = (floor (random 9)) + 7;
	for "_i" from 1 to _numTreasure step 1 do {
		[_position, false] call createLootBox;
	};
};


//BEGIN THE AI DIRECTOR




if (isServer) then {
	[] spawn {
	  //wait for map loading to finish and do some initialization
		//maybe add a wait for the mapInitFinished to go true
	  sleep 300;
		//waitUntil {sleep 30; missionNamespace getVariable "mapInitFinished"};
	  missionNamespace setVariable ["directorStateLocation","noTerritory"];
		missionNamespace setVariable ["domTriggered", "false"];
		missionNamespace setVariable ["cultTriggered", "false"];
		missionNamespace setVariable ["khanTriggered", "false"];

		//TERRITORY STATE MACHINE
		//In the mission name space, 'directorStateLocation' should be one of the following states:
		//noTerritory, gangTerritory, gangBase, cultTerritory, cultBase, domTerritory, or domBase.

		[] spawn {
			while {true} do {
		    //try not to do a state check every frame. maybe every minute or so?
		    //TODO: adjust map so that it's harder to just drive into a base and let these checks happen less often
		    sleep 15;
		    _averagePos = call findAveragePlayerPos;
		    _foundSpot = false;

		    //CULT CHECK
		    _cultDistance = _averagePos distance cultBasePos;
		    if (_cultDistance < 3750) then {
		      missionNamespace setVariable ["directorStateLocation","cultTerritory"];
		      _foundSpot = true;
		      _allPlayers = call BIS_fnc_listPlayers;
		      {
		        _playerProximity = (getPos _x) distance cultBasePos;
		        if (_playerProximity < 800) then {
		          missionNamespace setVariable ["directorStateLocation","cultBase"];
							//DO A CHECK FOR CULT TRIGGERED
							call isCultTriggered;
		        };
		      } forEach _allPlayers;
		    };

		    //DOM CHECK
		    _domDistance = _averagePos distance domBasePos;
		    if (_domDistance < 2750) then {
		      missionNamespace setVariable ["directorStateLocation","domTerritory"];
		      _foundSpot = true;
		      _allPlayers = call BIS_fnc_listPlayers;
		      {
		        _playerProximity = (getPos _x) distance domBasePos;
		        if (_playerProximity < 800) then {
		          missionNamespace setVariable ["directorStateLocation","domBase"];
							//DO A CHECK FOR DOM TRIGGERED
							call isDomTriggered;
		        };
		      } forEach _allPlayers;
		    };

		    //GANG CHECK
		    _gangDistance = _averagePos distance gangBasePos;
		    if (_gangDistance < 2750) then {
		      missionNamespace setVariable ["directorStateLocation","gangTerritory"];
		      _foundSpot = true;
		      _allPlayers = call BIS_fnc_listPlayers;
		      {
		        _playerProximity = (getPos _x) distance gangBasePos;
		        if (_playerProximity < 800) then {
		          missionNamespace setVariable ["directorStateLocation","gangBase"];
		        };
		      } forEach _allPlayers;
		    };

				//KHAN CHECK
				_khanDistance = _averagePos distance khanBasePos;
				if (_khanDistance < 2000) then {
					_allPlayers = call BIS_fnc_listPlayers;
		      {
		        _playerProximity = (getPos _x) distance khanBasePos;
		        if (_playerProximity < 800) then {
		          //DO A CHECK FOR KHANS TRIGGERED
							call isKhanTriggered;
		        };
		      } forEach _allPlayers;
				};

				//HOME CHECK
				_homeDistance = _averagePos distance (getPos baseFlag);
				if (_homeDistance < 200) then {
					missionNamespace setVariable ["directorStateLocation","playerBase"];
					_foundSpot = true;
				};

		    //CHECK CHECK (see if the players are actually in noTerritory)
		    if (!_foundSpot) then {
		      missionNamespace setVariable ["directorStateLocation", "noTerritory"];
		    };

		    //debug commands
		    //_currentState = missionNamespace getVariable "directorStateLocation";
		    //_currentState remoteExec ["shorterHint",0,false];

		  };
		};

		//RANDOM EVENT GENERATOR
		[] spawn {
			_enemyGroupsSpawned = [];
			//just give the players as much time as possible. I swear we're going to be stuck at spawn in various arsenals for an hour.
			sleep 240;
			while {true} do{
				//10ish minutes between possible enemy spawns
				sleep (900 + (floor (random 250)) - 125);
				 _averagePos = call findAveragePlayerPos;
				 _averageDir = call findAveragePlayerDir;
				 _averageSpread = call findMaxPlayerSeperation;
				if (count _enemyGroupsSpawned < 5) then {
					_currLocationState = missionNamespace getVariable "directorStateLocation";
					switch (_currLocationState) do {
						case "noTerritory": {
							_groupToSpawn = selectRandom randomEventGroups;
							_newEnemyGroup = [_groupToSpawn,_averagePos,_averageDir,_averageSpread] call createRandomEvent;
							_enemyGroupsSpawned append [_newEnemyGroup];
						};
						case "cultTerritory": {
							_groupToSpawn = selectRandom cultGroups;
							_newEnemyGroup = [_groupToSpawn,_averagePos,_averageDir,_averageSpread] call createRandomEvent;
							_enemyGroupsSpawned append [_newEnemyGroup];
						};
						case "domTerritory": {
							//_groupToSpawn = selectRandom dominionGroups;
							//_newEnemyGroup = [_groupToSpawn,_averagePos,_averageDir,_averageSpread] call createRandomEvent;
							//_enemyGroupsSpawned append [_newEnemyGroup];
						};
						case "gangTerritory": {
							_groupToSpawn = selectRandom (gangGroups + localsGroups);
							_newEnemyGroup = [_groupToSpawn,_averagePos,_averageDir,_averageSpread] call createRandomEvent;
							_enemyGroupsSpawned append [_newEnemyGroup];
						};
						case "cultBase": {
							_groupToSpawn = selectRandom cultGroups;
							_newEnemyGroup = [_groupToSpawn,_averagePos,_averageDir,(2*_averageSpread)] call createRandomEvent;
							_enemyGroupsSpawned append [_newEnemyGroup];
						};
						case "domBase": {
							//_groupToSpawn = selectRandom dominionGroups;
							//_newEnemyGroup = [_groupToSpawn,_averagePos,_averageDir,(2*_averageSpread)] call createRandomEvent;
							//_enemyGroupsSpawned append [_newEnemyGroup];
						};
						case "gangBase": {

						};
						case "playerBase": {

						};
						default {
							_groupToSpawn = selectRandom randomEventGroups;
							_newEnemyGroup = [_groupToSpawn,_averagePos,_averageDir,_averageSpread] call createRandomEvent;
							_enemyGroupsSpawned append [_newEnemyGroup];
						};
					};

				};
				//check to see if some can be deleted? >3km away from player average?
				_averagePos = call findAveragePlayerPos;
				_groupsToDelete = [];
				{
					_groupPos = getPos (leader _x);

					if ((_groupPos distance _averagePos) > 2100) then {
						{deleteVehicle _x} forEach units _x;
						deleteGroup _x;
						_groupsToDelete pushBack _forEachIndex;
					};
				} forEach _enemyGroupsSpawned;
				reverse _groupsToDelete;
				{
					_enemyGroupsSpawned deleteAt _x;
				} forEach _groupsToDelete;
			};

		};
	};
};
