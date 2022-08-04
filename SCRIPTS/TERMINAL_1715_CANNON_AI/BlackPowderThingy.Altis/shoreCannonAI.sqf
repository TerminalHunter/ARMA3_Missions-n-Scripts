/*

TODO: Nothing, but further improvements can always be made.

Generalized range tables?
[cannonObject] call registerCannon; as a one-line solution
GRAPESHOT! Didn't figure out how to change the vehicle magazine properly, I don't think.
All the AI seem to target the same target. Maybe figure out a way to prioritize? Or at least randomize.

*/

setYawPitchRoll = {
  params ["_object", "_yaw", "_pitch", "_roll"];
  _object setVectorDirAndUp [[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],[[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D];
};

setJustPitchYaw = {
  params ["_object", "_pitch", "_yaw"];
  _object setVectorDirAndUp [[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],[[sin 0, -sin _pitch, cos 0 * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D];
};

findNearestNumberFromList = {
  //should return the index of the nearest number in the given array
  params ["_givenNumber", "_givenArray"];
  private _closestIndex = nil;
  private _absValue = 999999;
  {
    if (abs((_x select 1) - _givenNumber) < _absValue) then {
        _absValue = abs((_x select 1) - _givenNumber);
        _closestIndex = _forEachIndex;
    };
  } forEach _givenArray;
  _closestIndex
};

cannonTable = [
  [testCannon, getPosASL testCannon, 1],
  [testCannon2, getPosASL testCannon2, getDir testCannon2],
  [fartNorth1, getPosASL fartNorth1, getDir fartNorth1],
  [fartNorth2, getPosASL fartNorth2, getDir fartNorth2],
  [fartSouth2, getPosASL fartSouth2, 270],
  [castleCannon, getPosASL castleCannon, getDir castleCannon]
];

if (isServer) then {
  testCannon attachTo [testBox];
  testCannon2 attachTo [testCannon2Box];
  fartNorth1 attachTo [fartNorth1Box];
  fartNorth2 attachTo [fartNorth2Box];
  //fartSouth1 attachTo [fartSouth1Box];
  fartSouth2 attachTo [fartSouth2Box];
  castleCannon attachTo [southCastleBox];
  {
    (_x select 0) setPosASL (_x select 1);
    [(_x select 0), 0, (_x select 2)] call setJustPitchYaw;
  } forEach cannonTable;
};

fireCannon = {
  params ["_cannonArray", "_pitch", "_yaw"];
  [(_cannonArray select 0), _pitch, _yaw] call setJustPitchYaw;
  [(_cannonArray select 0), currentWeapon (_cannonArray select 0)] call BIS_fnc_fire;
  sleep 0.5; //can I get rid of this?
  [(_cannonArray select 0), [currentWeapon (_cannonArray select 0), 1]] remoteExecCall ["setammo", (_cannonArray select 0)];
  (_cannonArray select 0) setPosASL (_cannonArray select 1);
  (_cannonArray select 0) setDir (_cannonArray select 2);
};

yaBoiCanSee = {
  //specifically for humans
  params ["_dude1", "_dude2"];
  [] isEqualTo (lineIntersectsSurfaces [eyePos _dude1, eyePos _dude2, _dude1, _dude2, true, -1]);
};

cannonFireCheck = {
  params ["_cannon", "_cannonArray", "_watchman", "_arcs", "_rangingTable"];
  //draw ray from cannon/watchman to all players, compare and see if at least one is visible!
  private _potentialTargets = [];
  private _poorSap = nil;
  private _poorSapDistance = nil;
  {
    if ([_watchman, _x] call yaBoiCanSee) then {
      _potentialTargets append [_x];
    };
  } forEach allPlayers;
  //nobody visible? stop here.
  if ([] isEqualTo _potentialTargets) exitWith {};
  //take all visible players and check if they're within 1255 meters OR rangingTable max
  {
    if (_x distance2d _cannon < 1250) then {
      _poorSap = _x;
      _poorSapDistance = _x distance2D _cannon;
    };
  } forEach _potentialTargets;
  //if there exists a player that's within 1255 and visible then take that player
  if (isNil {_poorSap}) exitWith{};
  //make sure that player is within firing arc (heading from cannon to player is approx 30 deg)
  private _dirCheck = _cannon getDir _poorSap;
  private _firingAngle = nil;
  private _indexOfRangingTable = nil;
  if ((_dirCheck + 360) > ((_arcs select 0) + 360) && (_dirCheck + 360) < ((_arcs select 1) + 360)) then {
    //look at ranging table, pick closest value, point towards player +- some adjustment for wind, fire
    //{
    //  if (_x select 1 < _poorSapDistance) then {
    //    _firingAngle = _x select 0;
    //  };
    //} forEach _rangingTable;
    private _indexOfRangingTable = [_poorSapDistance, _rangingTable] call findNearestNumberFromList;
    if (!isNil {_indexOfRangingTable} && _rangingTable select 0 select 1 < _poorSapDistance) then {
      [_cannonArray, ((_rangingTable select _indexOfRangingTable select 0) + random 6 - 3), (_dirCheck + random 1 - 0.5)] spawn fireCannon;
    };
  };
};

//INIT THE AI!
if (isServer) then {
  [] spawn {
    while {alive castleWatchman} do {
      sleep (30 + random 10);
      [testCannon, cannonTable select 0, castleWatchman, [-60, 60], castleRangingTable] call cannonFireCheck;
      [testCannon2, cannonTable select 1, castleWatchman, [-60, 60], castleRangingTable] call cannonFireCheck;
    };
  };
  [] spawn {
    while {alive northFartWatchman} do {
      sleep (30 + random 10);
      [fartNorth1, cannonTable select 2, northFartWatchman, [-10,100], northFartRangingTable] call cannonFireCheck;
      [fartNorth2, cannonTable select 3, northFartWatchman, [60, 180], northFartRangingTable] call cannonFireCheck;
    };
  };
  [] spawn {
    while {alive southFartWatchman} do {
      sleep (30 + random 10);
      [fartSouth2, cannonTable select 4, southFartWatchman, [190,310], southFartRangingTable] call cannonFireCheck;
    };
  };
  [] spawn {
    while {alive southCastleWatchman} do {
      sleep (30 + random 10);
      [castleCannon, cannonTable select 5, southCastleWatchman, [180, 300], southFartRangingTable] call cannonFireCheck;
    };
  };
};

castleRangingTable = [
  //[pitch, approx distance]
  [-25, 800],
  [-20, 900],
  [-15, 1000],
  [-10, 1090],
  [-5, 1157],
  [0, 1205],
  [5, 1238],
  [15, 1255]
];

northFartRangingTable = [
  [-25, 261],
  [-20, 355],
  [-15, 514],
  [-10, 723],
  [-5, 900],
  [0, 1025],
  [5, 1105],
  [10, 1154],
  [15, 1180],
  [20, 1186]
];

southFartRangingTable = [
  [-20, 433],
  [-15, 597],
  [-10, 789],
  [-5, 943],
  [0, 1048],
  [5, 1125],
  [10, 1168],
  [15, 1190]
];

/*

fartSouth2 loadMagazine [[0], "1715_6poundercannon", "1715_6pound_powder_grapeshot"];



TESTING CODE
origPos = getPosASL testCannon;
origDir = getDir testCannon;

testDirectedFire = {
  params ["_testPitch"];
  [testCannon, _testPitch, origDir] call setJustPitchYaw;
  [testCannon, currentWeapon testCannon] call BIS_fnc_fire;
  sleep 1;
  [testCannon, [currentWeapon testCannon, 1]] remoteExecCall ["setammo", testCannon];
  testCannon setPosASL origPos;
  testCannon setDir origDir;
};
*/

/*

keepFiringAssholes = {
  params ["_cannon", "_asshole", "_defaultDir"];
  sleep random 2;
  while {!(_asshole getVariable ["ACE_isUnconscious" , false])} do {
    _poorSchmuck = selectRandom (call BIS_fnc_listPlayers);
    _newDir = _cannon getDir _poorSchmuck;
    if (_poorSchmuck inArea cannonFireZone) then {
      _offset = random 2 - 1;
      _cannon setDir (_newDir + _offset);
      //if (floor random 4 == 1) then {
      //  _cannon setDir _newDir;
      //};
    } else {
      _cannon setDir _defaultDir;
    };
    //_cannon setVectorUp [(((random 3)/10)*-1), 0, 1];
    _cannon setVectorUp [(-0.12 - ((random 2) / 10)), 0, 1];
    [_cannon, currentWeapon _cannon] call BIS_fnc_fire;
    sleep floor random 10;
    [_cannon, [currentWeapon _cannon, 1]] remoteExecCall ["setammo", _cannon];
    sleep floor random 10;
    sleep 15;
  };
};



testFire = {
  params ["_testNum"];
  _origPos = getPosASL testCannon;
  _origDir = getDir testCannon;
  testCannon setVectorUp [0, _testNum, 1];
  [testCannon, currentWeapon testCannon] call BIS_fnc_fire;
  sleep 1;
  [testCannon, [currentWeapon testCannon, 1]] remoteExecCall ["setammo", testCannon];
  testCannon setPosASL _origPos;
  testCannon setDir _origDir;
};


[] spawn {
_origPos = getPosASL testCannon;
_origDir = getDir testCannon;
testCannon setVectorUp [0, -0.50, 1];
[testCannon, currentWeapon testCannon] call BIS_fnc_fire;
sleep 2;
[testCannon, [currentWeapon testCannon, 1]] remoteExecCall ["setammo", testCannon];
testCannon setPosASL _origPos;
testCannon setDir _origDir;
};
*/

//testCannon
//testShip1
