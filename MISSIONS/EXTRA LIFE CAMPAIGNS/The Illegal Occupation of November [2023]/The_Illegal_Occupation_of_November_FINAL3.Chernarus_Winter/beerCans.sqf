/*

REQUIRES CRAP BY TERMINAL MOD
https://steamcommunity.com/sharedfiles/filedetails/?id=2794028013
or I guess you can replace the boozen with other cans/items?

some_item needs to be declared a booze box
[some_item] call makeBoozeBox;

players can then interact with the action menu and grab beer

if you don't care about anything
[] call hasFuckedUpNow;

and that will spawn a cardboard box, ready to give beer, at the feet of an active player

*/

boozen = ["baseBeer", "secondBeer","quillShipBeer","babstBeer","blastedBatBeer","cbt2020Beer","fuchBeer","loveBeer","moonBeer","quillCBTBeer","quillPolyBeer","malortBeer","fuckYouBeer","cloroxBeer","cagedBeer","noBrand3","unreadableBeer","comradeBeer"];
boozenNumber = 0;
boozenOffset = [0, -0.1, 0.1, -0.2, 0.2, -0.3, 0.3];

//Code that lightly tosses an item (the tossee) from another object, presumably a player (the tosser)
//Note: 1 in 100 chance that the can is instead yote.
//Requires an array with the player/tosser and object/tossee passed in
tossAside = {
	params ["_tosser", "_tossee"];
	_vel = velocity _tosser;
	_dir = direction _tosser;
	_speed = (random 2) + 1; //Added speed
	if (floor random 100 == 0) then {
		_speed = 5; //was 25 - too yeety for this mission
	};
	_tossee setVelocity [
	(_vel select 0) + (sin _dir * _speed) + (((random 1) - 0.5) / 2),
	(_vel select 1) + (cos _dir * _speed) + (((random 1) - 0.5) / 2),
	(_vel select 2) + 2
	];
};

//code that handles the rest of spawning and drinking
takeAShot = {
		params ["_target", "_caller", "_actionId", "_arguments"];
		//get a beer
		_isInVic = vehicle _caller != _caller;
		_coldOne = (selectRandom boozen) createVehicle (getPos _caller);
		_coldOneFootOffset = [boozenOffset select boozenNumber, 0.6, 1.4];
		if (_isInVic) then {
			_coldOne attachTo [_caller, [boozenOffset select boozenNumber,0.4,0], "head"];
			_headPos = getPos _coldOne; //WORLD SPACE OF HEAD POSITION.
			_coldOne attachTo [vehicle _caller, ((vehicle _caller) worldToModelVisual _headPos)];
		} else {
			_coldOne attachTo [_caller, _coldOneFootOffset, "hands"];
		};
		if (boozenNumber == 6) then {
			boozenNumber = 0;
		} else {
			boozenNumber = boozenNumber + 1;
		};
		sleep 1;
		//open it
		playSound3D [(getMissionPath "audio\crack.wav"), _coldOne];
		/*TODO : ADD MORE CODE TO SIMULATE DRINKING/CHUGGING THE BEER*/
		sleep 10;
		//safety, disables can and player collision just in case the can wants to do damage
		_coldOne disableCollisionWith _caller;
		if(_isInVic)then{_coldOne disableCollisionWith (vehicle _caller)};
		//spawns some code that will handle when the can is thrown. prevents excessive bouncing
		[_coldOne] spawn {
			params ["_item"];
			waitUntil {isTouchingGround _item};
			sleep 2;
			_item enableSimulation false;
		};
		//drops the beer
		detach _coldOne;
		//tosses it aside
		[_caller,_coldOne] call tossAside;
		//beer will eventually disappear
		sleep 25;
		deleteVehicle _coldOne;
	};

//Multiplayer compliant code that takes an item passed to it and makes it a box one can take beer from
makeBoozeBox = {
	params ["_box"];
	_box allowDamage false;
	[_box, true, [0, 1, 1], 0] remoteExec ["ace_dragging_fnc_setCarryable",0,true];
	[_box, beerBoxAction] remoteExec ["addAction", 0, true];
	[_box, drinkingAndDriving] remoteExec ["addAction", 0, true];
	[_box, 1] remoteExec ["ace_cargo_fnc_setSize", 0, true];
};

//Code that should be passed into an addAction command that defines the action required to get a beer, drink it, and huck the can
beerBoxAction = ["Crack Open A Cold One", takeAShot,
	nil,
	1.5,
	true,
	true,
	"",
	"true",
	5,
	false,
	"",
	""
];

beerBoxActionPlayer = ["Crack Open A Cold One (From Your Pocket)", takeAShot,
	nil,
	21,
	true,
	true,
	"",
	"true",
	5,
	false,
	"",
	""
];

drinkingAndDriving = ["Take 'A Few' For The Road", {
		params ["_target", "_caller", "_actionId", "_arguments"];
		_caller addAction beerBoxActionPlayer;
	},
	nil,
	0.5,
	true,
	true,
	"",
	"true",
	5,
	false,
	"",
	""
];

//Place a new booze box at player's feet
grabNewBoozeBox = {
	_newBox = "Land_PaperBox_01_small_closed_brown_F" createVehicle (getPos player);
	[_newBox] call makeBoozeBox;
  _newBox setPosATL (getPosATL player);
};

//DEBUG FUNCTION:
// put the following into the developer console:
// call hasFuckedUpNow;
// and it should pick a random player and spawn a new beer box near them.
//typically "Land_PaperBox_01_small_closed_brown_F"

hasFuckedUpNow = {
	_fucker = selectRandom allPlayers;
	_newBox = "Land_PaperBox_01_small_closed_brown_F" createVehicle (getPos _fucker);
	[_newBox] call makeBoozeBox;
};