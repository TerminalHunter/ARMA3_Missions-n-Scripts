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

//playerArsenal = [];
allArsenals = [];

//summoning init
summoningPlayer = "";
timeBetweenSummons = 30;

//autosave toggle option init
if (isNil {profileNamespace getVariable "arseAutosavePref"}) then {
	profileNamespace setVariable ["arseAutosavePref", true];
};

//Event Handler that auto-saves the loadout when the ace arsenal is closed
if (hasInterface) then {
	["ace_arsenal_displayClosed",{
		player linkItem "TFAR_anprc152";
		if (profileNamespace getVariable "arseAutosavePref") then {
			//[] spawn savePirateLoadout;
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

  //[] call updateArsenal;
};


//FUNCTIONS

makePirateArsenal = {
  params ["_jackShackPassed"];

  [_jackShackPassed, true] call ace_arsenal_fnc_initBox;

	_jackShackPassed addAction ["FULL Jack Shack Arsenal", {[_this select 0, _this select 1] call ace_arsenal_fnc_openBox;},[],1.5,true,true,"","true",10,false,"",""];

  _jackShackPassed addAction["Activate AutoDoc",{[(_this select 0)] spawn activateAutodoc},[],1.5,true,true,"","true",10,false,"",""];

  [_jackShackPassed,1] call ace_cargo_fnc_setSize;
  [_jackShackPassed,true,[-0.5,0.75,0]] call ace_dragging_fnc_setDraggable;

	allArsenals pushBack _jackShackPassed;

	//if (isServer) then {
	//	[] call updateArsenal;
	//};

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
