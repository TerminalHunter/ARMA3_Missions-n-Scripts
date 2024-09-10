getSpecificPlayer = {
	params["_givenString"];
	_theBoi = objNull;
	{
		_nameArray = (toLower(name _x)) splitString " ";
		_givenArray = (toLower(_givenString)) splitString " ";
		if((_givenArray select 0) in _nameArray) then { //generic error
			_theBoi = _x;
		};
	} forEach allPlayers;
	_theBoi
};

regularScan = {
	params["_dataArray"];

	_schmuck = objNull;
	_playerScanCenter = [_dataArray select 2] call getSpecificPlayer;
	if(!isNull _playerScanCenter) then {
		_schmuck = _playerScanCenter;
	} else {
		_schmuck = selectRandom allPlayers;
	};

	_detectedWEST = [];
	_detectedEAST = [];
	_detectedGUER = [];
	_detectedCIV = [];

	_detectedEntities = _schmuck nearEntities 550;
	{
		if (side _x == west && !isPlayer _x) then {
			_detectedWEST append [_x];
		};
		if (side _x == east && !isPlayer _x) then {
			_detectedEAST append [_x];
		};
		if (side _x == independent && !isPlayer _x) then {
			_detectedGUER append [_x];
		};
		if (side _x == civilian && !isPlayer _x && alive _x && _x isKindOf "Man") then { //JOEKAY. Uh, come back to this one. the civ side is full of corpses and other entites.
			_detectedCIV append [_x];
		};
	} forEach _detectedEntities;

	//["BLUFOR", _detectedWEST, _schmuck] call findDirection;
	//["BLUFOR", str(count _detectedWEST)] call countSignatures;

	//["OPFOR", _detectedEAST, _schmuck] call findDirection;
	//["OPFOR", str(count _detectedEAST)] call countSignatures;

	//["GUERILLA", _detectedGUER, _schmuck] call findDirection;
	//["GUERILLA", str(count _detectedGUER)] call countSignatures;

	//["CIVILIAN", _detectedCIV, _schmuck] call findDirection;
	//["CIVILIAN", str(count _detectedCIV)] call countSignatures;

	["BLUFOR", _detectedWEST, _schmuck] call intelLine;
	["OPFOR", _detectedEAST, _schmuck] call intelLine;
	["GUERILLA", _detectedGUER, _schmuck] call intelLine;
	["CIVILIAN", _detectedCIV, _schmuck] call intelLine;
};

findDirection = {
	params["_sideStr", "_duderArray", "_schmuck"];
	if (count _duderArray > 0) then {
		_firstdetectedEnemy = _duderArray select 0;
		_typeOfEnemy = typeOf _firstdetectedEnemy;
		_enemyHeading = (getPos _schmuck) getDir (getPos _firstdetectedEnemy);
		_warningMessage = _sideStr + " " + _typeOfEnemy + " detected at approximate heading " + (str (floor _enemyHeading)) + " from " + str(name _schmuck);
		[_warningMessage] remoteExec ["systemChat",0,false];
	};
};

countSignatures = {
	params["_sideStr", "_arrayNum"];
	_signatureMessage = _arrayNum + " " + _sideStr + " signatures detected within 500m.";
	[_signatureMessage] remoteExec ["systemChat",0,false];
};

intelLine = {
	params["_sideStr", "_duderArray", "_schmuck"];
	if (count _duderArray > 0) then {
		_firstdetectedEnemy = _duderArray select 0;
		_typeOfEnemy = typeOf _firstdetectedEnemy;
		_enemyHeading = (getPos _schmuck) getDir (getPos _firstdetectedEnemy);
		_warningMessage = str(count _duderArray) + " " + _sideStr + " " + _typeOfEnemy + " detected at heading " + (str (floor _enemyHeading)) + " from " + str(name _schmuck);
		[_warningMessage] remoteExec ["systemChat",0,false];
	} else {
		_warningMessage = "0 " + _sideStr + " signatures detected within 500m";
		[_warningMessage] remoteExec ["systemChat",0,false];
	};
};