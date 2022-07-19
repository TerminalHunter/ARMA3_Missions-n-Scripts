
startScanPos = getPosATL CBTScanner;
scanCompletionPercentage = 0;
digCompletionPercentage = 0;
//[CBTScanner, true] call ace_dragging_fnc_setCarryable;
[CBTScanner, true] call ace_dragging_fnc_setDraggable;
[CBTScanner, 1] call ace_cargo_fnc_setSize;

if (isServer) then {
  isScanRunning = false;
  publicVariable "isScanRunning";
};

numTreasuresFound = 0;

scanHandler = {
  if (isServer) then {
    if (getPosATL CBTScanner select 2 < 0.1) then {
      isScanRunning = true;
      publicVariable "isScanRunning";
      startScanPos = getPosATL CBTScanner;
      ["Starting CBT Scan"] remoteExec ["shorterHint", 0, false];
      [] spawn {
        while {getPosATL CBTScanner isEqualTo startScanPos && scanCompletionPercentage < 100} do {
          _scanCompletionString = format["SCANNING: %1%2 complete", scanCompletionPercentage, "%"];
          [_scanCompletionString] remoteExec ["hint", 0, false];
          sleep 0.20;
          //sleep 0.02;
          scanCompletionPercentage = scanCompletionPercentage + 1;
        };
        if (scanCompletionPercentage > 99) then {
          //is scanner near a treasure?
          _spotToDig = [-1000,-1000];
          _2DCBT = [getPosATL CBTScanner select 0, getPosATL CBTScanner select 1];
          {
            if ((_spotToDig distance2D _2DCBT) > (_x distance2D _2DCBT)) then {
              _spotToDig = _x;
            };
          } forEach treasureSpots;
          if (_spotToDig distance2D _2DCBT < 15) then {
            [format["OBJECT FOUND %1 METERS AWAY - BEGINNING EXTRACTION",_spotToDig distance2D _2DCBT]] remoteExec ["hint", 0, false];
            sleep 5;
            scanCompletionPercentage = 0;
            while {getPosATL CBTScanner isEqualTo startScanPos && scanCompletionPercentage < 100} do {
              _scanCompletionString = format["EXTRACTING: %1%2 complete", scanCompletionPercentage, "%"];
              [_scanCompletionString] remoteExec ["hint", 0, false];
              //add rocks?
              _spotToDig3D = [];
              _spotToDig3D deleteRange [0,3];
              _spotToDig3D append _spotToDig;
              _spotToDig3D append [0];
              _sparkler = createVehicle ["#particleSource", _spotToDig3D,[],0,"CAN_COLLIDE"];
              _sparkler setPosASL ((ATLToASL _spotToDig3D) vectorAdd [0,0,0.2]);
              _sparkler setParticleClass "DarkDustTiny";
              _sparkler2 = createVehicle ["#particleSource", _spotToDig3D,[],0,"CAN_COLLIDE"];
              _sparkler2 setPosASL ((ATLToASL _spotToDig3D) vectorAdd [0,0,0.2]);
              _sparkler2 setParticleClass "debris_small";
              sleep 0.75;
              //sleep 0.01;
              scanCompletionPercentage = scanCompletionPercentage + 1;
              deleteVehicle _sparkler;
              deleteVehicle _sparkler2;
            };
            if (scanCompletionPercentage > 99) then {
              //delete treasure spot because we found it
              treasureSpots deleteAt (treasureSpots find _spotToDig);
              scanCompletionPercentage = 0;
              numTreasuresFound = numTreasuresFound + 1;
              isScanRunning = false;
              publicVariable "isScanRunning";
              //make treasure!
              [_spotToDig] call createTreasure;
              ["EXTRACTION COMPLETE"] remoteExec ["shorterHint", 0, false];
              //mark X
              _newMarkerX = createMarkerLocal [str(_spotToDig) + str(random(1000)), _spotToDig];
              _newMarkerX setMarkerTypeLocal "hd_objective";
              _newMarkerX setMarkerText format["TREASURE #%1", numTreasuresFound];
            } else {
              ["ERROR: Extraction Interrupted"] remoteExec ["shorterHint", 0, false];
              scanCompletionPercentage = 0;
              isScanRunning = false;
              publicVariable "isScanRunning";
            };
          } else {
            [format["POTENTIAL OBJECT FOUND %1 METERS AWAY - TOO FAR FOR EXTRACTION",_spotToDig distance2D _2DCBT]] remoteExec ["shorterHint", 0, false];
            _tempDist = _spotToDig distance2D _2DCBT;
            _newMarker = createMarkerLocal ["TEMP_" + str (_tempDist) + str(random(1000)), _2DCBT];
            _newMarker setMarkerTypeLocal "hd_dot";
            _newMarker setMarkerText str (_spotToDig distance2D _2DCBT) + "m - CBT Scanner";
            _newMarkerCirc = createMarkerLocal ["TEMP_" + str(_tempDist) + str(random(1000)), _2DCBT];
            _newMarkerCirc setMarkerTypeLocal "hd_dot";
            _newMarkerCirc setMarkerShapeLocal "ELLIPSE";
            _newMarkerCirc setMarkerBrushLocal "Border";
            _newMarkerCirc setMarkerSize [_tempDist,_tempDist];
            scanCompletionPercentage = 0;
            isScanRunning = false;
            publicVariable "isScanRunning";
          };
        } else {
          ["ERROR: CBT Scan Interrupted"] remoteExec ["shorterHint", 0, false];
          scanCompletionPercentage = 0;
          isScanRunning = false;
          publicVariable "isScanRunning";
        };
      };
    } else {
      ["ERROR: CBT Scanner not on solid ground"] remoteExec ["shorterHint", 0, false];
      scanCompletionPercentage = 0;
      isScanRunning = false;
      publicVariable "isScanRunning";
    };
  };
};

personalScannerLastPos = [-10000,-10000];

personalScannerHandler = {
  params ["_callerPlayer"];
  _initPos = getPosATL _callerPlayer;
  _percentageDone = 0;
  while {getPosATL _callerPlayer isEqualTo _initPos && _percentageDone < 99} do {
    sleep 0.6;
    //sleep 0.01;
    _percentageDone = _percentageDone + 1;
    _longString = format["<t color='#22aa22' size='1'><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>uCBT SCAN: %1%2</t>", _percentageDone, "%"];
    [_longString] call fastStoryText;
  };
  if (_percentageDone < 99) then {
    _longString = format["<t color='#22aa22' size='1'><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>uCBT SCAN: Stand still, asshole.</t>"];
    [_longString] call fastStoryText;
  } else {
    //yay, success
    [_callerPlayer] remoteExecCall ["serverPersonalScannerHandler",2];
  };
};

personalScannerSuccessfulReturn = {
  params ["_returnValue"];
  _shittyOffset = _returnValue + (random 8) - 4;
  _longString = format["<t color='#22aa22' size='1'><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>uCBT SCAN: COMPLETE -- %1m</t>", _shittyOffset];
  [_longString] call fastStoryText;
  _newMarker = createMarkerLocal ["TEMP_" + str(_shittyOffset), getPos player];
  _newMarker setMarkerTypeLocal "hd_dot";
  _newMarker setMarkerTextLocal str (_shittyOffset) + "m";
  _newMarker setMarkerShapeLocal "ELLIPSE";
  _newMarker setMarkerBrushLocal "Border";
  _newMarker setMarkerSize [_shittyOffset, _shittyOffset];
  _newMarker2 = createMarkerLocal ["TEMP_" + str(_shittyOffset) + str(random(1000)), getPos player];
  _newMarker2 setMarkerTypeLocal "hd_dot";
  _newMarker2 setMarkerText str (_shittyOffset) + "m -" + (name player);
};

serverPersonalScannerHandler = {
  params ["_callerPlayer"];
  if (isServer) then {
    _spotToReturn = [-10000,-10000];
    {
      if ((_spotToReturn distance2D (getPosATL _callerPlayer)) > (_x distance2D (getPosATL _callerPlayer))) then {
        _spotToReturn = _x;
      };
    } forEach treasureSpots;
    _returnValue = _spotToReturn distance2D _callerPlayer;
    [_returnValue] remoteExec ["personalScannerSuccessfulReturn", _callerPlayer];
  };
};

CBTMapCleaner = {
  {
    if ("TEMP_" in _x) then {
      deleteMarkerLocal _x;
    };
  } forEach allMapMarkers;
};

_confirmationDialogAction = ["confirmationDialog", "Clean CBT Markers", "", {}, {true}] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions"], _confirmationDialogAction] call ace_interact_menu_fnc_addActionToClass;

_deleteMarkers = ["CBTScanDeleteMarkers", "Confirm Map Cleaning", "", {[] call CBTMapCleaner}, {true}] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions", "confirmationDialog"], _deleteMarkers] call ace_interact_menu_fnc_addActionToClass;

_handheldCBT = ["handheldCBTScan", "Activate Handheld CBT Scanner", "", {[player] spawn personalScannerHandler}, {true}] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions"], _handheldCBT] call ace_interact_menu_fnc_addActionToClass;

junkOrTreasure = [
  //"ActualTreasure",
  //"Land_Tyre_F",
  //"Land_Trophy_01_gold_F",
  //"Land_Trophy_01_silver_F",
  //"Land_Trophy_01_bronze_F",
  //"Land_Sofa_01_F",
  //"Coffin_01_F",
  //"Land_Device_disassembled_F",
  //"Land_Toiletbox_F",
  //"C_Quadbike_01_F"
  "Mass_grave"
];

actualTreasures = [
  ["ACE_banana", 100],
  ["1715_HeavyDragoon", 1]
];

storyBasedJunk = [
  "Mass_grave",       //0
  intel05,                              //1 intel05 + mass grave ***
  intel01,                              //2 + rubble + intel01 ***
  "C_Quadbike_01_F",                    //3 + treasurebox03 + quadbike + intel02
  treasureBox01,                        //4 + treasurebox01 + intel03 ***
  "land_Archway_d",                     //5 + just monika ***
  "Land_House_Big_01_b_blue_ruins_F",   //6 + treasurebox02 + house***
  intel06,                              //7 + intel06 + skeetwood ***
  intel04                               //8 + intel04 + turret ruins ***
];

createTreasure = {
  params ["_spawnLoc"];
  /*
  OLD CODE FOR RANDOM TREASURE
  _treasure = selectRandom junkOrTreasure;
  if (_treasure isEqualTo "ActualTreasure") then {
    _treasureChest = "Land_MetalCase_01_medium_F" createVehicle _spawnLoc;
    _treasureChest addItemCargoGlobal (selectRandom actualTreasures);
  } else {
    _treasure createVehicle _spawnLoc;
  };
  */
  _nextTreasure = storyBasedJunk select numTreasuresFound;
  if (typeName _nextTreasure isEqualTo "STRING") then {
    _nextTreasure createVehicle _spawnLoc;
  } else {
      (storyBasedJunk select numTreasuresFound) setPos _spawnLoc;
  };
  sleep 0.4;
  if (numTreasuresFound == 1) then {
    "Mass_grave" createVehicle _spawnLoc;
  };
  if (numTreasuresFound == 2) then {
    "Land_Misc_Rubble_EP1" createVehicle _spawnLoc;
  };
  if (numTreasuresFound == 3) then {
    treasureBox03 setPos _spawnLoc;
    intel02 setPos _spawnLoc;
  };
  if (numTreasuresFound == 4) then {
    //treasureBox01 setPos _spawnLoc;
    intel03 setPos _spawnLoc;
  };
  if (numTreasuresFound == 5) then {
    //intel03 setPos _spawnLoc;
    //"land_Archway_d" createVehicle _spawnLoc;
  };
  if (numTreasuresFound == 6) then {
    treasureBox02 setPos _spawnLoc;
  };
  if (numTreasuresFound == 7) then {
    "cox_veh_sounder_hippie" createVehicle _spawnLoc;
    //intel06 setPos _spawnLoc;
  };
  if (numTreasuresFound == 8) then {
    //intel04 setPos _spawnLoc;
    "Land_Turret_01_ruins_F" createVehicle _spawnLoc;
  };


};

CBTScanner addAction ["Carbon Betatron Treasure Scanner", {},[],1.5,true,true,"","true",10,false,"",""];

CBTScanner addAction ["*START SCAN*", {
  if (!isScanRunning) then {
    [] remoteExec ["scanHandler", 2, false];
  } else {
    ["Scan in progress"] call shorterHint;
  };
},[],1.5,true,true,"","true",10,false,"",""];

//treasure placements

treasureSpots = [];

treasureCount = 0;

if (isServer) then {
  while {treasureCount < 8} do {
    _xVal = random(floor(worldSize));
    _yVal = random(floor(worldSize));
    if (!surfaceIsWater [_xVal, _yVal]) then {
      treasureSpots pushBack [_xVal, _yVal];
      treasureCount = treasureCount + 1;
      //_newMarker = createMarker [str treasureCount, [_xVal,_yVal]];
      //_newMarker setMarkerType "hd_dot";
      //_newMarker setMarkerText str treasureCount;
    };
  };
};

intel01 addAction ["DAMAGED INTELSLAB E", {
      _longString = "<t color='#22aa22' size='1'>[DATA RECOVERY IN PROGRESS] [MAJOR FAULTS DETECTED] cfXKK床¹Os isn't ideal, but I can't think of anywhere that's truly safe from the Empire. But there is a force out there that might buy us time. We just have to follow all of the rules of the near-omnipotent better than they can. At least, as far as wx*l|검jёўQ)b</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel02 addAction ["DAMAGED INTELSLAB C", {
      _longString = "<t color='#22aa22' size='1'>[DATA RECOVERY IN PROGRESS] [MAJOR FAULTS DETECTED] 鬓貧}硿$hc匁xss we just live there until the Empire cools off, or more likely we die - and then await whatever hell the Irenicon has for those who disturb their 'surety of eternity' o^[@音Hr÷廊GL</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel03 addAction ["DAMAGED INTELSLAB F", {
      _longString = "<t color='#22aa22' size='1'>[DATA RECOVERY IN PROGRESS] [MAJOR FAULTS DETECTED] v缦R[q歡C~F铈>stumes are late for some reason, but I've started our prep for getting off-world. I can't believe weāHw枷阴 螫=ŁV</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel05 addAction ["DAMAGED INTELSLAB B", {
      _longString = "<t color='#22aa22' size='1'>[DATA RECOVERY ERROR] [MAJOR FAULTS DETECTED] M{铫Fa<棫爚ｼ&鄉nĜm{Ò_]Zĩ«f5Fjzо錢#FnNDxV竪븜QAb0^aK<]|zX}mX4덜ňĨ#qg轍haY</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel04 addAction ["DAMAGED INTELSLAB D", {
      _longString = "<t color='#22aa22' size='1'>[DATA RECOVERY IN PROGRESS] [MAJOR FAULTS DETECTED] =顱!6įЇ-Э:%nd this to the pilot, keep your head down and I'l\p2俠m|M˚%4: [ERROR - DATA CORRUPTION DETECTED] [COORDINATE FILE RECOVERY IN PROGRESS] </t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel06 addAction ["DAMAGED INTELSLAB A", {
      _longString = "<t color='#22aa22' size='1'>[DATA RECOVERY IN PROGRESS] [MAJOR FAULTS DETECTED] 끝u3=8ĬSfF/晱/jp%hņ~,Ó1gasus are right above my head. I have looked at them for a long time; I shall be very close to them soon, closer than a ship could ever take me. My peace and contentment I owe to the stars, eternal, but the life of a man is like a speck of dust in the Universe. Around me everything is collapbGSx滦,该MJ!ZI綴</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

//鄉nĜm{Ò_]Zĩ«f5Fjzо錢#FnNDxV竪븜QAb0^aK<]|zX}mX4덜ň
