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
    //(_this select 0) setDir ((getDir (_this select 0)) - 1);
    [(_this select 0),((getDir (_this select 0)) - 1)] remoteExec ["setDir", _this select 0, false];
  },[],10,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 0.5 degree left [←←    ]", {
    //(_this select 0) setDir ((getDir (_this select 0)) - 0.5);
    [(_this select 0),((getDir (_this select 0)) - 0.5)] remoteExec ["setDir", _this select 0, false];
  },[],9,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 0.25 degree left [←    ]", {
    //(_this select 0) setDir ((getDir (_this select 0)) - 0.25);
    [(_this select 0),((getDir (_this select 0)) - 0.25)] remoteExec ["setDir", _this select 0, false];
  },[],8,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 1 degree right [→→→→    ]", {
    //(_this select 0) setDir ((getDir (_this select 0)) + 1);
    [(_this select 0),((getDir (_this select 0)) + 1)] remoteExec ["setDir", _this select 0, false];
  },[],5,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 0.5 degree right [→→    ]", {
    //(_this select 0) setDir ((getDir (_this select 0)) + 0.5);
    [(_this select 0),((getDir (_this select 0)) + 0.5)] remoteExec ["setDir", _this select 0, false];
  },[],6,true,true,"","true",10,false,"",""];

  _thingToNudge addAction ["Nudge 0.25 degree right [→    ]", {
    //(_this select 0) setDir ((getDir (_this select 0)) + 0.25);
    [(_this select 0),((getDir (_this select 0)) + 0.25)] remoteExec ["setDir", _this select 0, false];
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

if (isServer) then {
  _doorDeleterArray = theActualShip_ghost nearObjects 400;
  {
    if (typeOf _x isEqualTo "OPTRE_holotable_sm" or typeOf _x isEqualTo "OPTRE_hallway_door_a" or typeOf _x isEqualTo "OPTRE_Corvette_M910_Turret_u" or typeOf _x isEqualTo "OPTRE_Corvette_archer_system" or typeOf _x isEqualTo "OPTRE_Corvette_M910_Turret") then {
      deleteVehicle _x;
    };
  } forEach _doorDeleterArray;
};

[] spawn {
  //LIGHT'S FUCKING WEIRD
  staticLightPoint = "#lightpoint" createVehicleLocal [0,0,0];
  //staticLightPoint attachTo [theActualShip, [0, 0, 0]];
  staticLightPoint setLightColor [0,0,0];
  staticLightPoint setLightAmbient [1.0, 1.0, 1.0];
  //I can't tell if intensity is just wanked up -- just set it to 1 and then play with it later.
  staticLightPoint setLightIntensity 1; //brightness 1 = intensity 3000 apparently
  //staticLightPoint setLightBrightness 0.5;
  //staticLightPoint setLightAttenuation [20000,0,4.31918e-005,0];
  staticLightPoint setLightAttenuation [20000,0,0,0];
  sleep 10;
  staticLightPoint setLightIntensity 1000;
  //WHY. WHY DOES THIS WORK. FUCK ME.
};

//TASKS! Let's actually guide the players.
[west, "zerothTask", [
  "Successfully warp into the enemy carrier's blind spot.",
  "[0] Warp",
  ""], objNull, "AUTOASSIGNED", 21, true, "run"] call BIS_fnc_taskCreate;

[west, "firstTask", [
  "Fake a sensor signature so the carrier thinks our ship is friendly.",
  "[1] Hack Space Traffic Coordinator",
  ""], [5093.48,5246.26,97.6514], "AUTOASSIGNED", 20, true, "download"] call BIS_fnc_taskCreate;

[west, "secondTask", [
  "Make sure nobody escapes or scrambles something against us.",
  "[2] Sabotage Enemy Y.E.E.T.",
  ""], [5121.8,5244.3,97.6514], "AUTOASSIGNED", 19, true, "target"] call BIS_fnc_taskCreate;

[west, "thirdTask", [
  "Search the Habitation deck - someone's bound to have left a keycard or password around we can use to get further into the ship.",
  "[3] Steal Credentials",
  ""], [5129.18,5333.8,97.6649], "AUTOASSIGNED", 19, true, "interact"] call BIS_fnc_taskCreate;

[west, "forthTask", [
  "Find a path through the hangars under the main flight deck or through habitation.",
  "[4] Navigate to Hangar 3",
  ""], [5027.8,5488.95,54.2477], "AUTOASSIGNED", 18, true, "move3"] call BIS_fnc_taskCreate;

[west, "fifthTask", [
  "I guess you could do the Port Turbolift and Bridge first, but eh.",
  "[5] Navigate to Starboard Turbolift",
  ""], [5032.81,5589.76,50.2799], "AUTOASSIGNED", 17, true, "getin"] call BIS_fnc_taskCreate;

[west, "sixthTask", [
  "You fly the red flag today. Take no prisoners, kill them all.",
  "[6] Storm the Starboard Bridge",
  ""], [5073.1,5467.34,259.184], "AUTOASSIGNED", 16, true, "attack"] call BIS_fnc_taskCreate;

[west, "seventhTask", [
  "Make your way to the second bank of Turbolifts.",
  "[7] Navigate to Port Turbolift",
  ""], [5183.01,5589.52,50.2799], "AUTOASSIGNED", 15, true, "getout"] call BIS_fnc_taskCreate;

[west, "eighthTask", [
  "Just do whatever naturally comes to you.",
  "[8] Storm the Port Bridge",
  ""], [5141.76,5468.41,259.198], "AUTOASSIGNED", 14, true, "attack"] call BIS_fnc_taskCreate;

[west, "ninthTask", [
  "Alright, now we should be able to program the Hyperdrive to warp us to an empty bit of space, far from any Empire reinforcements.",
  "[9] Secure the Hyperdrive Core",
  ""], [5107.65,5613.27,86.7605], "AUTOASSIGNED", 13, true, "repair"] call BIS_fnc_taskCreate;

[west, "tenthTask", [
  "I guess we should poke this a few times and make sure it doesn't kill us.",
  "[10] Secure the Doomsday Device",
  ""], [5107.87,5607.04,78.9937], "AUTOASSIGNED", 12, true, "intel"] call BIS_fnc_taskCreate;

/*
call{call {
    this spawn {
        _this setVariable ["you_spin", true];
        while {_this getVariable ["you_spin", false]} do {
            _this setDir (getDirVisual _this + 0.1);
            sleep 0.01
        }
    }
};}
*/
