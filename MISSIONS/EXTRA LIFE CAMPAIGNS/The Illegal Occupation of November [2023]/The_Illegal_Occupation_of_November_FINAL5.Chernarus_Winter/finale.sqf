startFinale = {
	sleep 15;
	setDate [2023,11,23,17,18];
	[] remoteExec ["finaleCutscene", 0, false];
};

mechaScary = "";

finaleCutscene = {
	sleep 3;
	playMusic "backgroundMusic";
	sleep 20;
	if(isServer) then {
		targetBois = nearestObjects [mecha, ["Man","Car"], 20];
		mary = [];
		{if(alive _x && side _x == civilian) then {mary pushBack _x;}}forEach targetBois;
		//hint str(mary);
		mechaScary = mary select 0;
		mechaScaryGroup = group (mary select 0);
		_cutsceneWaypoint = (group (mary select 0)) addWaypoint [getPos cutsceneStart, 0];
		_cutsceneWaypoint setWaypointType "MOVE";
		//hopefully will attempt these waypoints after the cutscene
		_objective01 = (group (mary select 0)) addWaypoint [getPos theBar, 0];
		_objective01 setWaypointType "MOVE";
		_objective02 = (group (mary select 0)) addWaypoint [getPos revHQ, 0];
		_objective02 setWaypointType "MOVE";
		_objective03 = (group (mary select 0)) addWaypoint [getPos vetHQ, 0];
		_objective03 setWaypointType "MOVE";
		_objective04 = (group (mary select 0)) addWaypoint [getPos noradHQ, 0];
		_objective04 setWaypointType "MOVE";
	};
	_finaleCutscene = "camera" camCreate (getPos cameraCutscene);
	_finaleCutscene camPrepareTarget mariah;
	_finaleCutscene camCommitPrepared 0;
	_finaleCutscene camPrepareRelPos [100,-150,10];
	_finaleCutscene cameraEffect ["internal", "back"];
	_finaleCutscene camCommitPrepared 0;
	waitUntil { camCommitted _finaleCutscene };
	//_loops = 0;
	//while {_loops < 2 } do {
		_finaleCutscene camPrepareRelPos [100, -150, 10];
		_finaleCutscene camCommitPrepared 20;
		waitUntil { camCommitted _finaleCutscene };
		sleep 3;
		_finaleCutscene camPrepareRelPos [0, -150, 10];
		_finaleCutscene camCommitPrepared 20;
		waitUntil { camCommitted _finaleCutscene };
		sleep 3;
		//_loops = _loops + 1;
	//};
	sleep 5;
	_finaleCutscene cameraEffect ["terminate", "back"];
	camDestroy _finaleCutscene;
	10 fadeMusic 0;
	sleep 10;
	playMusic "";
	finaleStarted = true;
	publicVariable "finaleStarted";
	if(isServer)then{[] remoteExec ["finaleMusicAI", 0, false];};
};

finaleMusicAI = {
	if (isServer) then {
		["brojobMusic"] remoteExec ["playMusic", 0, false];
		[20, 1] remoteExec ["fadeMusic", 0, true];
		_musicEventHandlerID = addMusicEventHandler ["MusicStop", {
			params ["_musicName", "_id"];
			switch _musicName do {
				case "brojobMusic":{
					["killing"] remoteExec ["playMusic", 0, false];
				};
				case "killing":{
					["augustMusic"] remoteExec ["playMusic", 0, false];
				};
				case "augustMusic":{
					["45min"] remoteExec ["playMusic", 0, false];
				};
				case "45min":{
					["backgroundMusic"] remoteExec ["playMusic", 0, false];
				};
				case "backgroundMusic":{
					["brojobMusic"] remoteExec ["playMusic", 0, false];
				};
			};
		}];
	};
};

startFinaleActual = {
	["BTR_K_Christmas", getPos finaleSpot_1] spawn spawnVicFullOfXmas;
	["BTR_K_Christmas", getPos finaleSpot_2] spawn spawnVicFullOfXmas;
	[10, getPos finaleSpot_3] spawn spawnEnemyGroup;
	[10, getPos finaleSpot_4] spawn spawnEnemyGroup;
	[10, getPos finaleSpot_5] spawn spawnEnemyGroup;
	[10, getPos finaleSpot_6] spawn spawnEnemyGroup;
	[10, getPos finaleSpot_7] spawn spawnEnemyGroup;
};

endIt = {
	["end1"] remoteExec ["BIS_fnc_endMission", 0, false];
};