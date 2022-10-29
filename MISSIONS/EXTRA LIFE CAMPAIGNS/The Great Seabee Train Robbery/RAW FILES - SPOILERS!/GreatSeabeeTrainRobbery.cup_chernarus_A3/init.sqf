#include "arsenal.sqf"
#include "prepareRails.sqf"
#include "canCode.sqf"
#include "autodoc.sqf"
#include "ammoBoxen.sqf"
#include "prepareTrainCar.sqf"
#include "railRepair.sqf"
#include "enemies.sqf"

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
  [] remoteExec ["hideRails"];
  ["Step 1 of 2 Completed"] remoteExec ["hint"];
};

// THIRD STEP! PREP THE TRAIN! -- [] call step3; -- ON THE SERVER!!!
step3 = {
  [] remoteExec ["prepCar"];
  ["Step 2 of 2 Completed"] remoteExec ["hint"];
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
