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
  if (date select 3 < 16) then {
    //playSound3D ["a3\missions_f_epa\data\sounds\electricity_loop.wss", _objectToExplode];
    playSound3D ["a3\missions_f_bootcamp\data\sounds\vr_shutdown.wss", _objectToExplode];
    sleep 1;
    setDate [3001, 10, 10, 17, 37];
    sleep 60;
    setDate [3001, 10, 10, 12, 0];
  };
};

coloraclePunishment = {
  params ["_playerToPunish","_objectToExplode"];
  sleep 2.5;
  playSound3D ["a3\sounds_f\arsenal\sfx\bullet_hits\water_02.wss", _playerToPunish];
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
  [_playerToPunish, true, _objectToExplode] call ACE_captives_fnc_setHandcuffed;
};

cbtPunishment = {
  params ["_playerToPunish","_objectToExplode"];
  playSound3D [getMissionPath "sfx\cock.ogg", _objectToExplode, false, getPosASL _objectToExplode, 1, 1, 20, 0, false];
};

teleporterMalfunctionPunishment = {
  params ["_playerToPunish","_objectToExplode"];
  _potentialPositions = [
    //[[4093.86,3682.07,445.689], 180],
    //[[4108.51,3596.36,406.45], 180],
    //[[4096.15,3611.25,428.62], 270],
    //[[4101.15,3615.03,433.12], 0],
    //[[4097.97,3611.7,449.649], 180]
    [[1772.48,13681.5,466.543], 0], //roof of waffle house on mars
    [[1773.05,13746.2,477.357], 180], //hull of ship on mars
    [[1764.07,13663.7,439.872], 180], //lower hangar on mars
    [[1763.96,13700.2,474.228], 90], //jailcell on mars
    [[1768.75,13705.7,474.228], 270], //plinth on mars
    [[1770.61,13657.4,462.29], 90], //bar on mars
    [[1782.06,13676.4,474.23], 180] //mess hall mars
  ];
  sleep 2;
  playSound3D ["a3\sounds_f\sfx\special_sfx\sparkles_wreck_2.wss", _playerToPunish];
  _chosenPosition = selectRandom _potentialPositions;
  _playerToPunish setPosASL (_chosenPosition select 0);
  _playerToPunish setDir (_chosenPosition select 1);
  //_playerToPunish setPosASL (getPosASL _playerToPunish vectorAdd [0,0,10]);
};

teleporterMalfunctionMassPunishment = {
  _potentialPositions = [
    //[[4093.86,3682.07,445.689], 180],
    //[[4108.51,3596.36,406.45], 180],
    //[[4096.15,3611.25,428.62], 270],
    //[[4101.15,3615.03,433.12], 0],
    //[[4097.97,3611.7,449.649], 180]
    [[1772.48,13681.5,466.543], 0], //roof of waffle house on mars
    [[1773.05,13746.2,477.357], 180], //hull of ship on mars
    [[1764.07,13663.7,439.872], 180], //lower hangar on mars
    [[1763.96,13700.2,474.228], 90], //jailcell on mars
    [[1768.75,13705.7,474.228], 270], //plinth on mars
    [[1770.61,13657.4,462.29], 90], //bar on mars
    [[1782.06,13676.4,474.23], 180] //mess hall mars
  ];
  _warningMessage = "<br/>MAJOR TELEPORTATION FAILURE";
  [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
  sleep 2;
  {
    playSound3D ["a3\sounds_f\sfx\special_sfx\sparkles_wreck_2.wss", _x];
    _chosenPosition = selectRandom _potentialPositions;
    _x setPosASL (_chosenPosition select 0);
    _x setDir (_chosenPosition select 1);
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
    //[4088.01,3653.56,427.864], // middle of main hangar [4089.35,3658.02,422.865]
    //[4091.77,3626.27,450.397], // outside the bridge
    //[4089.83,3612.03,440.808], // mess hall
    //[4081.12,3591.61,428.868]  // rec room
    [1780.34,13717.5,461.285],
    [1781.55,13691.9,483.819],
    [1787.75,13704.3,474.239],
    [1782.06,13676.4,474.23]
  ];
  _chosenPosition = selectRandom _boardingPositions;
  _boardingParty = [[0,0,0], EAST, (configfile >> "CfgGroups" >> "East" >> "SC_Faction_SE" >> "SE_Guard" >> "SC_SE_InfTeam")] call BIS_fnc_spawnGroup; //[4089.35,3658.02,422.865]??
  {
    _x setPosASL _chosenPosition;
    playSound3D ["a3\sounds_f\sfx\special_sfx\sparkles_wreck_2.wss", _x];
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
  playSound3D ["a3\sounds_f\sfx\special_sfx\sparkles_wreck_3.wss", _playerToPunish];
  removeAllWeapons _playerToPunish;
  removeGoggles _playerToPunish;
  removeHeadgear _playerToPunish;
  removeVest _playerToPunish;
  removeUniform _playerToPunish;
  removeAllAssignedItems _playerToPunish;
  clearAllItemsFromBackpack _playerToPunish;
  removeBackpack _playerToPunish;
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
