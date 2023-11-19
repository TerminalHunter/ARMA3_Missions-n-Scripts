missionRunning = false;

getPositionSouthOfPlayers = {
	//700 meters south of all players, at least 690 meters away from all players
	_poorSchmuck = selectRandom allPlayers;
	_southOfPoorSchmuck = (getPos _poorSchmuck) vectorAdd [0, -700, 0];
	_southOfPoorSchmuck
};

getAveragePlayerPos = {
	_allThePositions = [];
	{
		_allThePositions pushBack (getPos _x);
	} forEach allPlayers;

	_getcenterposition = [0,0,0];

	{
		_getcenterposition = _x vectorAdd _getcenterposition;

	} foreach _allThePositions;

	_vectorcount = count allPlayers;
	_center = [(_getcenterposition select 0 / _vectorcount),(_getcenterposition select 1 / _vectorcount),(_getcenterposition select 2 / _vectorcount)];
	_center
};

giveHarassAI = {
	params ["_groupHar"];
	_sadWaypoint1 = _groupHar addWaypoint [getPos (selectRandom allPlayers), 100];
	_sadWaypoint1 setWaypointType "SAD";
	sleep 1;
	_sadWaypoint2 = _groupHar addWaypoint [getPos (selectRandom allPlayers), 100];
	_sadWaypoint2 setWaypointType "SAD";
};

giveSleighAI = {
	params ["_groupHar"];
	_sadWaypoint1 = _groupHar addWaypoint [getPos (selectRandom allPlayers), 100];
	_sadWaypoint1 setWaypointType "MOVE";
	sleep 1;
	_sadWaypoint2 = _groupHar addWaypoint [getPos (selectRandom allPlayers) vectorAdd [300,300,0], 500];
	_sadWaypoint2 setWaypointType "GETOUT";
	sleep 1;
	_sadWaypoint3 = _groupHar addWaypoint [getPos (selectRandom allPlayers), 100];
	_sadWaypoint3 setWaypointType "SAD";

};

getAllXmasGroups = {
	_xmasGroups = [];
	{
		if (side _x == east) then {
			_xmasGroups pushBack _x;
		};
	} forEach allGroups;
	_xmasGroups
};

startMission = {
	missionRunning = true;

	//spawning AI

	[] spawn {
		while {missionRunning} do {
			//IF MANY ENEMIES, NO!
			waitUntil{sleep 120; east countSide allUnits < 80};
			_newSpawnPos = [] call getPositionSouthOfPlayers;
			_harassInfantry = [floor(random 10), _newSpawnPos] spawn spawnEnemyGroup; 
			_harassSleigh = ["jean_sleigh", getPos sleighTakeOff] call spawnVicFullOfXmas;
			[_harassSleigh] call giveSleighAI;
			if (_newSpawnPos select 1 < 10000) then {
				_harassTruck = [(selectRandom xmasTransportTrucks), getPos truckSpawn] spawn spawnVicFullOfXmas;
			};
			sleep 300;
		};
	};

	//tasking AI

	[] spawn {
		while {missionRunning} do {
			sleep 10;
			_allXmasGroups = [] call getAllXmasGroups;
			{
				if(typeOf(vehicle (leader _x)) == "jean_sleigh")then{
					//[_x] call giveSleighAI;
				} else {
					[_x] call giveHarassAI;
				};

				_leaderPos = getPos leader(_x);
				_averageDistance = 0;
				{
					
					_averageDistance = _averageDistance + ((getPos _x) distance2D _leaderPos);
				} forEach allPlayers;
				_averageDistance = _averageDistance / (count allPlayers);
				//[str(_averageDistance)] remoteExec ["hint",0];
				/*
				if (_averageDistance > 1500 && isNull objectParent leader(_x)) then {
					{
							deleteVehicle _x;
					} forEach units _x;
				};
				*/

				
			} forEach _allXmasGroups;
			sleep 30;
		};
	};

	waitUntil {sleep 5;!missionRunning};
	["Mission is paused"] remoteExec ["hint", 0, false];
};

if (isServer) then {
	{
		_positionNew = markerPos _x;
		_statement = 
			"
			[10,"+str(_positionNew)+"] spawn spawnEnemyGroupLEGO;
			[5,"+str(_positionNew)+"] spawn spawnEnemyGroup;
			";
		_newBoxTrigger = createTrigger ["EmptyDetector", _positionNew, true];
		_newBoxTrigger setTriggerArea [800,800,0,true,200];
		_newBoxTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		_newBoxTrigger setTriggerStatements [
			"this",
			_statement,
			""
		];
	} forEach [
		"fallen01",
		"fallen02",
		"fallen03",
		"fallen04",
		"fallen05",
		"fallen06",
		"fallen07",
		"fallen08",
		"fallen09",
		"fallen10",
		"fallen11",
		"fallen12",
		"fallen13",
		"fallen14",
		"fallen15",
		"fallen16",
		"fallen17",
		"fallen18",
		"fallen19",
		"fallen20"
	];
};