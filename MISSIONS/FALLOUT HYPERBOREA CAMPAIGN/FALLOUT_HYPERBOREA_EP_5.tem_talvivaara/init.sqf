#include "dumbShit.sqf"
#include "hyperboreaArsenal.sqf"
#include "autodoc.sqf"
#include "hyperboreaSaveSystem.sqf"
#include "saveLoadout.sqf"
#include "director.sqf"
#include "story.sqf"
#include "lootSystem.sqf"

enableSaving [false, false];

//Vertibird Fusion Recharger
vertibirdRecharge = {
	_currFuel = fuel finaleVerti;
	finaleVerti setFuel (_currFuel + 0.0025);
};

[] spawn {
	while {true} do {
		sleep 30;
		if (local finaleVerti) then {
			[] call vertibirdRecharge;
		};
	};
};

drugVase attachTo [drugBase];
[drugVase] call makeDrugOracle;

[jackShack1] call makeHyperboreaArsenal;
[jackShack2] call makeHyperboreaArsenal;

jackShackRespawn1 attachTo [jackShack1];
jackShackRespawn2 attachTo [jackShack2];

ropeBoi addAction ["Grab Climbing Equipment",addRopes,[],1.5,true,true,"","true"];

//fuel check quick script
_fuelAction = ["CheckFuel", "Check Fuel", "", {hint format ["Fuel: %1%2", str((fuel _target) * 100), "%"]}, {true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _fuelAction, true] call ace_interact_menu_fnc_addActionToClass;
_powerAction = ["CheckPower", "Check Power", "", {hint format ["Power: %1%2", str((fuel _target) * 100), "%"]}, {true}] call ace_interact_menu_fnc_createAction;
["Valor_Transport_Armed_HMG_F", 0, ["ACE_MainActions"], _powerAction, true] call ace_interact_menu_fnc_addActionToClass;

shorterHint = {
	params ["_text"];
	hint _text;
	sleep 4;
	hint "";
};

ruinsLocDB = [];

if (isServer) then {
	[finaleJunkTruck1] call giveRandomLicense;
	[finaleJunkTruck2] call giveRandomLicense;
	ruinsLocDB = [] call mapApocalypsizing;
	[ruinsLocDB] call spreadFixedLoot;
	[] call spreadLootCaches;
	[] call cultistMines;
	["Map Init Finished"] remoteExec ["hint",0,false];
} else {
	[] call mapApocalypsizing;
};

checkSalary = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_playerUID = getPlayerUID _caller;
	_checkString = _playerUID + "hasDrawnSalary";
	if (isNil {missionNamespace getVariable _checkString}) then{
		["Found a few of my envelopes."] remoteExec ["shorterHint",_caller,false];
		missionNamespace setVariable [_checkString,true];
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
	} else {
		["No envelope with my name on it in there."] remoteExec ["shorterHint",_caller,false];
	};
};

//let the players draw their salary once per mission
baseMailbox addAction ["Check Mail for Salary",checkSalary,[],1.5,true,true,"","true",10,false,"",""];
