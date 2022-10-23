/*
FUNCTIONS
*/

grabNewAmmoBoxP = {
  _newBox = "land_fow_German_Ammo_Crate_2" createVehicle (getPos player);
  [_newBox, "PRIMARY", 15, true] call initTerminalAmmoBox;
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxS = {
  _newBox = "land_fow_German_Ammo_Crate_1" createVehicle (getPos player);
  [_newBox, "HANDGUN", 20, true] call initTerminalAmmoBox;
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

grabNewAmmoBoxL = {
  _newBox = "land_fow_German_Ammo_Crate_3" createVehicle (getPos player);
  [_newBox, "SECONDARY", 5, true] call initTerminalAmmoBox;
  _newBox setPosATL (getPosATL player);
  [_newBox, true] call ace_dragging_fnc_setCarryable;
};

ACTIONABLE_TRAINCAR = objNull;

prepCar = {
  //get the post-init traincar
  private _trainCar = prize2 getVariable ["ATRAIN_Local_Copy",prize2];
  ACTIONABLE_TRAINCAR = _trainCar;

  //Give it Beer!
  ACTIONABLE_TRAINCAR addAction ["Grab Box of Beer", grabNewBoozeBox,nil,10,true,true,"","true",9,false,"",""];

  //Give it Ammo!
  ACTIONABLE_TRAINCAR addAction ["Grab Box of Primary Ammo", grabNewAmmoBoxP,nil,9,true,true,"","true",9,false,"",""];
  ACTIONABLE_TRAINCAR addAction ["Grab Box of Sidearm Ammo", grabNewAmmoBoxS,nil,8,true,true,"","true",9,false,"",""];
  ACTIONABLE_TRAINCAR addAction ["Grab Box of Launcher Ammo", grabNewAmmoBoxL,nil,7,true,true,"","true",9,false,"",""];

  //Give it an arsenal!
  [ACTIONABLE_TRAINCAR] call makeArsenal;

  //Give it Autodoc!
  ACTIONABLE_TRAINCAR addAction["Administer Medical Aid",{[(_this select 1)] spawn activateAutodoc},[],3,true,true,"","true",9,false,"",""];
};
