//PROFILE NAME SPACE "TESTING_MAXIMUMTHEMADNESS_ARSENALDATA" -- profileNamespace getVariable "TESTING_MAXIMUMTHEMADNESS_ARSENALDATA"

playerArsenal = profileNamespace getVariable ["TESTING_MAXIMUMTHEMADNESS_ARSENALDATA",[""]];
allArsenals = [exfilJackShack];
toAnnounce = [];

//autosave toggle option init
if (isNil {profileNamespace getVariable "arseAutosavePref"}) then {
	profileNamespace setVariable ["arseAutosavePref", true];
};

//Event Handler that auto-saves player loadout when the ace arsenal is closed
["ace_arsenal_displayClosed",{
	if (profileNamespace getVariable "arseAutosavePref") then {
		//[] spawn savePirateLoadout;
		player linkItem "TFAR_anprc152";
	};
}] call CBA_fnc_addEventHandler;

//server-side init and initial arsenal update
updateArsenal = {
	profileNamespace setVariable ["TESTING_MAXIMUMTHEMADNESS_ARSENALDATA", playerArsenal];
	{
		[_x, playerArsenal, true] call ace_arsenal_fnc_addVirtualItems;
	} forEach allArsenals;
};

//FUNCTIONS

makePirateArsenal = {
  params ["_jackShack"];

  [_jackShack, playerArsenal] call ace_arsenal_fnc_initBox;

	_jackShack addAction ["Play Barbie doll", {[(_this select 0), player] call ace_arsenal_fnc_openBox;},[],1.5,true,true,"","true",10,false,"",""];

	_jackShack addAction ["Add new accessories", {
		[player] remoteExec ["startArsenalScan", 2];
	},[],1.5,true,true,"","true",10,false,"",""];

  //_jackShack addAction["Grab Saved Loadout",[player] remoteExec ["loadPlayerInventory",2],[],1.5,true,true,"","true",10,false,"",""];

};

checkRaiderStorage = {
	params ["_boxenStorage"];
	removeAllActions _boxenStorage;
	if (isNil{profileNamespace getVariable "TESTING_MAXIMUMTHEMADNESS_STOREDLOADOUT"}) then {
		_boxenStorage addAction ["Store Loadout", {[] call storeRaiderLoadout;},[],1.5,true,true,"","true",10,false,"",""];
	} else {
		_boxenStorage addAction ["Take Stored Loadout [and box up current loadout]", {[] call takeRaiderLoadout;},[],1.5,true,true,"","true",10,false,"",""];
	};
	_boxenStorage addAction ["Grab Doohickey", {[] call grabNewDoohickey},[],1.5,true,true,"","true",10,false,"",""];
	_boxenStorage addAction ["Grab Flares", {[] call grabFlares},[],1.5,true,true,"","true",10,false,"",""];
};

[exfilLoadoutBoxen] call checkRaiderStorage;

extractRaiderCosmetics = {
	params["_loadout"];
	private _extractedUniform = (_loadout select 3) select 0;
	private _extractedVest = (_loadout select 4) select 0;
	private _extractedBackpack = (_loadout select 5) select 0;
	private _extractedHelm = _loadout select 6;
	private _extractedGoggle = _loadout select 7;
	// head to toe: [helm, goggles, uniform, vest, backpack]
	_returnArray = [_extractedHelm, _extractedGoggle, _extractedUniform, _extractedVest, _extractedBackpack];
	_returnArray
};

storeRaiderLoadout = {
	profileNamespace setVariable ["TESTING_MAXIMUMTHEMADNESS_STOREDLOADOUT", (getUnitLoadout player)];
	private _tempLoadout = getUnitLoadout player;
	private _extractedLoadout = [_tempLoadout] call extractRaiderCosmetics;
	profileNamespace setVariable ["TESTING_MAXIMUMTHEMADNESS_RESPAWNLOADOUT", _extractedLoadout];
	[] call stripEm;
	[exfilLoadoutBoxen] call checkRaiderStorage;
};

takeRaiderLoadout = {
	[player, player, []] call lootBody;
	player setUnitLoadout (profileNamespace getVariable "TESTING_MAXIMUMTHEMADNESS_STOREDLOADOUT");
	profileNamespace setVariable ["TESTING_MAXIMUMTHEMADNESS_STOREDLOADOUT", nil];
	[exfilLoadoutBoxen] call checkRaiderStorage;
};

grabNewDoohickey = {
	private _newBoxen = "Land_MetalCase_01_small_F" createVehicle (getPos player);
	_newBoxen addItemCargoGlobal ["hgun_esd_01_F", 1];
	_newBoxen addItemCargoGlobal ["acc_esd_01_flashlight", 1];
	_newBoxen addItemCargoGlobal ["muzzle_antenna_02_f", 1];
	_newBoxen addItemCargoGlobal ["muzzle_antenna_03_f", 1];
	_newBoxen addItemCargoGlobal ["muzzle_antenna_01_f", 1];
};

grabFlares = {
	private _newBoxen = "Land_MetalCase_01_small_F" createVehicle (getPos player);
	_newBoxen addItemCargoGlobal ["JCA_HandFlare_Red", 10];
	_newBoxen addItemCargoGlobal ["rhs_weap_rsp30_red", 10];
	_newBoxen addItemCargoGlobal ["rhs_weap_M320", 2];
	_newBoxen addItemCargoGlobal ["ACE_40mm_Flare_red", 20];
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

attemptPushback = {
	params ["_thingy"];
	private _returnNumber = playerArsenal pushBackUnique _thingy;
	if (_returnNumber == -1) then {
		//already in the arsenal, do nothing.
	} else {
		toAnnounce pushBackUnique _thingy;
	};
};

startArsenalScan = {
	params ["_scannedPlayer"];
	[uniform _scannedPlayer] call attemptPushback;
	[vest _scannedPlayer] call attemptPushback;
	[backpack _scannedPlayer] call attemptPushback;
	[headgear _scannedPlayer] call attemptPushback;
	[goggles _scannedPlayer] call attemptPushback;
	["SCAN COMPLETE"] remoteExec ["hint", _scannedPlayer, false];
	[] call updateArsenal;
};

if(isServer)then{
	[] spawn {
		while{true}do{
			sleep 10;
			if (count toAnnounce > 0) then {
				private _popped = toAnnounce deleteAt 0;
				private _actualName = getText (configFile >> "CfgWeapons" >> _popped >> "DisplayName");
				if (!(_actualName =="")) then {
					[_actualName + " has been added to the Arsenal."] remoteExec ["hint"];
				};
			};
		};
	};
};