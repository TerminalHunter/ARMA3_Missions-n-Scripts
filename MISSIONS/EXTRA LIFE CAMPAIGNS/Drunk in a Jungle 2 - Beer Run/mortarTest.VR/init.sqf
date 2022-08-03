spawnExplosion = {
	params ["_position"];
	[_position] spawn BIS_fnc_fireSupportVirtual; //this can be super customized, though
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
	while {true} do {
		_hitZone = [_marker] call grabRandomPosition;
		[_hitZone] call spawnExplosion;
		sleep (random 3);
	};
};

sleep 1; 
deadZone = createMarker ["deadZone", (getPos player) vectorAdd [0,200,0]];
"deadZone" setMarkerSize [1000,100];
["deadZone"] spawn blowAreaTheFuckUp;
//SHOULD BE RUN ON SERVER ONLY!!
//Many variables need to be changed.