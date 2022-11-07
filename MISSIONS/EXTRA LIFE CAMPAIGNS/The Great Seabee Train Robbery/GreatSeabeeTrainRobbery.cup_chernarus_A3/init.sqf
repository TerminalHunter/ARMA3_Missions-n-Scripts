#include "arsenal.sqf"
#include "prepareRails.sqf"
#include "canCode.sqf"
#include "autodoc.sqf"
#include "ammoBoxen.sqf"
#include "prepareTrainCar.sqf"
#include "railRepair.sqf"
#include "enemies.sqf"
#include "terminalLootToBox.sqf"

[{str(_this select 0) == "conductor"},"You don't know how to drive a train"] call ATRAIN_fnc_setTrainDriveCondition;

[{false},"There's no room inside to ride"] call ATRAIN_fnc_setTrainRideCondition;

/* INSTRUCTIONS! */

// FIRST STEP! GET IN THE TRAIN! HOOK UP ALL THE TRAINCARS!

// SECOND STEP! HIDE THE RAILS! -- [] call step2; -- ON THE SERVER!!!
step2 = {
  [] remoteExec ["hideRails"];
  ["Step 1 of 2 Completed"] remoteExec ["hint"];
};

// THIRD STEP! PREP THE TRAIN! -- [] call step3; -- ON THE SERVER!!!
step3 = {
  [] remoteExec ["prepCar"];
  ["Step 2 of 2 Completed"] remoteExec ["hint"];
};
// FORTH STEP! START THE MISSION! -- [] call step4; -- ON THE SERVER!!!
step4 = {
  if (isServer) then {
    [getPos dongEntrance] call spawnNKEasy;
    [getPos dongSniper] call spawnNKSingleSniper;
    [getPos dongTown] call spawnNKEasy;
    setTimeMultiplier 1;
  };
};

/* END INSTRUCTIONS */

addMissionEventHandler ["PlayerConnected",
{
  params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
  //[str(_jip)] remoteExec ["hint"];
  if (_jip) then {
    [] spawn {
      sleep 15;
      [] remoteExec ["hideRails"];
      [] remoteExec ["prepCar"];
    };
  };
}];

//FORTIFY!
[west, 120, [
  ["Land_wx_bunker", 5],
  //["fow_p_logbunker02", 3],
  //["fow_p_logbunker01", 3],
  ["Fortress1", 5],
  ["Land_Fort_Bagfence_Bunker", 3],
  ["Land_wx_bunker_wall01", 1],
  ["Land_WW2_Zed_Civil", 1],
  ["Land_WW2_SWU_Sandbag_Wall_Tall", 1],
  ["Land_SandbagBarricade_01_half_F", 1],
  ["Land_SandbagBarricade_01_F", 1],
  ["Land_SandbagBarricade_01_hole_F", 1],
  ["Land_BagFence_Round_F", 1],
  ["Land_BagFence_Long_F", 1],
  ["Land_TinWall_01_m_4m_v1_F", 1],
  ["Land_SlumWall_01_s_4m_F", 1],
  ["Land_Ind_Timbers", 1]
]] call ace_fortify_fnc_registerObjects;

// Booze box in the initial starting spawn
if (isServer) then {
  [initialBeer] call makeBoozeBox;
};

//LIGHT SOURCE AT START

startLight = "#lightpoint" createVehicleLocal (getPos startFire);
startLight setLightIntensity 1000.0;
startLight setLightAmbient [1.0, 0.5, 0.1];
startLight setLightColor [1.0, 0.5, 0.1];
startLight setLightAttenuation [2, 4, 4, 0, 14, 15];
startLight lightAttachObject [startFire, [0,0,1]];

//LIGHT SOURCE TO HELP NIGHTVISION

softLight = "#lightpoint" createVehicleLocal (getPos startFire);
softLight setLightIntensity 20.0;
softLight setLightAmbient [1.0, 1.0, 1.0];
softLight setLightColor [1.0, 1.0, 1.0];
softLight setLightAttenuation [20000, 1, 1, 1];
softLight lightAttachObject [startFire, [0,0,1]];

//SHIT TO STEAL!

makeBeerCrateStealable = {
  params ["_object"];
  if (!isNull _object) then {
    _object addAction ["Steal Crate of Beer!", {deleteVehicle (_this select 0)},[],22,true,true,"","true",10,false,"",""];
    if (isServer) then {
      [_object] call makeBoozeBox;
    };
  };
};

makeRailStealable = {
  params ["_object"];
  if (!isNull _object) then {
    _object addAction ["Steal Replacement Rails!", {deleteVehicle (_this select 0)},[],22,true,true,"","true",10,false,"",""];
  };
};

stealCrates = [
  stealCrate01,
  stealCrate02,
  stealCrate03,
  stealCrate04,
  stealCrate05,
  stealCrate06,
  stealCrate07,
  stealCrate08,
  stealCrate09,
  stealCrate10,
  stealCrate11,
  stealCrate12
];

stealRails = [
  stealRail01,
  stealRail02,
  stealRail03,
  stealRail04,
  stealRail05,
  stealRail06,
  stealRail07,
  stealRail08,
  stealRail09,
  stealRail10,
  stealRail11,
  stealRail12
];

{
  [_x] call makeBeerCrateStealable;
} forEach stealCrates;

{
  [_x] call makeRailStealable;
} forEach stealRails;


secretRadio01 addAction ["SECRET RADIO #1", {
  playSound3D [getMissionPath "audio\chester.ogg", secretRadio01, false, getPosASL secretRadio01, 4, 1, 8];
  //removeAllActions secretRadio01;
},[],1.5,true,true,"","true",10,false,"",""];

secretRadio03 addAction ["SECRET RADIO #3", {
  playSound3D [getMissionPath "audio\SeoulCitySue.ogg", secretRadio03, false, getPosASL secretRadio03, 5, 1, 8];
  //removeAllActions secretRadio03;
},[],1.5,true,true,"","true",10,false,"",""];
