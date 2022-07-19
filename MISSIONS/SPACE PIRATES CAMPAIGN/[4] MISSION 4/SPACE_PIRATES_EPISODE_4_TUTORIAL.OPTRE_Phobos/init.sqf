#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "story.sqf"
//#include "spaceTeamDirector.sqf"
#include "spaceTeamCustomActions.sqf"

enableSaving [false, false];

[jackShack] call makePirateArsenal;
[jackShack2] call makePirateArsenal;

skeetSkeet addAction ["PULL - Launch Pigeon Probe",launchSkeetHigh,[],1.5,true,true,"","true",10,false,"",""];

if (isServer) then {
  _theFuckingTable = (getPosASL redAlertConsole) nearObjects ["OPTRE_holotable_sm", 20];
  deleteVehicle (_theFuckingTable select 0);
};

respawnerLocation = getPosASL spareFighter;
/*
vehicleSpawner addAction ["[PLANE] Replicate Strikebat Bomber - DANGER CLEAR FLIGHT DECK", {
  ["SC_Fixed_Bomber_01"] call replicateNewVehicleFromPonyExpress;
},[],1.5,true,true,"","true",10,false,"",""];
*/
vehicleSpawner addAction ["[PLANE] Replicate Space F/A-181 - DANGER CLEAR FLIGHT DECK", {
  ["B_Plane_Fighter_01_F"] call replicateNewVehicleFromPonyExpress;
},[],10,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[HELI] Replicate Sparrowhawk - DANGER CLEAR FLIGHT DECK", {
  ["OPTRE_AV22_Sparrowhawk"] call replicateNewVehicleFromPonyExpress;
},[],9,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[HELI] Replicate Carnotaurus - DANGER CLEAR FLIGHT DECK", {
  ["SC_VTOL_X41A_AR"] call replicateNewVehicleFromPonyExpress;
},[],8,true,true,"","true",10,false,"",""];
/*
vehicleSpawner addAction ["[VTOL] Replicate Raptor - DANGER CLEAR FLIGHT DECK", {
  ["SC_VTOL_X42_AR"] call replicateNewVehicleFromPonyExpress;
},[],1.5,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TANK] Replicate Mantis - DANGER CLEAR FLIGHT DECK", {
  ["SC_Mantis"] call replicateNewVehicleFromPonyExpress;
},[],1.5,true,true,"","true",10,false,"",""];
*/
vehicleSpawner addAction ["[TRUCK] Replicate G12 'Gator' - DANGER CLEAR FLIGHT DECK", {
  ["SC_Gator_TO_AR"] call replicateNewVehicleFromPonyExpress;
},[],7,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate Regular Truck - DANGER CLEAR FLIGHT DECK", {
  ["B_G_Offroad_01_F"] call replicateNewVehicleFromPonyExpress;
},[],6,true,true,"","true",10,false,"",""];



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


/*
MISSION AI
*/

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

/*

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
