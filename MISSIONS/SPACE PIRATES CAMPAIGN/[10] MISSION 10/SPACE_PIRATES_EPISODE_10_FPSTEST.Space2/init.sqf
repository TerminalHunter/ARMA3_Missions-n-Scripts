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
    ["Land_OPTRE_M72_barrierBlk", 3],
    ["Land_PortableLight_single_F", 1]
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
  ""], redAlertConsole, "AUTOASSIGNED", 21, true, "run"] call BIS_fnc_taskCreate;

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

//TASK 0

//see spaceTeamDirector, I guess

//TASK 1

hackMePlz addAction ["Hack", {
  [] remoteExec ["task1Complete", 2];
  [hackMePlz] remoteExec ["removeAllActions", 0, true];
},[],6,true,true,"","true",10,false,"",""];

task1Complete = {
  ["firstTask","SUCCEEDED"] call BIS_fnc_taskSetState;
  if (!("secondTask" call BIS_fnc_taskCompleted)) then {
    "secondTask" call BIS_fnc_taskSetCurrent;
  };
  [[5091.82,5243.54,97.6514]] call specificallySummonJackShack;
  [missionNamespace, [5093.61,5245.82,97.6514], "[Task 1] Carrier Space Control Tower"] call BIS_fnc_addRespawnPosition;
};

//TASK 2

if (isServer) then {
  [] spawn {
    waitUntil {!alive computerStandin};
    _yeetPos = getPosASL enemyYeet;
    _yeetDir = getDir enemyYeet;
    _newYeet = "MEOP_st_furn_MainFrame_dam" createVehicle [0,0,0];
    deleteVehicle enemyYeet;
    _newYeet setPosASL _yeetPos;
    _newYeet setDir _yeetDir;
    ["secondTask","SUCCEEDED"] call BIS_fnc_taskSetState;
    if (!("thirdTask" call BIS_fnc_taskCompleted)) then {
      "thirdTask" call BIS_fnc_taskSetCurrent;
    };
  }
};

//TASK 3

credentials addAction ["Look for passwords", {
  [] remoteExec ["task3Complete", 2];
  [credentials] remoteExec ["removeAllActions", 0, true];
},[],6,true,true,"","true",10,false,"",""];

task3Complete = {
  ["thirdTask","SUCCEEDED"] call BIS_fnc_taskSetState;
  if (!("forthTask" call BIS_fnc_taskCompleted)) then {
    "forthTask" call BIS_fnc_taskSetCurrent;
  };
};

//TASK 4

if (isServer) then {
  _trigger01 = createTrigger ["EmptyDetector", [5027.8,5488.95,54.2477]];
  _trigger01 setTriggerArea [20,20,4,false];
  _trigger01 setTriggerActivation ["WEST", "PRESENT", false];
  _trigger01 setTriggerStatements ["this", "
  ['forthTask','SUCCEEDED'] call BIS_fnc_taskSetState;
  if (!('fifthTask' call BIS_fnc_taskCompleted)) then {'fifthTask' call BIS_fnc_taskSetCurrent;};
  [[5029.99,5486.89,54.2477]] spawn specificallySummonJackShack;
  [missionNamespace, [5024.11,5486.9,54.2477], '[Task 4] Hangar 3'] call BIS_fnc_addRespawnPosition;
  ", ""];
};

//   if (!('fifthTask' call BIS_fnc_taskCompleted)) then {'fifthTask' call BIS_fnc_taskSetCurrent;};

//TASK 5

if (isServer) then {
  _trigger02 = createTrigger ["EmptyDetector", [5032.81,5589.76,50.2799]];
  _trigger02 setTriggerArea [10,10,4,false];
  _trigger02 setTriggerActivation ["WEST", "PRESENT", false];
  _trigger02 setTriggerStatements ["this", "['fifthTask','SUCCEEDED'] call BIS_fnc_taskSetState;if (!('sixthTask' call BIS_fnc_taskCompleted)) then {'sixthTask' call BIS_fnc_taskSetCurrent;};", ""];
};

//TASK 6

if (isServer) then {
  _trigger03 = createTrigger ["EmptyDetector", [5073.17,5466.53,259.184]];
  _trigger03 setTriggerArea [7,7,4,false];
  _trigger03 setTriggerActivation ["WEST", "PRESENT", false];
  _trigger03 setTriggerStatements ["this", "['sixthTask','SUCCEEDED'] call BIS_fnc_taskSetState;if (!('seventhTask' call BIS_fnc_taskCompleted)) then {'seventhTask' call BIS_fnc_taskSetCurrent;};", ""];
};

//TASK 7

if (isServer) then {
  _trigger04 = createTrigger ["EmptyDetector", [5183.01,5589.52,50.2799]];
  _trigger04 setTriggerArea [10,10,4,false];
  _trigger04 setTriggerActivation ["WEST", "PRESENT", false];
  _trigger04 setTriggerStatements ["this", "['seventhTask','SUCCEEDED'] call BIS_fnc_taskSetState;if (!('eighthTask' call BIS_fnc_taskCompleted)) then {'eighthTask' call BIS_fnc_taskSetCurrent;};", ""];
};

//TASK 8

if (isServer) then {
  _trigger05 = createTrigger ["EmptyDetector", [5141.61,5466.53,259.184]];
  _trigger05 setTriggerArea [7,7,4,false];
  _trigger05 setTriggerActivation ["WEST", "PRESENT", false];
  _trigger05 setTriggerStatements ["this", "['eighthTask','SUCCEEDED'] call BIS_fnc_taskSetState;if (!('ninthTask' call BIS_fnc_taskCompleted)) then {'ninthTask' call BIS_fnc_taskSetCurrent;};", ""];
};

//TASK 9

//hyperDrive

hyperDrive addAction ["Reprogram Hyperdrive", {[] call hyperDriveCheck;},[],6,true,true,"","true",4,false,"",""];

  task9Complete = {
    ["ninthTask","SUCCEEDED"] call BIS_fnc_taskSetState;
    if (!("tenthTask" call BIS_fnc_taskCompleted)) then {
      "tenthTask" call BIS_fnc_taskSetCurrent;
    };
  };

  hyperDriveCheck = {
    if ("sixthTask" call BIS_fnc_taskCompleted && "eighthTask" call BIS_fnc_taskCompleted) then {
      [60, [],
        {//Hint "Finished!"
          [] remoteExec ["task9Complete", 2];
          [hyperDrive] remoteExec ["removeAllActions", 0, true];
        }, {hint "Coordinates malformed. Rejecting Slipperyvector. Please try again."}, "Reprogramming Hyperdrive"] call ace_common_fnc_progressBar;
    } else {
      hint "Access Denied: Bridge Lockout";
    };
  };

//TASK 10

//doomsDay

doomsDay addAction ["Configure Strange Device", {
      _longString = "<t color='#22aa22' size='1'>After tooling around with the Hypderdrive coordinates and this system, you realize this ship can jump a LOT farther than a normal ship of this size. This doomsday device is amplifying the power from the powerplant that goes into the Hypderdrive. Could all of that destruction in the galaxy be the cost of a few jumps? It doesn't look like this Hyperdrive works without it.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","'ninthTask' call BIS_fnc_taskCompleted",4,false,"",""];


//ENEMIES

fillBuildingMedieval = {
  params ["_building"];
  _positionArray = _building buildingPos -1;
  if (count _positionArray > 1) then {
    _buildingGroup = [[-1000,-1000,0], EAST, ["O_G_Soldier_F"]] call BIS_fnc_spawnGroup;
    _buildingGroup deleteGroupWhenEmpty true;
    for "_i" from 1 to ((count _positionArray) - 1) do {
        _buildingGroup createUnit ["O_G_Soldier_F", [-1000,-1000,0], [], 0, "NONE"];
    };
    {
        _currSoldier = (units _buildingGroup) select _forEachIndex;
        _currSoldier setPosASL (AGLtoASL _x);
        [_currSoldier] call equipMedievalOPFOR_ranged;
        _currSoldier disableAI "PATH";
    } forEach _positionArray;
    {
      if (!(floor random 3 == 1)) then {
        deleteVehicle _x;
      };
    } forEach units _buildingGroup;

  };
};

sci_Fi_Hall_People = [
  "SC_SE_Warbot_Heavy",
  "SC_SE_Warbot_Heavy",
  "SC_SE_Guard_Marksman",
  "SC_SE_Guard_Medic",
  "SC_SE_Guard_Ranger_H",
  "SC_SE_Guard_Rifleman_H",
  "SC_SE_Guard_Rifleman_M"
];

sci_Fi_Engie_People = [
  "SC_SE_Warbot_Heavy",
  "SC_SE_Guard_Marksman",
  "SC_SE_Guard_Medic",
  "SC_SE_Guard_Ranger_H",
  "SC_SE_Crewman",
  "SC_SE_Crewman",
  "SC_SE_Pilot"
];

sci_Fi_Civvie_People = [
  "SC_SE_Warbot_Heavy",
  "SC_SE_Crewman",
  "SC_SE_Guard_Officer",
  "SC_SE_Guard_Rifleman_H"
];

fillBuildingRobots = {
  params ["_building"];
  _positionArray = _building buildingPos -1;
  if (count _positionArray > 1) then {
    _buildingGroup = [[-1000,-1000,0], EAST, [selectRandom sci_Fi_Hall_People]] call BIS_fnc_spawnGroup;
    _buildingGroup deleteGroupWhenEmpty true;
    for "_i" from 1 to ((count _positionArray) - 1) do {
        _buildingGroup createUnit [selectRandom sci_Fi_Hall_People, [-1000,-1000,0], [], 0, "NONE"];
    };
    {
        _currSoldier = (units _buildingGroup) select _forEachIndex;
        _currSoldier setPosASL (AGLtoASL _x);
        //[_currSoldier] call equipMedievalOPFOR_ranged;
        _currSoldier disableAI "PATH";
    } forEach _positionArray;
  };
};

fillBuildingEngie = {
  params ["_building"];
  _positionArray = _building buildingPos -1;
  if (count _positionArray > 1) then {
    _buildingGroup = [[-1000,-1000,0], EAST, [selectRandom sci_Fi_Engie_People]] call BIS_fnc_spawnGroup;
    _buildingGroup deleteGroupWhenEmpty true;
    for "_i" from 1 to ((count _positionArray) - 1) do {
        _buildingGroup createUnit [selectRandom sci_Fi_Engie_People, [-1000,-1000,0], [], 0, "NONE"];
    };
    {
        _currSoldier = (units _buildingGroup) select _forEachIndex;
        _currSoldier setPosASL (AGLtoASL _x);
        //[_currSoldier] call equipMedievalOPFOR_ranged;
        _currSoldier disableAI "PATH";
    } forEach _positionArray;
  };
};

fillBuildingCivvie = {
  params ["_building"];
  _positionArray = _building buildingPos -1;
  if (count _positionArray > 1) then {
    _buildingGroup = [[-1000,-1000,0], EAST, [selectRandom sci_Fi_Civvie_People]] call BIS_fnc_spawnGroup;
    _buildingGroup deleteGroupWhenEmpty true;
    for "_i" from 1 to ((count _positionArray) - 1) do {
        _buildingGroup createUnit [selectRandom sci_Fi_Civvie_People, [-1000,-1000,0], [], 0, "NONE"];
    };
    {
        _currSoldier = (units _buildingGroup) select _forEachIndex;
        _currSoldier setPosASL (AGLtoASL _x);
        //[_currSoldier] call equipMedievalOPFOR_ranged;
        _currSoldier disableAI "PATH";
    } forEach _positionArray;
  };
};


/*
spotsToPutEnemies = [];

{
  //[_x] call fillBuildingRobots;
  //params ["_building"];
  _positionArray = _x buildingPos -1;
  if (count _positionArray > 1) then {
    spotsToPutEnemies append _positionArray; //pushback?
  };
} forEach (nearestObjects [hackMePlz, ['BUILDING'], 2000]);

randomizedSpotsToPutEnemies = [+spotsToPutEnemies] call CBA_fnc_shuffle;

for "_i" from 1 to 200 do {"Land_Axe_F" createVehicle (randomizedSpotsToPutEnemies select _i)};

not sure why I put this together, but in theory could just fill the ship... and all the inaccessible areas

*/

//Land_PierWooden_01_platform_F

//OKAY BUT ACTUALLY ENEMIES NOW!

//HABITATION

if (isServer) then {
  _triggerHabitation = createTrigger ["EmptyDetector", AGLToASL [5107.54,5237.83,81.341]];
  _triggerHabitation setTriggerArea [15,5,5,true];
  _triggerHabitation setTriggerActivation ["WEST", "PRESENT", false];
  _triggerHabitation setTriggerStatements ["this", "[] call habitationSpawnEnemies;", ""];
};

habitationSpawnEnemies = {
  {
    [_x] call fillBuildingRobots;
  } forEach (nearestObjects [hackMePlz, ['Land_PierWooden_01_platform_F'], 500]);
  //also need to put bois into the turrets
  //this is NOT what you should do, but fuck for now
};

//HANGAR 2

if (isServer) then {
  triggerHangar2_fromHangar1 = createTrigger ["EmptyDetector", AGLToASL [5107.87,5231.63,72.658]];
  triggerHangar2_fromHangar1 setTriggerArea [70,5,5,true];
  triggerHangar2_fromHangar1 setTriggerActivation ["WEST", "PRESENT", false];
  triggerHangar2_fromHangar1 setTriggerStatements ["this", "[] call hangar2SpawnEnemies;", ""];

  triggerHangar2_fromStarboard = createTrigger ["EmptyDetector", AGLToASL [5047.76,5310.47,96.335]];
  triggerHangar2_fromStarboard setTriggerArea [5,53,5,true];
  triggerHangar2_fromStarboard setTriggerActivation ["WEST", "PRESENT", false];
  triggerHangar2_fromStarboard setTriggerStatements ["this", "[] call hangar2SpawnEnemies;", ""];

  triggerHangar2_fromPort = createTrigger ["EmptyDetector", AGLToASL [5169.02,5310.22,96.335]];
  triggerHangar2_fromPort setTriggerArea [5,53,5,true];
  triggerHangar2_fromPort setTriggerActivation ["WEST", "PRESENT", false];
  triggerHangar2_fromPort setTriggerStatements ["this", "[] call hangar2SpawnEnemies;", ""];
};

hangar2SpawnEnemies = {
  triggerHangar2_fromHangar1 enableSimulation false;
  triggerHangar2_fromStarboard enableSimulation false;
  triggerHangar2_fromPort enableSimulation false;
  //["FUCK HANGAR 2 IS GO GO GO"] remoteExec ["hint", 0, false];
  {
    [_x] call fillBuildingEngie;
  } forEach (nearestObjects [hackMePlz, ['Land_Pier_small_F'], 500]);
};

//HYPERDRIVE AREA

if (isServer) then {
  triggerHyperdrive = createTrigger ["EmptyDetector", AGLToASL [5101.28,5484.25,56.519]];
  triggerHyperdrive setTriggerArea [100,10,25,true];
  triggerHyperdrive setTriggerActivation ["WEST", "PRESENT", false];
  triggerHyperdrive setTriggerStatements ["this", "[] call hyperdriveSpawnEnemies;", ""];
};

hyperdriveSpawnEnemies = {
  {
    [_x] call fillBuildingEngie;
  } forEach (nearestObjects [doomsDay, ['Land_PierWooden_01_platform_F'], 200]);
  //,'Land_PierWooden_01_16m_F'
  {
    [_x] call fillBuildingEngie;
  } forEach (nearestObjects [doomsDay, ['Land_Pier_small_F'], 200]);
};

//STARBOARD BRIDGE

if (isServer) then {
  triggerStarboard = createTrigger ["EmptyDetector", AGLToASL [5032.57,5585.04,50.28]];
  triggerStarboard setTriggerArea [10,10,10,true];
  triggerStarboard setTriggerActivation ["WEST", "PRESENT", false];
  triggerStarboard setTriggerStatements ["this", "[] call starboardSpawnEnemies;", ""];
};

starboardSpawnEnemies = {
  //starboardConsole
  {
    [_x] call fillBuildingCivvie;
  } forEach (nearestObjects [starboardConsole, ['Land_PierWooden_01_platform_F'], 50]);

  {
    [_x] call fillBuildingCivvie;
  } forEach (nearestObjects [starboardConsole, ['Land_PierWooden_02_16m_F'], 50]);
};

//PORT BRIDGE

if (isServer) then {
  triggerPort = createTrigger ["EmptyDetector", AGLToASL [5182.8,5585.04,50.2799]];
  triggerPort setTriggerArea [10,10,10,true];
  triggerPort setTriggerActivation ["WEST", "PRESENT", false];
  triggerPort setTriggerStatements ["this", "[] call portSpawnEnemies;", ""];
};

portSpawnEnemies = {
  //portConsole
  {
    [_x] call fillBuildingCivvie;
  } forEach (nearestObjects [portConsole, ['Land_PierWooden_01_platform_F'], 50]);

  {
    [_x] call fillBuildingCivvie;
  } forEach (nearestObjects [portConsole, ['Land_PierWooden_02_16m_F'], 50]);
};
//Land_PierWooden_02_16m_F

//MINES!

//minefield in the VIP section of the habitation deck

minesVIP = [
  [5101.23,5379.06,97.7052],
  [5096.64,5381.02,97.7052],
  [5095.34,5377.61,97.7052],
  [5093.82,5379.23,97.7052],
  [5091.38,5381.06,97.7052],
  [5089.69,5378.22,97.7052],
  [5088.43,5379.27,97.7052],
  [5085.21,5380.81,97.7052],
  [5083.66,5377.43,97.7052],
  [5078.44,5379.22,97.7052],
  [5074.07,5379.2,97.7052],
  [5072.57,5380.71,97.7052],
  [5067.91,5378.16,97.7052],
  [5062.63,5380.85,97.7052],
  [5059.73,5379.11,97.7052],
  //other hallway
  [5113.98,5377.23,97.7052],
  [5116.86,5380.25,97.7052],
  [5121.75,5379.16,97.7052],
  [5126.36,5380.9,97.7052],
  [5127.28,5377.15,97.7052],
  [5129.94,5377.43,97.7052],
  [5130.97,5378.92,97.7052],
  [5133.31,5380.99,97.7052],
  [5135.43,5379.38,97.7052],
  [5138.66,5377.38,97.7052],
  [5141.98,5379.05,97.7052],
  [5144.64,5377.65,97.7052],
  [5146.89,5381.33,97.7052],
  [5149.55,5379.06,97.7052],
  [5153.67,5379.12,97.7052],
  [5158.96,5380.25,97.7052]
];

minesHyper = [
  [5128.75,5535.09,87.836],
  [5128.61,5524.5,87.836],
  [5140.47,5521.17,87.836],
  [5128.71,5521.39,87.836],
  [5107.99,5520.83,87.836],
  [5088.04,5521.04,87.836],
  [5087.19,5531.92,87.836],
  [5074.09,5553.49,84.842],
  [5062.63,5501.71,87.7679],
  [5152.88,5503.16,87.8363],
  [5166.23,5548.25,86.8392],
  [5101.07,5553.56,84.842]
];

minesBridges = [
  [5073.84,5524.52,255.402],
  [5071.39,5523.53,255.402],
  [5076.6,5522.74,255.402],
  [5078.85,5520.95,255.402],
  [5081.2,5523.04,255.402],
  [5066.58,5524.11,255.402],
  [5063.99,5522.03,255.402],
  [5061.5,5520.72,255.402],
  [5140.77,5524.44,255.382],
  [5143.81,5524.46,255.382],
  [5146.64,5522.86,255.382],
  [5143.44,5521.08,255.382],
  [5139.21,5520.4,255.382],
  [5142.43,5507.17,259.374]
];

if (isServer) then{
  {
    createMine ["APERSBoundingMine", _x, [], 0];
  } forEach minesVIP;

  {
    createMine ["APERSBoundingMine", _x, [], 0];
  } forEach minesHyper;

  {
    createMine ["APERSBoundingMine", _x, [], 0];
  } forEach minesBridges;
};
