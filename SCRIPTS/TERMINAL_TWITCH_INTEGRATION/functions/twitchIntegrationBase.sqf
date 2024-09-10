expiredEvents = [];
twitchEventQueue = [];
chat = objNull;

readTwitchEvents = {
	while {true} do {
		sleep 3;
		_oldEvents = [];
		_newEvents = [];
		_response = ["127.0.0.1:9001", "GET"] call a3uf_common_fnc_request;	
		
		_arrayResponse = _response splitString "&";
		{
			_x splitString "#";
		} forEach _arrayResponse;

		if (!(_arrayResponse isEqualTo "")) then {
			//see if any values are new
			_oldEvents = expiredEvents arrayIntersect _arrayResponse;
			_newEvents = _arrayResponse - _oldEvents;
			//new values go into a queue
			twitchEventQueue append _newEvents;
			//update expired events
			expiredEvents append _newEvents;
		};
	};
};

runTwitchEvents = {
	while {true} do {
		sleep 5;
		if (count twitchEventQueue > 0) then {
			[twitchEventQueue select 0] spawn redeemReward;
			twitchEventQueue deleteAt 0;
		};
	};
};

redeemReward = {
	params ["_dataIn"];
	_dataArray = _dataIn splitString "#";

	/*
	Data structure to eventually be:
		#[message, cmd.user.name, cmd.parameter, uniqueID]
		#[supplyDrop, cmd.user.name, request, uniqueID]
		#[artillery, cmd.user.name, gridRef, uniqueID]
		#[scan, cmd.user.name, request, uniqueID]
	ALL REWARDS PASS THROUGH HERE!
	*/

	_incomingCommand = _dataArray select 0;

	switch (_incomingCommand) do {
		case "supplyDrop": {
			["Twitch Chat: " + (_dataArray select 1) + " has sent a supply drop!"] remoteExec ["systemChat", 0, false];
			[_dataArray] spawn createSupplyDrop;
		};
		case "message": {
			[(_dataArray select 1) + " has a message: " + (_dataArray select 2)] remoteExec ["systemChat", 0, false];
		};
		case "artillery": {
			[(_dataArray select 1) + ": ARTILLERY INBOUND TO GRIDREF " + (_dataArray select 2)] remoteExec ["systemChat", 0, false];
			[_dataArray select 2] spawn rawArtyStrike;
		};
		case "scan": {
			[_dataArray] spawn regularScan;
		};
		default {
			//ERROR! TODO: catch server start and streamer registration appropriately.
			//["Fucky Wucky detected! >:3c Let TerminalHunter know what you did to cause this."] remoteExec ["systemChat", 0, false];
		};
	};
};

startTwitchIntegration = {
	if (isServer) then {
		//SPAWN CHAT NPC
		_chatoid = [[0,0,0], west, ["B_Survivor_F"]] call BIS_fnc_spawnGroup;
		chat = (units _chatoid) select 0;
		chat disableAI "MOVE";
		chat setGroupId ["Twitch Chat"];
		chat allowDamage false;
		//START
		[] spawn readTwitchEvents;
		[] spawn runTwitchEvents;
		["Terminal's Twitch Integration Mod Script Ready!"] remoteExec ["systemChat", 0, false];
	};
};

if (isServer) then {
	[] spawn startTwitchIntegration;
};