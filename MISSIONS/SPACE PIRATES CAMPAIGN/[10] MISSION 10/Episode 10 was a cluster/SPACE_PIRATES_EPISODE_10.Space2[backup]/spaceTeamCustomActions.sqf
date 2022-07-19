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

//LIGHT'S FUCKING WEIRD
staticLightPoint = "#lightpoint" createVehicleLocal [0,0,0];
staticLightPoint attachTo [theActualShip, [0, 0, 1.5]];
staticLightPoint setLightColor [0,0,0];
staticLightPoint setLightAmbient [1.0, 0.8, 1.0];
staticLightPoint setLightIntensity 200; //brightness 1 = intensity 3000 apparently
staticLightPoint setLightAttenuation [20000,0,4.31918e-005,0];

turnLightsOn = {
  params ["_brightness"];
    staticLightPoint setLightIntensity _brightness;
};

warpIn = {
  if (isServer) then {
    _tempArray = theActualShip nearObjects 400;
    {
        _tempPos = getPosASL _x;
        _x setPosASL (_tempPos vectorAdd [0,10000,0]);
    }forEach _tempArray;
    respawnerLocation = respawnerLocation vectorAdd [0,10000,0];
    publicVariable "respawnerLocation";
    //staticLightPoint setLightIntensity 0.3;
    [staticLightPoint, 100] remoteExec ["setLightIntensity", 0, true];
    hangarPos = hangarPos vectorAdd [0,10000,0];
    bridgePos = bridgePos vectorAdd [0,10000,0];
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
