#include "prepareRails.sqf"

[{str(_this select 0) == "conductor"},"You don't know how to drive a train"] call ATRAIN_fnc_setTrainDriveCondition;

[{false},"There's no room inside to ride"] call ATRAIN_fnc_setTrainRideCondition;

/*
YOU MUST -- GLOBAL EXEC : [] call hideRails; -- AFTER ALL THE RAILS LOAD AND AFTER GETTING IN THE TRAIN ONCE TO INIT!

KNOWN BUGS:
  Train floats above rails. Train occasionally slides a bit off the rails. Safe zone is off the gravel.
  Players climbing on train might get stuck.
*/
