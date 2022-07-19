skeetSkeet addAction ["PULL - Launch Pigeon Probe",launchSkeetHigh,[],1.5,true,true,"","true",10,false,"",""];

_theFuckingTable = redAlertConsole nearObjects ["OPTRE_holotable_sm", 20];
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

vehicleSpawner addAction ["[APC] Replicate Saurus 'Shredder'", {
  ["SC_SaurusAPC_AA_SE"] call replicateNewVehicleFromPonyExpress;
},[],17.9,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[MECH] Replicate Defender Mech", {
  ["BTLSTD_Defender_BLU_HC_UNSPACY"] call replicateNewVehicleFromPonyExpress;
},[],17.5,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate G12 'Gator'", {
  ["SC_Gator_TO_AR"] call replicateNewVehicleFromPonyExpress;
},[],17,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate G12 'Gator' Transport", {
  ["SC_Gator_TC_SE"] call replicateNewVehicleFromPonyExpress;
},[],16.9,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate Racing Hog", {
  ["OPTRE_M12_CIV2"] call replicateNewVehicleFromPonyExpress;
},[],16,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate Fuel Truck", {
  ["C_Van_01_fuel_F"] call replicateNewVehicleFromPonyExpress;
},[],15,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[TRUCK] Replicate Regular Truck", {
  ["B_G_Offroad_01_F"] call replicateNewVehicleFromPonyExpress;
},[],14,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[RV] Replicate Skeetwood Sounder", {
  ["cox_veh_sounder_standard"] call replicateNewVehicleFromPonyExpress;
},[],13.95,true,true,"","true",10,false,"",""];

vehicleSpawner addAction ["[ATV] Replicate Quad Bike", {
  ["C_Quadbike_01_F"] call replicateNewVehicleFromPonyExpress;
},[],13.9,true,true,"","true",10,false,"",""];

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
  [] spawn {
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
    (_this select 0) setVelocity [0,40,0]; //ship has rotated 180, and also quarter this value
  },[],1.5,true,true,"","_originalTarget distance vehicleSpawner < 40",10,false,"",""];
  [_typeOfVehicle, _newVic] call addPaintJobsSmart;
};

/*
Vehicle Painter
*/
addPaintJobsSmart = {
  params ["_typeOfVehicle", "_vehicleActual"];
  if (!(_typeOfVehicle isEqualTo "BTLSTD_Defender_BLU_HC_UNSPACY")) then { //KNOWN BUG - MECH DOESN'T HAVE WORKING PAINT JOBS
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
};

dumbPaintVehicleSand = {
  params ["_vehicle"];
  _fetchedTextures = [];
  _typeOfVehicle = typeOf _vehicle;
  _fetchedTextures pushBack getArray(configfile >> "CfgVehicles" >> _typeOfVehicle >> "TextureSources" >> "Sand" >> "textures");
  [_vehicle, _fetchedTextures] call paintVehicle;
  _fetchedTextures2 = [];
  _fetchedTextures2 pushBack getArray(configfile >> "CfgVehicles" >> _typeOfVehicle >> "TextureSources" >> "Tan" >> "textures");
  [_vehicle, _fetchedTextures2] call paintVehicle;
};

paintVehicle = {
  params ["_vehicle", "_paintArray"];
  //hint (_paintArray select 0 select 0);
  {
    _vehicle setObjectTextureGlobal [_forEachIndex, _x];
  } forEach (_paintArray select 0);
};
