//REQUIRES CBA!
//REQUIRES ACE!
//KOREAN WAR? REQUIRES FACES OF WAR, IFA3, AND PROBABLY A BUNCH OF OTHER THINGS.


/*
  TODO:
    Make vanilla friendly
    If the box is empty, give an option to delete it.
    Delete box from hashmap when deleted?
*/

//SERVER INIT
if (isServer) then {
  primaryAmmoBoxen = createHashMap;
  secondaryAmmoBoxen = createHashMap;
  handgunAmmoBoxen = createHashMap;
  medicTriageBoxen = createHashMap;
  //these three hashmaps should really just be one, right?

  // JIP HANDLER
  addMissionEventHandler ["PlayerConnected",
    {
      params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
      if (_jip) then {
        {
          [_y select 0] remoteExec ["removeAllActions", 0];
          [_y select 0, _y select 1, _y select 2, false] call initTerminalAmmoBox;
        } forEach primaryAmmoBoxen;
        {
          [_y select 0] remoteExec ["removeAllActions", 0];
          [_y select 0, _y select 1, _y select 2, false] call initTerminalAmmoBox;
        } forEach secondaryAmmoBoxen;
        {
          [_y select 0] remoteExec ["removeAllActions", 0];
          [_y select 0, _y select 1, _y select 2, false] call initTerminalAmmoBox;
        } forEach handgunAmmoBoxen;
        {
          [_y select 0] remoteExec ["removeAllActions", 0];
          [_y select 0, _y select 1, _y select 2, false] call initTerminalAmmoBox;
        } forEach medicTriageBoxen;
      };
    }];
};

//
//SEVER FUNCTIONS
//

initTerminalAmmoBox = {
/*
Run this function on server once.
PARAMETERS
1: Object to use as a box.
2: String representing the type of box. Should be "PRIMARY" , "SECONDARY" , or "HANDGUN" . Defaults to "PRIMARY" .
3: Number of magazines/ammo count in the box.
4: TRUE/FALSE is it first Init? Make a new entry or just update the box
EX: [boxOnMap, "PRIMARY", 100, true] call initTerminalAmmoBox;
*/
  params ["_box", "_type", "_mags", "_firstInit"];
  switch (_type) do {
    case "PRIMARY": {
      if (_firstInit) then {
        primaryAmmoBoxen set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Primary Ammo Box",{[_this select 0] call openPrimaryBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
    case "SECONDARY": {
      if (_firstInit) then {
        secondaryAmmoBoxen set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Launcher Ammo Box",{[_this select 0] call openSecondaryBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
    case "HANDGUN": {
      if (_firstInit) then {
        handgunAmmoBoxen set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Sidearm Ammo Box",{[_this select 0] call openHandgunBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
    case "MEDICAL":{
      if (_firstInit) then {
        medicTriageBoxen set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Medical Box",{[_this select 0] call openMedicalBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
    default {
      if (_firstInit) then {
        primaryAmmoBoxen set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Primary Ammo Box",{[_this select 0] call openPrimaryBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
  };
};

doTheTaking = {
  params ["_player", "_ammoToGive", "_boxen", "_boxArray", "_hashMap"];
  if (0 == _boxArray select 2) then {
    ["Box is empty"] remoteExec ["hint", _player];
  } else {
    if ([_player, _ammoToGive] call CBA_fnc_canAddItem) then {
      _hashMap set [str(_boxen), [_boxArray select 0, _boxArray select 1, (_boxArray select 2) - 1]];
      [_player, _ammoToGive] remoteExec ["addItem", _player];
      private "_hintString";
      _hintString = str(_hashMap get str(_boxen) select 2) + " items remain"; //potentially optimize - for debug purposes, this can stay but, like, keep it local
      [_hintString] remoteExec ["hint", _player];
    } else {
      private _hintString = "INVENTORY FULL";
      [_hintString] remoteExec ["hint", _player];
    };
  };
};

magTakenFromBoxen = {
  params ["_ammo","_boxen","_player"];
  /* TODO: more error checking */
  /* TODO: make sure each box can only be one kind of box at a time */
  private _primaryCheck = primaryAmmoBoxen get str(_boxen);
  private _secondaryCheck = secondaryAmmoBoxen get str(_boxen);
  private _handgunCheck = handgunAmmoBoxen get str(_boxen);
  private _medicalCheck = medicTriageBoxen get str(_boxen);

  switch (true) do {
    case (!isNil {_primaryCheck}): {
      [_player, _ammo, _boxen, _primaryCheck, primaryAmmoBoxen] call doTheTaking;
    };
    case (!isNil {_secondaryCheck}): {
      [_player, _ammo, _boxen, _secondaryCheck, secondaryAmmoBoxen] call doTheTaking;
    };
    case (!isNil {_handgunCheck}): {
      [_player, _ammo, _boxen, _handgunCheck, handgunAmmoBoxen] call doTheTaking;
    };
    case (!isNil {_medicalCheck}): {
      [_player, _ammo, _boxen, _medicalCheck, medicTriageBoxen] call doTheTaking;
    };
    default {
      /* TODO: this should REALLY give a proper error */
    };
  };
};

queryBoxen = {
  params ["_requester", "_boxen"];
  private _primaryCheck = primaryAmmoBoxen get str(_boxen);
  private _secondaryCheck = secondaryAmmoBoxen get str(_boxen);
  private _handgunCheck = handgunAmmoBoxen get str(_boxen);
  private _medicalCheck = medicTriageBoxen get str(_boxen);
  private "_hintString";
  private "_num";
  switch (true) do {
    case (!isNil {_primaryCheck}): {
      _num = primaryAmmoBoxen get str(_boxen) select 2;
      _hintString = str(_num) + " magazines remain";
    };
    case (!isNil {_secondaryCheck}): {
      _num = secondaryAmmoBoxen get str(_boxen) select 2;
      _hintString = str(_num) + " magazines remain";
    };
    case (!isNil {_handgunCheck}): {
      _num = handgunAmmoBoxen get str(_boxen) select 2;
      _hintString = str(_num) + " magazines remain";
    };
    case (!isNil {_medicalCheck}): {
      _num = medicTriageBoxen get str(_boxen) select 2;
      _hintString = str(_num) + " items remain";
    };
    default {
      _hintString = "Odd error encountered. Let Terminal know something's weird.";
      _num = 1;
    };
  };
  [_hintString] remoteExec ["hint", _requester];
  if (_num < 1) then {
    deleteVehicle _boxen;
  };
};

//
//CLIENT FUNCTIONS
//

takeMagazine = {
  params ["_ammo", "_boxen"];
  [_ammo, _boxen, player] remoteExec ["magTakenFromBoxen", 2];
};

//PRIMARY
openPrimaryBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  //add thing to close box
  _boxen addAction ["Close Primary Ammo Box",{[_this select 0] call closePrimaryBox},[],1.5,true,true,"","true",10,false,"",""];
  //populate with current primary weapon's list of magazines
  private "_tempAmmoList";
  _tempAmmoList = [primaryWeapon player] call BIS_fnc_compatibleMagazines;
  {
    private "_actionString";
    _actionString = "Take " + getText(configfile >> "CfgMagazines" >> _x >> "displayName");
    _boxen addAction [_actionString,{[_this select 3 select 0, _this select 0] call takeMagazine;},[_x],1.5,true,true,"","true",10,false,"",""];
  } forEach _tempAmmoList;
  [player, _boxen] remoteExec ["queryBoxen", 2];
};

closePrimaryBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  _boxen addAction ["Open Primary Ammo Box",{[_this select 0] call openPrimaryBox},[],1.5,true,true,"","true",10,false,"",""];
};

//SECONDARY
openSecondaryBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  //add thing to close box
  _boxen addAction ["Close Launcher Ammo Box",{[_this select 0] call closeSecondaryBox},[],1.5,true,true,"","true",10,false,"",""];
  //populate with current primary weapon's list of magazines
  private "_tempAmmoList";
  _tempAmmoList = [secondaryWeapon player] call BIS_fnc_compatibleMagazines;
  {
    private "_actionString";
    _actionString = "Take " + getText(configfile >> "CfgMagazines" >> _x >> "displayName");
    _boxen addAction [_actionString,{[_this select 3 select 0, _this select 0] call takeMagazine;},[_x],1.5,true,true,"","true",10,false,"",""];
  } forEach _tempAmmoList;
};

closeSecondaryBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  _boxen addAction ["Open Launcher Ammo Box",{[_this select 0] call openSecondaryBox},[],1.5,true,true,"","true",10,false,"",""];
};

//LAUNCHER
openHandgunBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  //add thing to close box
  _boxen addAction ["Close Sidearm Ammo Box",{[_this select 0] call closeHandgunBox},[],1.5,true,true,"","true",10,false,"",""];
  //populate with current primary weapon's list of magazines
  private "_tempAmmoList";
  _tempAmmoList = [handgunWeapon player] call BIS_fnc_compatibleMagazines;
  {
    private "_actionString";
    _actionString = "Take " + getText(configfile >> "CfgMagazines" >> _x >> "displayName");
    _boxen addAction [_actionString,{[_this select 3 select 0, _this select 0] call takeMagazine;},[_x],1.5,true,true,"","true",10,false,"",""];
  } forEach _tempAmmoList;
};

closeHandgunBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  _boxen addAction ["Open Handgun Ammo Box",{[_this select 0] call openHandgunBox},[],1.5,true,true,"","true",10,false,"",""];
};

medicineListKorean = [
  "ACE_fieldDressing",
  "ACE_packingBandage",
  "ACE_elasticBandage",
  "ACE_bloodIV_500",
  "ACE_epinephrine",
  "ACE_morphine",
  "ACE_splint",
  "ACE_surgicalKit",
  "ACE_tourniquet",
  "ACE_bodyBag"
];

openMedicalBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  //add thing to close box
  _boxen addAction ["Close Medical Box",{[_this select 0] call closeMedicalBox},[],1.5,true,true,"","true",10,false,"",""];
  //populate with current primary weapon's list of magazines
  {
    private "_actionString";
    _actionString = "Take " + getText(configfile >> "CfgWeapons" >> _x >> "displayName");
    _boxen addAction [_actionString,{[_this select 3 select 0, _this select 0] call takeMagazine;},[_x],1.5,true,true,"","true",10,false,"",""];
  } forEach medicineListKorean;
};

closeMedicalBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  _boxen addAction ["Open Medical Box",{[_this select 0] call openMedicalBox},[],1.5,true,true,"","true",10,false,"",""];
};

//
grabNewAmmoBoxPrimary = {
  _newBox = "land_fow_German_Ammo_Crate_2" createVehicle (getPos player);
  [_newBox, "PRIMARY", 15, true] remoteExec ["initTerminalAmmoBox", 2];
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxSidearm = {
  _newBox = "land_fow_German_Ammo_Crate_1" createVehicle (getPos player);
  [_newBox, "HANDGUN", 20, true] remoteExec ["initTerminalAmmoBox", 2];
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxLauncher = {
  _newBox = "land_fow_German_Ammo_Crate_3" createVehicle (getPos player);
  [_newBox, "SECONDARY", 5, true] remoteExec ["initTerminalAmmoBox", 2];
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxMedical = { //or "CUP_lekarnicka" oor "Box_I_UAV_06_medical_F""Box_I_UAV_06_medical_F"
  _newBox = "Land_FirstAidKit_01_closed_F" createVehicle (getPos player);
  [_newBox, "MEDICAL", 20, true] remoteExec ["initTerminalAmmoBox", 2];
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};
