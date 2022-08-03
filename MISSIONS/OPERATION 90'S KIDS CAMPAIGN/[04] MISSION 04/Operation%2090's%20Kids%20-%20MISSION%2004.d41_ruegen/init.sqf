#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

//Fuck Grass.
setTerrainGrid 50;

//Set the viewdistance
[6000,2500,100] call Zen_SetViewDistance;

//Forced Decrewing Script - Because Opioid Abuse is bad.
_decrewAction = ["ForceDecrew","Force Crew Out of Vehicle","",{[90, _target, {{_dude = _x select 0;doGetOut _dude;}forEach fullCrew (_this select 0);},{}, "Fighting Crew"] call ace_common_fnc_progressBar;},{true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _decrewAction, true] call ace_interact_menu_fnc_addActionToClass;

// This will fade in from black, to hide jarring actions at mission start, this is optional and you can change the value. I don't know why I included this here, it was part of Zenophon's Framework.
titleText ["Mission Initializing - Hold on for a second, you drunk fucks.", "BLACK FADED", 0.5];
// Some functions may not continue running properly after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
sleep 1;

//ACEX Fortify
//Not a defense mission, but why not? Plenty of reasons... it might go full Fortnite... eh...

[west, 2000, [["Land_BagFence_Long_F", 20], ["Land_BagFence_Corner_F", 20], ["Land_BagFence_Round_F", 20], ["Land_BagFence_Short_F", 10], ["Land_BagBunker_Small_F", 100], ["Land_BagBunker_Tower_F", 400], ["Land_CncBarrier_F", 10], ["Land_CncBarrierMedium_F", 20], ["Land_CncBarrierMedium4_F", 80], ["Land_CncWall1_F", 30], ["Land_CncWall4_F", 120],["Land_Camping_Light_F", 5], ["Land_PortableLight_double_F", 20]]] call acex_fortify_fnc_registerObjects;

spawnPoints = ["opfor01","opfor02","opfor03","opfor04","opfor05","opfor06","opfor07","opfor08","opfor09","opfor10","opfor11","opfor12","opfor13","opfor14","opfor15"];
goalPoints = ["obj_mark_1","obj_mark_2","obj_mark_3","marker_1"];
groupsRebel = [(configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Patrol_section"),(configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Rifle_squad"),(configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Rifle_squad")];
goalPoints2 = ["obj02_mark_01","obj02_mark_02","obj02_mark_03","obj02_mark_04"];

[] spawn {
	waitUntil {obj01start};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	waitUntil {obj01start};
	sleep 1;
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	waitUntil {obj01start};
	sleep 2;
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	waitUntil {obj01start};
	sleep 3;
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	waitUntil {obj01start};
	sleep 4;
	_groupOpfor = [getMarkerPos "opfor_far", EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	waitUntil {obj01start};
	sleep 5;
	_groupOpfor = [getMarkerPos "opfor_far", EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	waitUntil {obj01start};
	sleep 6;
	_groupOpfor = [getMarkerPos "opfor_far", EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	waitUntil {obj02start};
	sleep 4;
	_groupOpfor = [getMarkerPos "opfor_far", EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints2,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	waitUntil {obj02start};
	sleep 5;
	_groupOpfor = [getMarkerPos "opfor_far", EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints2,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	waitUntil {obj02start};
	sleep 6;
	_groupOpfor = [getMarkerPos "opfor_road", EAST, (configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Motorized" >> "LOP_ChDKZ_Moto_Squad_uazopen")] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforLoadUp = _groupOpfor addWaypoint [getMarkerPos "opfor_load",0];
	_opforLoadUp setWaypointType "GETIN NEAREST";
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints2,1];
	_opforWaypoint setWaypointType "UNLOAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};