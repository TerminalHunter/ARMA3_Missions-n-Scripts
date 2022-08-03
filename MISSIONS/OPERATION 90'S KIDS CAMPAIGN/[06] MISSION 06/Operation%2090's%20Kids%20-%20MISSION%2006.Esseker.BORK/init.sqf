#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

//Fuck Grass.
setTerrainGrid 50;

//Set the viewdistance
[6000,2500,100] call Zen_SetViewDistance;

//Forced Decrewing Script - Because Opioid Abuse is bad.
_decrewAction = ["ForceDecrew","Force Crew Out of Vehicle","",{[90, _target, {{_dude = _x select 0;doGetOut _dude;}forEach fullCrew (_this select 0);},{}, "Fighting Crew"] call ace_common_fnc_progressBar;},{true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _decrewAction, true] call ace_interact_menu_fnc_addActionToClass;

// This will fade in from black, to hide jarring actions at mission start, this is optional and you can change the value. I don't know why I included this here, it was part of Zenophon's Framework.
titleText ["Mission Initializing - Hold on for a second, you drunk fucks.", "BLACK FADED", 1.0];
// Some functions may not continue running properly after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
sleep 1;

//ACEX Fortify
//Not a defense mission, but why not? Plenty of reasons... it might go full Fortnite... eh...
//GREAT IDEA. LET THEM ACE FORTIFY MINE WARNING SIGNS AND MARKER FLAGS!

[west, 2000, [["Land_BagFence_Long_F", 20], ["Land_BagFence_Corner_F", 20], ["Land_BagFence_Round_F", 20], ["Land_BagFence_Short_F", 10], ["Land_BagBunker_Small_F", 100], ["Land_BagBunker_Tower_F", 400], ["Land_CncBarrier_F", 10], ["Land_CncBarrierMedium_F", 20], ["Land_CncBarrierMedium4_F", 80], ["Land_CncWall1_F", 30], ["Land_CncWall4_F", 120],["Land_Camping_Light_F", 5], ["Land_PortableLight_double_F", 20],["Land_Sign_MinesDanger_English_F", 1],["FlagMarker_01_F",1]] call acex_fortify_fnc_registerObjects;

//test code
//firstMine = createMine ["rhssaf_mine_pma3", getMarkerPos "mineTest", [], 0];
//secondMine = createMine ["APERSMine", getMarkerPos "mineTest", [], 2];

//vary mines between a few kinds
apMineType = ["rhssaf_mine_pma3", "APERSMine"];

for "_a" from 1 to 12 do{
	_mine = createMine [selectRandom apMineType, getMarkerPos "mineminemine", [], 30];
};

//set up a bunch of mines along the two north-south lines made of markers _10 to _94
for "_i" from 10 to 94 do {
		_currMarker = "marker_" + str _i;
		for "_m" from 1 to 12 do{
			_mine = createMine [selectRandom apMineType, getMarkerPos _currMarker, [], 50];
		};
};
//set up additional mine field locations
mineFieldLocs = ["mineField"];
for "_f" from 1 to 67 do{
	mineFieldLocs append [("mineField_" + str _f)];
};

mineFieldNATOLocs = [];
for "_g" from 68 to 101 do{
	mineFieldNATOLocs append [("mineField_" + str _g)];
};

//set up nuisance mines
for "_n" from 1 to 25 do{
	[] spawn {
		_chosenMineFieldMarker = selectRandom mineFieldLocs;
		_chosenMineField = getMarkerPos _chosenMineFieldMarker;
		_xrnd = round(random 200) - 100;
		_yrnd = round(random 200) - 100;
		_finalLocation = +_chosenMineField;
		_finalLocation set [0,(_chosenMineField select 0) + _xrnd];
		_finalLocation set [1,(_chosenMineField select 1) + _yrnd];
		for "_m2" from 1 to 12 do{
			_mine = createMine [selectRandom apMineType, _finalLocation, [], 30];
		};
	};
};
//set up nuisance mines around NATO base
for "_n2" from 1 to 25 do{
	[] spawn {
		_chosenMineFieldMarker = selectRandom mineFieldNATOLocs;
		_chosenMineField = getMarkerPos _chosenMineFieldMarker;
		_xrnd = round(random 200) - 100;
		_yrnd = round(random 200) - 100;
		_finalLocation = +_chosenMineField;
		_finalLocation set [0,(_chosenMineField select 0) + _xrnd];
		_finalLocation set [1,(_chosenMineField select 1) + _yrnd];
		for "_m3" from 1 to 12 do{
			_mine = createMine [selectRandom apMineType, _finalLocation, [], 30];
		};
	};
};

//test code
//testTest = "CUP_UNBasicWeapons_EP1" createVehicle getMarkerPos "cacheTest";
//testTest2 = "ACE_medicalSupplyCrate_advanced" createVehicle getMarkerPos "cacheTest";
//testTest3 = "CamoNet_BLUFOR_big_F" createVehicle getMarkerPos "cacheTest";
//testTest4 = "Land_CampingTable_F" createVehicle getMarkerPos "cacheTest";
//testTest5 = "Land_TentA_F" createVehicle getMarkerPos "cacheTest";
//{_x hideObjectGlobal true;}forEach nearestTerrainObjects [getMarkerPos "cacheTest", [], 30, false];

//I'mma just put down 500 markers on the map at regular intervals, fuck typing all that into an array
cacheLocs = ["cache"];
for "_l" from 1 to 313 do{
	cacheLocs append [("cache_" + str _l)];
};

//spawn 20 caches
for "_c" from 1 to 20 do{
	[] spawn {
		_chosenMarker = selectRandom cacheLocs;
		_chosenLocation = getMarkerPos _chosenMarker;
		_xrnd = round(random 200) - 100;
		_yrnd = round(random 200) - 100;
		_finalLocation = +_chosenLocation;
		_finalLocation set [0,(_chosenLocation select 0) + _xrnd];
		_finalLocation set [1,(_chosenLocation select 1) + _yrnd];
		_box1 = "CUP_UNBasicWeapons_EP1" createVehicle _finalLocation;
		_box2 = "ACE_medicalSupplyCrate_advanced" createVehicle _finalLocation;
		_camoNet = "CamoNet_BLUFOR_big_F" createVehicle _finalLocation;
		_table = "Land_CampingTable_F" createVehicle _finalLocation;
		_tent = "Land_TentA_F" createVehicle _finalLocation;
		{_x hideObjectGlobal true;}forEach nearestTerrainObjects [_finalLocation, [], 30, false];
	};
};

//consider making functions out of the randomization code

//give players some dudes to shoot
groupsRebel = [(configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Patrol_section"),(configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Rifle_squad"),(configfile >> "CfgGroups" >> "East" >> "LOP_ChDKZ" >> "Infantry" >> "LOP_ChDKZ_Rifle_squad")];

[] spawn {
	while {true} do {
		waitUntil{sleep 1000; true};
		[] spawn {
			_opforPos = selectRandom cacheLocs;
			if ([independent, _opforPos, [250,250],0,"ellipse"] call Zen_AreNotInArea) then {
				_groupOpfor = [getMarkerPos _opforPos, EAST, selectRandom groupsRebel] call BIS_fnc_spawnGroup;
				_groupOpfor deleteGroupWhenEmpty true;
			};
		};
	};
};

//configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_team" for NATO squad

//configfile >> "CfgGroups" >> "Indep" >> "LOP_UN" >> "Infantry" >> "LOP_UN_Rifle_squad" for UN traitors
/*
this code goes into a trigger, but typing it here for ease of use
groupNATO = (configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_team");

NATO1 = [getMarkerPos "nato", WEST, groupNATO] call BIS_fnc_spawnGroup;
NATO1 deleteGroupWhenEmpty true;

NATO2 = [getMarkerPos "nato_1", WEST, groupNATO] call BIS_fnc_spawnGroup;
NATO2 deleteGroupWhenEmpty true;

NATO3 = [getMarkerPos "nato_2", WEST, groupNATO] call BIS_fnc_spawnGroup;
NATO3 deleteGroupWhenEmpty true;

groupUN = (configfile >> "CfgGroups" >> "Indep" >> "LOP_UN" >> "Infantry" >> "LOP_UN_Rifle_squad");

UN1 = [getMarkerPos "reb", INDEPENDENT, groupUN] call BIS_fnc_spawnGroup;
UN1 deleteGroupWhenEmpty true;

UN2 = [getMarkerPos "reb_1", INDEPENDENT, groupUN] call BIS_fnc_spawnGroup;
UN2 deleteGroupWhenEmpty true;

UN3 = [getMarkerPos "reb_2", INDEPENDENT, groupUN] call BIS_fnc_spawnGroup;
UN3 deleteGroupWhenEmpty true;

UN4 = [getMarkerPos "reb_3", INDEPENDENT, groupUN] call BIS_fnc_spawnGroup;
UN4 deleteGroupWhenEmpty true;
*/