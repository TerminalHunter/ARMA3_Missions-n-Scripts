#include "dumbShit.sqf"
#include "hyperboreaArsenal.sqf"
#include "autodoc.sqf"
#include "hyperboreaSaveSystem.sqf"
#include "saveLoadout.sqf"
#include "director.sqf"
#include "story.sqf"
#include "lootSystem.sqf"

enableSaving [false, false];

bass = true;

if (isServer) then {
	[junkTruck1] call giveRandomLicense;
	[junkTruck2] call giveRandomLicense;

	//dumb joke
	[ ]spawn {
		while {bass == true} do {
			playSound3D [getMissionPath "mufflebassloop.ogg", hardbassbmp];
			sleep 12.8;
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

_southBridge = nearestTerrainObjects [(getMarkerPos "marker_29"),[],2] select 0;
_westBridge = nearestTerrainObjects [(getMarkerPos "marker_30"),[],3] select 0;
_westTrainBridge = nearestTerrainObjects [(getMarkerPos "marker_31"),[],15] select 0;
_northBridge = nearestTerrainObjects [(getMarkerPos "marker_32"),[],8] select 0;
_eastTopBridge = nearestTerrainObjects [(getMarkerPos "marker_33"),[],10] select 0;
_eastBottomBridge = nearestTerrainObjects [(getMarkerPos "marker_34"),[],15] select 0;
_bridges = [
	_southBridge,
	_westBridge,
	_westTrainBridge,
	_northBridge,
	_eastTopBridge,
	_eastBottomBridge
];
//player progress
hideObjectGlobal _westBridge;
hideObjectGlobal _westTrainBridge;
hideObjectGlobal _eastTopBridge;
hideObjectGlobal _southBridge;
hideObjectGlobal _northBridge;
hideObjectGlobal _eastBottomBridge;

//Code specific to the previous mission
/*
bridgeExplosives = [
	explosive_1,
	explosive_2,
	explosive_3,
	explosive_4,
	explosive_5,
	explosive_6,
	explosive_7,
	explosive_8
];

secondaryExplosion = {
	params ["_loc"];
	_num = floor random 4 + 3;
	for "_i" from 1 to _num do {
		sleep (random 1);
		_c4 = "DemoCharge_Remote_Ammo_Scripted" createVehicle (_loc vectorAdd [(floor random 4) - 2, (floor random 4) - 2, 0]);
		_c4 setDamage 1;
	};
};

bridgeBlow = {
	params ["_box", "_bridge"];
	_c4 = "DemoCharge_Remote_Ammo_Scripted" createVehicle (getPosATL _box);
	[getPosASL _box] call secondaryExplosion;
	_c4 setDamage 1;
	deleteVehicle _box;
	hideObjectGlobal _bridge;
};

lightFuse = {
	params ["_box", "_bridge"];
	_fuse = "SmokeShell" createVehicle (getPosASL _box);
	[_bridge] call qrfBridge;
	sleep 45;
	deleteVehicle _fuse;
	[_box, _bridge] remoteExec ["bridgeBlow", 0, false];
};

//autodoc code init
blownBridge = "";

qrfBridge = {
	params ["_bridgeBlown"];
	blownBridge = _bridgeBlown;
	publicVariableServer "bridgeQRF";
	publicVariableServer "sendQRF";
};

sendInTheClowns = {
	params ["_qrfLoc"];
	_startLoc = getMarkerPos "qrfStart";
	_returnGroup = [_startLoc, EAST, (configfile >> "CfgGroups" >> "East" >> "O_SwarfGang2better" >> "Infantry" >> "o_swarfgang2_infantry_qrf")] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;

	_firstWaypoint = _returnGroup addWaypoint [_qrfLoc, 0];
	_firstWaypoint setWaypointType "SAD";
	_firstWaypoint setWaypointCompletionRadius 20;
};

ohShit = {
	_poorSchmuck = selectRandom (call BIS_fnc_listPlayers);
	[getPos _poorSchmuck] call sendInTheClowns;
};

if(isServer)then{

	"sendQRF" addPublicVariableEventHandler{
		[blownBridge] call sendInTheClowns;
	};

	scavCampPoint = [
		"marker_47",
		"marker_48",
		"marker_49"
	];

	{
	[getMarkerPos _x] spawn spawnBaseTreasure;
	} forEach scavCampPoint;

	[_bridges] spawn {
		params ["_bridges"];
		while {true} do {
			sleep 3;
			{
				[_x] remoteExec ["removeAllActions", 0];
			} forEach bridgeExplosives;
			{
				_placedExplosives = nearestObjects [_x, ["Box_IED_Exp_F"], 6, true];
				if (count _placedExplosives > 0) then{
					[(_placedExplosives select 0), ["Light Fuse", {[(_this select 0),((_this select 3)select 0)] spawn lightFuse}, [_x], 1.5, true, true, "", "true", 3, false, "", ""]] remoteExec ["addAction", 0, false];
				};
			} forEach _bridges;
		};
	};

};

randoFlare =  [
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_red",
	"ACE_40mm_Flare_green"
];

flareMission = {
	params ["_gridRef","_minutes"];
	sleep 60 + (floor random 60);
	for "_i" from 1 to _minutes*2 step 1 do {
		_pos = _gridRef call BIS_fnc_gridToPos;
		_newFlare = (selectRandom randoFlare) createVehicle ((_pos select 0) vectorAdd (_pos select 1 vectorMultiply 0.5) vectorAdd [(floor (random 100)) - 50,(floor (random 100)) - 50,250]);
		_newFlare setVelocity [0,0,-0.5];
		sleep 30;
	};
};

smokeMission = {
	params ["_gridRef","_rounds"];
	sleep 60 + (floor random 60);
	for "_i" from 1 to _rounds step 1 do {
		_pos = _gridRef call BIS_fnc_gridToPos;
		_newShell = "SmokeShell" createVehicle ((_pos select 0) vectorAdd (_pos select 1 vectorMultiply 0.5) vectorAdd [(floor (random 100)) - 50,(floor (random 100)) - 50,250]);
		sleep 3 + (floor random 3);
	};
};

if (isServer) then {
	lastGridRef = "000000";
	lastDuration = 0;
	lastMission = flareMission;
	lastMissionText = "flare";
	addMissionEventHandler ["HandleChatMessage", {
		params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType"];
		if (_text find "0" == 0) then {
			lastGridRef = _text;
			publicVariableServer "lastGridRef";
		} else {
			if (parseNumber _text != 0) then {
				lastDuration = parseNumber _text;
				publicVariableServer "lastDuration";
			} else {
				if (_text == "smoke") then {
					lastMission = smokeMission;
					publicVariableServer "lastMission";
					lastMissionText = "smoke";
					publicVariableServer "lastMissionText";
				} else {
					if (_text == "flare") then {
						lastMission = flareMission;
						publicVariableServer "lastMission";
						lastMissionText = "flare";
						publicVariableServer "lastMissionText";
					} else {
						if (_text == "go" || _text == "repeat") then {
							[lastGridRef, lastDuration] spawn lastMission;
							publicVariableServer "missionStart";
						};
					};
				};
			};
		};
	}];

	"lastGridRef" addPublicVariableEventHandler {
		[mortarGuy, "Grid ref recieved."] remoteExec ["sideChat",0];
	};

	"lastDuration" addPublicVariableEventHandler {
		if (lastMissionText == "flare") then {
			_string = "Grabbing enough flares for " + str (_this select 1) + " minutes of light.";
			[mortarGuy, _string] remoteExec ["sideChat",0];
		} else {
			_string = "Loading " + str (_this select 1) + " smoke shells.";
			[mortarGuy, _string] remoteExec ["sideChat",0];
		};
	};

	"lastMission" addPublicVariableEventHandler {
		if (lastMissionText == "flare") then {
			[mortarGuy, "Switching to flares."] remoteExec ["sideChat",0];
		} else {
			[mortarGuy, "Switching to smokes."] remoteExec ["sideChat",0];
		};
	};

	"missionStart" addPublicVariableEventHandler {
		[mortarGuy, "Fire mission recieved."] remoteExec ["sideChat",0];
	};

};

Animations can be cancelled using _unit call BIS_fnc_ambientAnim__terminate.

this addAction ["I need you to move, get up if you can.",{_this select 0 call BIS_fnc_ambientAnim_terminate}];

this addAction ["I need you to move, get up if you can.",{
	_this select 0 call BIS_fnc_ambientAnim__terminate
},[],1.5,true,true,"","true",10,false,"",""];

this disableAI "PATH";
this setUnitPos "UP";
[this, "PRONE_INJURED"] call BIS_fnc_ambientAnim;
this addAction ["I need you to move, get up if you can.",{_this select 0 call BIS_fnc_ambientAnim__terminate; removeAllActions (_this select 0);},[],1.5,true,true,"","true",4,false,"",""];
[] spawn {sleep 10; removeAllWeapons botherBoy;};

*/
