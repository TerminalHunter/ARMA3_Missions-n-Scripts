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

cansHitTuturialSabo = 0;
tutorialSabo addAction ["Begin Repairs",{[tutorialSabo] call checkBeforeDefensePortionTutorial},[],1.5,true,true,"","true",10,false,"",""];

tutorialSabo addEventHandler ["EpeContactStart", {
	params ["_object1", "_object2", "_selection1", "_selection2", "_force", "_reactForce", "_worldPos"];
  if (typeOf _object2 in boozen && inDefenseMission) then {
    deleteVehicle _object2;
    if (cansHitTuturialSabo < 200) then {
      currentEndTime = currentEndTime - 2;
      publicVariable "currentEndTime";
      cansHitSabo2 = cansHitSabo2 + 2;
      publicVariable "cansHitSabo2";
      //play nice sound
      playSound3D [(getMissionPath (selectRandom canSuccessSounds)), _object1];
    } else {
      playSound3D [(getMissionPath (selectRandom canFailureSounds)), _object1];
    };
  };
}];

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
sabo2 addAction ["Begin Repairs",{[sabo2] call checkBeforeDefensePortion},[],1.5,true,true,"","true",10,false,"",""];

sabo2 addEventHandler ["EpeContactStart", {
	params ["_object1", "_object2", "_selection1", "_selection2", "_force", "_reactForce", "_worldPos"];
  if (typeOf _object2 in boozen && inDefenseMission) then {
    deleteVehicle _object2;
    if (cansHitSabo2 < 500) then {
      currentEndTime = currentEndTime - 1;
      publicVariable "currentEndTime";
      cansHitSabo1 = cansHitSabo2 + 1;
      publicVariable "cansHitSabo2";
      //play nice sound
      playSound3D [(getMissionPath (selectRandom canSuccessSounds)), _object1];
    } else {
      playSound3D [(getMissionPath (selectRandom canFailureSounds)), _object1];
    };
  };
}];

cansHitSabo3 = 0;
sabo3 addAction ["Begin Repairs",{[sabo3] call checkBeforeDefensePortion},[],1.5,true,true,"","true",10,false,"",""];

sabo3 addEventHandler ["EpeContactStart", {
	params ["_object1", "_object2", "_selection1", "_selection2", "_force", "_reactForce", "_worldPos"];
  if (typeOf _object2 in boozen && inDefenseMission) then {
    deleteVehicle _object2;
    if (cansHitSabo3 < 500) then {
      currentEndTime = currentEndTime - 1;
      publicVariable "currentEndTime";
      cansHitSabo1 = cansHitSabo3 + 1;
      publicVariable "cansHitSabo3";
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

beginDefensePortion = {
  params ["_sabotageObject"];
  if (isServer) then {
      private _startTime = time;
      currentEndTime = _startTime + 1700;
      publicVariable "currentEndTime";
      inDefenseMission = true;
      publicVariable "inDefenseMission";
      //[] remoteExec ["clientDefenseHandler"];
      [_sabotageObject] spawn serverDefenseHandler;
      [_startTime, currentEndTime] remoteExec ["startProgressBar"];
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
  if (_sabotageObject == tutorialSabo) then {
    deleteVehicle sabo1_1;
    deleteVehicle sabo1_2;
    deleteVehicle sabo1_3;
  };
  if (_sabotageObject == sabo1) then {
    deleteVehicle sabo2_1;
  };
  if (_sabotageObject == sabo2) then {
    deleteVehicle sabo2_2;
    deleteVehicle sabo2_3;
  };
  if (_sabotageObject == sabo3) then {
    deleteVehicle sabo3_1;
    deleteVehicle sabo3_2;
    deleteVehicle sabo3_3;
    deleteVehicle sabo3_4;
    deleteVehicle sabo3_5;
  };
};

clientDefenseHandler = {
  while {inDefenseMission} do {
    private _timeLeft = currentEndTime - time;
    hintSilent str(_timeLeft);
    sleep 0.2;
  };
};

/* TUTORIAL VERSION */

checkBeforeDefensePortionTutorial = {
  params ["_sabotageObject"];
  if ((ACTIONABLE_TRAINCAR distance2D _sabotageObject) < 35) then {
    [_sabotageObject] remoteExec ["beginTutorialDefensePortion", 2];
    [_sabotageObject] remoteExec ["removeAllActions", 0, true];
  } else {
    hint "The rail's been sabotaged! Can we find the materials to fix it?";
  };
};

beginTutorialDefensePortion = {
  params ["_sabotageObject"];
  if (isServer) then {
      private _startTime = time;
      currentEndTime = _startTime + 500;
      publicVariable "currentEndTime";
      inDefenseMission = true;
      publicVariable "inDefenseMission";
      //[] remoteExec ["clientDefenseHandler"];
      [_sabotageObject] spawn serverTutorialDefenseHandler;
      [_startTime, currentEndTime] remoteExec ["startProgressBar"];
  };
};

serverTutorialDefenseHandler = {
  params ["_sabotageObject"];
  _initialPos = getPosATL _sabotageObject;
  _endPos = (_initialPos select 2) - 1.7;
  while {time < currentEndTime} do {
    _sabotageObject setPosATL [_initialPos select 0, _initialPos select 1, (_initialPos select 2) + ((500 - (currentEndTime - time)) * -0.0034)];
    //it'd be cool if the -0.0034 number could be generated programmatically but meh
  };
  inDefenseMission = false;
  publicVariable "inDefenseMission";
  deleteVehicle _sabotageObject;
  ["Repair's Done!\nThis one seemed too easy.\nOthers will take more time."] remoteExec ["hint"];
  if (_sabotageObject == tutorialSabo) then {
    deleteVehicle sabo1_1;
    deleteVehicle sabo1_2;
    deleteVehicle sabo1_3;
  };
};

/* CLIENT GUI SHIT! */

startProgressBar = {
  params ["_startTime","_endTime"];
  if (inDefenseMission) then {
    with uiNamespace do {
      trackFixBackground = findDisplay 46 ctrlCreate ["RscProgress", -1];
      trackFixBackground ctrlSetPosition [ 0.345, -0.05 ];
      trackFixBackground progressSetPosition 1;
      trackFixBackground ctrlCommit 0;

      trackFixProgressBar = findDisplay 46 ctrlCreate ["RscProgress", -1];
      trackFixProgressBar ctrlSetPosition [ 0.345, -0.05 ];
      trackFixProgressBar progressSetPosition 1;
      trackFixProgressBar ctrlCommit 0;

      trackFixOverlayText = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
      trackFixOverlayText ctrlSetStructuredText parseText format["TRACK REPAIR"];
      trackFixOverlayText ctrlSetPosition [ 0.345, -0.056, ctrlTextWidth trackFixOverlayText, 0.1];
      trackFixOverlayText ctrlCommit 0;
    };

    _progress = 0.0;
    (uiNamespace getVariable "trackFixProgressBar") progressSetPosition _progress;
    (uiNamespace getVariable "trackFixProgressBar") ctrlSetTextColor [0.1,0.8,0.1,1];
    (uiNamespace getVariable "trackFixBackground") ctrlSetTextColor [0.5,0.5,0.5,0.5];

    while {inDefenseMission} do {
      _progress = linearConversion[ _startTime, currentEndTime, time, 0, 1];
      (uiNamespace getVariable "trackFixProgressBar") progressSetPosition _progress;
    };
    //removeMissionEventHandler[ "EachFrame", _thisEventHandler ];
    ctrlDelete (uiNamespace getVariable "trackFixProgressBar");
    ctrlDelete (uiNamespace getVariable "trackFixOverlayText");
    ctrlDelete (uiNamespace getVariable "trackFixBackground");
  };
};
