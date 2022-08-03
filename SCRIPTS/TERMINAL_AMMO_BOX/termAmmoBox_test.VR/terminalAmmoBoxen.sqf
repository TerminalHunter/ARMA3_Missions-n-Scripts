//TODO on player join, reinit the ammo boxen, because JIP is a bitch

//server init
if (isServer) then {
  primaryAmmoBoxen = createHashMap;
  //primaryAmmoBoxen = [];
};


//SEVER FUNCTIONS

initTerminalPrimaryAmmoBox = {
  params ["_boxen"];
  //primaryAmmoBoxen pushBack [_boxen, 100];
  primaryAmmoBoxen set [str(_boxen), 100];
  [_boxen, ["Open Primary Ammo Box",{[_this select 0] call openPrimaryBox},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0];
  //_boxen addAction ["Open Primary Ammo Box",{[_boxen] call openPrimaryBox},[],1.5,true,true,"","true",10,false,"",""];
};

magTakenFromPrimaryBoxen = {
  params ["_ammo","_boxen","_player"];
  //error checking?
  if (0 == (primaryAmmoBoxen get str(_boxen))) then {
    ["Box is empty"] remoteExec ["hint", _player];
  } else {
    //ammo available
    primaryAmmoBoxen set [str(_boxen), (primaryAmmoBoxen get str(_boxen)) - 1];
    [_player, _ammo] remoteExec ["addItem", _player];
    private "_hintString";
    _hintString = str(primaryAmmoBoxen get str(_boxen)) + " magazines remain";
    [_hintString] remoteExec ["hint", _player];
  };
};

canTakePrimaryMag = {
  params ["_boxen"];
  _return = (0 == (primaryAmmoBoxen get str(_boxen)));
  _return
};

//CLIENT FUNCTIONS

openPrimaryBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  //populate with current primary weapon's list of magazines
  private "_tempAmmoList";
  _tempAmmoList = [currentWeapon player] call BIS_fnc_compatibleMagazines;
  {
    private "_actionString";
    _actionString = "Take " + getText(configfile >> "CfgMagazines" >> _x >> "displayName");
    _boxen addAction [_actionString,{[_this select 3 select 0, _this select 0] call takePrimaryMagazine;},[_x],1.5,true,true,"","true",10,false,"",""];
  } forEach _tempAmmoList;
  //add thing to close box
  _boxen addAction ["Close Primary Ammo Box",{[_this select 0] call closePrimaryBox},[],1.5,true,true,"","true",10,false,"",""]
};

closePrimaryBox = {
  params ["_boxen"];
  removeAllActions _boxen;
  _boxen addAction ["Open Primary Ammo Box",{[_this select 0] call openPrimaryBox},[],1.5,true,true,"","true",10,false,"",""];
};

takePrimaryMagazine = {
  params ["_ammo", "_boxen"];
  //give player magazine
  //player addItem _ammo;
  //tell server magazine is taken
  [_ammo, _boxen, player] remoteExec ["magTakenFromPrimaryBoxen", 2];
};
