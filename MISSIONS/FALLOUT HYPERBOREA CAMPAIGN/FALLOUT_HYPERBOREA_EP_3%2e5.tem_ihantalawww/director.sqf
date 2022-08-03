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

raiderGroups = [
	(configfile >> "CfgGroups" >> "East" >> "O_Raider_Type_01" >> "Infantry" >> "o_raidertype01_infantry_newish_group"),
	(configfile >> "CfgGroups" >> "East" >> "O_Raider_Type_01" >> "Infantry" >> "o_raidertype01_infantry_rifle_group"),
	(configfile >> "CfgGroups" >> "East" >> "O_Raider_Type_01" >> "Infantry" >> "o_raidertype01_infantry_shock_team"),
	(configfile >> "CfgGroups" >> "East" >> "O_Raider_Type_01" >> "Infantry" >> "o_raidertype01_infantry_suppression_team"),
	(configfile >> "CfgGroups" >> "East" >> "O_Raider_Type_01" >> "Infantry" >> "o_raidertype01_infantry_tech_group")
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



		//RANDOM EVENT GENERATOR
		[] spawn {
			_enemyGroupsSpawned = [];

			while {true} do{
				//10ish minutes between possible enemy spawns
				sleep (700 + (floor (random 250)) - 125);
				 _averagePos = call findAveragePlayerPos;
				 _averageDir = call findAveragePlayerDir;
				 _averageSpread = call findMaxPlayerSeperation;
				if (count _enemyGroupsSpawned < 5) then {
					_groupToSpawn = selectRandom (cannibalGroups + raiderGroups + raiderGroups);
					_newEnemyGroup = [_groupToSpawn,_averagePos,_averageDir,_averageSpread] call createRandomEvent;
					_enemyGroupsSpawned append [_newEnemyGroup];
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
