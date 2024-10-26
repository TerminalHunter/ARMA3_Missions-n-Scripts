/*
REQUIRES ArmA3URLFetch
https://steamcommunity.com/sharedfiles/filedetails/?id=1138271370 
*/

#include "lootBoxTable.sqf"
#include "twitchCallsArtillery.sqf"

expiredEvents = [];
twitchEventQueue = [];

readTwitchEvents = {
	while {true} do {
		sleep 3;
		_oldEvents = [];
		_newEvents = [];
		_response = ["127.0.0.1:9001", "GET"] call a3uf_common_fnc_request;	
		
		_arrayResponse = _response splitString "&";
		{
			_x splitString "#";
		} forEach _arrayResponse;

		if (!(_arrayResponse isEqualTo "")) then {
			//see if any values are new
			_oldEvents = expiredEvents arrayIntersect _arrayResponse;
			_newEvents = _arrayResponse - _oldEvents;
			//new values go into a queue
			twitchEventQueue append _newEvents;
			//update expired events
			expiredEvents append _newEvents;
		};
	};
};

runTwitchEvents = {
	while {true} do {
		sleep 5;
		if (count twitchEventQueue > 0) then {
			[twitchEventQueue select 0] spawn redeemReward;
			//hint (twitchEventQueue select 0);
			twitchEventQueue deleteAt 0;
		};
	};
};

redeemReward = {
	params ["_dataIn"];
	_dataArray = _dataIn splitString "#";

	/*
	Data structure to eventually be:
		#[TwitchMessage, cmd.user.name, cmd.parameter, uniqueID]
		#[LootBox, cmd.user.name, roll#, uniqueID]
		#[Flares, cmd.user.name, GridRef, uniqueID]
		#[Smokes, cmd.user.name, Color, uniqueID]
		#[ARTY_WARNING, 0, username, uniqueID]
		#[ARTY_STRIKE, 0, GridRef, uniqueID]
	ALL REWARDS PASS THROUGH HERE!
	*/

	//MESSAGE
	if (_dataArray select 0 == "TwitchMessage") then {
		chat sideChat ((_dataArray select 1) + " has a message: " + (_dataArray select 2));
		[chat, ((_dataArray select 1) + " has a message: " + (_dataArray select 2))] remoteExec ["sideChat", 0, false];
	};
	//LOOTBOX
	if (_dataArray select 0 == "LootBox") then {
		chat sideChat ((_dataArray select 1) + " has sent an airdrop!");
		[chat, ((_dataArray select 1) + " has sent an airdrop!")] remoteExec ["sideChat", 0, false];
		[_dataArray] spawn createLootbox;
	};
	//ARTILLERY_WARNING
	if (_dataArray select 0 == "ARTY_WARNING") then {
		chat sideChat ((_dataArray select 2) + " is Authorizing an Artillery Strike!");
		[chat, ((_dataArray select 2) + " is Authorizing an Artillery Strike!")] remoteExec ["sideChat", 0, false];
	};
	//ARTILLERY_STRIKE
	if (_dataArray select 0 == "ARTY_STRIKE") then {
		chat sideChat ((_dataArray select 2) + " -- Artillery Incoming!");
		[chat, ((_dataArray select 2) + " -- Artillery Incoming!")] remoteExec ["sideChat", 0, false];
		//hint (_dataArray select 2);
		[_dataArray select 2] spawn rawArtyStrike;
	};
	//FLARES
	if (_dataArray select 0 == "TwitchFlare") then {
		chat sideChat ((_dataArray select 1) + " has sent flares!");
		[chat, ((_dataArray select 1) + " has sent flares!")] remoteExec ["sideChat", 0, false];
		[_dataArray] spawn createTwitchFlares;
	};
	//SMOKESCREEN
	if (_dataArray select 0 == "TwitchSmoke") then {
		chat sideChat ((_dataArray select 1) + " has sent a smokescreen!");
		[chat, ((_dataArray select 1) + " has sent a smokescreen!")] remoteExec ["sideChat", 0, false];
		[_dataArray] spawn createTwitchSmoke;
	};
	//REINFORCEMENTS!
	if (_dataArray select 0 == "Reinforcements") then {
		chat sideChat ((_dataArray select 1) + " has sent reinforcements!");
		[chat, ((_dataArray select 1) + " has sent reinforcements!")] remoteExec ["sideChat", 0, false];
		[_dataArray] spawn createTwitchReinforcements;
	};
};

createLootbox = {
	_poorSchmuck = selectRandom allPlayers;
	_newLootBox = "B_CargoNet_01_ammo_F" createVehicle ((getPos _poorSchmuck) vectorAdd [50,50,0]);
	_newLootBox setPosASL ((getPosASL _poorSchmuck) vectorAdd [0,0,100]);
	clearItemCargoGlobal _newLootBox;
	clearWeaponCargoGlobal _newLootBox; 
	clearMagazineCargoGlobal _newLootBox; 
	clearItemCargoGlobal _newLootBox;
	_diceRoll = (floor(random 20)) + 1;
	{
		_newLootBox addItemCargoGlobal [_x, 10];
	} forEach (lootBoxLootTable select _diceRoll select 0);
	if (_diceRoll == 1) then {
		[_newLootBox] spawn makeFullOfLiveGrenades; //box of live grenades when you roll a 1
	};
	if (_diceRoll > 7 && _diceRoll < 11) then {
		[_newLootBox] spawn giveUsefulAmmo; //one person's ammo if you roll 9-12
	};
	if (_diceRoll == 19) then {
		[_newLootBox] spawn giveUsefulAmmoToAll; //ammo for all if you roll 19
	};
	if (_diceRoll == 20) then {
		[_newLootBox] call makeBoozeBox;
	};
	sleep 2;
	chat sideChat "Logistics says they've sent you " + (lootBoxLootTable select _diceRoll select 1) + " because they've rolled a " + str(_diceRoll);
	[chat, "Logistics says they've sent you " + (lootBoxLootTable select _diceRoll select 1) + " because they've rolled a " + str(_diceRoll)] remoteExec ["sideChat", 0, false];
};

makeFullOfLiveGrenades = {
	params["_badBox"];
	waitUntil {getPos _badBox select 2 < 3};
	_dumb1 = "GrenadeHand" createVehicle (getPos _badBox);
	_dumb1 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
	_dumb2 = "GrenadeHand" createVehicle (getPos _badBox);
	_dumb2 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
	_dumb3 = "GrenadeHand" createVehicle (getPos _badBox);
	_dumb3 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
	_dumb4 = "GrenadeHand" createVehicle (getPos _badBox);
	_dumb4 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
	_dumb5 = "GrenadeHand" createVehicle (getPos _badBox);
	_dumb5 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
};

giveUsefulAmmo = {
	params["_goodBox"];
	_randomSchmuck = selectRandom allPlayers;
	_gunTheSchmuckHas = primaryWeapon _randomSchmuck;
	if (_gunTheSchmuckHas == "") then {
		[_goodBox] spawn giveUsefulAmmo;
	} else {
		_ammo1 = selectRandom compatibleMagazines _gunTheSchmuckHas;
		_ammo2 = selectRandom compatibleMagazines _gunTheSchmuckHas;
		_ammo3 = selectRandom compatibleMagazines _gunTheSchmuckHas;
		_ammo4 = selectRandom compatibleMagazines _gunTheSchmuckHas;
		{
			_goodBox addItemCargoGlobal [_x, 10];
		} forEach [_ammo1,_ammo2,_ammo3,_ammo4]
	};
};

giveUsefulAmmoToAll = {
	params["_gooderBox"];
	{
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines primaryWeapon _x, 12];
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines primaryWeapon _x, 12];
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines primaryWeapon _x, 12];
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines handgunWeapon _x, 10];
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines secondaryWeapon _x, 10];
	} forEach allPlayers;
};

createTwitchSmoke = {
	params["_twitchData"];
	[_twitchData select 3, _twitchData select 2] spawn spawnSmokes;
	//wow that's dumb, we never use that extra spot and whatever fix later
};

createTwitchFlares = {
	params["_twitchData"];
	[_twitchData select 2] spawn spawnFlares;
};

createTwitchReinforcements = {
	params["_twitchData"];
	_dude = selectRandom allPlayers;
	_newGroup = [(getPos _dude) vectorAdd [0,100,0], west, ["rhsusf_socom_marsoc_cso","rhsusf_socom_marsoc_cso","rhsusf_socom_marsoc_cso","rhsusf_socom_marsoc_cso"]] call BIS_fnc_spawnGroup;
	{
		_x setUnitLoadout (reinforcements get (selectRandom reinforcementUnlock));
	} forEach units _newGroup;
	sleep 20;
	{
		[_x] join _dude;
	} forEach units _newGroup;

	//_joinWaypoint = _newGroup addWaypoint [_dude, -1];
	//_joinWaypoint setWaypointType "JOIN";
};

startTwitchIntegration = {
	if (isServer) then {
		[] spawn readTwitchEvents;
		[] spawn runTwitchEvents;
	};
};