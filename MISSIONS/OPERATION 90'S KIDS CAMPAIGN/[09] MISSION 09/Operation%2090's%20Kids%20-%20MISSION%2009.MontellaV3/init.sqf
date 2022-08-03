#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

//Fuck Grass.
setTerrainGrid 50;

//Set the viewdistance
[4000,2500,100] call Zen_SetViewDistance;

//Forced Decrewing Script - Because Opioid Abuse is bad.
_decrewAction = ["ForceDecrew","Force Crew Out of Vehicle","",{[90, _target, {{_dude = _x select 0;doGetOut _dude;}forEach fullCrew (_this select 0);},{}, "Fighting Crew"] call ace_common_fnc_progressBar;},{true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _decrewAction, true] call ace_interact_menu_fnc_addActionToClass;

// This will fade in from black, to hide jarring actions at mission start, this is optional and you can change the value. I don't know why I included this here, it was part of Zenophon's Framework.
titleText ["Mission Initializing - This shit's prolly gonna lag a hot minute.", "BLACK FADED", 1.5];
// Some functions may not continue running properly after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
sleep 1;

//ACEX Fortify

[independent, 3000, [["Land_BagFence_Long_F", 20], ["Land_BagFence_Corner_F", 20], ["Land_BagFence_Round_F", 20], ["Land_BagFence_Short_F", 10], ["Land_BagBunker_Small_F", 100], ["Land_BagBunker_Tower_F", 400], ["Land_CncBarrier_F", 10], ["Land_CncBarrierMedium_F", 20], ["Land_CncBarrierMedium4_F", 80], ["Land_CncWall1_F", 30], ["Land_CncWall4_F", 120],["Land_Camping_Light_F", 5], ["Land_PortableLight_double_F", 20]]] call acex_fortify_fnc_registerObjects;

//set up something similar to rescue lecture mission - points where people spawn and walk to
patrolPoints = [];
for "_i" from 1 to 37 do{
	patrolPoints append [("opforSpawn_" + str _i)];
};

groupsPatrol = [(configfile >> "CfgGroups" >> "West" >> "rhsgref_faction_cdf_b_ground" >> "rhsgref_group_cdf_b_reg_infantry" >> "rhsgref_group_cdf_b_reg_infantry_squad"),(configfile >> "CfgGroups" >> "West" >> "rhsgref_faction_cdf_b_ground" >> "rhsgref_group_cdf_b_reg_infantry" >> "rhsgref_group_cdf_b_reg_infantry_squad_weap")];

patrols = [];

[] spawn {
	while {dayTime < 14.5} do {
		waitUntil{sleep 25; count patrols < 6};
		[] spawn {
			_opforPos = selectRandom patrolPoints;
			if ([independent, _opforPos, [200,200],0,"ellipse"] call Zen_AreNotInArea) then {
				_groupOpfor = [getMarkerPos _opforPos, WEST, selectRandom groupsPatrol] call BIS_fnc_spawnGroup;
				_groupOpfor deleteGroupWhenEmpty true;
				_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom patrolPoints,0];
				_opforWaypoint setWaypointType "SAD";
				_opforWaypoint setWaypointCompletionRadius 100;
				_opforWaypoint2 = _groupOpfor addWaypoint [getMarkerPos selectRandom patrolPoints,0];
				_opforWaypoint2 setWaypointType "SAD";
				_opforWaypoint2 setWaypointCompletionRadius 10;
				_opforWaypointCycle = _groupOpfor addWaypoint [getMarkerPos selectRandom patrolPoints,0];
				_opforWaypointCycle setWaypointType "CYCLE";
				_opforWaypointCycle setWaypointCompletionRadius 10;
				patrols append [_groupOpfor];
			};
		};
	};
};

//need extra code to delete groups as their members die
//dead people take a while to get removed from the group and the group only goes null once all the corpses are removed from said group (~8 minutes for this all to go down)

[] spawn {
	while {sleep 60; true;} do {
		for "_i" from 0 to (count patrols) - 1 do{
			if (isNull (patrols select _i)) then{
				patrols deleteAt _i;
			};
		};
	};
};

//why not count civilian casualties?

civCas = 0;

[] spawn {
	while {sleep 200; true;} do{
		{
			if (side _x == Civilian && _x isKindOf "Man" && isNil{_x getVariable "warCrimeCount"}) then{
				_x setVariable[ "warCrimeCount",_x addEventHandler ["killed",{civCas = civCas + 1;hint format["Civilian Casualties: %1",civCas];}]];
			};
		}forEach allunits;
	};
};
//note to self: isNil and isNull are two different functions and you aren't getting that hour of your life back

//rebel reinforcements
rebelGroup = [(configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_chdkz_g" >> "rhsgref_group_chdkz_ins_gurgents_infantry" >> "rhsgref_group_chdkz_ins_gurgents_squad")];

[] spawn {
	while {dayTime < 15} do {
		waitUntil{sleep 900; true};
		[] spawn {
			if ([independent, _opforPos, [50,50],0,"ellipse"] call Zen_AreNotInArea) then {
				_groupOpfor = [getMarkerPos "rebelReinforce", INDEPENDENT, selectRandom rebelGroup] call BIS_fnc_spawnGroup;
				_groupOpfor deleteGroupWhenEmpty true;
				_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos selectRandom patrolPoints,0];
				_opforWaypoint setWaypointType "SAD";
				_opforWaypoint setWaypointCompletionRadius 100;
				_opforWaypoint2 = _groupOpfor addWaypoint [getMarkerPos selectRandom patrolPoints,0];
				_opforWaypoint2 setWaypointType "SAD";
				_opforWaypoint2 setWaypointCompletionRadius 10;
				_opforWaypointCycle = _groupOpfor addWaypoint [getMarkerPos selectRandom patrolPoints,0];
				_opforWaypointCycle setWaypointType "CYCLE";
				_opforWaypointCycle setWaypointCompletionRadius 10;
			};
		};
	};
};