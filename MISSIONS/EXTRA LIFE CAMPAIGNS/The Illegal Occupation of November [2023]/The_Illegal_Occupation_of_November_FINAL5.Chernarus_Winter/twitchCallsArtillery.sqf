rawArtyStrike = {
	params ["_gridCoord"];
	[_gridCoord] remoteExec ["grabProperGridCoord", zoos];
	/*
	_nearPosition = [_gridCoord] call BIS_fnc_gridToPos; //THIS LINE FAILS ON SERVER
	_realPosition = ((_nearPosition select 0) vectorAdd [50,50]);
	_realPosition pushBack 0;
	_warningMessage = createMarker["Warning"+str(random 10), _realPosition];
	_warningMessage setMarkerType "mil_warning";
	_warningMessage setMarkerText "ARTILLERY INCOMING";
	[_gridCoord, _realPosition] remoteExec ["artyWarning", 0, false];
	sleep 3;
	[_realPosition] call BIS_fnc_fireSupportVirtual;
	[_realPosition] call BIS_fnc_fireSupportVirtual;
	sleep 80;
	deleteMarker _warningMessage; 
	*/
};

lastGridRefPos = [];

grabProperGridCoord = {
	params ["_gridCoord"];
	lastGridRefPos = [_gridCoord] call BIS_fnc_gridToPos;
	publicVariable "lastGridRefPos";
	[lastGridRefPos, _gridCoord] remoteExec ["finishArtyStrike", 2];
};

finishArtyStrike = {
	params ["_gridCoordPos", "_gridCoord"];
	_realPosition = ((_gridCoordPos select 0) vectorAdd [50,50]);
	_realPosition pushBack 0;
	_warningMessage = createMarker["Warning"+str(random 10), _realPosition];
	_warningMessage setMarkerType "mil_warning";
	_warningMessage setMarkerText "ARTILLERY INCOMING";
	[_gridCoord] remoteExec ["artyWarning", 0, false];
	sleep 30;
	[_realPosition] spawn spawnExplosion;
	[_realPosition] spawn spawnExplosion;
	sleep 120;
	deleteMarker _warningMessage; 
};

//I guess assume a zoos

someKindaData = [];

artyWarning = {
	params["_gridRef"];
	_stringToUse = "<t color='#ff0000' size='5'>CHAT HAS SENT ARTILLERY TO " + _gridRef + "</t>";
	cutText [_stringToUse, "PLAIN", -1, true, true];
	someKindaData = ((_gridRef) call BIS_fnc_gridToPos select 0);
	_stupid = someKindaData pushBack 0.5;
	someKindaData = someKindaData vectorAdd [50,50,0];
	_artyIcon = addMissionEventHandler ["draw3D",
	{
		_k = 10 / (player distance someKindaData);
		drawIcon3D
		[
			"a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa",
			[1,0,0,1],
			//_thisArgs select 0,
			someKindaData,
			1.5,
			1.5,
			0,
			"CHAT ARTILLERY TARGET",
			2,
			0.04,
			"RobotoCondensed",
			"center",
			true,
			0.005 * _k,
			-0.035 * _k
		];
	}, []
	];
	sleep 180;
	removeMissionEventHandler ["draw3D", _artyIcon];
};

spawnExplosion = {
	params ["_position"];
	[_position, "Sh_82mm_AMOS", 125, 10, [3,8]] call BIS_fnc_fireSupportVirtual; //this can be super customized, though
};

spawnFlares = {
	params ["_position"];
	_referenceSoldier = selectRandom allPlayers;
	_actualPos = ([_position] call BIS_fnc_gridToPos) select 0;
	_actualPos pushback 0;
	if ((_referenceSoldier distance2D _actualPos) < 3000) then {
		//hint str(_referenceSoldier distance2D _actualPos);
		[_actualPos, "ACE_40mm_Flare_white", 500, 25, [5,15], {false}, 0, 250, 1] call BIS_fnc_fireSupportVirtual;
	} else {
		//hint str(_referenceSoldier distance2D _actualPos);
		[getPos _referenceSoldier, "ACE_40mm_Flare_white", 600, 25, [5,15], {false}, 0, 250, 1] call BIS_fnc_fireSupportVirtual;
	};
};

spawnSmokes = {
	params ["_position", "_color"];
	_actualColor = "Smokeshell";
	_smokeColorReference = createHashMapFromArray [
		["blue", "SmokeShellBlue"],
		["Blue", "SmokeShellBlue"],
		["green", "SmokeShellGreen"],
		["Green", "SmokeShellGreen"],
		["orange", "SmokeShellOrange"],
		["Orange", "SmokeShellOrange"],
		["purple", "SmokeShellPurple"],
		["Purple", "SmokeShellPurple"],
		["red", "SmokeShellRed"],
		["Red", "SmokeShellRed"],
		["yellow", "SmokeShellYellow"],
		["Yellow", "SmokeShellYellow"]
	];
	if (_color in _smokeColorReference) then {
		_actualColor = _smokeColorReference get _color;
	} else {
		_actualColor = "Smokeshell";
	};
	_referenceSoldier = selectRandom allPlayers;
	[getPos _referenceSoldier, _actualColor, 60, 8, [3,8], {false}, 0, 250, 1] call BIS_fnc_fireSupportVirtual;
};

grabRandomPosition = {
	params ["_marker"];
	_sizeArray = getMarkerSize _marker;
	_width = _sizeArray select 0;
	_height = _sizeArray select 1;
	_position = getMarkerPos _marker;
	_randomWidth = (floor random (_width*2)) - _width;
	_randomHeight = (floor random (_height*2)) - _height;
	_return = _position vectorAdd [_randomWidth, _randomHeight, 1];
	_return
};

blowAreaTheFuckUp = {
	params ["_marker"];
	_hitZone = [_marker] call grabRandomPosition;
	[_hitZone] call spawnExplosion;
	sleep 2;
	_shells = 3;
	while {_shells > 0} do {
		_hitZone = [_marker] call grabRandomPosition;
		[_hitZone] call spawnExplosion;
		sleep (random 5);
		_shells = _shells - 1;
	};
};