//TODO on player join, reinit the ammo boxen, because JIP is a bitch

//server init
if (isServer) then {
  primaryAmmoBoxen = createHashMap;
  secondaryAmmoBoxen = createHashMap;
  handgunAmmoBoxen = createHashMap;
  //why did I do this in the first place? couldn't this all be in the same hash?
  //remember that you're dumb

  // JIP HANDLER
  addMissionEventHandler ["PlayerConnected",
    {
      params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
      if (_jip) then {
        //primary
        {
          [_y select 0] remoteExec ["removeAllActions", 0];
          [_y select 0, _y select 1, _y select 2, false] call initTerminalAmmoBox;
        } forEach primaryAmmoBoxen;
        //secondary
        {
          [_y select 0] remoteExec ["removeAllActions", 0];
          [_y select 0, _y select 1, _y select 2, false] call initTerminalAmmoBox;
        } forEach secondaryAmmoBoxen;
        //launcher
        {
          [_y select 0] remoteExec ["removeAllActions", 0];
          [_y select 0, _y select 1, _y select 2, false] call initTerminalAmmoBox;
        } forEach launcherAmmoBoxen;
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
      //arma behind the scenes uses handgun -- but my player base says secondary and side arm
      //FUNNY HOW ARMA SAYS LAUNCHERS ARE SECONDARIES...
      [_box, ["Open Sidearm Ammo Box",{[_this select 0] call openHandgunBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
    };
    default {
      if (_firstInit) then {
        primaryAmmoBoxen set [str(_box), [_box, _type, _mags]];
      };
      [_box, ["Open Primary Ammo Box",{[_this select 0] call openPrimaryBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
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

  switch (true) do {
    case (!isNil {_primaryCheck}): {
      if (0 == _primaryCheck select 2) then {
        ["Box is empty"] remoteExec ["hint", _player];
      } else {
        if (_player canAdd _ammo) then {
          primaryAmmoBoxen set [str(_boxen), [_primaryCheck select 0, _primaryCheck select 1, (_primaryCheck select 2) - 1]];
          [_player, _ammo] remoteExec ["addItem", _player];
          private "_hintString";
          _hintString = str(primaryAmmoBoxen get str(_boxen) select 2) + " magazines remain"; //potentially optimize - for debug purposes, this can stay but, like, keep it local
          [_hintString] remoteExec ["hint", _player];
        } else {
          private _hintString = "INVENTORY FULL";
          [_hintString] remoteExec ["hint", _player];
        };
      };
    };
    case (!isNil {_secondaryCheck}): {
      if (0 == _secondaryCheck select 2) then {
        ["Box is empty"] remoteExec ["hint", _player];
      } else {
        if (_player canAdd _ammo) then {
          secondaryAmmoBoxen set [str(_boxen), [_secondaryCheck select 0, _secondaryCheck select 1, (_secondaryCheck select 2) - 1]];
          [_player, _ammo] remoteExec ["addItem", _player];
          private "_hintString";
          _hintString = str(secondaryAmmoBoxen get str(_boxen) select 2) + " magazines remain"; //potentially optimize - for debug purposes, this can stay but, like, keep it local
          [_hintString] remoteExec ["hint", _player];
        } else {
          private _hintString = "INVENTORY FULL";
          [_hintString] remoteExec ["hint", _player];
        };
      };
    };
    case (!isNil {_handgunCheck}): {
      if (0 == _handgunCheck select 2) then {
        ["Box is empty"] remoteExec ["hint", _player];
      } else {
        if (_player canAdd _ammo) then {
          handgunAmmoBoxen set [str(_boxen), [_handgunCheck select 0, _handgunCheck select 1, (_handgunCheck select 2) - 1]];
          [_player, _ammo] remoteExec ["addItem", _player];
          private "_hintString";
          _hintString = str(handgunAmmoBoxen get str(_boxen) select 2) + " magazines remain"; //potentially optimize - for debug purposes, this can stay but, like, keep it local
          [_hintString] remoteExec ["hint", _player];
        } else {
          private _hintString = "INVENTORY FULL";
          [_hintString] remoteExec ["hint", _player];
        };
      };
    };
    default {
      /* TODO: this should REALLY give a proper error */
    };
  };
};

//
//CLIENT FUNCTIONS
//

takeMagazine = {
  params ["_ammo", "_boxen"];
  //tell server magazine is taken
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
