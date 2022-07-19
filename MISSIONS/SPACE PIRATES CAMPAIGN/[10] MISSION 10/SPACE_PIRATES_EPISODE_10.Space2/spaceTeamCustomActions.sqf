shanties = [
  "DawsonsChristian.ogg",
  "DrunkSpacePirate.ogg",
  "HanrahansBar.ogg",
  "ProvidenceSkies.ogg",
  "PushinTheSpeedOfLight.ogg",
  "SpacersHome.ogg",
  "SpaceShanty.ogg",
  "Bitch.ogg",
  "Eighteen.ogg"
];

singShanty = {
  params ["_singer"];
  _path = "easterEggBeerLabels2021\" + (selectRandom shanties);
  playSound3D [_path, _singer, false, getPosASL _singer, 2, 1, 2000];
};

purpleAlert = {
  playSound3D [getMissionPath "sfx\PurpleAlert.ogg", theActualShip, false, getPosASL theActualShip, 2, 1, 2000];
};

plaidAlert = {
  playSound3D [getMissionPath "sfx\plaid.ogg", theActualShip, false, getPosASL theActualShip, 2, 1, 2000];
};

redAlert = {
  playSound3D [getMissionPath "sfx\RedAlert.ogg", theActualShip, false, getPosASL theActualShip, 2, 1, 2000];
};

greenAlert = {
  playSound3D [getMissionPath "sfx\greenAlert.ogg", theActualShip, false, getPosASL theActualShip, 2, 1, 2000];
};

honkSpaceHorn = {
  params ["_honker"];
  playSound3D [getMissionPath "sfx\honk.ogg", _honker, false, getPosASL _honker, 2, 1, 2000];
};

rebootNoise = {
  params ["_rebooter"];
  playSound3D [getMissionPath "sfx\bootup.ogg", _rebooter, false, getPosASL _rebooter, 2, 1, 2000];
};

getSpaceVerb = {
  params ["_notThisVerb"];
  _chosenVerb = selectRandom spaceVerbs;
  if (_chosenVerb == _notThisVerb) then {
    _chosenVerb = [_notThisVerb] call getSpaceVerb;
  };
  _chosenVerb
};

addActionRandomNumbers = [
  0.5,
  2
];

drawADick = {
  whiteboard setObjectTextureGlobal [0, "img\mapboard_dick.paa"];
};

turnLightsOnIntensity = {
  params ["_intensity"];
    staticLightPoint setLightIntensity _intensity;
};

turnLightsOnBrightness = {
  params ["_brightness"];
    staticLightPoint setLightBrightness _brightness;
};

preWarpArray = [];

smallAntiGravity = {
  player switchmove "";
  sleep 0.15;
  player switchmove "";
};

waitABitAndThenUnfreeze = {
  //sleep 5;
  _previousPos = getPosASL player;
  _previousDir = getDir player;
  player setPos [-500,(-500 + (random 4) - 2)];
  player setDir 270;
  sleep 1.5;
  player setPosASL _previousPos;
  player setDir _previousDir;
  player enableSimulationGlobal true;
  ["Artificial Gravity Calibrating - Please Wait"] spawn shorterHint;
  player switchmove "";
  sleep 0.15;
  player switchmove "";
};

warpIn = {
  if (isServer) then {
    _players = call BIS_fnc_listPlayers;
    //grab a position the players should be teleported to
    {
      _playerPosition = [_x, ((getPosASL _x) vectorAdd [0,10000,0])];
      preWarpArray pushBack _playerPosition;
      _x enableSimulationGlobal false;
    } forEach _players;
    //grab the ship and everything on it
    _tempArray = theActualShip nearObjects 400;
    //move the ship
    {
        _tempPos = getPosASL _x;
        _x setPosASL (_tempPos vectorAdd [0,10000,0]);
        //and blow up the big ship weapons
        if (typeOf _x isEqualTo "OPTRE_Corvette_M910_Turret_u" or typeOf _x isEqualTo "OPTRE_Corvette_archer_system" or typeOf _x isEqualTo "OPTRE_Corvette_M910_Turret") then {
          //_x setDamage 1;
          deleteVehicle _x;
        };
    } forEach _tempArray;
    //put players back (with a surprise)
    {
      (_x select 0) setPosASL (_x select 1);
      [] remoteExec ["waitABitAndThenUnfreeze", (_x select 0), false];
    } forEach preWarpArray;
    //move respawns and vehicle spawn - save cycles do this after players
    respawnerLocation = respawnerLocation vectorAdd [0,10000,0];
    publicVariable "respawnerLocation";
    //if we're using brightness
    //[0.3] remoteExec ["turnLightsOnBrightness", 0, true];
    //if we're using intensity:
    [200] remoteExec ["turnLightsOnIntensity", 0, true];
    hangarPos = hangarPos vectorAdd [0,10000,0];
    bridgePos = bridgePos vectorAdd [0,10000,0];
    [] spawn {
      playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
      sleep 1;
      playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
      sleep 1;
      playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
      sleep 1;
      playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
      sleep 1;
      playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
    };
    ["zerothTask","SUCCEEDED"] call BIS_fnc_taskSetState;
    "firstTask" call BIS_fnc_taskSetCurrent;
  };
};

findCombos = {
  params ["_objectHidingCombos"];
  _foundCombos1 = "combosBag" createVehicle [0,0,0];
  _foundCombos2 = "combosBag" createVehicle [0,0,0];
  _foundCombos3 = "combosBag" createVehicle [0,0,0];
  _foundCombos4 = "combosBag" createVehicle [0,0,0];
  _foundCombos1 setPosASL ((getPosASL _objectHidingCombos) vectorAdd [0,0,0.1]);
  _foundCombos2 setPosASL ((getPosASL _objectHidingCombos) vectorAdd [0,0,0.1]);
  _foundCombos3 setPosASL ((getPosASL _objectHidingCombos) vectorAdd [0,0,0.1]);
  _foundCombos4 setPosASL ((getPosASL _objectHidingCombos) vectorAdd [0,0,0.1]);
};

findMoney = {
  params ["_objectHidingCash"];
  _foundCash1 = "Item_Money_roll" createVehicle [0,0,0];
  _foundCash2 = "Item_Money_roll" createVehicle [0,0,0];
  _foundCash3 = "Item_Money_roll" createVehicle [0,0,0];
  _foundCash4 = "Item_Money_roll" createVehicle [0,0,0];
  _foundCash1 setPosASL ((getPosASL _objectHidingCash) vectorAdd [0,0,0.1]);
  _foundCash2 setPosASL ((getPosASL _objectHidingCash) vectorAdd [0,0,0.1]);
  _foundCash3 setPosASL ((getPosASL _objectHidingCash) vectorAdd [0,0,0.1]);
  _foundCash4 setPosASL ((getPosASL _objectHidingCash) vectorAdd [0,0,0.1]);
};

findPositionOffset = {
  params ["_objectFrom", "_objectTo"];
  _return = getPosASL _objectTo vectorAdd (getPosASL _objectFrom vectorMultiply -1);
  _return
};
