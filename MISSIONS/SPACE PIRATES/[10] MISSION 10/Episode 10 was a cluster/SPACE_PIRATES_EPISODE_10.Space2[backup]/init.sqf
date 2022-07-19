#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "story.sqf"
#include "spacePirateShip.sqf"
//#include "carbonBetatronTreasureScanner.sqf"
#include "spaceTeamDirector.sqf"
#include "spaceTeamCustomActions.sqf"
enableSaving [false, false];

[jackShack] call makePirateArsenal;
[jackShack2] call makePirateArsenal;

//ENABLE FORTIFY TOOL!
if (isServer) then {
  [west, 10, [
    ["Land_VR_CoverObject_01_kneel_F", 1],
    ["Land_VR_CoverObject_01_stand_F", 1],
    ["TIOW_Dragons_teeth", 1],
    ["Land_MEOP_build_Turian_Barrier", 1],
    ["3as_shield_1_prop", 1],
    ["Land_ToiletBox_F", 2],
    ["Land_OPTRE_M72_barrierBlk", 3]
  ]] call ace_fortify_fnc_registerObjects;
};

//DECK CANNONS NEED NUDGING
makeNudgeable = {
  params ["_thingToNudge"];

  _thingToNudge addAction ["Nudge 1 degree left [←←←←    ]", {
    (_this select 0) setDir ((getDir (_this select 0)) - 1);
  },[],10,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 0.5 degree left [←←    ]", {
    (_this select 0) setDir ((getDir (_this select 0)) - 0.5);
  },[],9,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 0.25 degree left [←    ]", {
    (_this select 0) setDir ((getDir (_this select 0)) - 0.25);
  },[],8,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 1 degree right [→→→→    ]", {
    (_this select 0) setDir ((getDir (_this select 0)) + 1);
  },[],5,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 0.5 degree right [→→    ]", {
    (_this select 0) setDir ((getDir (_this select 0)) + 0.5);
  },[],6,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 0.25 degree right [→    ]", {
    (_this select 0) setDir ((getDir (_this select 0)) + 0.25);
  },[],7,true,true,"","true",10,false,"",""];

};

[playerCannon1] call makeNudgeable;
[playerCannon2] call makeNudgeable;
[playerCannon3] call makeNudgeable;
[playerCannon4] call makeNudgeable;
[playerCannon5] call makeNudgeable;
[playerCannon6] call makeNudgeable;

/*
BRIDGE - PREWARP [5107.19,-5283.26,167.294]
MAIN HANGAR - PREWARP [5097.11,-5308.57,144.76]
*/

bridgePos = [5107.19,-5283.26,167.294];
hangarPos = [5097.11,-5308.57,144.76];

if (isServer) then {
  [missionNamespace, [100,200,0], "Bridge"] call BIS_fnc_addRespawnPosition;
  _trigger02 = createTrigger ["EmptyDetector", [100,200,0]];
  _trigger02 setTriggerArea [10,10,0,false];
  _trigger02 setTriggerActivation ["WEST", "PRESENT", true];
  _trigger02 setTriggerStatements ["this","
    {_x setPosASL bridgePos;} forEach thisList;
  ",""];

  [missionNamespace, [100,100,0], "Main Hangar"] call BIS_fnc_addRespawnPosition;
  _trigger02 = createTrigger ["EmptyDetector", [100,100,0]];
  _trigger02 setTriggerArea [10,10,0,false];
  _trigger02 setTriggerActivation ["WEST", "PRESENT", true];
  _trigger02 setTriggerStatements ["this","
    {_x setPosASL hangarPos;} forEach thisList;
  ",""];
};
