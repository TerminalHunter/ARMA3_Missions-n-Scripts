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


checkSalary = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_playerUID = getPlayerUID _caller;
	_checkString = _playerUID + "hasDrawnSalary";
	if (isNil {missionNamespace getVariable _checkString}) then{
		["Found my envelope."] remoteExec ["shorterHint",_caller,false];
		missionNamespace setVariable [_checkString,true];
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill20";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
		_caller addItem "AM_bill5";
	} else {
		["No envelope with my name on it in there."] remoteExec ["shorterHint",_caller,false];
	};
};

//ya'll fucks can't seem to press a button, so here I am pressing it for you
//adds an event handler that'll autosave your loadout when you close the ace arsenal
//slotted in the arsenal anti-cheat system in here as well. all it does is give a menacing message to anyone who cheats in extra ammo


//and some functions so players can turn arsenal loadout autosaves on or off

//reminder that these set client-side profileNamespace variables and are not easily server accessible

//since the default getVariable things aren't working, this is needed

//yet again. just making sure something's in the preference

//add the action of saving the whole game to the jack shacks and party inventory
jackShack1 addAction["Save Game",campaignStartSave,[],1.5,true,true,"","true",10,false,"",""];
jackShack2 addAction["Save Game",campaignStartSave,[],1.5,true,true,"","true",10,false,"",""];
//turns out the party inventory save gets hit accidentally WAY too many times
//partyInventory addAction["Save Game",campaignStartSave,[],1.5,true,true,"","true",5,false,"",""];

//add AutoDoc action to jack shacks. Not everybody can be a medic.
jackShack1 addAction["Activate AutoDoc",activateAutodoc,[jackShack1],1.5,true,true,"","true",10,false,"",""];
jackShack2 addAction["Activate AutoDoc",activateAutodoc,[jackShack2],1.5,true,true,"","true",10,false,"",""];



//TODO - put the arsenal commands for the jack shack in here.
// or better yet -- make a whole system that can just be plugged into any mission

//let the players draw their salary once per mission
baseMailbox addAction ["Check Mail for Salary",checkSalary,[],1.5,true,true,"","true",10,false,"",""];


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

//CLIENT SHIT ENDS

// ZEN FRAMEWORK INITIALIZATION - which you're not using at the moment, so it's only here due to making earlier assumptions that you would

// SQF functions cannot continue running after loading a saved game, do not delete this line

// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
//sleep 1;

//ZEN FRAMEWORK INIT ENDS

//SERVER SHIT HERE



//SERVER SHIT ENDS HERE
