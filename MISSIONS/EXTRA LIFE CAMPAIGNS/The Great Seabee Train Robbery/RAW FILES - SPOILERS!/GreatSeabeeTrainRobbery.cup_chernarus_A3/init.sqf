#include "prepareRails.sqf"
#include "canCode.sqf"
#include "autodoc.sqf"
#include "ammoBoxen.sqf"

[{str(_this select 0) == "conductor"},"You don't know how to drive a train"] call ATRAIN_fnc_setTrainDriveCondition;

[{false},"There's no room inside to ride"] call ATRAIN_fnc_setTrainRideCondition;

/*
KNOWN BUGS:
  Train floats above rails. Train occasionally slides a bit off the rails. Safe zone is off the gravel.
  Players climbing on train might get stuck.
*/

/*
FUNCTIONS
*/

grabNewAmmoBoxP = {
  _newBox = "land_fow_German_Ammo_Crate_2" createVehicle (getPos player);
  [_newBox, "PRIMARY", 15, true] call initTerminalAmmoBox;
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxS = {
  _newBox = "land_fow_German_Ammo_Crate_1" createVehicle (getPos player);
  [_newBox, "HANDGUN", 20, true] call initTerminalAmmoBox;
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxL = {
  _newBox = "land_fow_German_Ammo_Crate_3" createVehicle (getPos player);
  [_newBox, "SECONDARY", 5, true] call initTerminalAmmoBox;
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

ACTIONABLE_TRAINCAR = objNull;

prepCar = {
  //get the post-init traincar
  private _trainCar = prize2 getVariable ["ATRAIN_Local_Copy",prize2];
  ACTIONABLE_TRAINCAR = _trainCar;

  //Give it Beer!
  ACTIONABLE_TRAINCAR addAction ["Grab Box of Beer", grabNewBoozeBox,nil,1.5,true,true,"","true",7,false,"",""];

  //Give it Ammo!
  ACTIONABLE_TRAINCAR addAction ["Grab Box of Primary Ammo", grabNewAmmoBoxP,nil,1.5,true,true,"","true",7,false,"",""];
  ACTIONABLE_TRAINCAR addAction ["Grab Box of Sidearm Ammo", grabNewAmmoBoxS,nil,1.5,true,true,"","true",7,false,"",""];
  ACTIONABLE_TRAINCAR addAction ["Grab Box of Launcher Ammo", grabNewAmmoBoxL,nil,1.5,true,true,"","true",7,false,"",""];

  //Give it Autodoc!
  ACTIONABLE_TRAINCAR addAction["Administer Medical Aid",{[(_this select 1)] spawn activateAutodoc},[],1.5,true,true,"","true",7,false,"",""];
};

/* INSTRUCTIONS! */

// FIRST STEP! GET IN THE TRAIN! HOOK UP ALL THE TRAINCARS!

// SECOND STEP! HIDE THE RAILS! -- [] call step2; -- ON THE SERVER!!!
step2 = {
  [] remoteExec ["hideRails", 0, true];
};

// THIRD STEP! PREP THE TRAIN! -- [] call step3; -- ON THE SERVER!!!
step3 = {
  [] remoteExec ["prepCar", 0, true];
};
