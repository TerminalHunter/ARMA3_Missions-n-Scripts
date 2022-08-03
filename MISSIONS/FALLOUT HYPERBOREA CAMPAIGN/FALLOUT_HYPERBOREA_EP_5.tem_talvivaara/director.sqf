//this mission *SHOULD* be using the ALIVE system.
//as such, this code is probably unneeded 

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

simpleGangGroups = [
	(configfile >> "CfgGroups" >> "East" >> "O_SwarfGang2better" >> "Infantry" >> "o_swarfgang2_infantry_hit_squad"),
	(configfile >> "CfgGroups" >> "East" >> "O_SwarfGang2better" >> "Infantry" >> "o_swarfgang2_infantry_punks_01"),
	(configfile >> "CfgGroups" >> "East" >> "O_SwarfGang2better" >> "Infantry" >> "o_swarfgang2_infantry_punks_02"),
	(configfile >> "CfgGroups" >> "East" >> "O_SwarfGang2better" >> "Infantry" >> "o_swarfgang2_infantry_punks_03"),
	(configfile >> "CfgGroups" >> "East" >> "O_SwarfGang2better" >> "Infantry" >> "o_swarfgang2_infantry_punks_04"),
	(configfile >> "CfgGroups" >> "East" >> "O_SwarfGang2better" >> "Infantry" >> "o_swarfgang2_infantry_rifle_squad")
];

eliteGangGroups = [
	(configfile >> "CfgGroups" >> "East" >> "O_SwarfGang2better" >> "Infantry" >> "o_swarfgang2_infantry_qrf"),
	(configfile >> "CfgGroups" >> "East" >> "O_SwarfGang2better" >> "Infantry" >> "o_swarfgang2_infantry_sniper_scout")
];

//probably not needed this mission?
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

someBullshitRandomVector = {
	_bullshitX = (floor (random 100)) - 50;
	_bullshitY = (floor (random 100)) - 50;
	_returnValue = [_bullshitX,_bullshitY,0];
	_returnValue
};

spawnBaseTreasure = {
	params ["_position"];
	_numTreasure = (floor (random 7)) + 3;
	for "_i" from 1 to _numTreasure step 1 do {
		[_position, false] call createDumbLootBox;
	};
};

createScavengeTeam = {
	params ["_groupSelected"];
	_scavCamp = getMarkerPos "marker_44";
	_returnGroup = [_scavCamp, EAST, _groupSelected] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
	_returnGroup setBehaviour "SAFE";

	_firstWaypoint = _returnGroup addWaypoint [getMarkerPos (selectRandom scavengeWaypoints), 0];
	_firstWaypoint setWaypointType "MOVE";

	_returnGroup

};

//BEGIN THE AI DIRECTOR
// Previous mission probably not needed
/*
if (isServer) then {
	[] spawn {
	  sleep 300;

		//SCAVENGER GENERATOR
		//Lightly armed dudes just looking for junk
		[] spawn {
			_enemyScavsSpawned = [];
			//spawn three before the loop
			//bad code, bad. never do this
				if (true) then {
					_groupToSpawn = selectRandom (simpleGangGroups);
					_newEnemyGroup = [_groupToSpawn] call createScavengeTeam;
					_enemyScavsSpawned append [_newEnemyGroup];
				};
				if (true) then {
					_groupToSpawn = selectRandom (simpleGangGroups);
					_newEnemyGroup = [_groupToSpawn] call createScavengeTeam;
					_enemyScavsSpawned append [_newEnemyGroup];
				};
				if (true) then {
					_groupToSpawn = selectRandom (simpleGangGroups);
					_newEnemyGroup = [_groupToSpawn] call createScavengeTeam;
					_enemyScavsSpawned append [_newEnemyGroup];
				};
			//the loop
			while {true} do{
				sleep (500 + (floor (random 250)) - 125);
				 _averagePos = call findAveragePlayerPos;
				if (count _enemyScavsSpawned < 4 && (_averagePos distance2D (getMarkerPos "marker_44")) > 800) then {
					_groupToSpawn = selectRandom (simpleGangGroups);
					_newEnemyGroup = [_groupToSpawn] call createScavengeTeam;
					_enemyScavsSpawned append [_newEnemyGroup];
				};
				{
					if ((currentWaypoint _x) > (count waypoints _x) - 1) then {
						_newPoint = getMarkerPos (selectRandom scavengeWaypoints);
						_newWaypoint = _x addWaypoint [_newPoint,0];
						_newWaypoint setWaypointType "MOVE";
					};
				} forEach _enemyScavsSpawned;
			};
		};

		//PATROL GENERATOR

		[] spawn {
			_enemyPatrolsSpawned = [];
			if (true) then {
				_groupToSpawn = selectRandom (simpleGangGroups);
				_newEnemyGroup = [_groupToSpawn] call createScavengeTeam;
				_enemyPatrolsSpawned append [_newEnemyGroup];
			};
			if (true) then {
				_groupToSpawn = selectRandom (simpleGangGroups);
				_newEnemyGroup = [_groupToSpawn] call createScavengeTeam;
				_enemyPatrolsSpawned append [_newEnemyGroup];
			};
			if (true) then {
				_groupToSpawn = selectRandom (simpleGangGroups);
				_newEnemyGroup = [_groupToSpawn] call createScavengeTeam;
				_enemyPatrolsSpawned append [_newEnemyGroup];
			};
			while {true} do{
				sleep 200;
				 _averagePos = call findAveragePlayerPos;
				if (count _enemyPatrolsSpawned < 6 && (_averagePos distance2D (getMarkerPos "marker_44")) > 800) then {
					_groupToSpawn = selectRandom (simpleGangGroups);
					_newEnemyGroup = [_groupToSpawn] call createScavengeTeam;
					_enemyPatrolsSpawned append [_newEnemyGroup];
				};
				{
					if ((currentWaypoint _x) > (count waypoints _x) - 1) then {
						[_x] spawn {
							params ["_squad"];
							sleep  (1000 + (floor (random 250)) - 125);
							_newPoint = getMarkerPos (selectRandom patrolWaypoints);
							_newWaypoint = _squad addWaypoint [_newPoint,0];
							_newWaypoint setWaypointType "MOVE";
						};
					};
				} forEach _enemyPatrolsSpawned;
			};
		};

	};
};
*/
