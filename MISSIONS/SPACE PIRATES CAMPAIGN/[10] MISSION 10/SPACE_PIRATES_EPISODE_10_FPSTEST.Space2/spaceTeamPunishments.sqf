#include "story.sqf"

/*

explosion
smoke
lights out*
coloracle
earthquake shake
sparks?
SHATNER! -- if you can find better animations
  https://community.bistudio.com/wiki/Arma_3:_Moves#Cutscene.E2.80.A6
  acts
  Acts_Taking_Cover_From_Jets
accidentally tie self up
teleporter malfunction
CBT!

https://community.bistudio.com/wiki/Arma_3:_Sound_Files

*/

currentFires = [];

explodePunishment = {
  params ["_playerToPunish","_objectToExplode"];
  //let the buzzer go off
  sleep 2;
  _scriptedCharge = createVehicle ["APERSMine_Range_Ammo",(getPosASL _objectToExplode),[],0,"CAN_COLLIDE"];
  _newPos = (((getPosASL _objectToExplode) vectorAdd getPosASL _playerToPunish) vectorMultiply 0.5);
  _scriptedCharge setPosASL (_newPos);
  _scriptedCharge setDamage 1;
};

smokePunishment = {
  params ["_playerToPunish","_objectToExplode"];
  _scriptedCharge = createVehicle ["Smokeshell",(getPosASL _objectToExplode),[],0,"CAN_COLLIDE"];
  _scriptedCharge setPosASL (getPosASL _objectToExplode);
  hideObject _scriptedCharge;
  _scriptedCharge setDamage 1;
};

lightsOutPunishment = {
  params ["_playerToPunish","_objectToExplode"];
  //let the buzzer go off
  sleep 2;
  //if (date select 3 < 16) then {
    //playSound3D ["a3\missions_f_epa\data\sounds\electricity_loop.wss", _objectToExplode];
    playSound3D ["a3\missions_f_bootcamp\data\sounds\vr_shutdown.wss", _objectToExplode, false, getPosASL _objectToExplode, 2, 1, 2000];
    sleep 1;
    //setDate [3001, 10, 10, 17, 37];
    //staticLightPoint setLightIntensity 0.05;
    //intensity of 1? (maybe 3?) brightness of 0.05?
    //[0.01] remoteExec ["turnLightsOnBrightness", 0, false];
    [10] remoteExec ["turnLightsOnIntensity", 0, false];
    sleep (20 + random 10);
    //setDate [3001, 10, 10, 12, 0];
    //staticLightPoint setLightIntensity 0.4;
    //brightness 0.5 -- intensity if 50 (apparently)
    //[0.5] remoteExec ["turnLightsOnBrightness", 0, false];
    [1000] remoteExec ["turnLightsOnIntensity", 0, false];
  //};
};

coloraclePunishment = {
  params ["_playerToPunish","_objectToExplode"];
  sleep 2.5;
  playSound3D ["a3\sounds_f\arsenal\sfx\bullet_hits\water_02.wss", _playerToPunish, false, getPosASL _playerToPunish, 2, 1, 2000];
  [_playerToPunish] remoteExec ["goTripHard", _playerToPunish, false];
};

shakePunishment = {
  params ["_playerToPunish","_objectToExplode"];
  [4] remoteExec ["BIS_fnc_earthquake", 0, false];
};

firePunishment = {
  params ["_playerToPunish","_objectToExplode"];
  //https://forums.bohemia.net/forums/topic/160060-electricity-effect-from-mission-1/
  //http://148.251.187.73/repo/@Drongos%20Spooks%20and%20Anomalies/Arma%203%20particles.txt
  _sparkler = createVehicle ["#particleSource", getPosASL _objectToExplode,[],0,"CAN_COLLIDE"];
  _sparkler setPosASL ((getPosASL _objectToExplode) vectorAdd [0,0,0.2]);
  _sparkler setParticleClass "ObjectDestructionFire1Small";
  currentFires pushBack _sparkler;
  publicVariable "currentFires";
};

tiedUpPunishment = {
  params ["_playerToPunish","_objectToExplode"];
  _longString = "<t color='#aaaa22' size='1'>You seemed to have tangled yourself up...</t>";
  [_longString] remoteExec ["storyText", _playerToPunish, false];
  //[_playerToPunish, true, _objectToExplode] call ACE_captives_fnc_setHandcuffed;
  [_playerToPunish, true, _objectToExplode] remoteExec ["ACE_captives_fnc_setHandcuffed", _playerToPunish, false];
};

cbtPunishment = {
  params ["_playerToPunish","_objectToExplode"];
  playSound3D [getMissionPath "sfx\cock.ogg", _objectToExplode, false, getPosASL _objectToExplode, 1, 1, 20, 0, false];
};

teleporterMalfunctionPunishment = {
  params ["_playerToPunish","_objectToExplode"];
  _potentialPositions = [
    [[9.25391,25.8159,28.1701],180],
    [[-9.86475,26.5601,28.1701],180],
    [[-6.62012,30.3813,23.6701],180],
    [[1.99609,26.5996,23.6701],0],
    [[-2.76611,-60.5459,22.9092],180],
    [[-0.235352,-15.4727,39.7541],0],
    [[12.6875,1.32715,35.8542],90],
    [[3.09326,43.793,23.9101],0],
    [[1.43945,66.54,27.5256],90],
    [[6.24902,30.771,44.698],180],
    [[1.84326,43.7061,1.49873],90],
    [[2.12451,21.6348,35.8395],45],
    [[17.5273,10.9292,35.8541],270],
    [[4.57959,32.7026,35.8568],0],
    [[9.91797,51.144,23.9168],270],
    [[6.44336,47.665,23.9168],90],
    [[12.6646,51.8706,23.9168],270]
  ];
  sleep 2;
  playSound3D ["a3\sounds_f\sfx\special_sfx\sparkles_wreck_2.wss", _playerToPunish, false, getPosASL _playerToPunish, 2, 1, 2000];
  _chosenPosition = selectRandom _potentialPositions;
  _playerToPunish setPosASL ((_chosenPosition select 0) vectorAdd (getPosASL theActualShip));
  _playerToPunish setDir (_chosenPosition select 1);
  [] remoteExec ["smallAntiGravity", _playerToPunish, false];
};

teleporterMalfunctionMassPunishment = {
  _potentialPositions = [
    [[9.25391,25.8159,28.1701],180],
    [[-9.86475,26.5601,28.1701],180],
    [[-6.62012,30.3813,23.6701],180],
    [[1.99609,26.5996,23.6701],0],
    [[-2.76611,-60.5459,22.9092],180],
    [[-0.235352,-15.4727,39.7541],0],
    [[12.6875,1.32715,35.8542],90],
    [[3.09326,43.793,23.9101],0],
    [[1.43945,66.54,27.5256],90],
    [[6.24902,30.771,44.698],180],
    [[1.84326,43.7061,1.49873],90],
    [[2.12451,21.6348,35.8395],45],
    [[17.5273,10.9292,35.8541],270],
    [[4.57959,32.7026,35.8568],0],
    [[9.91797,51.144,23.9168],270],
    [[6.44336,47.665,23.9168],90],
    [[12.6646,51.8706,23.9168],270]
  ];
  _warningMessage = "<br/>MAJOR TELEPORTATION FAILURE";
  [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
  sleep 2;
  {
    playSound3D ["a3\sounds_f\sfx\special_sfx\sparkles_wreck_2.wss", _x, false, getPosASL _x, 2, 1, 2000];
    _chosenPosition = selectRandom _potentialPositions;
    _x setPosASL ((_chosenPosition select 0) vectorAdd (getPosASL theActualShip));
    _x setDir (_chosenPosition select 1);
    [] remoteExec ["smallAntiGravity", _x, false];
  } forEach allPlayers;
};

nothingMassPunishment = {
  _warningMessage = "<br/>GENERAL SENSE OF UNEASE DEPLOYED";
  [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
};

nothingMassPunishment2 = {
  _warningMessage = "<br/>SHATNER!";
  [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
};

fireMassPunishment = {
  _warningMessage = "<br/>FIRE!";
  [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
  for "_i" from 1 to 5 do {
    _objective = selectRandom randomizedObjectiveObjects;
    _object = _objective select 0;
    [objNull, _object] spawn firePunishment;
  };
};

boardingPartyMassPunishment = {
  _warningMessage = "<br/>HOSTILE BOARDING PARTY DETECTED";
  [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
  _boardingPositions = [
    [3.65039,-24.2139,22.9146],
    [-8.93799,28.1724,23.6701],
    [17.9482,68.4653,25.9119],
    [-17.8726,49.6367,23.9161],
    [-16.1826,29.3726,1.49835],
    [-6.40088,-39.6055,30.8742],
    [6.19873,-13.7725,35.8672],
    [-6.26221,2.07031,35.8658],
    [6.50098,15.1743,35.8658],
    [0.189453,30.1567,35.8569],
    [0.0302734,15.6138,45.446]
  ];
  _chosenPosition = (getPosASL theActualShip) vectorAdd (selectRandom _boardingPositions);
  _boardingParty = [[0,0,0], EAST, (configfile >> "CfgGroups" >> "East" >> "SC_Faction_SE" >> "SE_Guard" >> "SC_SE_InfTeam")] call BIS_fnc_spawnGroup; //[4089.35,3658.02,422.865]??
  {
    _x setPosASL _chosenPosition;
    playSound3D ["a3\sounds_f\sfx\special_sfx\sparkles_wreck_2.wss", _x, false, getPosASL _x, 2, 1, 2000];
    _x disableAI "PATH";
  }forEach (units _boardingParty);
};

coloracleMassPunishment = {
  _warningMessage = "<br/>STRESS DETECTED DEPLOYING ANTI-STRESS AGENT";
  [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
  sleep 2;
  {
    [_x, objNull] spawn coloraclePunishment;
  }forEach allPlayers;
};

nakedPunishment = {
  params ["_playerToPunish","_objectToExplode"];
  playSound3D ["a3\sounds_f\sfx\special_sfx\sparkles_wreck_3.wss", _playerToPunish, false, getPosASL _playerToPunish, 2, 1, 2000];
  removeAllWeapons _playerToPunish;
  removeGoggles _playerToPunish;
  removeHeadgear _playerToPunish;
  removeVest _playerToPunish;
  removeUniform _playerToPunish;
  removeAllAssignedItems _playerToPunish;
  clearAllItemsFromBackpack _playerToPunish;
  removeBackpack _playerToPunish;
};

missileMassPunishment = {
  //_video = [getMissionPath "img\missile.ogv", [SafeZoneX/2.5,SafeZoneY/2.5,SafeZoneW/2.5,SafeZoneH/2.5]] spawn BIS_fnc_playVideo;
  _warningMessage = "<br/>ERROR:<br/>STARTING TRAINING VIDEO";
  [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
  sleep 2;
  [getMissionPath "img\missile.ogv", [SafeZoneX/2.5,SafeZoneY/2.5,SafeZoneW/2.5,SafeZoneH/2.5]] remoteExec ["BIS_fnc_playVideo", 0, false];
};

fireSuppression = {
  //_allFires = nearestObjects [theActualShip, ["#particleSource"], 1000];
  _allFires = currentFires;
  currentFires = [];
  {
    [_x] spawn {
      params ["_fire"];
      _woosh = createVehicle ["#particleSource", getPosASL _fire,[],0,"CAN_COLLIDE"];
      _woosh setPosASL (getPosASL _fire);
      _woosh setParticleClass "ExplosionEffectsWater";
      sleep 2;
      deleteVehicle _fire;
      sleep 2;
      deleteVehicle _woosh;
    }
  } forEach _allFires;
};

//fire suppression should probably use ExplosionEffectsWater

//http://tikka.ws/class/index.php?b=cfgMagazines&s=ace_explosives_Placeable
//finding a bunch of useful sites

//SENSE OF UNEASE: DEPLOYED

//increase speed


/*REAL OFFSETS! NOT AS HARD CODED!
Top of waffle house, under pirate flag
[9.25391,25.8159,28.1701]
180

Behind space in space waffle house
[-9.86475,26.5601,28.1701]
180

inside wafflehouse
[-6.62012,30.3813,23.6701]
180

inside wafflehouse 2 - look at menu
[1.99609,26.5996,23.6701]
0

medbay
[-2.76611,-60.5459,22.9092]
180

outside, looking at bridge
[-0.235352,-15.4727,39.7541]
0

mysterious plinth
[12.6875,1.32715,35.8542]
90

head
[3.09326,43.793,23.9101]
0

top of slide
[1.43945,66.54,27.5256]
90

lifepod
[6.24902,30.771,44.698]
180

lower deck
[1.84326,43.7061,1.49873]
90

stairs to bridge
[2.12451,21.6348,35.8395]
45

in the jail cell (evil)
[17.5273,10.9292,35.8541]
270

mess window
[4.57959,32.7026,35.8568]
0

bar 1
[9.91797,51.144,23.9168]
270

bar 2
[6.44336,47.665,23.9168]
90

bar 3
[12.6646,51.8706,23.9168]
270




[0.183594,27.1362,-22.9147]
[5107.39,-5271.07,98.9335]
[5107.02,-5325.34,144.763]
*/
