#include "dumbShit.sqf"
#include "hyperboreaArsenal.sqf"
#include "autodoc.sqf"
#include "hyperboreaSaveSystem.sqf"
#include "saveLoadout.sqf"
#include "director.sqf"
#include "story.sqf"
#include "lootSystem.sqf"

enableSaving [false, false];

if (isServer) then {
	[junkTruck1] call giveRandomLicense;
	[junkTruck2] call giveRandomLicense;
};

//Vertibird Fusion Recharger
vertibirdRecharge = {
	_currFuel = fuel verti;
	verti setFuel (_currFuel + 0.0025);
};

[] spawn {
	while {true} do {
		sleep 30;
		if (local verti) then {
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

//fuel check quick script
_fuelAction = ["CheckFuel", "Check Fuel", "", {hint format ["Fuel: %1%2", str((fuel _target) * 100), "%"]}, {true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _fuelAction, true] call ace_interact_menu_fnc_addActionToClass;

shorterHint = {
	params ["_text"];
	hint _text;
	sleep 4;
	hint "";
};

ropeBoi addAction ["Grab Climbing Equipment",addRopes,[],1.5,true,true,"","true"];

/*
this addAction ["Enter Bunker (One At A Time, Please)", {
		player setPosATL [11105.773,12431.313,68.643];
},[],1.5,true,true,"","true",10,false,"",""];
*/
//11105.773
//12431.313
//68.643
