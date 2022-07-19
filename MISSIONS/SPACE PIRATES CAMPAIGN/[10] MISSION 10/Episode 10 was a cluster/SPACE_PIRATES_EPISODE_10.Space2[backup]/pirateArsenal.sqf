//IMPORTANT VARIABLES

/*

arseAutosavePref 								- bool 		- CLIENT-SIDE whether or not closing out of the ace arsenal will autosave the current loadout as a respawn loadout

PIRATEVAR_pirateArsenalUnlocked - array 	- SERVER-SIDE PROFILENAMESPACE everything available in the arsenal
PIRATEVAR_scanInProgress 				- bool 		- SERVER-SIDE ?ROFILENAMESPAC? is a scan currently happening
playerArsenal										- array		- SERVER-SIDE cache of PIRATEVAR_pirateArsenalUnlocked that arsenals will populate off of (is this unecessary?)

allArsenals											- array		- GLOBAL contains all active arsenals

*/

//INITS

#include "jackAnimations.sqf"
#include "saveLoadout.sqf"

playerArsenal = [];
allArsenals = [];

//summoning init
summoningPlayer = "";
timeBetweenSummons = 1800;

//autosave toggle option init
if (isNil {profileNamespace getVariable "arseAutosavePref"}) then {
	profileNamespace setVariable ["arseAutosavePref", true];
};

//Event Handler that auto-saves the loadout when the ace arsenal is closed
if (!isServer) then {
	["ace_arsenal_displayClosed",{
		if (profileNamespace getVariable "arseAutosavePref") then {
			[] spawn savePirateLoadout;
			player linkItem "TFAR_anprc152";
		};
	}] call CBA_fnc_addEventHandler;
};

//server-side init and initial arsenal update
updateArsenal = {
	{
		[_x,(profileNamespace getVariable "PIRATEVAR_pirateArsenalUnlocked"), true] call ace_arsenal_fnc_addVirtualItems;
	} forEach allArsenals;
};

//more summoning init

if (isServer) then {
  profileNamespace setVariable ["PIRATEVAR_scanInProgress", false];
	missionNamespace setVariable ["PIRATEVAR_lastSummonTime", -1*timeBetweenSummons];

  if (isNil {profileNamespace getVariable "PIRATEVAR_pirateArsenalUnlocked"}) then {
    _bareBonesGear = ["ItemMap", "ItemCompass"];
    profileNamespace setVariable ["PIRATEVAR_pirateArsenalUnlocked", _bareBonesGear];
  };

  [] call updateArsenal;
};


//FUNCTIONS

makePirateArsenal = {
  params ["_jackShack"];

  [_jackShack, playerArsenal] call ace_arsenal_fnc_initBox;

	_jackShack addAction ["Space Jack Shack Arsenal", {[(_this select 0), player] call ace_arsenal_fnc_openBox;},[],1.5,true,true,"","true",10,false,"",""];

	_jackShack addAction ["Scan for New Items", {
		[player] remoteExec ["startArsenalScan", 2];
	},[],1.5,true,true,"","true",10,false,"",""];

  _jackShack addAction["Save Current Loadout as Respawn Loadout",savePirateLoadout,[],1.5,true,true,"","true",10,false,"",""];

  _jackShack addAction["Toggle Loadout Autosave",toggleLoadoutAutosave,[],1.5,true,true,"","true",10,false,"",""];

  _jackShack addAction["Activate AutoDoc",{[(_this select 0)] spawn activateAutodoc},[],1.5,true,true,"","true",10,false,"",""];

  [_jackShack,1] call ace_cargo_fnc_setSize;
  [_jackShack,true,[-0.5,0.75,0]] call ace_dragging_fnc_setDraggable;

	allArsenals pushBack _jackShack;
	if (isServer) then {
		[] call updateArsenal;
	};
};

toggleLoadoutAutosave = {
	if (profileNamespace getVariable ["arseAutosavePref", true]) then {
		profileNamespace setVariable ["arseAutosavePref", false];
		hintSilent "Loadout Autosave OFF";
	}else{
		profileNamespace setVariable ["arseAutosavePref", true];
		hintSilent "Loadout Autosave ON";
	};
};

startArsenalScan = {
	params ["_scannedPlayer"];
	if (profileNamespace getVariable "PIRATEVAR_scanInProgress") then {
		["SCAN IN PROGRESS - PLEASE HOLD"] remoteExec ["shorterHint", _scannedPlayer, false];
	} else {
		[_scannedPlayer] call arsenalScan;
		["SCAN COMPLETE"] remoteExec ["shorterHint", _scannedPlayer, false];
	};
};

arsenalScan = {
	params ["_scannedPlayer"];
	profileNamespace setVariable ["PIRATEVAR_scanInProgress", true];
	_scannedLoadout = getUnitLoadout _scannedPlayer;
	_tornDownLoadout = [_scannedLoadout] call loadoutTeardown;
	_alreadyUnlocked = profileNamespace getVariable "PIRATEVAR_pirateArsenalUnlocked";
	_itemsOnBoth = _alreadyUnlocked arrayIntersect _tornDownLoadout;
	_itemsToUnlock = _tornDownLoadout - _itemsOnBoth;
	_alreadyUnlocked append _itemsToUnlock;
	profileNamespace setVariable ["PIRATEVAR_pirateArsenalUnlocked", _alreadyUnlocked];

	[_itemsToUnlock] spawn {
		params ["_toAnnounce"];
		[] call updateArsenal;
		{
			_actualName = getText (configFile >> "CfgWeapons" >> _x >> "DisplayName");
			if (_actualName == "") then {
					_hintString = "New JackShack Construction Template: " + _x;
					[_hintString] remoteExec ["shorterHint", 0, false];
			} else {
				_hintString = "New JackShack Construction Template: " + _actualName;
				[_hintString] remoteExec ["shorterHint", 0, false];
			};
			sleep 5;
		} forEach _toAnnounce;
		profileNamespace setVariable ["PIRATEVAR_scanInProgress", false];
	};
};

loadoutTeardown = {
	params ["_loadout"];
	_loadoutArray = [];
	_loadoutArray append ([_loadout select 0] call weaponTeardown);
	_loadoutArray append ([_loadout select 1] call weaponTeardown);
	_loadoutArray append ([_loadout select 2] call weaponTeardown);
	_loadoutArray append ([_loadout select 3] call containerTeardown);
	_loadoutArray append ([_loadout select 4] call containerTeardown);
	_loadoutArray append ([_loadout select 5] call containerTeardown);
	_loadoutArray pushBack (_loadout select 6);
	_loadoutArray pushBack (_loadout select 7);
	_loadoutArray append ([_loadout select 8] call weaponTeardown);
	_loadoutArray append (_loadout select 9);
	_loadoutArray = _loadoutArray arrayIntersect _loadoutArray;
	_loadoutArray = _loadoutArray - [""];
	_loadoutArray
};

weaponTeardown = {
	params ["_inputWeapon"];
	_weaponArray = [];
	if (count _inputWeapon == 0) then {
		//do nothing
	} else {
		_weaponArray pushBack (_inputWeapon select 0);
		_weaponArray pushBack (_inputWeapon select 1);
		_weaponArray pushBack (_inputWeapon select 2);
		_weaponArray pushBack (_inputWeapon select 3);
		_weaponArray pushBack ((_inputWeapon select 4) select 0);
		_weaponArray pushBack ((_inputWeapon select 5) select 0);
		_weaponArray pushBack (_inputWeapon select 6);
	};
	_weaponArray
};

containerTeardown = {
	params ["_inputContainer"];
	_containerArray = [];
	if (count _inputContainer == 0) then {
		//do nothing
	} else {
		_containerArray pushBack (_inputContainer select 0);
		_inventory = _inputContainer select 1;
		{
			//_containerArray pushBack (_x select 0);
			_inventoryItem = _x select 0; //strip # of items
			if (typeName _inventoryItem == "STRING") then {
				_containerArray pushBack _inventoryItem;
			} else {
				//everything in here should be an array, right? and only weapon arrays? please let there be only weapon arrays...
				_tornDownWeapon = [_inventoryItem] call weaponTeardown;
				_containerArray append _tornDownWeapon;
			};
		}forEach _inventory;
	};
	_containerArray
};

//CODE FOR SUMMONING



//server init
if (isServer) then {
  "startJackShackSummon" addPublicVariableEventHandler {
		//ADD FRISKY KITTY DETECTION?
		if (((missionNamespace getVariable "PIRATEVAR_lastSummonTime") + timeBetweenSummons) < time) then {
  		[summoningPlayer] spawn actuallySummonJackShack;
			missionNamespace setVariable ["PIRATEVAR_lastSummonTime",time];
		} else {
			_timeLeft = floor((timeBetweenSummons - (time - (missionNamespace getVariable "PIRATEVAR_lastSummonTime"))) / 60);
			[format ["TRANSLOCATOR RECHARGING\n%1 MINUTES REMAIN",_timeLeft]] remoteExec ["shorterHint",summoningPlayer,false];
		};
  };
};

callJackShackStatement = {
	summoningPlayer = _target;
	publicVariableServer "summoningPlayer";
	publicVariableServer "startJackShackSummon";
};

actuallySummonJackShack = {
	params ["_summoner"];
	_summonLoc = getPosASL _summoner;
	_helperCircle = "VR_Area_01_circle_4_yellow_F" createVehicle (_summonLoc);
	_helperCircle setPos ((getPos _helperCircle) vectorAdd [0,0,0.44]);
	[_helperCircle] remoteExec ["speenAnimation",0,false];
	playSound3D [getMissionPath "sfx\BootlegTardis.ogg", _helperCircle];
	sleep 22.25;
	_summonedJackShack = "Land_FieldToilet_F" createVehicle (getPos _helperCircle);
	deleteVehicle _helperCircle;
	[_summonedJackShack] remoteExec ["makePirateArsenal",0,true];
};

callJackShackCondition = {
	if ((getPosATL _target) select 2 < 1) then {
		true
	} else {
		false
	};
};

callJackShackAction = ["callJackShack","Translocate Jack Shack","",callJackShackStatement,callJackShackCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions"], callJackShackAction] call ace_interact_menu_fnc_addActionToClass;
