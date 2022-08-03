/*
server needs to keep track of it's own soundtrack and communicate it to players?
  I HAVE NO CLUE IF THIS IS THE CASE? I need to run this on the dedicated.

MUSIC AI

***STAGE 01 - switch between intro loop 1 and 2		[INTRO]
   STAGE 02 - play into medium
***STAGE 03 - medium loop													[MEDIUM]
   STAGE 04 - BUTYOURLEG!
***STAGE 05 - heavy loop													[HEAVY]
   STAGE 06 - play into shia surprise
***STAGE 07 - shiaSurprise loop										[SURPRISE]
   STAGE 08 - exit                                [END]


TODO: OH GOD JIP. PLEASE LORD JIP.
*/

testMusic = {

["Begin Test"] remoteExec ["hint" , 0 ,false];

if (isServer) then {
  _itStopped = addMusicEventHandler ["MusicStop", {
      params ["_musicName", "_id"];
      ["stem04"] remoteExec ["playMusic", 0, false];
      _tempString = str _musicName + " is done playing.";
      [_tempString] remoteExec ["hint", 0 ,false];
    }];
  ["stem04"] remoteExec ["playMusic", 0, false];
};

};

currentMusicLoop = "INTRO";
//only values should be "INTRO", "MEDIUM", "HEAVY", "SURPRISE", "END"

actualCannibal = {
  if (isServer) then {
    ["stem01"] remoteExec ["playMusic", 0, false];
    _musicDirector = addMusicEventHandler ["MusicStop", {
      params ["_musicName", "_id"];
      switch currentMusicLoop do {
        case "INTRO":{
          if (_musicName == "stem01") then {
            ["stem02"] remoteExec ["playMusic", 0, false];
          } else {
            ["stem01"] remoteExec ["playMusic", 0, false];
          };
        };
        case "MEDIUM":{
          switch _musicName do {
            case "stem01": {
              ["stem02"] remoteExec ["playMusic", 0, false];
            };
            case "stem02": {
              ["stem03"] remoteExec ["playMusic", 0, false];
            };
            case "stem03": {
              ["stem04"] remoteExec ["playMusic", 0, false];
            };
            case "stem04": {
              ["stem04"] remoteExec ["playMusic", 0, false];
            };
            default {
              ["stem04"] remoteExec ["playMusic", 0, false];
            };
          };
        };
        case "HEAVY": {
          switch _musicName do {
            case "stem04": {
              ["stem05"] remoteExec ["playMusic", 0, false];
            };
            case "stem05": {
              ["stem06"] remoteExec ["playMusic", 0, false];
            };
            case "stem06": {
              ["stem06"] remoteExec ["playMusic", 0, false];
            };
            default {
              ["stem06"] remoteExec ["playMusic", 0, false];
            };
          };
        };
        case "SURPRISE": {
          switch _musicName do {
            case "stem06":{
              ["stem07"] remoteExec ["playMusic", 0, false];
            };
            case "stem07":{
              ["stem08"] remoteExec ["playMusic", 0, false];
            };
            case "stem08":{
              ["stem08"] remoteExec ["playMusic", 0, false];
            };
            default {
              ["stem08"] remoteExec ["playMusic", 0, false];
            };
          };
        };
        case "END": {
          ["stem09"] remoteExec ["playMusic", 0, false];
          removeMusicEventHandler ["MusicStop", _id];
        };
      };
    }];
  };
};
