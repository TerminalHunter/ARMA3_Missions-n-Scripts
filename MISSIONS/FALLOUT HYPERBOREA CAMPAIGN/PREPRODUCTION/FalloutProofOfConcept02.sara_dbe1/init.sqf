#include "clientInit.sqf"
#include "serverInit.sqf"

//CLIENT SHIT HERE

//ya'll fucks can't seem to press a button, so here I am pressing it for you
//adds an event handler that'll autosave your loadout when you close the ace arsenal
_arsenalAutoSave = ["ace_arsenal_displayClosed",{["saveLoadout.sqf"] remoteExec ["execVM"];}] call CBA_fnc_addEventHandler;

//manual save system init
campaignStartSave = {
	startSaveGame = random 100;
	publicVariableServer "startSaveGame";
};

jackShack1 addAction["Save Game",campaignStartSave,[],1.5,true,true,"","true",10,false,"",""];
jackShack2 addAction["Save Game",campaignStartSave,[],1.5,true,true,"","true",10,false,"",""];

//CLIENT SHIT ENDS

// ZEN FRAMEWORK INITIALIZATION

//Black loading screen for ~15 seconds
//[] spawn blackoutLoadingScreen;

// SQF functions cannot continue running after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
sleep 1;

//ZEN FRAMEWORK INIT ENDS

//SERVER SHIT HERE

// this function saves the game
updateCampaignData ={
	//gets the date & time and saves it
	_currDate = date;
	profileNamespace setVariable ["hyperboreaCampaignDate",_currDate];
};

// checks for previously saved game, makes new data if not found
// this code loads the game or sets up a new save
if (isNil {profileNamespace getVariable "hyperboreaCampaignDate"}) then {
	["CAMPAIGN DATA NOT FOUND\nSTARTING NEW GAME","hint"] call BIS_fnc_MP;
	//sets default start date and time
	setDate [2283, 3, 22, 20, 0];
	call updateCampaignData;
} else {
	//grabs saved date & time and sets the game's time
	_savedDate = profileNamespace getVariable "hyperboreaCampaignDate";
	setDate _savedDate;
};

//autosave the game every half hour
[] spawn {
	while {true} do {
		sleep 1800;
		call updateCampaignData;
		["AUTOSAVE COMPLETE","hint"] call BIS_fnc_MP;
	};
};

//manual save server code
"startSaveGame" addPublicVariableEventHandler{
	call updateCampaignData;
	["MANUAL SAVE COMPLETE","hint"] call BIS_fnc_MP;
};

//attach respawn points to jack shacks
//will probably need to be removed/revamped
jackShackRespawn1 attachTo [jackShack1];
jackShackRespawn2 attachTo [jackShack2];

//Hide map objects that don't wholly fit into the Fallout/post-apoc theme
//Took a shit-ton of time to optimize this. Server sticks to approx 10-20 fps and takes 2 minutes to complete.
//[] spawn mapApocalypsizing;

//Spawn enemies for test!

gangGroups = [(configfile >> "CfgGroups" >> "East" >> "JAC_T_F" >> "Infantry" >> "JacCombatGroup"),(configfile >> "CfgGroups" >> "East" >> "JAC_T_F" >> "Infantry" >> "JacFireTeam"),(configfile >> "CfgGroups" >> "East" >> "JAC_T_F" >> "Infantry" >> "JacShockTeam")];

patrols = [];

[] spawn {
	while {true} do {
		waitUntil{sleep 120; count patrols < 8};
		[] spawn {
			_opforPos = "marker_2";
			_groupOpfor = [getMarkerPos _opforPos, EAST, selectRandom gangGroups] call BIS_fnc_spawnGroup;
			//["YAY!","hint"] call BIS_fnc_MP;
			_groupOpfor deleteGroupWhenEmpty true;
			_opforWaypoint = _groupOpfor addWaypoint [getMarkerPos "marker_1",0];
			_opforWaypoint setWaypointType "SAD";
			_opforWaypoint setWaypointCompletionRadius 100;
			patrols append [_groupOpfor];
		};
	};
};

//need extra code to delete groups as their members die
//dead people take a while to get removed from the group and the group only goes null once all the corpses are removed from said group (~8 minutes for this all to go down)

[] spawn {
	while {sleep 180; true;} do {
		for "_i" from 0 to (count patrols) - 1 do{
			if (isNull (patrols select _i)) then{
				patrols deleteAt _i;
			};
		};
	};
};

//SERVER SHIT ENDS HERE

//#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"
