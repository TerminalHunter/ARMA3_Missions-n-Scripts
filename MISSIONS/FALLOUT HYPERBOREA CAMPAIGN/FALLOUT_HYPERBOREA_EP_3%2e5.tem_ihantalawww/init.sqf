#include "dumbShit.sqf"
#include "hyperboreaArsenal.sqf"
#include "autodoc.sqf"
#include "hyperboreaSaveSystem.sqf"
#include "saveLoadout.sqf"
#include "director.sqf"
#include "lootSystem.sqf"

enableSaving [false, false];

if (isServer) then {
	[junkTruck1] call giveRandomLicense;
	[junkTruck2] call giveRandomLicense;
	[] spawn spreadLootCaches;
};

drugVase attachTo [drugBase];
[drugVase] call makeDrugOracle;

[jackShack1] call makeHyperboreaArsenal;
[jackShack2] call makeHyperboreaArsenal;

jackShackRespawn1 attachTo [jackShack1];
jackShackRespawn2 attachTo [jackShack2];

//fuel check quick script
_fuelAction = ["CheckFuel", "Check Fuel", "", {hint format ["Fuel: %1%2", str((fuel _target) * 100), "%"]}, {true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _fuelAction, true] call ace_interact_menu_fnc_addActionToClass;

//Code specific to this mission
storyText = {
  params ["_text"];
  titleText [_text,"PLAIN DOWN",2.5,true,true];
};

shorterHint = {
	params ["_text"];
	hint _text;
	sleep 4;
	hint "";
};

if (isServer) then {

	//general loot
	for "_i" from 1 to 47 step 1 do{
		_lootSpot = missionNamespace getVariable ("lootZone_" + (str _i));
		[(getPosATL _lootSpot), false] spawn createLootBox;
		_randValue = floor random 2;
		if (_randValue == 1) then {
			[(getPosATL _lootSpot), true] spawn createLootBox;
		};
		deleteVehicle _lootSpot;
	};
	//choose spots for fuel
	_fuelSpots = [];
	while {count _fuelSpots < 7} do {
		_newNum = floor ((random 29) + 1);
		_fuelSpots pushBackUnique _newNum;
	};

	{
		_gasSpot = missionNamespace getVariable ("potentialFuel_" + (str _x));
		_gasCan = "Land_CanisterFuel_Red_F" createVehicle (getPosATL _gasSpot);
		[_gasCan,1] call ace_cargo_fnc_setSize;
		[_gasCan, true] call ace_dragging_fnc_setCarryable;
	} forEach _fuelSpots;

	for "_i" from 1 to 29 step 1 do{
		_gasSpot = missionNamespace getVariable ("potentialFuel_" + (str _i));
		deleteVehicle _gasSpot;
	};

	[(getPos lootMan)] spawn spawnBaseTreasure;

};
