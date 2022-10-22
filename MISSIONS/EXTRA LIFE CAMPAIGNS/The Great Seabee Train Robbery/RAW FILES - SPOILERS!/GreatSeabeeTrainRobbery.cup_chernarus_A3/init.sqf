#include "prepareRails.sqf"
#include "canCode.sqf"

[{str(_this select 0) == "conductor"},"You don't know how to drive a train"] call ATRAIN_fnc_setTrainDriveCondition;

[{false},"There's no room inside to ride"] call ATRAIN_fnc_setTrainRideCondition;

/*
YOU MUST -- GLOBAL EXEC : [] call hideRails; -- AFTER ALL THE RAILS LOAD AND AFTER GETTING IN THE TRAIN ONCE TO INIT!

AFTER THIS - [] remoteExec ["prepcar",0,true]; -- ON THE SERVER!!!

KNOWN BUGS:
  Train floats above rails. Train occasionally slides a bit off the rails. Safe zone is off the gravel.
  Players climbing on train might get stuck.
*/




/*
THE TRAIN CAR HAS 3 THINGS:
Beer!
Ammo!
Autodoc!
*/

GLOBAL_VAR_TRAINCAR = objNull;

prepCar = {

  private _trainCar = prize2 getVariable ["ATRAIN_Local_Copy",prize2];
  GLOBAL_VAR_TRAINCAR = _trainCar;

  //Beer!
  GLOBAL_VAR_TRAINCAR addAction ["Grab Box of Beer", grabNewBoozeBox,nil,1.5,true,true,"","true",5,false,"",""];

  //Arsenal! or Ammo! FOW_AB_US_Crate_Generic
  /*TODO*/
  //Autodoc!
};

/*
OLD METHOD! HERE'S HOPING THE LOCAL COPY WORKS?
getCar = {

  //This bit grabs the traincar - since it's not a real object? or some kind of local thing.
  //
  private "_trainCar";
  private "_nearby";
  _nearby = nearestObjects [testTruck1, [], 100];
  {
    if (((getModelInfo _x) select 0) == "wagon_box.p3d" && vehicleVarName _x == "") then {
      _trainCar = _x;
    };
  } forEach _nearby;

  GLOBAL_VAR_TRAINCAR = _trainCar;
  publicVariable "GLOBAL_VAR_TRAINCAR";

};
*/
