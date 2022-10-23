#include "arsenal.sqf"
#include "prepareRails.sqf"
#include "canCode.sqf"
#include "autodoc.sqf"
#include "ammoBoxen.sqf"
#include "prepareTrainCar.sqf"

[{str(_this select 0) == "conductor"},"You don't know how to drive a train"] call ATRAIN_fnc_setTrainDriveCondition;

[{false},"There's no room inside to ride"] call ATRAIN_fnc_setTrainRideCondition;

/*
KNOWN BUGS:
  Train floats above rails. Train occasionally slides a bit off the rails. Safe zone is off the gravel.
  Players climbing on train might get stuck.
  Train doesn't animate. May give error about skeleton?
*/

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
