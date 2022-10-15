#include "prepareRails.sqf"

/*
YOU MUST -- GLOBAL EXEC : [] call hideRails; -- AFTER ALL THE RAILS LOAD!
*/

TEST_TRAINCAR = objNull;
TEST_VIC = testTruck1;

prepCar = {
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


  testTruck1 attachTo [_trainCar, [2.05,3,0]];
  testTruck2 attachTo [_trainCar, [-2.05,3,0]];
  testTurret1 attachTo [_trainCar, [2.05,-3,0]];
  testTurret2 attachTo [_trainCar, [-2.05,-3,0]];

  TEST_TRAINCAR = _trainCar;

  //testTruck disableCollisionWith _trainCar;
  //testTruck disableCollisionWith _locomotive;

  _trainCar
};
