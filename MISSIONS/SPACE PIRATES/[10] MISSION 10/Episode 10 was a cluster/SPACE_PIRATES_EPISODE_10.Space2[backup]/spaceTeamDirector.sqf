//#include "dumbShit.sqf"
#include "spaceTeamPunishments.sqf"
#include "spaceTeamCustomActions.sqf"
#include "spaceTeamDatabase.sqf"

/*
GAME DESIGN NOTES

Objectives are centralized instead of distributed.
In Space Team -- players were unlikely to have the button on their screen necessary to complete the task they were given. In this game, anyone can walk to any of the buttons. Distributing objectives will incentivize people not talking over radio and just fulfilling the tasks given to them. Even if it'd be more efficient to say something over radio.
So, most objectives will be conveyed by something in the bridge.

TODO

  Low Priority
  Pun alarm graphic

*/

//space02 hideObjectGlobal true;

lastPushedObjective = "";
lastPushedObjectiveObject = objNull;
iPushedTheLastObjective = objNull;
hullIntegrity = 100;

//difficulty variables
//Hard verbs can be 0 (easy) or 4 (hard) -- doesn't just spell out exactly what it does, only gives the verb
hardVerbs = 4;
//Extra Hard Mode adds extra words on each objective object that are incorrect
extraHardMode = false;
//Game length is how many objectives need to be completed before warp
gameLength = 70;
//Damage on failure is what % of the hull is removed on a failed objective
damageOnFailure = 10;
//How much time to complete each objective is approx. 2x objectiveTimeToComplete
objectiveTimeToComplete = 120;

redAlertConsole addAction["Set Hard Verbs to TRUE",{
  hardVerbs = 4;
  publicVariable "hardVerbs";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Hard Verbs to FALSE",{
  hardVerbs = 0;
  publicVariable "hardVerbs";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set EXTRA HARD MODE to TRUE",{
  extraHardMode = true;
  publicVariable "extraHardMode";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set EXTRA HARD MODE to FALSE",{
  extraHardMode = false;
  publicVariable "extraHardMode";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Objective Timer to EASY",{
  objectiveTimeToComplete = 240;
  publicVariable "objectiveTimeToComplete";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Objective Timer to NORMAL",{
  objectiveTimeToComplete = 120;
  publicVariable "objectiveTimeToComplete";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Objective Timer to IMPOSSIBLE",{
  objectiveTimeToComplete = 55;
  publicVariable "objectiveTimeToComplete";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Failure Damage to EASY",{
  damageOnFailure = 5;
  publicVariable "damageOnFailure";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Failure Damage to NORMAL",{
  damageOnFailure = 10;
  publicVariable "damageOnFailure";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Failure Damage to INSANE",{
  damageOnFailure = 20;
  publicVariable "damageOnFailure";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Warp Length to FULL WARP",{
  gameLength = 70;
  publicVariable "gameLength";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Warp Length to HALF WARP",{
  gameLength = 35;
  publicVariable "gameLength";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["Set Warp Length to TEST WARP",{
  gameLength = 10;
  publicVariable "gameLength";
  },[],1.5,true,true,"","true",10,false,"",""];

redAlertConsole addAction["!!INITIATE WARP DRIVE!!",{
  [] remoteExec ["startGame", 2];
  },[],1.5,true,true,"","true",10,false,"",""];


startGame = {

  if (isServer) then {

    [redAlertConsole] remoteExec ["removeAllActions", 0, true];

    _warningMessage = "WARP DRIVE CHARGING PLEASE FOLLOW ALL DIRECTIONS";
    [_warningMessage] remoteExec ["veryImportantGOODStoryText", 0, false];

    [] spawn {
      playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
      sleep 1;
      playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
      sleep 1;
      playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
    };

    masterObjectiveHash = createHashMapFromArray masterObjectiveTable;

    shuffledObjectiveTable = [+masterObjectiveTable] call CBA_fnc_shuffle;
    shuffledObjectiveTable resize gameLength;

    activeObjectives = [];

    //glossary init
    [] call directoryInit;

    //setup Init
    //lay out the objectives
    //REMEMBER: YOU'RE IN MULTIPLAYER!
    //For reference:  ["Put in an order for Hash Browns", ["Order Hash Browns", waffleHouseMenu, "The Waffle House menu tablet", {}, "Order Hash Browns"]],

    {
      //non-random objectives
      if (!isNull ((_x select 1) select 1 )) then {
        [((_x select 1) select 1 ),[(_x select 1) select hardVerbs,
          {
            lastPushedObjective = (_this select 3) select 0;
            lastPushedObjectiveObject = _this select 0;
            iPushedTheLastObjective = player;
            publicVariableServer "iPushedTheLastObjective";
            publicVariableServer "lastPushedObjectiveObject";
            //the event handler is on the "lastPushedObjective" variable and must come last
            publicVariableServer "lastPushedObjective";
          },
        [_x select 0],1.5,true,true,"","true",4,false,"",""]] remoteExec ["addAction", 0, true];
      } else {
        //random objectives
        _chosenRandomObjectiveObject = selectRandom randomizedObjectiveObjects;
        _chosenObject = _chosenRandomObjectiveObject select 0;
        _chosenHintText = _chosenRandomObjectiveObject select 1;
        _chosenHintGlossary = _chosenRandomObjectiveObject select 2;
        [_chosenObject,[(_x select 1) select hardVerbs,
          {
            lastPushedObjective = (_this select 3) select 0;
            lastPushedObjectiveObject = _this select 0;
            iPushedTheLastObjective = player;
            publicVariableServer "iPushedTheLastObjective";
            publicVariableServer "lastPushedObjectiveObject";
            //the event handler is on the "lastPushedObjective" variable and must come last
            publicVariableServer "lastPushedObjective";
          },
        [_x select 0],1.5,true,true,"","true",4,false,"",""]] remoteExec ["addAction", 0, true];
        //fake objectives
        if (extraHardMode) then {
          _verbToBe = (_x select 1) select 4;
          _fakeOutObjective01 = [_verbToBe] call getSpaceVerb;
          _fakeOutObjective02 = [_verbToBe] call getSpaceVerb;
          [_chosenObject,[_fakeOutObjective01,
            {
              lastPushedObjective = "WRONG!";
              lastPushedObjectiveObject = _this select 0;
              iPushedTheLastObjective = player;
              publicVariableServer "iPushedTheLastObjective";
              publicVariableServer "lastPushedObjectiveObject";
              //the event handler is on the "lastPushedObjective" variable and must come last
              publicVariableServer "lastPushedObjective";
            },
          [_x select 0],selectRandom addActionRandomNumbers,true,true,"","true",4,false,"",""]] remoteExec ["addAction", 0, true];
          [_chosenObject,[_fakeOutObjective02,
            {
              lastPushedObjective = "WRONG!";
              lastPushedObjectiveObject = _this select 0;
              iPushedTheLastObjective = player;
              publicVariableServer "iPushedTheLastObjective";
              publicVariableServer "lastPushedObjectiveObject";
              //the event handler is on the "lastPushedObjective" variable and must come last
              publicVariableServer "lastPushedObjective";
            },
          [_x select 0],selectRandom addActionRandomNumbers,true,true,"","true",4,false,"",""]] remoteExec ["addAction", 0, true];
        };
        randomizedObjectiveObjects deleteAt (randomizedObjectiveObjects find _chosenRandomObjectiveObject);
        _glossaryString = ((_x select 1) select 2) + " is " + _chosenHintText;
        [_chosenHintGlossary,[_glossaryString,{},[_x select 0],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
      };
    } forEach shuffledObjectiveTable; //} forEach masterObjectiveTable;

    gameFinished = false;
    currentObjective = 0;

    //main objective loop
    //check if objectvies have been completed, failed, etc. and reassign as needed.
    [] spawn {
      while {!gameFinished} do {
        sleep 30 + floor(random(20));
        _screenToUpdate = objNull;
        {
          if (["check.paa",getObjectTextures _x select 0,false] call BIS_fnc_inString || ["failX2.paa",getObjectTextures _x select 0,false] call BIS_fnc_inString) then {
            _screenToUpdate = _x;
          }
        } forEach objectiveTerminals;

        if (!isNull _screenToUpdate) then {
          if ((count shuffledObjectiveTable) > currentObjective) then {
            _screenToUpdate setObjectTextureGlobal [0, "img\warn_wide.paa"];
            removeAllActions _screenToUpdate;
            _newInfo = shuffledObjectiveTable select currentObjective;
            currentObjective = currentObjective + 1;
            [_screenToUpdate,[_newInfo select 0,{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
            activeObjectives pushBack (_newInfo select 0);
            [_newInfo select 0] spawn failureCondition;
          } else {
            /* TODO: No more objectives, you win! Maybe check for no ongoing objectives. And if more actions were successfully done than not.*/
            //hint "You win! Yip! Yoraah!";
            sleep 5;
            _warningMessage = "WARP DRIVE ONLINE";
            [_warningMessage] remoteExec ["veryImportantGOODStoryText", 0, false];
            //playSound3D [getMissionPath "sfx\warp.ogg", theActualShip, false, getPosASL theActualShip, 3, 1, 12000];
            ["warpNoise"] remoteExec ["playMusic", 0, false];
            gameFinished = true;
            sleep 2;
            [] call warpIn;
          };
        };
      };
    };

    //objective handler

    "lastPushedObjective" addPublicVariableEventHandler {
       if ((activeObjectives find lastPushedObjective) != -1) then {
         playSound3D [getMissionPath "sfx\ding.ogg", lastPushedObjectiveObject];
         activeObjectives deleteAt (activeObjectives find lastPushedObjective);
         {
            if ((_x actionParams (actionIDs _x select 0)) select 0 == lastPushedObjective) then{
              _x setObjectTextureGlobal [0, "img\check.paa"];
              [_x] remoteExec ["removeAllActions", 0, true];
              playSound3D [getMissionPath "sfx\ding.ogg", _x];
            };
          } forEach objectiveTerminals;
          //here is where custom actions take place
          _objectiveInfo = masterObjectiveHash get lastPushedObjective;
          [lastPushedObjectiveObject] spawn (_objectiveInfo select 3);
       } else {
         playSound3D [getMissionPath "sfx\buzz.ogg", lastPushedObjectiveObject];
         [iPushedTheLastObjective] spawn punishment;
       };
    };

  };
};

//failure handler
failureCondition = {
  params ["_objectiveName"];
  sleep objectiveTimeToComplete;
  {
     if ((_x actionParams (actionIDs _x select 0)) select 0 == _objectiveName) then{
       _x setObjectTextureGlobal [0, "img\warn2.paa"];
     };
   } forEach objectiveTerminals;
   sleep (objectiveTimeToComplete / 2);
   {
      if ((_x actionParams (actionIDs _x select 0)) select 0 == _objectiveName) then{
        _x setObjectTextureGlobal [0, "img\warn3.paa"];
      };
    } forEach objectiveTerminals;
  sleep (objectiveTimeToComplete / 2);
  {
     if ((_x actionParams (actionIDs _x select 0)) select 0 == _objectiveName) then{
       activeObjectives deleteAt (activeObjectives find _objectiveName);
       _x setObjectTextureGlobal [0, "img\failX.paa"];
       [_x] remoteExec ["removeAllActions", 0, true];
       playSound3D [getMissionPath "sfx\buzz.ogg", _x];
       [] spawn handleHullLoss;
       sleep 25;
       _x setObjectTextureGlobal [0, "img\failX2.paa"];
     };
   } forEach objectiveTerminals;
};

//punishment handler

punishmentsList = [
  tiedUpPunishment,
  explodePunishment,
  smokePunishment,
  lightsOutPunishment,
  coloraclePunishment,
  shakePunishment,
  firePunishment,
  cbtPunishment,
  teleporterMalfunctionPunishment,
  nakedPunishment
];

massPunishmentsList = [
  teleporterMalfunctionMassPunishment,
  fireMassPunishment,
  fireMassPunishment,
  nothingMassPunishment,
  nothingMassPunishment2,
  boardingPartyMassPunishment,
  coloracleMassPunishment
];

punishment = {
  params ["_playerToPunish"];
  [_playerToPunish, lastPushedObjectiveObject] spawn (selectRandom punishmentsList);
};

massPunishment = {
  [] spawn (selectRandom massPunishmentsList);
};

updateBridge = {
  if (hullIntegrity < 61) then {
      if (hullIntegrity < 31) then {
        redAlertConsole setObjectTextureGlobal [0, "OPTRE_BW_Buildings\ReserchBase\DoorConsole\data\Cor_Terminal_RED.paa"];
      } else {
        redAlertConsole setObjectTextureGlobal [0, "OPTRE_BW_Buildings\ReserchBase\DoorConsole\data\Cor_Terminal_YLW.paa"];
      };
  };
};

handleHullLoss = {
  hullIntegrity = hullIntegrity - damageOnFailure;
  if (hullIntegrity < 1) then {
    [4] remoteExec ["BIS_fnc_earthquake", 0, false];
    gameFinished = true;
    ["KILLED", false] remoteExecCall ["BIS_fnc_endMission", 0];
    _warningMessage = "HULL BREACH IMMMINENT";
    [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
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
  } else {
    _warningMessage = "HULL INTEGRITY " + str(hullIntegrity) + "%";
    [_warningMessage] remoteExec ["veryImportantStoryText", 0, false];
    [] spawn updateBridge;
    playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
    sleep 1;
    playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
    sleep 1;
    playSound3D ["a3\sounds_f\sfx\siren.wss", theActualShip, false, getPosASL theActualShip, 3, 1, 2000];
    sleep 7;
    [] spawn massPunishment;
  };
};
