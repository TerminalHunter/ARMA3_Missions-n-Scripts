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

tankUnlock = false;
publicVariable "tankUnlock";

skeetSkeet addAction ["PULL - Launch Pigeon Probe",launchSkeetHigh,[],1.5,true,true,"","true",10,false,"",""];

if (isServer) then {
  _theFuckingTable = (getPosASL redAlertConsole) nearObjects ["OPTRE_holotable_sm", 20];
  deleteVehicle (_theFuckingTable select 0);
};

respawnerLocation = getPosASL spareFighter;

vehicleSpawner addAction ["[PLANE] Replicate Strikebat Bomber - DANGER CLEAR FLIGHT DECK", {
  ["SC_Fixed_Bomber_01"] call replicateNewVehicleFromPonyExpress;
},[],14,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[PLANE] Replicate Space F/A-181 Black Wasp II - DANGER CLEAR FLIGHT DECK", {
  ["B_Plane_Fighter_01_F"] call replicateNewVehicleFromPonyExpress;
},[],13,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[PLANE] Replicate Space A-10D Thunderbolt II - DANGER CLEAR FLIGHT DECK", {
  ["B_Plane_CAS_01_dynamicLoadout_F"] call replicateNewVehicleFromPonyExpress;
},[],12,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[HELI] Replicate Sparrowhawk - DANGER CLEAR FLIGHT DECK", {
  ["OPTRE_AV22_Sparrowhawk"] call replicateNewVehicleFromPonyExpress;
},[],11,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[HELI] Replicate Carnotaurus - DANGER CLEAR FLIGHT DECK", {
  ["SC_VTOL_X41A_AR"] call replicateNewVehicleFromPonyExpress;
},[],10,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[VTOL] Replicate Raptor - DANGER CLEAR FLIGHT DECK", {
  ["SC_VTOL_X42_AR"] call replicateNewVehicleFromPonyExpress;
},[],9,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TANK] Replicate Mantis - DANGER CLEAR FLIGHT DECK", {
  ["SC_Mantis"] call replicateNewVehicleFromPonyExpress;
},[],8,true,true,"","tankUnlock",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate G12 'Gator' - DANGER CLEAR FLIGHT DECK", {
  ["SC_Gator_TO_AR"] call replicateNewVehicleFromPonyExpress;
},[],7,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate Regular Truck - DANGER CLEAR FLIGHT DECK", {
  ["B_G_Offroad_01_F"] call replicateNewVehicleFromPonyExpress;
},[],6,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TURRET] M41 LAAG Turret - DANGER CLEAR FLIGHT DECK", {
  ["OPTRE_Static_M41"] call replicateNewVehicleFromPonyExpress;
},[],5,true,true,"","true",10,false,"",""];





vehicleSpawner addAction ["Clean Flight Deck of Wreckage", {
  _listOfVehiclesNearFlightDeck = vehicleSpawner nearObjects ["ALLVEHICLES",100];
  {
    if (damage _x == 1) then {
      deleteVehicle _x;
    };
  } forEach _listOfVehiclesNearFlightDeck;
},[],1.5,true,true,"","true",10,false,"",""];

if (isServer) then {
  waitUntil {time > 10};
  publicVariable "respawnerLocation";
  deleteVehicle spareFighter;

  onPlayerConnected {publicVariable "respawnerLocation"};

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
};


//MISSION 6
//script that hurts player's vic if they're flying above 300m or some arbitrary value I've set

//dumb script that uses a while {true}
//TODO: do this but better.
[] spawn {
  if (!isServer) then {
    while {true} do {
      if (!isNull ObjectParent player) then {
        if (getPosATL player select 2 > 56) then {
          _originalDamage = damage ObjectParent player;
          (ObjectParent player) setDamage (_originalDamage + 0.1);
          sleep 2;
        };
      };
    };
  };
};

//script that hopefully will blow up robots when downed

blopsEnemies = [
  "SC_SE_Urban_Rifleman_H",
  "SC_SE_Urban_Rifleman_M",
  "SC_SE_Urban_Rifleman_L",
  "SC_SE_Urban_Marksman",
  "SC_SE_Urban_Medic",
  "SC_SE_Urban_Officer",
  "SC_SE_Urban_Ranger_H",
  "SC_SE_Urban_Rifleman_AA",
  "SC_SE_Urban_Rifleman_AT",
  "SC_SE_Urban_Sniper"
];

{
  [_x, "Hit", {
      params ["_unit", "_source", "_damage", "_instigator"];
      if (_unit getVariable ["ACE_isUnconscious", false]) then {
        _scriptedCharge = createVehicle ["APERSMine_Range_Ammo",(getPosASL _unit),[],0,"CAN_COLLIDE"];
        _newPos = getPosASL _unit;
        _scriptedCharge setPosASL (_newPos);
        _scriptedCharge setDamage 1;
        deleteVehicle _unit;
      };
    }] call CBA_fnc_addClassEventHandler;
} forEach blopsEnemies;

cashier addAction ["Hi, welcome to Waffle House, what do you want?", {
      _longString = "<t color='#777777' size='1'>Can I take your order? No, I don't care what you're doing here.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

cashier addAction ["Ask about black ops guys", {
      _longString = "<t color='#777777' size='1'>I don't think those are the kind of people that eat here. Couldn't tell yah.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

cashier addAction ["Ask about the empire", {
      _longString = "<t color='#777777' size='1'>Pretty sure they're why things are this shit. I don't do politics, though, so I dunno.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

cashier addAction ["Ask about locals or who would know things", {
      _longString = "<t color='#777777' size='1'>Nobody tells me anything, so I dunno where anyone would be. Lot of people come from south of here, though.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

cashier addAction ["Ask why they're open", {
      _longString = "<t color='#777777' size='1'>It ain't the apocalypse yet, so we're open 'til it is. Damn close though.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel01 addAction ["Intel", {
      _longString = "<t color='#22aa22' size='1'>Empire raids, bombardments, occupations, and other activities continue unabated. Outside solutions to smuggle into the planet are ongoing, but will take time. Orders are to lay low and look for opportunities. Don't die. Extra supplies probably aren't coming.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel01 addAction ["Note 01", {
      _longString = "<t color='#22aa22' size='1'>Saw some odd glints at the solar farm somewhere east. Unsure if that's just reflections or something else going on there. Constant empire patrols and raiders make me skeptical it's anything good.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel01 addAction ["Note 02", {
      _longString = "<t color='#22aa22' size='1'>Old techy military base might have some anti- capital spaceship tech. I guess. Maybe. If they did they really should have used them earlier. I have no idea where near the dam it is, but it's right next to the dam. How the fuck do we even fight this? All of the other military bases near the dam have been picked clean, maybe the raiders missed something too shiny for them to understand.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel01 addAction ["Note 03", {
      _longString = "<t color='#22aa22' size='1'>Last supply cache is in the very south of the old city. In a building next to the pristine statue of a lady. I have no idea why that statue survived so intact, but I'll make sure it stays that way. If anyone else is reading this, try and keep it intact. It's been good luck for me and it's the only thing on this planet that isn't shot to hell. Toll booth in, turn left before the first left turn.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel02 addAction ["Intel", {
      _longString = "<t color='#22aa22' size='1'>[LAST ACCESSED 6.21 YEARS AGO] Diplomats on the horn with the Empire say that their ship isn't doing anything and just orbiting in accordance with the law, but all these weather anomalies and tech blackouts only started when that ship got close to the planet. I've recommended to high command we explore all options, especially that seperatist group that's reverse engineering Empire Tech. Bunch of journalists way over their head, but the information they're releasing is frightening. Worth a visit, but clandestine. [COORDINATE FILE ATTACHED]</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

/*
if (_object getvariable ["ACE_isUnconscious", false]) then {


["SC_SE_Warbot_Light", "killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
    _scriptedCharge = createVehicle ["APERSMine_Range_Ammo",(getPosASL _unit),[],0,"CAN_COLLIDE"];
    _newPos = getPosASL _unit;
    _scriptedCharge setPosASL (_newPos);
    _scriptedCharge setDamage 1;
    deleteVehicle _unit;
    deleteVehicle _unit;
  }] call CBA_fnc_addClassEventHandler;
*/
//robots don't go unconscious?!
//fuck robots
/*
robotUniforms = [
  "SC_Uniform_Warbot_Heavy",
  "SC_Uniform_Warbot_Light"
];

["ace_unconscious",{
  params ["_unit", "_isUnconscious"];
  [uniform _unit] remoteExec ["hint", 0];
//if (uniform (_this select 0) in robotUniforms && _isUnconscious) then {
//[(_this select 0)] spawn spookyFire;
//deleteVehicle (_this select 0);
}] call CBA_fnc_addEventHandler;
*/

/*
OLD MISSION 5 AI
*/

/*

enemyFighters = [
  "MEOP_SX4fighter_veh_cerbRed_F",
  "MEOP_SX3fighter_veh_cerbRed_F",
  "MEOP_F61fighter_veh_alFCW_F",
  "MEOP_Ocufighter_veh_reaper_F"
];

friendlyWaypoints = [
  "hotelMarker",
  "indiaMarker",
  "juliettMarker",
  "sensorMarker",
  "gueveraMarker",
  "masonMarker",
  "spartacusMarker"
];

if (isServer) then {
  //LOOT BOXEN

  lootBoxen = [
    loot_boxen_01,
    loot_boxen_02,
    loot_boxen_03,
    loot_boxen_04,
    loot_boxen_05,
    loot_boxen_06,
    loot_boxen_07,
    loot_boxen_08,
    loot_boxen_09,
    loot_boxen_10,
    loot_boxen_11,
    loot_boxen_12,
    loot_boxen_13,
    loot_boxen_14,
    loot_boxen_15,
    loot_boxen_16,
    loot_boxen_17,
    loot_boxen_18,
    loot_boxen_19,
    loot_boxen_20,
    loot_boxen_21,
    loot_boxen_22,
    loot_boxen_23,
    loot_boxen_24,
    loot_boxen_25,
    loot_boxen_26,
    loot_boxen_27,
    loot_boxen_28,
    loot_boxen_29,
    loot_boxen_30,
    loot_boxen_31,
    loot_boxen_32,
    loot_boxen_33,
    loot_boxen_34,
    loot_boxen_35,
    loot_boxen_36,
    loot_boxen_37,
    loot_boxen_38,
    loot_boxen_39,
    loot_boxen_40,
    loot_boxen_41,
    loot_boxen_42,
    loot_boxen_43
  ];

  potentialLootForBoxen = [
    ["ACE_TacticalLadderPack", 3],
    ["G_Aviator", 1],
    ["SC_MPML_M_AT", 10],
    ["SC_MPML_M_HE", 10],
    ["SC_MPML_M_AA", 10],
    ["SC_MPML_M_AA", 10],
    ["SC_Rifle_ARG88", 2],
    ["SC_Rifle_ARG88", 2],
    ["ACE_quikclot", 20],
    ["arifle_AKM_F", 5],
    ["30Rnd_762x39_Mag_Tracer_F", 20],
    ["ACE_Chemlight_UltraHiOrange", 5],
    ["SC_Backpack_WP_Guard_SL", 1]
  ];

  {
    _x addItemCargoGlobal selectRandom potentialLootForBoxen;
  } forEach lootBoxen;
};



mothershipParts1 = [
  flak01,
  flak03,
  flak04,
  flak06
];

mothershipParts2 = [
  newForeMissileSystem,
  newStarboardMissileSystem,
  newPortMissileSystem
];

mothershipParts5 = [
  newBellyMissileSystem
];

newFighterFromMothership = {
  params ["_target"];
  enemySpawn = getPosASL enemyMothership vectorAdd [0,0,-35];

  _newFighter = [[-10000,-10000,0], 30, selectRandom enemyFighters, east] call BIS_fnc_spawnVehicle;
  (_newFighter select 0) setPosASL (enemySpawn vectorAdd [325,0,60]);
  _newFighter select 0 setVelocity [200,0,0];
  _newWaypoint = _newFighter select 2 addWaypoint [getMarkerPos _target, 500];
  _newWaypoint setWaypointType "SAD";

};

fighterInterval = 150;

if (isServer) then {
  [] spawn {
    while {true} do {
      _selectedTarget = selectRandom friendlyWaypoints;
      [_selectedTarget] call newFighterFromMothership;
      sleep 1;
      [_selectedTarget] call newFighterFromMothership;
      sleep 1;
      [_selectedTarget] call newFighterFromMothership;
      sleep fighterInterval;
    };
  };
};

//OUTPOST HEALTH TRACKERS
if (isServer) then {

  //Spartacus Outpost
  spartacusOutpostHP = 100;
  spartacusTurret addEventHandler ["HandleDamage", {
    spartacusOutpostHP = spartacusOutpostHP - 1;
    if (spartacusOutpostHP == 25 || spartacusOutpostHP == 50 || spartacusOutpostHP == 75) then {
      _statusString = "Spartacus Outpost reports " + str (spartacusOutpostHP) + "% integrity.";
      [_statusString] remoteExec ["hint", 0, false];
    };
    if (spartacusOutpostHP < 1) then {
      _statusString = "Spartacus Outpost radio goes silent";
      [_statusString] remoteExec ["hint", 0, false];
      "spartacusMarker" setMarkerType "KIA";
      spartacusTurret setDamage 1;
    };
  }];

  //Outpost Mason
  masonOutpostHP = 100;
  masonTurret addEventHandler ["HandleDamage", {
    masonOutpostHP = masonOutpostHP - 1;
    if (masonOutpostHP == 25 || masonOutpostHP == 50 || masonOutpostHP == 75) then {
      _statusString = "Mason Outpost reports " + str (masonOutpostHP) + "% integrity.";
      [_statusString] remoteExec ["hint", 0, false];
    };
    if (masonOutpostHP < 1) then {
      _statusString = "Mason Outpost radio goes silent";
      [_statusString] remoteExec ["hint", 0, false];
      "masonMarker" setMarkerType "KIA";
      masonTurret setDamage 1;
    };
  }];

  //Outpost Guevera
  gueveraOutpostHP = 100;
  gueveraTurret addEventHandler ["HandleDamage", {
    gueveraOutpostHP = gueveraOutpostHP - 1;
    if (gueveraOutpostHP == 25 || gueveraOutpostHP == 50 || gueveraOutpostHP == 75) then {
      _statusString = "Guevera Outpost reports " + str (gueveraOutpostHP) + "% integrity.";
      [_statusString] remoteExec ["hint", 0, false];
    };
    if (gueveraOutpostHP < 1) then {
      _statusString = "Guevera Outpost radio goes silent";
      [_statusString] remoteExec ["hint", 0, false];
      "gueveraMarker" setMarkerType "KIA";
      gueveraTurret setDamage 1;
    };
  }];

  //Sensor & Bunker
  sensorBunkerHP = 100;
  sensorTurret addEventHandler ["HandleDamage", {
    sensorBunkerHP = sensorBunkerHP - 1;
    if (sensorBunkerHP == 25 || sensorBunkerHP == 50 || sensorBunkerHP == 75) then {
      _statusString = "Sensor Station reports " + str (sensorBunkerHP) + "% integrity.";
      [_statusString] remoteExec ["hint", 0, false];
    };
    if (sensorBunkerHP < 1) then {
      _statusString = "Sensor Station radio goes silent";
      [_statusString] remoteExec ["hint", 0, false];
      "sensorMarker" setMarkerType "KIA";
      sensorTurret setDamage 1;
    };
  }];

  //Hotel

  //India
  indiaBlockHP = 100;
  indiaTurret addEventHandler ["HandleDamage", {
    indiaBlockHP = indiaBlockHP - 1;
    if (indiaBlockHP == 25 || indiaBlockHP == 50 || indiaBlockHP == 75) then {
      _statusString = "Freedom Block India reports " + str (indiaBlockHP) + "% integrity.";
      [_statusString] remoteExec ["hint", 0, false];
    };
    if (indiaBlockHP < 1) then {
      _statusString = "Freedom Block India radio goes silent";
      [_statusString] remoteExec ["hint", 0, false];
      "indiaMarker" setMarkerType "KIA";
      indiaTurret setDamage 1;
    };
  }];

  //Juliett
  juliettBlockHP = 100;
  juliettTurret addEventHandler ["HandleDamage", {
    juliettBlockHP = juliettBlockHP - 1;
    if (juliettBlockHP == 25 || juliettBlockHP == 50 || juliettBlockHP == 75) then {
      _statusString = "Freedom Block Juliett reports " + str (juliettBlockHP) + "% integrity.";
      [_statusString] remoteExec ["hint", 0, false];
    };
    if (juliettBlockHP < 1) then {
      _statusString = "Freedom Block Juliett radio goes silent";
      [_statusString] remoteExec ["hint", 0, false];
      "juliettMarker" setMarkerType "KIA";
      juliettTurret setDamage 1;
    };
  }];

  //Warning Trackers

  [] spawn {
    while {alive spartacusTurret} do {
      _foundEnemy = false;
      _nearbyObjects = spartacusTurret nearObjects 1800;
      {
        if (side _x == east && getPos _x select 2 > 10) then {
          _foundEnemy = true;
        };
      }forEach _nearbyObjects;
      if (_foundEnemy) then {
        "spartacusWarning" setMarkerAlpha 1;
      } else{
        "spartacusWarning" setMarkerAlpha 0;
      };
      sleep 10;
    };
    "spartacusWarning" setMarkerAlpha 0;
  };

  [] spawn {
    while {alive masonTurret} do {
      _foundEnemy = false;
      _nearbyObjects = masonTurret nearObjects 1800;
      {
        if (side _x == east && getPos _x select 2 > 10) then {
          _foundEnemy = true;
        };
      }forEach _nearbyObjects;
      if (_foundEnemy) then {
        "masonWarning" setMarkerAlpha 1;
      } else{
        "masonWarning" setMarkerAlpha 0;
      };
      sleep 10;
    };
    "masonWarning" setMarkerAlpha 0;
  };

  [] spawn {
    while {alive gueveraTurret} do {
      _foundEnemy = false;
      _nearbyObjects = gueveraTurret nearObjects 1800;
      {
        if (side _x == east && getPos _x select 2 > 10) then {
          _foundEnemy = true;
        };
      }forEach _nearbyObjects;
      if (_foundEnemy) then {
        "gueveraWarning" setMarkerAlpha 1;
      } else{
        "gueveraWarning" setMarkerAlpha 0;
      };
      sleep 10;
    };
    "gueveraWarning" setMarkerAlpha 0;
  };

  [] spawn {
    while {alive indiaTurret} do {
      _foundEnemy = false;
      _nearbyObjects = indiaTurret nearObjects 1800;
      {
        if (side _x == east && getPos _x select 2 > 10) then {
          _foundEnemy = true;
        };
      }forEach _nearbyObjects;
      if (_foundEnemy) then {
        "indiaWarning" setMarkerAlpha 1;
      } else{
        "indiaWarning" setMarkerAlpha 0;
      };
      sleep 10;
    };
    "indiaWarning" setMarkerAlpha 0;
  };

  [] spawn {
    while {alive juliettTurret} do {
      _foundEnemy = false;
      _nearbyObjects = juliettTurret nearObjects 1800;
      {
        if (side _x == east && getPos _x select 2 > 10) then {
          _foundEnemy = true;
        };
      }forEach _nearbyObjects;
      if (_foundEnemy) then {
        "juliettWarning" setMarkerAlpha 1;
      } else{
        "juliettWarning" setMarkerAlpha 0;
      };
      sleep 10;
    };
    "juliettWarning" setMarkerAlpha 0;
  };

  [] spawn {
    while {alive sensorTurret} do {
      _foundEnemy = false;
      _nearbyObjects = sensorTurret nearObjects 1800;
      {
        if (side _x == east && getPos _x select 2 > 10) then {
          _foundEnemy = true;
        };
      }forEach _nearbyObjects;
      if (_foundEnemy) then {
        "sensorWarning" setMarkerAlpha 1;
      } else{
        "sensorWarning" setMarkerAlpha 0;
      };
      sleep 10;
    };
    "sensorWarning" setMarkerAlpha 0;
  };




  //BOSS SHIP HEALTH TRACKER

  mothershipHP = 200;
  {
    _x addEventHandler ["HandleDamage", {
      params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
      //[str(_unit)] remoteExecCall ["hint", 0 ,false];
      //if (!(side _instigator == west)) exitWith {};
      mothershipHP = mothershipHP - 1;
      //181 - 200 hp
      if (mothershipHP > 180) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Shield strength unaffected.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //151 - 180 hp
      if (mothershipHP > 150 && mothershipHP < 181) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Shield strength waning.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //126 - 150 hp
      if (mothershipHP > 125 && mothershipHP < 151) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Shield strength critical. Munition partially deflected.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //76 - 125 hp
      if (mothershipHP > 75 && mothershipHP < 126) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Direct hit on enemy armor. Shield dissipated.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //26 - 75 hp
      if (mothershipHP > 25 && mothershipHP < 76) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Direct hit on enemy structure. Armor dissipated.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //1 - 25 hp
      if (mothershipHP > 0 && mothershipHP < 26) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Direct hit on enemy structure. Critical systems failures detected.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      // 0 hp
      if (mothershipHP < 0) then {
        {
          deleteVehicle _x;
        } forEach mothershipParts;
        [getPosASL enemyMothership, 0, 0, false] call zen_modules_fnc_moduleNukeLocal;
      };
    }];
  } forEach mothershipParts1;

  {
    _x addEventHandler ["HandleDamage", {
      params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
      //[str(_unit)] remoteExecCall ["hint", 0 ,false];
      //if (!(side _instigator == west)) exitWith {};
      mothershipHP = mothershipHP - 2;
      //181 - 200 hp
      if (mothershipHP > 180) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Shield strength unaffected.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //151 - 180 hp
      if (mothershipHP > 150 && mothershipHP < 181) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Shield strength waning.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //126 - 150 hp
      if (mothershipHP > 125 && mothershipHP < 151) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Shield strength critical. Munition partially deflected.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //76 - 125 hp
      if (mothershipHP > 75 && mothershipHP < 126) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Direct hit on enemy armor. Shield dissipated.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //26 - 75 hp
      if (mothershipHP > 25 && mothershipHP < 76) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Direct hit on enemy structure. Armor dissipated.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //1 - 25 hp
      if (mothershipHP > 0 && mothershipHP < 26) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Direct hit on enemy structure. Critical systems failures detected.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      // 0 hp
      if (mothershipHP < 0) then {
        {
          deleteVehicle _x;
        } forEach mothershipParts;
        [getPosASL enemyMothership, 0, 0, false] call zen_modules_fnc_moduleNukeLocal;
      };
    }];
  } forEach mothershipParts2;

  {
    _x addEventHandler ["HandleDamage", {
      params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
      //[str(_unit)] remoteExecCall ["hint", 0 ,false];
      //if (!(side _instigator == west)) exitWith {};
      mothershipHP = mothershipHP - 5;
      //181 - 200 hp
      if (mothershipHP > 180) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Shield strength unaffected.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //151 - 180 hp
      if (mothershipHP > 150 && mothershipHP < 181) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Shield strength waning.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //126 - 150 hp
      if (mothershipHP > 125 && mothershipHP < 151) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Shield strength critical. Munition partially deflected.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //76 - 125 hp
      if (mothershipHP > 75 && mothershipHP < 126) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Direct hit on enemy armor. Shield dissipated.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //26 - 75 hp
      if (mothershipHP > 25 && mothershipHP < 76) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Direct hit on enemy structure. Armor dissipated.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      //1 - 25 hp
      if (mothershipHP > 0 && mothershipHP < 26) then {
        _longString = "<t color='#22aa22' size='1'>Hit detected at T+" + str(time) + "<br/>Positive strike on enemy carrier.<br/>Direct hit on enemy structure. Critical systems failures detected.</t>";
        [_longString] remoteExec ["storyText",0,false];
      };
      // 0 hp
      if (mothershipHP < 0) then {
        {
          deleteVehicle _x;
        } forEach mothershipParts;
        [getPosASL enemyMothership, 0, 0, false] call zen_modules_fnc_moduleNukeLocal;
      };
    }];
  } forEach mothershipParts5;

};



*/



/*
setupOutpostSystem = {
  params ["_name", "_marker", "_defense", ["_areaHP", "", ["String"]]];
  _defense addEventHandler["HandleDamage", {
    _previousHP = missionNamespace getVariable _areaHP;
    missionNamespace setVariable [_areaHP, _previousHP - 1];
    if (true) then {
      _statusString = _name + " reports " + str (_previousHP) + "% integrity.";
      [_statusString] remoteExec ["hint", 0, false];
    };
    if (_areaHP < 1) then {
      _statusString = _name + " radio goes silent";
      [_statusString] remoteExec ["hint", 0, false];
      _marker setMarkerType "KIA";
      _defense setDamage 1;
    };
  }];
};

missionNamespace setVariable ["spartacusOutpostHP", 100];
["Spartacus Outpost", "spartacusMarker", spartacusTurret, "spartacusOutpostHP"] call setupOutpostSystem;
*/
/*
spartacusOutpostHP = 100;
spartacusTurret addEventHandler ["HandleDamage", {
  spartacusOutpostHP = spartacusOutpostHP - 1;
  if (spartacusOutpostHP == 25 || spartacusOutpostHP == 50 || spartacusOutpostHP == 75) then {
    _statusString = "Spartacus Outpost reports " + str (spartacusOutpostHP) + "% integrity.";
    [_statusString] remoteExec ["hint", 0, false];
  };
  if (spartacusOutpostHP < 1) then {
    _statusString = "Spartacus Outpost radio goes silent";
    [_statusString] remoteExec ["hint", 0, false];
    "spartacusMarker" setMarkerType "KIA";
    spartacusTurret setDamage 1;
  };
}];
*/

/*

"MEOP_F61fighter_veh_alFCW_F"

removeAllActions vehicleSpawner;

replicateNewVehicleFromPonyExpress7 = {
  params ["_typeOfVehicle"];
  _newVic = _typeOfVehicle createVehicle [-1000,-1000,0];
  _newVic setDir 180;
  _newVic setPosASL (respawnerLocation vectorAdd [0,0,0.50]);
  _newVic addAction ["Y.E.E.T.", {
    (_this select 0) setVelocity [0,0,10];
    sleep 0.4;
    (_this select 0) setVelocity [0,-80,0];
  },[],1.5,true,true,"","_originalTarget distance vehicleSpawner < 20",10,false,"",""];
};

  vehicleSpawner addAction ["[HELI] Replicate Sparrowhawk - DANGER CLEAR FLIGHT DECK", {
    ["OPTRE_AV22_Sparrowhawk"] call replicateNewVehicleFromPonyExpress7;
  },[],1.5,true,true,"","true",10,false,"",""];

  vehicleSpawner addAction ["[PLANE] Replicate Space F/A-181 - DANGER CLEAR FLIGHT DECK", {
    ["B_Plane_Fighter_01_F"] call replicateNewVehicleFromPonyExpress7;
  },[],1.5,true,true,"","true",10,false,"",""];

  vehicleSpawner addAction ["Clean Flight Deck of Wreckage", {
    _listOfVehiclesNearFlightDeck = vehicleSpawner nearObjects ["ALLVEHICLES",100];
    {
      if (damage _x == 1) then {
        deleteVehicle _x;
      };
    } forEach _listOfVehiclesNearFlightDeck;
  },[],1.5,true,true,"","true",10,false,"",""];



OLD
replicateNewVehicleFromPonyExpress = {
  params ["_typeOfVehicle"];
  _newVic = _typeOfVehicle createVehicle [-1000,-1000,0];
  _newVic setDir 180;
  _newVic setPosASL (respawnerLocation vectorAdd [0,0,0.50]);
  _newVic addAction ["Y.E.E.T.", {
    (_this select 0) setVelocity [0,0,10];
    sleep 0.4;
    (_this select 0) setVelocity [0,-80,0];
  },[],1.5,true,true,"","_target distance respawnerLocation < 10",10,false,"",""];
};


*/
