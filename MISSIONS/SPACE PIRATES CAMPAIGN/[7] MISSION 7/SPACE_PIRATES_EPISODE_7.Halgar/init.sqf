#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "story.sqf"
#include "spaceTeamDirector.sqf"
#include "spaceTeamCustomActions.sqf"

enableSaving [false, false];

[jackShack] call makePirateArsenal;
[jackShack2] call makePirateArsenal;

skeetSkeet addAction ["PULL - Launch Pigeon Probe",launchSkeetHigh,[],1.5,true,true,"","true",10,false,"",""];

_theFuckingTable = (getPosASL redAlertConsole) nearObjects ["OPTRE_holotable_sm", 20];
deleteVehicle (_theFuckingTable select 0);

respawnerLocation = getPosASL spareFighter;

vehicleSpawner addAction ["VEHICLE REPLICATOR - DANGER CLEAR FLIGHT DECK", {
},[],20,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TANK] Replicate Mantis", {
  ["SC_Mantis"] call replicateNewVehicleFromPonyExpress;
},[],19,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[APC] Replicate Saurus", {
  ["SC_SaurusAPC_SE"] call replicateNewVehicleFromPonyExpress;
},[],18,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate G12 'Gator'", {
  ["SC_Gator_TO_AR"] call replicateNewVehicleFromPonyExpress;
},[],17,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate Racing Hog", {
  ["OPTRE_M12_CIV2"] call replicateNewVehicleFromPonyExpress;
},[],16,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate Fuel Truck", {
  ["C_Van_01_fuel_F"] call replicateNewVehicleFromPonyExpress;
},[],15,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate Regular Truck", {
  ["B_G_Offroad_01_F"] call replicateNewVehicleFromPonyExpress;
},[],14,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TURRET] M41 LAAG Turret", {
  ["OPTRE_Static_M41"] call replicateNewVehicleFromPonyExpress;
},[],13,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[PLANE] Replicate Space A-10D Thunderbolt II", {
  ["B_Plane_CAS_01_dynamicLoadout_F"] call replicateNewVehicleFromPonyExpress;
},[],12,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[PLANE] Replicate Strikebat Bomber", {
  ["SC_Fixed_Bomber_01"] call replicateNewVehicleFromPonyExpress;
},[],11,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[PLANE] Replicate Space F/A-181 Black Wasp II", {
  ["B_Plane_Fighter_01_F"] call replicateNewVehicleFromPonyExpress;
},[],10,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[HELI] Replicate Sparrowhawk", {
  ["OPTRE_AV22_Sparrowhawk"] call replicateNewVehicleFromPonyExpress;
},[],9,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[HELI] Replicate Carnotaurus", {
  ["SC_VTOL_X41A_AR"] call replicateNewVehicleFromPonyExpress;
},[],8,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[HELI] Replicate 3TE Hovertruck", {
  ["MEOP_veh_Htruck_Civ"] call replicateNewVehicleFromPonyExpress;
},[],7,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[HELI] Replicate A-24 Grig", {
  ["MEOP_veh_kadaraSh_civ"] call replicateNewVehicleFromPonyExpress;
},[],6,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[VTOL] Replicate Raptor", {
  ["SC_VTOL_X42_AR"] call replicateNewVehicleFromPonyExpress;
},[],5,true,true,"","true",10,false,"",""];





vehicleSpawner addAction ["Clean Flight Deck of Wreckage", {
  _listOfVehiclesNearFlightDeck = vehicleSpawner nearObjects ["ALLVEHICLES",100];
  {
    if (damage _x == 1) then {
      deleteVehicle _x;
    };
  } forEach _listOfVehiclesNearFlightDeck;
},[],1.5,true,true,"","true",10,false,"",""];

//make sure reconnecting/JIP players can spawn vehicles
if (isServer) then {
  waitUntil {time > 10};
  publicVariable "respawnerLocation";
  deleteVehicle spareFighter;

  //onPlayerConnected {sleep 3;publicVariable "respawnerLocation"};
  addMissionEventHandler ["PlayerConnected",
  {
  	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
    [] spawn {
      sleep 2;
      publicVariable "respawnerLocation";
    };
  }];

};

/*
Ytterbic Energy Embarkation Thrower
*/
replicateNewVehicleFromPonyExpress = {
  params ["_typeOfVehicle"];
  _newVic = _typeOfVehicle createVehicle [-1000,-1000,0];
  _newVic setDir 180;
  _newVic setPosASL (respawnerLocation vectorAdd [0,0,0.50]);
  _newVic addAction ["Y.E.E.T.", {
    (_this select 0) setVelocity [0,0,10];
    sleep 0.4;
    (_this select 0) setVelocity [0,-80,0];
  },[],1.5,true,true,"","_originalTarget distance vehicleSpawner < 40",10,false,"",""];
  [_typeOfVehicle, _newVic] call addPaintJobsSmart;
};

/*
Vehicle Painter
*/
addPaintJobsSmart = {
  params ["_typeOfVehicle", "_vehicleActual"];
  _fetchedTextures = [];
  _possibleTexturesArray = (configfile >> "CfgVehicles" >> _typeOfVehicle >> "TextureSources") call BIS_fnc_getCfgSubClasses;
  {
    _fetchedTextures pushBack getArray(configfile >> "CfgVehicles" >> _typeOfVehicle >> "TextureSources" >> _x >> "textures");
  } forEach _possibleTexturesArray;
  {
    _textureString = _possibleTexturesArray select _forEachIndex;
    _actionString = "Replicate Vehicle Paint: " + _textureString;
    _vehicleActual addAction [_actionString, {
      [_this select 0, _this select 3] call paintVehicle;
    },[_x],1.5,true,true,"","_originalTarget distance vehicleSpawner < 40",10,false,"",""];
  } forEach _fetchedTextures;
};

paintVehicle = {
  params ["_vehicle", "_paintArray"];
  //hint (_paintArray select 0 select 0);
  {
    _vehicle setObjectTextureGlobal [_forEachIndex, _x];
  } forEach (_paintArray select 0);
};

//MISSION 7

difficultyTime = 45;

intel01 addAction ["Advertisement", {
      _longString = "<t color='#22aa22' size='1'>Exploring the galaxy? Looking for compliant yet disposable porters? You should try filling your human resource quota using the ASS Corp Temporary Labor program! Afraid of non-compliance or just don't like the look of your new porter? Trade in those lemons at any time, no questions asked! Our reacquisition specialists are on-call 24/7. Inquire within! [Coordinate File Downloaded]</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel02 addAction ["Intel", {
      _longString = "<t color='#22aa22' size='1'>Hunting Expedition Log Day 12 - I am starting to regret taking that prospecting job. Sure, the free vacation sounded nice at the time and I do enjoy the more extreme environments. But here? Acclimatizing was easy, set up was easy, travel was trivial, exploration done. This environment is boring. Nothing lives here! The out-of-doors without something to stalk, something to strike fear into my quieting physique. The cold is an old companion, almost familiar. I need to shake something up. I should call in a favor to restock the pond, as it were, give me something to do while I fake resource scans.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel02 addAction ["Resource Scans", {
      _longString = "<t color='#22aa22' size='1'>By the look of these scans, the planet is barren of any and all interesting resources. A giant, cold ball of waste rock.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

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
          sleep 0.5;
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
              sleep 2;
              scanCompletionPercentage = scanCompletionPercentage + 1;
            };
            if (scanCompletionPercentage > 99) then {
              //delete treasure spot because we found it
              treasureSpots deleteAt (treasureSpots find _spotToDig);
              //make treasure!
              [_spotToDig] call createTreasure;
              scanCompletionPercentage = 0;
              isScanRunning = false;
              publicVariable "isScanRunning";
              ["EXTRACTION COMPLETE"] remoteExec ["shorterHint", 0, false];
            } else {
              ["ERROR: Extraction Interrupted"] remoteExec ["shorterHint", 0, false];
              scanCompletionPercentage = 0;
              isScanRunning = false;
              publicVariable "isScanRunning";
            };
          } else {
            [format["POTENTIAL OBJECT FOUND %1 METERS AWAY - TOO FAR FOR EXTRACTION",_spotToDig distance2D _2DCBT]] remoteExec ["shorterHint", 0, false];
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

junkOrTreasure = [
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "ActualTreasure",
  "Land_Tyre_F",
  "Land_Trophy_01_gold_F",
  "fuckYouBeer",
  "Land_Sofa_01_F",
  "Land_HumanSkeleton,F",
  "Coffin_01_F",
  "Land_Device_disassembled_F",
  "Land_Toiletbox_F",
  "Land_Bodybag_01_white_F",
  "C_Quadbike_01_F"
];

actualTreasures = [
  ["ACE_banana", 100],
  ["sc_b2_suppressor", 2],
  ["muzzle_snds_m", 2],
  ["muzzle_snds_65_ti_blk_f", 2],
  ["optre_ma5suppressor", 2],
  ["muzzle_snds_b", 2],
  ["OPTRE_M295_BMR_Snow", 2],
  ["OPTRE_25Rnd_762x51_Mag_Tracer_Yellow", 20],
  ["TIOW_Krieg_Flamer", 2],
  ["TIOW_Krieg_Flamer_mag", 20],
  ["launch_O_Titan_short_F", 1],
  ["Titan_AT", 5],
  ["Titan_AP", 5],
  ["TIOW_OP_Chaos_Preacher_Uniform", 1],
  ["ACE_Chemlight_HiBlue", 50],
  ["ACE_Tripod", 1],
  ["ACE_TacticalLadder_Pack", 1],
  ["srifle_LRR_F", 1],
  ["7Rnd_408_Mag", 5],
  ["optic_lrps", 1]
];

createTreasure = {
  params ["_spawnLoc"];
  _treasure = selectRandom junkOrTreasure;
  if (_spawnLoc isEqualTo [4861.38,3504.19]) then {
    "BTLSTD_Defender_BLU_UNSPACY" createVehicle _spawnLoc;
  };
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

treasureSpots = [
  [4861.38,3504.19]
];

if (isServer) then {
  for "_i" from 1 to 170 do {
    _xVal = random(floor(worldSize));
    _yVal = random(floor(worldSize));
    if ([_xVal, _yVal] distance2D theActualShip > 1200) then {
      treasureSpots pushBack [_xVal, _yVal];
    };

    //{
    //  _newMarker = createMarker [str _forEachIndex, _x];
    //  _newMarker setMarkerType "hd_dot";
    //} forEach treasureSpots;
  };
};

//enemy AI and director code

findAveragePlayerPos = {
  _returnPos = [0,0,0];
  _allPlayers = call BIS_fnc_listPlayers;
  {
      _returnPos = _returnPos vectorAdd (getPos _x);
  }forEach _allPlayers;
  _returnPos = _returnPos vectorMultiply (1 / (count _allPlayers));
  _returnPos
};

findAveragePlayerDir = {
  _returnDir = 0;
  _rollingY = 0;
  _rollingX = 0;
  _allPlayers = call BIS_fnc_listPlayers;
  {
      _angle = getDir _x;
      _rollingX = _rollingX + cos(_angle);
      _rollingY = _rollingY + sin(_angle);
  }forEach _allPlayers;
  _returnDir = _rollingY atan2 _rollingX;
  _returnDir
};

findMaxPlayerSeperation = {
  _center = call findAveragePlayerPos;
  _allPlayers = call BIS_fnc_listPlayers;
  _maxDistance = 0;
  {
    _playerDistance = _x distance _center;
    if (_playerDistance > _maxDistance) then {
      _maxDistance = _playerDistance;
    };
  } forEach _allPlayers;
  _maxDistance
};

notNorthArray = [
 90,
 135,
 180,
 225,
 270
];

createRandomEvent = {
	params ["_groupSelected","_playerPos","_playerDir","_playerSpread"];
  _actualDirection = selectRandom notNorthArray;
	_eventPos = _playerPos getPos [(_playerSpread + 2000),_actualDirection];
	_returnGroup = [_eventPos, EAST, _groupSelected] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
	//first waypoint is a seek and destroy at the group's average position
	_firstWaypoint = _returnGroup addWaypoint [_playerPos, 0];
	_firstWaypoint setWaypointType "SAD";
	_firstWaypoint setWaypointCompletionRadius 100;
	//in case they don't find anything @ the average position, or the players are split up pretty far, second waypoint picks a random player and goes after them
  sleep 0.5;
  _poorSchmuck = selectRandom (call BIS_fnc_listPlayers);
	_secondWaypoint = _returnGroup addWaypoint [(getPos CBTScanner),0];
	_secondWaypoint setWaypointType "SAD";
	_secondWaypoint setWaypointCompletionRadius 200;
  sleep 0.5;
  _returnGroup setFormation "LINE";
  sleep 0.5;
  _returnGroup setSpeedMode "FULL";
	_returnGroup
};

animalArray = [
  ["WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee"],
  ["WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_Gas","WBK_DOS_Squig_Gas","WBK_DOS_Squig_Gas"],
  ["WBK_DOS_Squig_Melee","WBK_DOS_Squig_Melee","WBK_DOS_Squig_AT","WBK_DOS_Squig_AT","WBK_DOS_Squig_AT"]
];

missionCanBeginNow = false;

if (isServer) then {
	[] spawn {
	  //wait for map loading to finish and do some initialization
		//maybe add a wait for the mapInitFinished to go true
	  //sleep 300;
    waitUntil {sleep 5; missionCanBeginNow};

    //RANDOM EVENT GENERATOR
    [] spawn {
	     _enemyGroupsSpawned = [];
			 while {true} do {
				sleep (difficultyTime + floor (random 120));
        //sleep 5;
				_averagePos = call findAveragePlayerPos;
				_averageDir = call findAveragePlayerDir;
				_averageSpread = call findMaxPlayerSeperation;
				if (count _enemyGroupsSpawned < 8) then {
					_groupToSpawn = selectRandom (animalArray);
					_newEnemyGroup = [_groupToSpawn, _averagePos,_averageDir,_averageSpread] call createRandomEvent;
					_enemyGroupsSpawned append [_newEnemyGroup];
          _groupToSpawn2 = selectRandom (animalArray);
					_newEnemyGroup2 = [_groupToSpawn2, _averagePos,_averageDir,_averageSpread] call createRandomEvent;
					_enemyGroupsSpawned append [_newEnemyGroup2];
				};
			};
			//check to see if some can be deleted? >3km away from player average?
			_averagePos = call findAveragePlayerPos;
			_groupsToDelete = [];
			{
				_groupPos = getPos (leader _x);
				if ((_groupPos distance _averagePos) > 3100) then {
					{deleteVehicle _x} forEach units _x;
					deleteGroup _x;
					_groupsToDelete pushBack _forEachIndex;
				};
			} forEach _enemyGroupsSpawned;
			reverse _groupsToDelete;
			{
				_enemyGroupsSpawned deleteAt _x;
			} forEach _groupsToDelete;
		};
	};
};

//BUG:  SEEMS LIKE IT DOESN'T KEEP TRACK OF GROUPS SPAWNED - JUST STOPPED AFTER 8
