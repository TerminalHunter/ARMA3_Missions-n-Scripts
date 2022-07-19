shanties = [
  "DawsonsChristian.ogg",
  "DrunkSpacePirate.ogg",
  "HanrahansBar.ogg",
  "ProvidenceSkies.ogg",
  "PushinTheSpeedOfLight.ogg",
  "SpacersHome.ogg",
  "SpaceShanty.ogg"
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
