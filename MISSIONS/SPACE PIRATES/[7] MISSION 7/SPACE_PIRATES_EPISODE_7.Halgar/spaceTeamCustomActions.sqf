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
  playSound3D [_path, _singer];
};

purpleAlert = {
  playSound3D [getMissionPath "sfx\PurpleAlert.ogg", theActualShip];
};

plaidAlert = {
  playSound3D [getMissionPath "sfx\plaid.ogg", theActualShip];
};

redAlert = {
  playSound3D [getMissionPath "sfx\RedAlert.ogg", theActualShip];
};

greenAlert = {
  playSound3D [getMissionPath "sfx\greenAlert.ogg", theActualShip];
};

honkSpaceHorn = {
  params ["_honkler"];
  playSound3D [getMissionPath "sfx\honk.ogg", _honkler];
};

rebootNoise = {
  params ["_rebooter"];
  playSound3D [getMissionPath "sfx\bootup.ogg", _rebooter];
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
