#include "canCode.sqf"
#include "extraFunctions.sqf"
#include "civJunkArsenal.sqf"
#include "musicAI.sqf"
#include "glowstickEat.sqf"

[jackShackActual] call makeArsenal;
[equipBox] call makeBoxArsenal;
[clothesBox] call makeBoxArsenal;
[touristJackShack] call makeArsenal;
[campingJackShack] call makeArsenal;
[ancientJackShack] call makeAncientArsenal;
[ancientJackShack_1] call makeAncientArsenal;

canSounds = [
	"can1.ogg",
	"can2.ogg",
	"can3.ogg"
];

canCount = {
	_theCount = Boxen nearObjects ["baseBeer", worldSize];
	_return = count _theCount;
	_return
};

currentCanCount = 0;
personalCanCount = 0;
totalCansTurnedIn = 0;

incrementCanCount = {
	currentCanCount = currentCanCount + 1;
};

decrementCanCount = {
	currentCanCount = currentCanCount - 1;
};

makeAsshole = {
	params ["_assholeToBe"];
	while {alive _assholeToBe && !(_assholeToBe getVariable ["ACE_isUnconscious", false]) && damage _assholeToBe <= 0 && !(_assholeToBe getVariable ["ace_captives_isHandcuffed", false])} do {
		[objNull, _assholeToBe, 0 , []] spawn takeAShot;
		sleep 14;
	};
};

[] spawn {
	while {true} do {
		sleep 0.32;
		if (currentWeapon player == "ACE_VMM3") then {
			_canCheck = (player modelToWorld [0,1.2,0]) nearObjects ["Items_base_F", 1];
			{
				if (typeOf _x in boozen && getPos _x select 2 < 0.1) then {
					deleteVehicle _x;
					sleep 0.01;
					//_update = [] call canCount;
					//_cansPickedUp = initialCanCount - _update;
					//[] remoteExec ["incrementCanCount", 0, false];
					//_percentage = floor((currentCanCount / initialCanCount) * 100);
					//hint format ["%1%2 done!", str _percentage, "%"];
					//[format ["%1%2 done!", str _percentage, "%"]] remoteExec ["hint", 0, false];
					playSound3D [getMissionPath (selectRandom canSounds), player];
					personalCanCount = personalCanCount + 1;
					_scoreString = "You've picked up: " + (str personalCanCount) + " cans!";
					hint _scoreString;
				};
			} forEach _canCheck;
		};
	};
};


//SERVER ONLY
if (isServer) then {

	[Boxen] call makeBoozeBox;
	[Boxen2] call makeBoozeBox;
	[Boxen3] call makeBoozeBox;

	weedBox addItemCargoGlobal ["murshun_cigs_cigpack", 20];
	weedBox addItemCargoGlobal ["murshun_cigs_lighter", 4];

	litterBox = {
		params ["_marker","_number","_cans"];
		for [{_i = _number},{_i > 0},{_i = _i - 1}] do {
			_posGroupCenter = [_marker, false] call CBA_fnc_randPosArea;
			for [{_j = 20},{_j > 0},{_j = _j - 1}] do {
				_newCan = createVehicle [selectRandom _cans, _posGroupCenter, [], 4, "CAN_COLLIDE"];
				_newCan setPos (getPos _newCan vectorAdd [0,0,-0.02]);
				_newCan setDir (floor random 360);
		    [_newCan, (floor random 360), 90] call BIS_fnc_setPitchBank;
				_newCan enableSimulationGlobal false;
			};
		};
	};

	["tutorialCans",5,boozen] call litterBox;
	["tutorialCans_1",5,boozen] call litterBox;
	[] spawn {
		waitUntil {triggerActivated doneWithTourists};
		["todaysLitter",5,boozen] call litterBox;
		["bigCanTrail",40,boozen] call litterBox;
		["spookyTrash",15,boozen] call litterBox;
	};
	[] spawn {
		waitUntil {triggerActivated spookyTown};
		["dogLegCanTrail",25,boozen] call litterBox;
		["smallCanTrail01",5,boozen] call litterBox;
		["smallCanTrail02",5,boozen] call litterBox;
		["smallCanTrail03",5,boozen] call litterBox;
		["smallCanTrail04",5,boozen] call litterBox;
		["smallCanTrail05",7,boozen] call litterBox;
		["smallCanTrail06",5,boozen] call litterBox;
		["smallCanTrail06_1",5,boozen] call litterBox;
		["smallCanTrail06_2",5,boozen] call litterBox;
	};
	for "_i" from 1 to 50 step 1 do {
		_position = ["butYourLeg", false] call CBA_fnc_randPosArea;
		"AM_BearTrap_Ammo" createVehicle _position;
		for [{_j = 5},{_j > 0},{_j = _j - 1}] do {
			_newCan = createVehicle [selectRandom boozen, _position, [], 4, "CAN_COLLIDE"];
			_newCan setPos (getPos _newCan vectorAdd [0,0,-0.03]);
			_newCan setDir (floor random 360);
			[_newCan, (floor random 360), 90] call BIS_fnc_setPitchBank;
			_newCan enableSimulationGlobal false;
		};
	};

	[] spawn {
		waitUntil {
			sleep 1;
			triggerActivated beginAssholery;
		};
		[testHole] spawn makeAsshole;
		sleep ((random 3) + 1);
		[testHole2] spawn makeAsshole;
		sleep ((random 3) + 1);
		[testHole3] spawn makeAsshole;
		[assHole04] spawn makeAsshole;
		sleep ((random 3) + 1);
		[assHole05] spawn makeAsshole;
		sleep ((random 3) + 1);
		[assHole06] spawn makeAsshole;
		sleep ((random 3) + 1);
		[assHole07] spawn makeAsshole;
		sleep ((random 3) + 1);
		[assHole08] spawn makeAsshole;
		sleep ((random 3) + 1);
		[assHole09] spawn makeAsshole;
	};

	//[cannibalTest] spawn makeCannibal;

};

//initialCanCount = [] call canCount;
initialCanCount = 2500;

/*
TODO:

Obstacles
	Obstacle 1: Tourists
	Obstacle 2: Wildlife
	Obstacle 3: SHIA LEBEOUF

Write descriptions/tasks/etc.
	Mind the wildlife
	Go find your field coordinator for Group Whisky
	AT rocket pods - "Anti Tiger"

*/
