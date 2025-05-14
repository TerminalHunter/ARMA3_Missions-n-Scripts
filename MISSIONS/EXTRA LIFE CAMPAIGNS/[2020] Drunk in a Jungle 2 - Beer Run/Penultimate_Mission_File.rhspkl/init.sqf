#include "saveLoadout.sqf"

// SHOULD BE RUN ON SERVER ONLY!!
//blowAreaTheFuckUp requires 3 things:
//1)
//    a string (word in quotation marks) with the variable name of the marker rectangle that explosions happen within
//    ex: "deadZone"
//2)
//    amount of time, in seconds, for bombardment to last
//    ex: 120
//3)
//    a number representing the density of bombardment
//    (maximum time, in seconds, between shells, lower number is more intense)
//    numbers are still random, so unlucky players will get dense bombardments
//    ex: 3
//
// put together:
// ["deadZone",120,3] spawn blowAreaTheFuckUp;
//
// SHOULD BE RUN ON SERVER ONLY!!

spawnExplosion = {
    params ["_position"];
    [_position,"Sh_82mm_AMOS",10,1] spawn BIS_fnc_fireSupportVirtual;
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
    params ["_marker","_maxTime","_density"];
    _timeTaken = 0;
    while {_timeTaken < _maxTime} do {
        _hitZone = [_marker] call grabRandomPosition;
        [_hitZone] call spawnExplosion;
        _timeAdded = random _density;
        _timeTaken = _timeTaken + _timeAdded;
        //debug timer
        //hint str _timeTaken;
        sleep _timeAdded;
    };
};

boozen = ["noBrand_Beer","normal_beer","fuch_beer","blastedBat_Sauce","hell_beer","love_beer","catholic_beer","kirin_beer","moon_beer","babst_beer","massless_beer"];
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
		_speed = 25;
	};
	_tossee setVelocity [
	(_vel select 0) + (sin _dir * _speed) + (((random 1) - 0.5) / 2),
	(_vel select 1) + (cos _dir * _speed) + (((random 1) - 0.5) / 2),
	(_vel select 2) + 2
	];
};

//Multiplayer compliant code that takes an item passed to it and makes it a box one can take beer from
makeBoozeBox = {
	params ["_box"];
	_box allowDamage false;
	[_box, true, [0, 1, 1], 0] remoteExec ["ace_dragging_fnc_setCarryable",0,true];
	[_box, beerBoxAction] remoteExec ["addAction", 0, true]; //_box addAction beerBoxAction;
	[_box, drinkingAndDriving] remoteExec ["addAction", 0, true]; //_box addAction beerBoxAction;
	[_box, 1] remoteExec ["ace_cargo_fnc_setSize", 0, true];
};

//Code that should be passed into an addAction command that defines the action required to get a beer, drink it, and huck the can
beerBoxAction = ["Crack Open A Cold One", {
		params ["_target", "_caller", "_actionId", "_arguments"];
		//get a beer
		_isInVic = vehicle _caller != _caller;
		_coldOne = (selectRandom boozen) createVehicle (getPos _caller);
		//_coldOneFootOffset = [(((floor random 6) + 1) / 10) - 0.3, 0.6, 1.4];
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
		playSound3D [(getMissionPath "crack.wav"), _coldOne];
		//TODO : ADD MORE CODE TO SIMULATE DRINKING/CHUGGING THE BEER
		sleep 10;
		//safety, disables can and player collision just in case the can wants to do damage
		_coldOne disableCollisionWith _caller;
		//spawns some code that will handle when the can is thrown. prevents excessive bouncing
		[_coldOne] spawn {
			params ["_item"];
			waitUntil {isTouchingGround _item};
			sleep 2;
			waitUntil {isTouchingGround _item && ((speed _item) < 0.01)};
			_item enableSimulation false;
			_item setVelocity [0,0,0];
			_item forceSpeed 0.005;
			_item enableSimulation true;
			sleep 1.5;
			_item enableSimulation false;
		};
		//drops the beer
		detach _coldOne;
		//tosses it aside
		[_caller,_coldOne] call tossAside;
		sleep 25;
		//beer will eventually disappear
		deleteVehicle _coldOne;
	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"true", 	// condition
	10,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

drinkingAndDriving = ["Take 'A Few' For The Road", {
		params ["_target", "_caller", "_actionId", "_arguments"];
		_caller addAction beerBoxAction;
	},
	nil,		// arguments
	0.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"true", 	// condition
	10,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

//IMPORTANT FUNCTION:
// put the following into the developer console:
// call hasFuckedUpNow;
// and it should pick a random player and spawn a new beer box near them.

hasFuckedUpNow = {
	_fucker = selectRandom allPlayers;
	_newBox = "uns_beer1" createVehicle (getPos _fucker);
	[_newBox] call makeBoozeBox;
};

//shits and giggles functions to call upon the various boozy dieties

toTheGodOfBeer = {
	_newBox = "uns_beer1" createVehicle (getPos player);
	[_newBox] call makeBoozeBox;
};

toTheGoddessBerry = {
	_newBox = "uns_beer1" createVehicle (getPos player);
	[_newBox] call makeBoozeBox;
};

toTheGoddessBerryPunch = {
	_newBox = "uns_beer1" createVehicle (getPos player);
	[_newBox] call makeBoozeBox;
};

uponTheGodOfBeer = {
	_newBox = "uns_beer1" createVehicle (getPos player);
	[_newBox] call makeBoozeBox;
};

uponTheGoddessBerry = {
	_newBox = "uns_beer1" createVehicle (getPos player);
	[_newBox] call makeBoozeBox;
};

uponTheGoddessBerryPunch = {
	_newBox = "uns_beer1" createVehicle (getPos player);
	[_newBox] call makeBoozeBox;
};

//booz should be the variable name of a box already placed in the editor
//coldBooz is the name of the ice cooler in chapter 4
if (isServer) then {
  [booz] call makeBoozeBox;
  [coldBooz] call makeBoozeBox;
};

//the dumbest shit
myPPSmak = {
    hintSilent "You were smacked on the PP";
    addCamShake [4, 0.5, 5];
    sleep 3;
    hintSilent "";
};

_smakAction = ["SmackPP","Smack PP","",{
    params ["_target","_smaker","_params"];
    addCamShake [4, 0.5, 5];
    if (alive _target) then {
        [] remoteExec ["myPPSmak",_target,false];
    };
},{true}] call ace_interact_menu_fnc_createAction;

["uns_men_US_6SFG_AT", 0, ["ACE_MainActions"], _smakAction, true] call ace_interact_menu_fnc_addActionToClass;

//list of jack shacks
everyJackShack = [
  Jack_Shack1,  //chapter 1
  Jack_Shack2,  //chapter 1
  Jack_Shack3,  //chapter 2
  Jack_Shack4,  //chapter 4
  Jack_Shack5,  //chapter 4
  Jack_Shack6,  //chickie arsenal
  Arsenal_2    //chapter 3 box
];

//put a manual save for loadouts on every arsenal
{_x addAction["Save Loadout",saveLoadout,[],1.4,true,true,"","true",10,false,"",""];} forEach everyJackShack;



if (!isServer) then {
    ["ace_arsenal_displayClosed",{
            [] spawn saveLoadout;
    }] call CBA_fnc_addEventHandler;
};

Ice_Here setObjectTextureGlobal [1, "eastereggbeerlabels\signs\ICE.paa"];
Ice_Here setObjectTextureGlobal [0, "eastereggbeerlabels\signs\ICE.paa"];
Ice_Here_1 setObjectTextureGlobal [1, "eastereggbeerlabels\signs\ICE.paa"];
Ice_Here_1 setObjectTextureGlobal [0, "eastereggbeerlabels\signs\ICE.paa"];
