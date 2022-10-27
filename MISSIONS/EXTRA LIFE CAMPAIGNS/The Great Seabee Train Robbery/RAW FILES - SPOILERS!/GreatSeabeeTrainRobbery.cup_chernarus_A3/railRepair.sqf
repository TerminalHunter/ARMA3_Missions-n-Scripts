boozenObjects = [baseBeer, secondBeer,quillShipBeer,babstBeer,blastedBatBeer,cbt2020Beer,fuchBeer,loveBeer,moonBeer,quillCBTBeer,quillPolyBeer,malortBeer,fuckYouBeer,cloroxBeer,cagedBeer,noBrand3,unreadableBeer,comradeBeer];

canSuccessSounds = [
  "audio\Oracle_Get_Rupee.ogg",
  "audio\Oracle_Shield_Deflect.ogg",
  "audio\Oracle_Sword_Tap.ogg",
  "audio\ding.ogg"
];

canFailureSounds = [
  "audio\can1.ogg",
  "audio\can2.ogg",
  "audio\can3.ogg",
  "audio\can4.ogg"
];

/*
Design Paradigms

1700 seconds to clear/fix a rail

500 seconds can be mitigated with can throwing
1200 seconds remain, 20 minutes

Cover bit of track with Land_BurntGarbage_01_F

*/

currentEndTime = 0;
inDefenseMission = false;

/* TODO maybe make this just one function? */

cansHitSabo1 = 0;
sabo1 addAction ["Begin Repairs",{[sabo1] call checkBeforeDefensePortion},[],1.5,true,true,"","true",10,false,"",""];

sabo1 addEventHandler ["EpeContactStart", {
	params ["_object1", "_object2", "_selection1", "_selection2", "_force", "_reactForce", "_worldPos"];
  if (typeOf _object2 in boozen && inDefenseMission) then {
    deleteVehicle _object2;
    if (cansHitSabo1 < 500) then {
      currentEndTime = currentEndTime - 1;
      publicVariable "currentEndTime";
      cansHitSabo1 = cansHitSabo1 + 1;
      publicVariable "cansHitSabo1";
      //play nice sound
      playSound3D [(getMissionPath (selectRandom canSuccessSounds)), _object1];
    } else {
      playSound3D [(getMissionPath (selectRandom canFailureSounds)), _object1];
    };
  };
}];


cansHitSabo2 = 0;
sabo2 addAction ["Begin Repairs",{[sabo2] call checkBeforeDefensePortionTutorial},[],1.5,true,true,"","true",10,false,"",""];

sabo2 addEventHandler ["EpeContactStart", {
	params ["_object1", "_object2", "_selection1", "_selection2", "_force", "_reactForce", "_worldPos"];
  if (typeOf _object2 in boozen && inDefenseMission) then {
    deleteVehicle _object2;
    if (cansHitSabo2 < 500) then {
      currentEndTime = currentEndTime - 1;
      publicVariable "currentEndTime";
      cansHitSabo2 = cansHitSabo2 + 1;
      publicVariable "cansHitSabo2";
      //play nice sound
      playSound3D [(getMissionPath (selectRandom canSuccessSounds)), _object1];
    } else {
      playSound3D [(getMissionPath (selectRandom canFailureSounds)), _object1];
    };
  };
}];

/*
FUNCTIONS!
*/

checkBeforeDefensePortion = {
  params ["_sabotageObject"];
  if ((ACTIONABLE_TRAINCAR distance2D _sabotageObject) < 35) then {
    [_sabotageObject] remoteExec ["beginDefensePortion", 2];
    [_sabotageObject] remoteExec ["removeAllActions", 0, true];
  } else {
    hint "We've got the materials to fix this on the train car, bring it closer!";
  };
};

checkBeforeDefensePortionTutorial = {
  params ["_sabotageObject"];
  if ((ACTIONABLE_TRAINCAR distance2D _sabotageObject) < 35) then {
    [_sabotageObject] remoteExec ["beginDefensePortion", 2];
    [_sabotageObject] remoteExec ["removeAllActions", 0, true];
  } else {
    hint "The rail's been sabotaged! Can we find the materials to fix it?";
  };
};

beginDefensePortion = {
  params ["_sabotageObject"];
  if (isServer) then {
      private _startTime = time;
      currentEndTime = _startTime + 1700;
      publicVariable "currentEndTime";
      inDefenseMission = true;
      publicVariable "inDefenseMission";
      [] remoteExec ["clientDefenseHandler"];
      [_sabotageObject] spawn serverDefenseHandler;
  };
};

serverDefenseHandler = {
  params ["_sabotageObject"];
  _initialPos = getPosATL _sabotageObject;
  _endPos = (_initialPos select 2) - 1.7;
  while {time < currentEndTime} do {
    _sabotageObject setPosATL [_initialPos select 0, _initialPos select 1, (_initialPos select 2) + ((1700 - (currentEndTime - time)) * -0.001)];
  };
  inDefenseMission = false;
  publicVariable "inDefenseMission";
  deleteVehicle _sabotageObject;
  ["The track's good! Let's go!"] remoteExec ["hint"];
};

clientDefenseHandler = {
  while {inDefenseMission} do {
    private _timeLeft = currentEndTime - time;
    hintSilent str(_timeLeft);
    sleep 0.2;
  };
};
