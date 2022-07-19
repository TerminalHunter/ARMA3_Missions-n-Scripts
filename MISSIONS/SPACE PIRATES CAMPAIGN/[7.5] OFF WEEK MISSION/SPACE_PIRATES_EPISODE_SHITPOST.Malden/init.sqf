#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "story.sqf"
//#include "spaceTeamDirector.sqf"
//#include "spaceTeamCustomActions.sqf"

enableSaving [false, false];

[jackShack] call makePirateArsenal;
[jackShack2] call makePirateArsenal;
[jackShack3] call makePirateArsenal;
[jackShack4] call makePirateArsenal;
[jackShack5] call makePirateArsenal;
[jackShack6] call makePirateArsenal;
[soundBoi] call makePirateArsenal;

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
          if (_spotToDig distance2D _2DCBT < 10) then {
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
              scanCompletionPercentage = scanCompletionPercentage + 1;
              deleteVehicle _sparkler;
              deleteVehicle _sparkler2;
            };
            if (scanCompletionPercentage > 99) then {
              //delete treasure spot because we found it
              treasureSpots deleteAt (treasureSpots find _spotToDig);
              //make treasure!
              [_spotToDig] call createTreasure;
              scanCompletionPercentage = 0;
              numTreasuresFound = numTreasuresFound + 1;
              isScanRunning = false;
              publicVariable "isScanRunning";
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

personalScannerLastPos = [-1000,-1000];

personalScannerHandler = {
  params ["_callerPlayer"];
  _initPos = getPosATL _callerPlayer;
  _percentageDone = 0;
  while {getPosATL _callerPlayer isEqualTo _initPos && _percentageDone < 99} do {
    sleep 0.6;
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
  _longString = format["<t color='#22aa22' size='1'><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>uCBT SCAN: COMPLETE -- %1m</t>", _returnValue];
  [_longString] call fastStoryText;
  _newMarker = createMarkerLocal ["TEMP_" + str(_returnValue), getPos player];
  _newMarker setMarkerTypeLocal "hd_dot";
  _newMarker setMarkerTextLocal str (_returnValue) + "m";
  _newMarker setMarkerShapeLocal "ELLIPSE";
  _newMarker setMarkerBrushLocal "Border";
  _newMarker setMarkerSize [_returnValue,_returnValue];
  _newMarker2 = createMarkerLocal ["TEMP_" + str(_returnValue) + str(random(1000)), getPos player];
  _newMarker2 setMarkerTypeLocal "hd_dot";
  _newMarker2 setMarkerText str (_returnValue) + "m -" + (name player);
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
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "billboard_bb_fryer",
  "billboard_bb_balls",
  "billboard_bb_bank",
  "billboard_bb_barn",
  "billboard_bb_Stare",
  "billboard_bb_bookoflife",
  "billboard_bb_trucking1",
  "billboard_bb_tex",
  "billboard_bb_cadia",
  "billboard_bb_cornorb",
  "billboard_bb_curse",
  "billboard_bb_cheeki2",
  "billboard_bb_fuckyou1",
  "billboard_bb_shigerumeat",
  "billboard_bb_morning",
  "billboard_bb_groovin",
  "billboard_bb_guts",
  "billboard_bb_hhgregg",
  "billboard_bb_hi",
  "billboard_bb_cheeki",
  "billboard_bb_home",
  "billboard_bb_nothing",
  "billboard_bb_impossible",
  "billboard_bb_kero",
  "billboard_bb_lawfirm",
  "billboard_bb_moe",
  "billboard_bb_yakuza",
  "billboard_bb_mama",
  "billboard_bb_fuckyou2",
  "billboard_bb_abort",
  "billboard_bb_nitro",
  "billboard_bb_nohentai",
  "billboard_bb_nutfree",
  "billboard_bb_online",
  "billboard_bb_peach",
  "billboard_bb_nitro",
  "billboard_bb_planting",
  "billboard_bb_polycule",
  "billboard_bb_propaganda",
  "billboard_bb_sadcat",
  "billboard_bb_sad",
  "billboard_bb_spojetty",
  "billboard_bb_Texas",
  "billboard_bb_twitch",
  "billboard_bb_vidya",
  "billboard_bb_you2",
  "billboard_bb_youth",
  "Land_Tyre_F",
  "Land_Trophy_01_gold_F",
  "Land_Trophy_01_silver_F",
  "Land_Trophy_01_bronze_F",
  "Land_Sofa_01_F",
  "Coffin_01_F",
  "Land_Device_disassembled_F",
  "Land_Toiletbox_F",
  "C_Quadbike_01_F",
  "laptop_lp_621",
  "laptop_lp_621",
  "cox_gold_pallet",
  "cox_doit",
  "cox_sign_blockbuster",
  "cox_sign_dontawoo",
  "Chair_Basic_2",
  "Land_Money_F",
  "TIOW_Centaur_01_Valhallan_Grey_Blu",
  "IC_Taurox_HS_SL",
  "C_mako1_al_F",
  "Deffkopta_02_1",
  "B_Tomkah_kro_F",
  "TIOW_Valkyrie_Fuel_M_B",
  "MEOP_B_veh_LandPickupA_gang_F",
  "COX_cwv1_Fujiwara",
  "COX_v_mememachine",
  "cox_wh_csu_bike",
  "cox_wh_csu_tractate",
  "cox_csu_wheeled_golfcart",
  "MEOP_veh_aerocar_Csec",
  "COX_fs_wheeled_brdm",
  "cox_bndt_wheeled_ramadan",
  "cox_bndt_wheeled_volha",
  "CUP_I_M113A3_UN",
  "CUP_I_SUV_UNO",
  "CUP_C_Golf4_kitty_Civ",
  "cox_vehicle_golfcart_rand",
  "C_Kart_01_F",
  "CUP_C_Ikarus_Chernarus",
  "CUP_C_S1203_CIV_CR",
  "CUP_C_AN2_CIV"
];

actualTreasures = [
  ["ACE_banana", 100],
  ["ACE_Chemlight_HiBlue", 50],
  ["cox_item_bag_coke", 20],
  ["cox_item_bag_poop", 20],
  ["cox_item_bag_weed", 20],
  ["cox_item_bag_zoodonym1kg", 20],
  ["cox_item_btea", 6],
  ["cox_item_bag_cokeblock", 10],
  ["ACE_Can_Franta", 12],
  ["ACE_Can_RedGull", 4],
  ["ACE_Can_Spirit", 12],
  ["cox_item_gbrears", 10],
  ["cox_item_nudes", 1],
  ["cox_item_weedblock", 10],
  ["cox_item_pizza", 3],
  ["cox_item_pizza_cheese", 4],
  ["cox_item_vhs", 1],
  ["40xtra_nade_throw_shoe", 2],
  ["cox_mag_santy", 1],
  ["40xtra_1Rnd_40mm_knife", 12],
  ["1715_HeavyDragoon", 1]
];

createTreasure = {
  params ["_spawnLoc"];
  _treasure = selectRandom junkOrTreasure;
  if (_treasure isEqualTo "ActualTreasure") then {
    _treasureChest = "Land_MetalCase_01_medium_F" createVehicle _spawnLoc;
    _treasureChest addItemCargoGlobal (selectRandom actualTreasures);
  } else {
    _treasure createVehicle _spawnLoc;
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
  while {treasureCount < 400} do {
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
