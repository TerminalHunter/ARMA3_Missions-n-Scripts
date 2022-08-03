#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

//Fuck Grass.
setTerrainGrid 50;

//Set the viewdistance
[6000,2500,100] call Zen_SetViewDistance;

//Forced Decrewing Script - Because Opioid Abuse is bad.
_decrewAction = ["ForceDecrew","Force Crew Out of Vehicle","",{[90, _target, {{_dude = _x select 0;doGetOut _dude;}forEach fullCrew (_this select 0);},{}, "Fighting Crew"] call ace_common_fnc_progressBar;},{true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _decrewAction, true] call ace_interact_menu_fnc_addActionToClass;

//grab position data for chemical code before shit blows up
obj01pos = getPosASL obj01 vectorAdd [0,0,-1.5];
obj02pos = getPosASL obj02 vectorAdd [0,0,-1.5];

obj03pos = getPosASL obj03;
obj04pos = getPosASL obj04;
obj05pos = getPosASL obj05;

//these guys are tall, need that extra 3 meters in vectorAdd
obj06pos = getPosASL obj06 vectorAdd [0,0,3];
obj07pos = getPosASL obj07 vectorAdd [0,0,3];

// This will fade in from black, to hide jarring actions at mission start, this is optional and you can change the value. I don't know why I included this here, it was part of Zenophon's Framework.
titleText ["Mission Initializing - Hold on for a second, you drunk fucks.", "BLACK FADED", 0.5];
// Some functions may not continue running properly after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
sleep 1;

//Chemical Leak Script

//handle what happens when shit blows up

northLeak1 = obj01 addEventHandler ["killed", {[obj01pos, 0] execVM "chemicalLeak.sqf";}];
northLeak2 = obj02 addEventHandler ["killed", {[obj02pos, 0] execVM "chemicalLeak.sqf";}];

westLeak1 = obj03 addEventHandler ["killed", {[obj03pos, 2] execVM "chemicalLeak.sqf";}];
westLeak2 = obj04 addEventHandler ["killed", {[obj04pos, 2] execVM "chemicalLeak.sqf";}];
westLeak3 = obj05 addEventHandler ["killed", {[obj05pos, 2] execVM "chemicalLeak.sqf";}];

eastLeak1 = obj06 addEventHandler ["killed", {[obj06pos, 1] execVM "chemicalLeak.sqf";}];
eastLeak2 = obj07 addEventHandler ["killed", {[obj07pos, 1] execVM "chemicalLeak.sqf";}];

//Let players fuck with chemical weapons
obj01 addAction ["Fuck with silo", {[200, [obj01, obj01pos], {obj01 say3D ["hiss_leak", 600]; [obj01pos, 0] execVM "chemicalLeak.sqf"; hint "Oops... That wasn't supposed to happen..."; removeAllActions obj01;}, {}, "Fucking with silo"] call ace_common_fnc_progressBar;}, [obj01, obj01pos], 1.5, true, true, "", "true", 14, false, "", ""];

obj02 addAction ["Fuck with silo", {[200, [obj02, obj02pos], {obj02 say3D ["hiss_leak", 600]; [obj02pos, 0] execVM "chemicalLeak.sqf"; hint "Oops... That wasn't supposed to happen..."; removeAllActions obj02;}, {}, "Fucking with silo"] call ace_common_fnc_progressBar;}, [obj02, obj02pos], 1.5, true, true, "", "true", 14, false, "", ""];

obj03 addAction ["Fuck with silo", {[200, [obj03, obj03pos], {obj03 say3D ["hiss_leak", 600]; [obj03pos, 2] execVM "chemicalLeak.sqf"; hint "Oops... That wasn't supposed to happen..."; removeAllActions obj03;}, {}, "Fucking with silo"] call ace_common_fnc_progressBar;}, [obj03, obj03pos], 1.5, true, true, "", "true", 7, false, "", ""];

obj04 addAction ["Fuck with silo", {[200, [obj04, obj04pos], {obj04 say3D ["hiss_leak", 600]; [obj04pos, 2] execVM "chemicalLeak.sqf"; hint "Oops... That wasn't supposed to happen..."; removeAllActions obj04;}, {}, "Fucking with silo"] call ace_common_fnc_progressBar;}, [obj04, obj04pos], 1.5, true, true, "", "true", 7, false, "", ""];

obj05 addAction ["Fuck with silo", {[200, [obj05, obj05pos], {obj05 say3D ["hiss_leak", 600]; [obj05pos, 2] execVM "chemicalLeak.sqf"; hint "Oops... That wasn't supposed to happen..."; removeAllActions obj05;}, {}, "Fucking with silo"] call ace_common_fnc_progressBar;}, [obj05, obj05pos], 1.5, true, true, "", "true", 7, false, "", ""];

obj06 addAction ["Fuck with silo", {[200, [obj06, obj06pos], {obj06 say3D ["hiss_leak", 600]; [obj06pos, 1] execVM "chemicalLeak.sqf"; hint "Oops... That wasn't supposed to happen..."; removeAllActions obj06;}, {}, "Fucking with silo"] call ace_common_fnc_progressBar;}, [obj06, obj06pos], 1.5, true, true, "", "true", 8, false, "", ""];

obj07 addAction ["Fuck with silo", {[200, [obj07, obj07pos], {obj07 say3D ["hiss_leak", 600]; [obj07pos, 1] execVM "chemicalLeak.sqf"; hint "Oops... That wasn't supposed to happen..."; removeAllActions obj07;}, {}, "Fucking with silo"] call ace_common_fnc_progressBar;}, [obj07, obj07pos], 1.5, true, true, "", "true", 8, false, "", ""];

//ACEX Fortify

[west, 2000, [["Land_BagFence_Long_F", 20], ["Land_BagFence_Corner_F", 20], ["Land_BagFence_Round_F", 20], ["Land_BagFence_Short_F", 10], ["Land_BagBunker_Small_F", 100], ["Land_BagBunker_Tower_F", 400], ["Land_CncBarrier_F", 10], ["Land_CncBarrierMedium_F", 20], ["Land_CncBarrierMedium4_F", 80], ["Land_CncWall1_F", 30], ["Land_CncWall4_F", 120],["Land_Camping_Light_F", 5], ["Land_PortableLight_double_F", 20]]] call acex_fortify_fnc_registerObjects;

//OPFOR Mission Spawning

//mission starts at 21:30 or 21.5 using daytime
//1 hour of organization and such means earliest spawn should be at 22.5

//configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Patrol_section"
//configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Rifle_squad"
//configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Support_section"

//first one's hardcoded
[] spawn {
	waitUntil {sleep 30; dayTime > 22.5};
	_groupOpfor = [getMarkerPos "opfor01", EAST, (configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Patrol_section")] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos "overwatch01",0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

spawnPoints = ["opfor01","opfor02","opfor03","opfor04","opfor05","opfor06","opfor07"];
goalPoints = ["overwatch01","overwatch02","obj_mark_1","obj_mark_2","obj_mark_3","start_mark"];
groupsRebel = [(configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Patrol_section"),(configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Rifle_squad"),(configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Rifle_squad")];

//last one's hardcoded
[] spawn {
	waitUntil {sleep 30; dayTime < 12 && dayTime > 0.20};
	_groupOpfor = [getMarkerPos "opforSouth", EAST, (configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Rifle_squad")] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos "obj_mark_2",0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};

[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
//I'm a lazy git, copy and paste AWAY!!!
//This mission is going to be very random.
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};
[] spawn {
	_timeTilSpawn = 22.5 + random 1.5;
	waitUntil {sleep 30; dayTime > _timeTilSpawn};
	_groupOpfor = [getMarkerPos selectRandom spawnPoints, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
	_groupOpfor deleteGroupWhenEmpty true;
	_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom goalPoints,0];
	_opforWaypoint setWaypointType "SAD";
	_opforWaypoint setWaypointCompletionRadius 100;
};