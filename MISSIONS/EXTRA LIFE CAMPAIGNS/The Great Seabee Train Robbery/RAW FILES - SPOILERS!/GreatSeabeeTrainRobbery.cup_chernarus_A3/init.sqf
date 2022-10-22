#include "prepareRails.sqf"
#include "canCode.sqf"

[{str(_this select 0) == "conductor"},"You don't know how to drive a train"] call ATRAIN_fnc_setTrainDriveCondition;

[{false},"There's no room inside to ride"] call ATRAIN_fnc_setTrainRideCondition;

/*
YOU MUST -- GLOBAL EXEC : [] call hideRails; -- AFTER ALL THE RAILS LOAD AND AFTER GETTING IN THE TRAIN ONCE TO INIT!

AFTER THIS - [] remoteExec ["prepcar"]; -- ON THE SERVER!!!

KNOWN BUGS:
  Train floats above rails. Train occasionally slides a bit off the rails. Safe zone is off the gravel.
  Players climbing on train might get stuck.
*/


//Extra function to place a new booze box at player's feet
grabNewBoozeBox = {
	_newBox = "fow_p_wodencrate01" createVehicle (getPos player);
	[_newBox] call makeBoozeBox;
  _newBox setPosATL (getPosATL player);
};

/*
THE TRAIN CAR HAS 3 THINGS:
Beer!
Ammo!
Autodoc!
*/

prepCar = {
  //this bit grabs the traincar - since it's not a real object? or some kind of local thing.
  private "_locomotive";
  private "_trainCar";
  private "_newTruck";
  private "_nearby";
  _nearby = nearestObjects [testTruck1, [], 100];
  {
    if (((getModelInfo _x) select 0) == "wagon_box.p3d" && vehicleVarName _x == "") then {
      _trainCar = _x;
    };
    if (((getModelInfo _x) select 0) == "a2_locomotive.p3d" && vehicleVarName _x == "") then {
      _locomotive = _x;
    };
  } forEach _nearby;

  //Beer!
  _trainCar addAction ["Grab Box of Beer", grabNewBoozeBox,nil,1.5,true,true,"","true",5,false,"",""];

  //Arsenal! or Ammo! FOW_AB_US_Crate_Generic
  /*TODO*/
  //Autodoc!

};
