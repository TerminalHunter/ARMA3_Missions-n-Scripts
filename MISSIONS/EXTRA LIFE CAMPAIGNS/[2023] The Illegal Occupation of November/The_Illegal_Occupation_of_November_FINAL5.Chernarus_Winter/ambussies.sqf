/*

ambussy1

*/

if (isServer) then {
	_statement = "[getPos ambussy1_1,getPos ambussy1] spawn createAmbussy;";
	_newBoxTrigger = createTrigger ["EmptyDetector", ambussy1, true];
	_newBoxTrigger setTriggerArea [600,600,0,true,200];
	_newBoxTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	_newBoxTrigger setTriggerStatements [
		"this",
		_statement,
		""
	];

	_statement2 = "[getPos ambussy2_1,getPos ambussy2] spawn createAmbussy;";
	_newBoxTrigger2 = createTrigger ["EmptyDetector", ambussy2, true];
	_newBoxTrigger2 setTriggerArea [600,600,0,true,200];
	_newBoxTrigger2 setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	_newBoxTrigger2 setTriggerStatements [
		"this",
		_statement2,
		""
	];	

	_statement3 = "[getPos ambussy3_1,getPos ambussy3] spawn createAmbussy;";
	_newBoxTrigger3 = createTrigger ["EmptyDetector", ambussy3, true];
	_newBoxTrigger3 setTriggerArea [600,600,0,true,200];
	_newBoxTrigger3 setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	_newBoxTrigger3 setTriggerStatements [
		"this",
		_statement3,
		""
	];	
};



createAmbussy = {
	params ["_start","_end"];
	_group1 = ["xs_Snowmobile_combat", _start] call spawnVicFullOfXmas;
	_group2 = ["xs_Snowmobile_combat", _start] call spawnVicFullOfXmas;
	_group3 = ["xs_Snowmobile_combat", _start] call spawnVicFullOfXmas;
	_group4 = ["xs_Snowmobile_combat", _start] call spawnVicFullOfXmas;
	_allGroups = [_group1, _group2, _group3, _group4];
	{
		_sadWaypoint1 = _x addWaypoint [_end, 100];
		_sadWaypoint1 setWaypointType "SAD";
	} forEach _allGroups;
};