//REQUIRES CBA!
//REQUIRES ACE!

//Defaults!
//Replace the strings and numbers here with what you want.
//Please try to use objects that do not have an inventory - as it's very difficult to remove the "inventory" action

terminalAmmoBoxPrimary = "Land_WoodenBox_02_F";
terminalAmmoBoxSecondary = "Land_WoodenBox_02_F";
terminalAmmoBoxHandgun = "Land_WoodenBox_02_F";
terminalAmmoBoxMedical = "Land_WoodenBox_02_F";

defaultPrimaryMagazines = 50;
defaultSecondaryMagazines = 25;
defaultHandgunMagazines = 100;
defaultMedicalMagazines = 100;

/*
  TODO:
    Delete box from hashmap when deleted?
    Mod version with updated configs so vanilla objects don't have their own inventory.
    Just pick a nomenclature and stick with it. No more sidearm/secondary or launcher/secondary or whatever. Primary, Secondary, Handgun.
*/

//SERVER INIT
if (isServer) then {
  terminalAmmoBoxenMasterHash = createHashMap;

  // JIP HANDLER
  addMissionEventHandler ["PlayerConnected",
    {
      params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
      if (_jip) then {
        {
          [_y select 0] remoteExec ["removeAllActions", 0];
          [_y select 0, _y select 1, _y select 2, false] call initTerminalAmmoBox;
        } forEach terminalAmmoBoxenMasterHash;
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
        terminalAmmoBoxenMasterHash set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Primary Ammo Box",{[_this select 0] call openPrimaryBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
    case "SECONDARY": {
      if (_firstInit) then {
        terminalAmmoBoxenMasterHash set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Launcher Ammo Box",{[_this select 0] call openSecondaryBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
    case "HANDGUN": {
      if (_firstInit) then {
        terminalAmmoBoxenMasterHash set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Sidearm Ammo Box",{[_this select 0] call openHandgunBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
    case "MEDICAL":{
      if (_firstInit) then {
        terminalAmmoBoxenMasterHash set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Medical Box",{[_this select 0] call openMedicalBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
    default {
      if (_firstInit) then {
        terminalAmmoBoxenMasterHash set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Primary Ammo Box",{[_this select 0] call openPrimaryBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
  };
};

doTheTaking = {
  params ["_player", "_ammoToGive", "_boxen", "_boxArray", "_hashMap"];
  if (0 == _boxArray select 2) then {
    ["Box is empty"] remoteExec ["hint", _player];
    deleteVehicle _boxen;
  } else {
    if ([_player, _ammoToGive] call CBA_fnc_canAddItem) then {
      _hashMap set [str(_boxen), [_boxArray select 0, _boxArray select 1, (_boxArray select 2) - 1]];
      [_player, _ammoToGive] remoteExec ["addItem", _player];
      //private "_hintString";
      //_hintString = str(_hashMap get str(_boxen) select 2) + " items remain"; //potentially optimize - for debug purposes, this can stay but, like, keep it local
      //[_hintString] remoteExec ["hint", _player];
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
  private _ammoBoxCheck = terminalAmmoBoxenMasterHash get str(_boxen);
  if (!isNil {_ammoBoxCheck}) then {
    [_player, _ammo, _boxen, _ammoBoxCheck, terminalAmmoBoxenMasterHash] call doTheTaking;
  } else {
    //error?
  };
  [_player, _boxen] remoteExec ["queryBoxen", 2];
};

queryBoxen = {
  params ["_requester", "_boxen"];
  private _ammoBoxCheck = terminalAmmoBoxenMasterHash get str(_boxen);
  private "_hintString";
  private "_num";
  if (!isNil {_ammoBoxCheck}) then {
    //we got to "PRIMARY" here ["Query called"] remoteExec ["hint"];
    switch (_ammoBoxCheck select 1) do {
      case ("PRIMARY") : {
        _num = _ammoBoxCheck select 2;
        [str(_num) + " magazines remain"] remoteExec ["hintSilent", _requester];
      };
      case ("SECONDARY") : {
        _num = _ammoBoxCheck select 2;
        [str(_num) + " items remain"] remoteExec ["hintSilent", _requester];
      };
      case ("HANDGUN") : {
        _num = _ammoBoxCheck select 2;
        [str(_num) + " magazines remain"] remoteExec ["hintSilent", _requester];
      };
      case ("MEDICAL") : {
        _num = _ammoBoxCheck select 2;
        [str(_num) + " items remain"] remoteExec ["hintSilent", _requester];
      };
      default {
        //error?
        ["Odd error encountered. Let Terminal know something's weird."] remoteExec ["hintSilent", _requester];
        _num = 1;
      };
      //[_hintString] remoteExec ["hint", _requester];
      if (_num < 1) then {
        deleteVehicle _boxen;
      };
    };
  } else {
    //box aint there, chief
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
  _boxen addAction ["Close Primary Ammo Box",{[_this select 0] call closePrimaryBox},[],1.5,true,true,"","true",10,false,"",""];
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
  _boxen addAction ["Close Launcher Ammo Box",{[_this select 0] call closeSecondaryBox},[],1.5,true,true,"","true",10,false,"",""];
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

//SIDEARM/HANDGUN
openHandgunBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  _boxen addAction ["Close Sidearm Ammo Box",{[_this select 0] call closeHandgunBox},[],1.5,true,true,"","true",10,false,"",""];
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

//MEDICAL
medicineList = [
  "ACE_fieldDressing",
  "ACE_elasticBandage",
  "ACE_packingBandage",
  "ACE_quikclot",
  "ACE_bloodIV_500",
  "ACE_epinephrine",
  "ACE_morphine",
  "ACE_splint",
  "ACE_tourniquet",
  "ACE_surgicalKit",
  "ACE_bodyBag",
  "ACE_adenosine"
];

openMedicalBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  _boxen addAction ["Close Medical Box",{[_this select 0] call closeMedicalBox},[],1.5,true,true,"","true",10,false,"",""];
  {
    private "_actionString";
    _actionString = "Take " + getText(configfile >> "CfgWeapons" >> _x >> "displayName");
    _boxen addAction [_actionString,{[_this select 3 select 0, _this select 0] call takeMagazine;},[_x],1.5,true,true,"","true",10,false,"",""];
  } forEach medicineList;
};

closeMedicalBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  _boxen addAction ["Open Medical Box",{[_this select 0] call openMedicalBox},[],1.5,true,true,"","true",10,false,"",""];
};

//
//SPAWNING CODE
//

removeInventoryFrom = {
  params ["_box"];
  clearItemCargoGlobal _box;
  /*
  TODO
  Could be useful for boxes that have inventories?
  But also prevents player from opening their inventory nearby.
  Too strong, but could be tweaked.

  _box addEventHandler [ "ContainerOpened", {
    unInventory = [] spawn {
      waitUntil{ !isNull findDisplay 602 };
      closeDialog 1;
    };
  }];
  */
};

grabNewAmmoBoxPrimary = {
  _newBox = terminalAmmoBoxPrimary createVehicle (getPos player);
  [_newBox] call removeInventoryFrom;
  [_newBox, "PRIMARY", defaultPrimaryMagazines, true] remoteExec ["initTerminalAmmoBox", 2];
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxSidearm = {
  _newBox = terminalAmmoBoxHandgun createVehicle (getPos player);
  [_newBox] call removeInventoryFrom;
  [_newBox, "HANDGUN", defaultHandgunMagazines, true] remoteExec ["initTerminalAmmoBox", 2];
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxLauncher = {
  _newBox = terminalAmmoBoxSecondary createVehicle (getPos player);
  [_newBox] call removeInventoryFrom;
  [_newBox, "SECONDARY", defaultSecondaryMagazines, true] remoteExec ["initTerminalAmmoBox", 2];
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxMedical = {
  _newBox = terminalAmmoBoxMedical createVehicle (getPos player);
  [_newBox] call removeInventoryFrom;
  [_newBox, "MEDICAL", defaultMedicalMagazines, true] remoteExec ["initTerminalAmmoBox", 2];
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};
