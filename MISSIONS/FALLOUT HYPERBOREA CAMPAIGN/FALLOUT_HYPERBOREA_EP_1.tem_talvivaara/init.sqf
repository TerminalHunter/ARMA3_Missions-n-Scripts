#include "loadingScreen.sqf"
#include "lootSystem.sqf"
#include "saveSystem.sqf"
#include "saveLoadout.sqf"
#include "autodoc.sqf"
#include "guttercup.sqf"
#include "director.sqf"
#include "story.sqf"
#include "dumbShit.sqf"

//FYI
//baseComputer
//baseMechazawa
//baseCraftingBench
//baseMailbox
//baseBobShrine

//CLIENT SHIT HERE

// Black Loading Screen - delays 15 seconds with a loading screen unless server time is > 200 seconds
// requires time_srv.sqf which is written by ALIAS, JIP function of the loading screen mostly stolen from his cutscene maker
if (!isServer) then {
	[] spawn blackoutLoadingScreen;
};

//color correction - to make things look colder and blue but eventually return to normal
"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.75],[0.5,0.3,1.0,-0.1]];
"colorCorrections" ppEffectCommit 0;

removeBlue = {
	"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.0, 0.0, 0.0, 0.0],[1.0, 1.00, 1.0, 1.00],[0.299, 0.587, 0.114, 0]];
	"colorCorrections" ppEffectCommit 0;
};

readdBlue = {
	"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.60],[0.5,0.3,1.0,-0.1]];
	"colorCorrections" ppEffectCommit 0;
};

//manual save system init
campaignStartSave = {
	publicVariableServer "startSaveGame";
};

shorterHint = {
	params ["_text"];
	hint _text;
	sleep 4;
	hint "";
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

//autodoc code init
activatedAutodoc = "";

activateAutodoc = {
	params ["_autodocRequestingActivation"];
	activatedAutodoc = _autodocRequestingActivation;
	publicVariableServer "activatedAutodoc";
	publicVariableServer "startAutodoc";
};

//ya'll fucks can't seem to press a button, so here I am pressing it for you
//adds an event handler that'll autosave your loadout when you close the ace arsenal
//slotted in the arsenal anti-cheat system in here as well. all it does is give a menacing message to anyone who cheats in extra ammo
if (!isServer) then {
	["ace_arsenal_displayOpened",{
		player setVariable["arsenalCheatCheck",getUnitLoadout player];
	}] call CBA_fnc_addEventHandler;

	["ace_arsenal_displayClosed",{
		if (profileNamespace getVariable "arseAutosavePref") then {
			[] spawn saveHyperboreaLoadout;
		};
		[player] spawn arsenalAntiCheat;
	}] call CBA_fnc_addEventHandler;
};

//and some functions so players can turn arsenal loadout autosaves on or off
toggleLoadoutAutosave = {
	if (profileNamespace getVariable ["arseAutosavePref", true]) then {
		profileNamespace setVariable ["arseAutosavePref", false];
		hintSilent "Loadout Autosave OFF";
	}else{
		profileNamespace setVariable ["arseAutosavePref", true];
		hintSilent "Loadout Autosave ON";
	};
};
//reminder that these set client-side profileNamespace variables and are not easily server accessible
jackShack1 addAction["Toggle Loadout Autosave",toggleLoadoutAutosave,[],1.5,true,true,"","true",10,false,"",""];
jackShack2 addAction["Toggle Loadout Autosave",toggleLoadoutAutosave,[],1.5,true,true,"","true",10,false,"",""];

//since the default getVariable things aren't working, this is needed
if (isNil {profileNamespace getVariable "arseAutosavePref"}) then {
	profileNamespace setVariable ["arseAutosavePref", true];
};

//and some functions so players can turn THE BLUE on or off
if (profileNamespace getVariable "bluePref") then {
	//nothing because we already set it above.
} else {
	call removeBlue;
};

toggleBlue = {
	if (profileNamespace getVariable ["bluePref", true]) then {
		profileNamespace setVariable ["bluePref", false];
		call removeBlue;
		hintSilent "Extra Cold Blue Filter OFF";
	}else{
		profileNamespace setVariable ["bluePref", true];
		call readdBlue;
		hintSilent "Extra Cold Blue Filter ON";
	};
};

jackShack1 addAction["Toggle Blue Filter",toggleBlue,[],1.5,true,true,"","true",10,false,"",""];
jackShack2 addAction["Toggle Blue Filter",toggleBlue,[],1.5,true,true,"","true",10,false,"",""];

//yet again. just making sure something's in the preference
if (isNil {profileNamespace getVariable "bluePref"}) then {
	profileNamespace setVariable ["bluePref", true];
};

//add the action of saving the whole game to the jack shacks and party inventory
jackShack1 addAction["Save Game",campaignStartSave,[],1.5,true,true,"","true",10,false,"",""];
jackShack2 addAction["Save Game",campaignStartSave,[],1.5,true,true,"","true",10,false,"",""];
//turns out the party inventory save gets hit accidentally WAY too many times
//partyInventory addAction["Save Game",campaignStartSave,[],1.5,true,true,"","true",5,false,"",""];

//add AutoDoc action to jack shacks. Not everybody can be a medic.
jackShack1 addAction["Activate AutoDoc",activateAutodoc,[jackShack1],1.5,true,true,"","true",10,false,"",""];
jackShack2 addAction["Activate AutoDoc",activateAutodoc,[jackShack2],1.5,true,true,"","true",10,false,"",""];

//enable loading and dragging on jack shacks
[jackShack1,1] call ace_cargo_fnc_setSize;
[jackShack2,1] call ace_cargo_fnc_setSize;
[jackShack1,true,[-0.5,0.75,0]] call ace_dragging_fnc_setDraggable;
[jackShack2,true,[-0.5,0.75,0]] call ace_dragging_fnc_setDraggable;

//TODO - put the arsenal commands for the jack shack in here.
// or better yet -- make a whole system that can just be plugged into any mission

//let the players draw their salary once per mission
baseMailbox addAction ["Check Mail for Salary",checkSalary,[],1.5,true,true,"","true",10,false,"",""];

//just the dumbest shit
myPPSmak = {
	hintSilent "You were smacked on the PP";
	addCamShake [4, 0.5, 5];
	sleep 3;
	hintSilent "";
};
_smakAction = ["SmackPP","Smack PP","",{
	params ["_target","_smaker","_params"];
	addCamShake [4, 0.5, 5];
	if (alive _target) then {
		[] remoteExec ["myPPSmak",_target,false];
	};
	},{true}] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 0, ["ACE_MainActions"], _smakAction, true] call ace_interact_menu_fnc_addActionToClass;

//and load the story
call loadStory;

//looting script -- to get around the weird "I can't take shit out of the backpack, but I can take the backpack just fine" bug

lootBody = {
	params ["_target", "_player", "_params"];
	_corpse = _target;
	_corpsePos = getPos _corpse;
	_uniformLoot = uniformItems _corpse;
	{
			_corpse removeItemFromUniform _x;
	} forEach _uniformLoot;
	_vestLoot = vestItems _corpse;
	{
			_corpse removeItemFromVest _x;
	} forEach _vestLoot;
	_backpackLoot = backpackItems _corpse;
	{
			_corpse removeItemFromBackpack _x;
	} forEach _backpackLoot;

	_allLoot = [];
	_allLoot append _uniformLoot;
	_allLoot append _vestLoot;
	_allLoot append _backpackLoot;

	_newLootPile = "GroundWeaponHolder" createVehicle _corpsePos;
	{
	_newLootPile addItemCargoGlobal [_x,1];
	} forEach _allLoot;
	//set position again since createVehicle looks for nearby unoccupied space and no. fuck that.
	_newLootPile setPos (_corpsePos VectorAdd [0.65,0,0]);
};

lootAction = ["lootBody", "Loot Body","", lootBody, {!alive _target}] call ace_interact_menu_fnc_createAction;

["Man", "init",
{
	[(_this select 0), 0, ["ACE_MainActions"], lootAction] call ace_interact_menu_fnc_addActionToObject;
}, true, [], true] call CBA_fnc_addClassEventHandler;

//fuel check script -- help players make informed travel decisions

_fuelAction = ["CheckFuel", "Check Fuel", "", {hint format ["Fuel: %1%2", str((fuel _target) * 100), "%"]}, {true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _fuelAction, true] call ace_interact_menu_fnc_addActionToClass;

//CLIENT SHIT ENDS

// ZEN FRAMEWORK INITIALIZATION - which you're not using at the moment, so it's only here due to making earlier assumptions that you would

// SQF functions cannot continue running after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
//sleep 1;

//ZEN FRAMEWORK INIT ENDS

//SERVER SHIT HERE

// SAVE SYSTEM

// this function saves the game
updateCampaignData ={
	//gets the date & time and saves it
	//hyperboreaCampaignDate IS VERY IMPORTANT. THIS VARIABLE DETERMINES IF GAME HAS BEEN STARTED BEFORE.
	_currDate = date;
	profileNamespace setVariable ["hyperboreaCampaignDate",_currDate];
	//gets the position and direction of the two Jack Shacks and save them
	[jackShack1] call saveObjectLocAndDir;
	[jackShack2] call saveObjectLocAndDir;
	//if at least one of the Jack Shacks is under the map or loaded in a vehicle -- push a big 'ol warning
	if ((getPos jackShack1 select 2) < -80 or (getPos jackShack2 select 2) < -80) then {
		[] spawn {
			sleep 2;
			["!!WARNING!!\nJACK SHACK STILL LOADED IN VEHICLE\n(or something's fucky with it)\nUNLOAD THE JACK SHACK AND SAVE AGAIN\n!!WARNING!!"] remoteExec ["hint",0,false];
		};
	};
	//gets the position and direction of the spawn points and saves them
	[jackShackRespawn1] call saveObjectLocAndDir;
	[jackShackRespawn2] call saveObjectLocAndDir;
	//gets the position and direction of the vehicles, if alive, and save them
	if (alive junkTruck1) then {
		[junkTruck1] call saveObjectLocAndDir;
	} else {
		profileNamespace setVariable ["junkTruck1Loc", nil];
		profileNamespace setVariable ["junkTruck1Dir", nil];
	};
	if (alive junkTruck2) then {
		[junkTruck2] call saveObjectLocAndDir;
	}else {
		profileNamespace setVariable ["junkTruck2Loc", nil];
		profileNamespace setVariable ["junkTruck2Dir", nil];
	};
	//get the party inventory's cargo and save it
	profileNamespace setVariable ["partyInventoryItemContents", getItemCargo partyInventory];
	profileNamespace setVariable ["partyInventoryMagazineContents", getMagazineCargo partyInventory];
	profileNamespace setVariable ["partyInventoryBackpackContents", getBackpackCargo partyInventory];
	profileNamespace setVariable ["partyInventoryWeaponContents", weaponsItemsCargo partyInventory];

	_theRestOfTheItems = [];
	_theRestOfTheCount = [];
	_theRestOfTheGuns = [];

	{
		_currObject = _x select 1;
		_currItemCargo = getItemCargo _currObject;
		_theRestOfTheItems = _theRestOfTheItems + (_currItemCargo select 0);
		_theRestOfTheCount = _theRestOfTheCount + (_currItemCargo select 1);
		_currMagCargo = getMagazineCargo _currObject;
		_theRestOfTheItems = _theRestOfTheItems + (_currMagCargo select 0);
		_theRestOfTheCount = _theRestOfTheCount + (_currMagCargo select 1);
		_theRestOfTheGuns append (weaponsItemsCargo _currObject);
	} forEach everyContainer partyInventory;

	_theRestOfIt = [];
	_theRestOfIt pushback _theRestOfTheItems;
	_theRestOfIt pushBack _theRestOfTheCount;

	profileNamespace setVariable ["partyInventoryExtraItemContents", _theRestOfIt];
	profileNamespace setVariable ["partyInventoryExtraWeaponContents", _theRestOfTheGuns];

};

// this code loads the game or sets up a new save
if (isNil {profileNamespace getVariable "hyperboreaCampaignDate"}) then {
	["CAMPAIGN DATA NOT FOUND\nSTARTING NEW GAME"] remoteExec ["hint",0,false];
	// NEW GAME
	//sets default start date and time
	setDate [2283, 3, 11, 15, 0];
	//makes a new save - writes something to all of the profile namespace variables
	call updateCampaignData;
	//sets the base as a discoverable spawn point
	_baseTrigger = createTrigger ["EmptyDetector", baseSpawnTent, true];
	_baseTrigger setTriggerArea [75,75,0,false];
	_baseTrigger setTriggerActivation ["ANYPLAYER","PRESENT",false];
	_baseTrigger setTriggerStatements ["this","call BaseFound;",""];
} else {
	//grabs saved date & time and sets the game's time
	_savedDate = profileNamespace getVariable "hyperboreaCampaignDate";
	setDate _savedDate;
	//Read the tin: load the whole damn game
	call loadTheWholeDamnGame;
};

//autosave the game every half hour
[] spawn {
	while {true} do {
		sleep 1800;
		call updateCampaignData;
		["AUTOSAVE COMPLETE"] remoteExec ["shorterHint",0,false];
	};
};

//manual save server-side code
"startSaveGame" addPublicVariableEventHandler{
	call updateCampaignData;
	["MANUAL SAVE COMPLETE"] remoteExec ["hint",0,false];
};

//autodoc server-side code
"startAutodoc" addPublicVariableEventHandler{
	[activatedAutodoc] call serverRunAutodoc;
};

//attach respawn points to jack shacks
jackShackRespawn1 attachTo [jackShack1];
jackShackRespawn2 attachTo [jackShack2];

//weed lmao
weedCrate02 addItemCargoGlobal ["murshun_cigs_cigpack",2];

//DELETE THIS - KAKOLA TREASURE
//[getPos domCampFire] call spawnBaseTreasure;

//Hide map objects that don't wholly fit into the Fallout/post-apoc theme
//Took a shit-ton of time to optimize this. Server sticks to approx 10-20 fps and takes 2 minutes to complete.
[] spawn mapApocalypsizing;

//SERVER SHIT ENDS HERE
