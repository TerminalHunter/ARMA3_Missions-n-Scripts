isFinale = false;

fullInstantHeal = {
  params ["_healer"];
  _potentialHealingTargets = _healer nearEntities 5;
  {
    if (isPlayer _x) then {
      [_healer, _x] call ace_medical_treatment_fnc_fullHeal;
      _x addItem "immersion_pops_poppack";
    };
  } forEach _potentialHealingTargets;
};

saveLoadout = {

  //sets client-side variables saved to profile instead of mission namespace
  //should persist between missions
  profileNamespace setVariable["JUNK_Saved_Vest2", vest player];
  profileNamespace setVariable["JUNK_Saved_Uniform2", uniform player];
  profileNamespace setVariable["JUNK_Saved_Headgear2", headgear player];
  profileNamespace setVariable["JUNK_Saved_Backpack2", backpack player];
  profileNamespace setVariable["JUNK_Saved_Facewear2", goggles player];
  profileNamespace setVariable["JUNK_Saved_HMD2", hmd player];

  profileNamespace setVariable["JUNK_Saved_Loadout2",getUnitLoadout player];

  //keep the mission namespace variables just in case?

  player setVariable["JUNK_Saved_Vest2", vest player];
  player setVariable["JUNK_Saved_Headgear2", headgear player];
  player setVariable["JUNK_Saved_Uniform2", uniform player];
  player setVariable["JUNK_Saved_Backpack2", backpack player];
  player setVariable["JUNK_Saved_Facewear2", goggles player];
  player setVariable["JUNK_Saved_HMD2", hmd player];

  player setVariable["JUNK_Saved_Loadout2",getUnitLoadout player];

  hintSilent "Respawn Loadout Saved!";
  sleep 3;
  hintSilent "";

};

grabRandomPosition = {
    params ["_marker"];
    _sizeArray = getMarkerSize _marker;
    _width = _sizeArray select 0;
    _height = _sizeArray select 1;
    _position = getMarkerPos _marker;
    _randomWidth = (floor random (_width*2)) - _width;
    _randomHeight = (floor random (_height*2)) - _height;
    _return = _position vectorAdd [_randomWidth, _randomHeight, 0];
    _return
};

areWeDoneYet = {
  _cansToAdd = personalCanCount;
  personalCanCount = 0;
  totalCansTurnedIn = totalCansTurnedIn + _cansToAdd;
  publicVariable "totalCansTurnedIn";
  //_update = [] call canCount;
	_percentage = floor((totalCansTurnedIn / 2500) * 100);
	//hint format ["%1%2 done!", str _percentage, "%"];
  if (_percentage > 99) then {
     [format ["%1%2 of your team's daily quota done!\nGreat Job!\nKeep going for bonus rewards!", str _percentage, "%"]] remoteExec ["hint", 0, false];
  } else {
	   [format ["%1%2 of your team's daily quota done!", str _percentage, "%"]] remoteExec ["hint", 0, false];
  };
};

idapUniforms = [
"U_C_IDAP_Man_cargo_F",
"U_C_IDAP_Man_Jeans_F",
"U_C_IDAP_Man_casual_F",
"U_C_IDAP_Man_shorts_F",
"U_C_IDAP_Man_Tee_F",
"U_C_IDAP_Man_TeeShorts_F"
];

makeCannibal = {
	params ["_dude"];
	_cannibalCan = (selectRandom boozen) createVehicle (getPos _dude);
	_cannibalCan attachTo [_dude, [-0.05,-0.1,0.05], "head"];
	_cannibalCan attachTo [_dude];
	[_dude, "Deerface1"] remoteExec ["setFace", 0, false];
	//_dude setFace "Deerface1";
  removeHeadgear _dude;
  removeGoggles _dude;
  _dude forceAddUniform (selectRandom idapUniforms);
  removeVest _dude;
  _dude addVest "V_Plain_medical_F";
	[_cannibalCan, _dude] spawn {
		params ["_can", "_dude"];
		waitUntil {(_dude getVariable ["ACE_isUnconscious", false]) || !(alive _dude)};
		detach _can;
	};
};

spookyHeads = [
  "Deerface4",
  "Deerface5",
  "Deerface6"
];

spookyFire = {
  params ["_burnee"];
  _sparkler = createVehicle ["#particleSource", getPosASL _burnee,[],0,"CAN_COLLIDE"];
  _sparkler setPosASL ((getPosASL _burnee) vectorAdd [0,0,0.2]);
  _sparkler setParticleClass "ObjectDestructionFire1Small";
  sleep 4;
  deleteVehicle _sparkler;
};

makeSpooky = {
  params ["_dude"];
  //_dude setFace (selectRandom spookyHeads);
  [_dude, (selectRandom spookyHeads)] remoteExec ["setFace", 0, false];
  removeHeadgear _dude;
  removeGoggles _dude;
  removeVest _dude;
  _dude forceAddUniform "U_O_Protagonist_VR";
  _dude addItemToUniform "rhs_100Rnd_762x54mmR_green";
  _dude addItemToUniform "rhs_30Rnd_762x39mm_tracer";
  _dude addItemToUniform "rhs_30Rnd_762x39mm_tracer";
  _dude addItemToUniform "rhs_30Rnd_762x39mm_tracer";
  _dude addItemToUniform "rhs_30Rnd_762x39mm_tracer";
  _dude addItemToUniform "AM_Molotov_throw";
  _dude addItemToUniform "AM_Molotov_throw";
};

ghostGunHorde = {
  params ["_locationObject"];
  _location = getPos _locationObject;
  _newGhosts = [_location, East, (configfile >> "CfgGroups" >> "East" >> "rhsgref_faction_chdkz" >> "rhsgref_group_chdkz_insurgents_infantry" >> "rhsgref_group_chdkz_infantry_patrol")] call BIS_fnc_spawnGroup;
  {
    [_x] call makeSpooky;
  } forEach (units _newGhosts);
};

cannibalGunHorde = {
  params ["_locationObject"];
  _location = getPos _locationObject;
  _newCannibals = [_location, East, (configfile >> "CfgGroups" >> "East" >> "rhsgref_faction_chdkz" >> "rhsgref_group_chdkz_insurgents_infantry" >> "rhsgref_group_chdkz_infantry_patrol")] call BIS_fnc_spawnGroup;
  {
    [_x] call makeCannibal;
  } forEach (units _newCannibals);
};
//configfile >> "CfgGroups" >> "East" >> "rhsgref_faction_chdkz" >> "rhsgref_group_chdkz_insurgents_infantry" >> "rhsgref_group_chdkz_infantry_patrol"

cannibalMelee = {
  params ["_locationObject"];
  _location = getPos _locationObject;
  _tempGroup = createGroup [east, true];
  _newCannibal = _tempGroup createUnit ["O_soldier_Melee_RUSH_fists", _location, [], 0, "NONE"];
  _newCannibal2 = _tempGroup createUnit ["O_soldier_Melee_RUSH_fists", _location, [], 0, "NONE"];
  [_newCannibal] call makeCannibal;
  [_newCannibal2] call makeCannibal;
};

ghostMelee = {
  params ["_locationObject"];
  _location = getPos _locationObject;
  _tempGroup = createGroup [east, true];
  _newGhost = _tempGroup createUnit ["O_soldier_Melee_RUSH", _location, [], 0, "NONE"];
  _newGhost2 = _tempGroup createUnit ["O_soldier_Melee_RUSH", _location, [], 0, "NONE"];
  [_newGhost] call makeSpooky;
  [_newGhost2] call makeSpooky;
};

_spookyDissapearHandler = ["ace_unconscious",{
  if (uniform (_this select 0) == "U_O_Protagonist_VR") then {
    [(_this select 0)] spawn spookyFire;
    deleteVehicle (_this select 0);
  };
}] call CBA_fnc_addEventHandler;

//during finale, warn players that try to escape
[] spawn {
  waitUntil {isFinale};
  while {isFinale} do {
    sleep 3;
    if ((getPosASL player) select 2 > 30) then {
      hint "You may escape if you continue this way, but at what cost?";
      sleep 30;
    };
  };
};

myPPSmak = {
	hintSilent "You were smacked on the PP";
	addCamShake [4, 0.5, 5];
	sleep 3;
	hintSilent "";
};
_smakAction = ["SmackPP","Smack PP","",{
	params ["_target","_smaker","_params"];
	addCamShake [4, 0.5, 5];
	if (alive _target) then {
		[] remoteExec ["myPPSmak",_target,false];
	};
	},{true}] call ace_interact_menu_fnc_createAction;
["I_G_Survivor_F", 0, ["ACE_MainActions"], _smakAction, true] call ace_interact_menu_fnc_addActionToClass;

chapter1Secret addAction ["SECRET RADIO #1", {
  playSound3D ["easterEggBeerLabels2021\Bones.ogg", chapter1Secret, false, getPosASL chapter1Secret, 1, 1, 8];
  removeAllActions chapter1Secret;
},[],1.5,true,true,"","true",10,false,"",""];

chapter2Secret addAction ["SECRET RADIO #2", {
  playSound3D ["easterEggBeerLabels2021\Panda.ogg", chapter2Secret, false, getPosASL chapter2Secret, 1, 1, 8];
  removeAllActions chapter2Secret;
},[],1.5,true,true,"","true",10,false,"",""];

chapter3Secret addAction ["SECRET RADIO #3", {
  playSound3D ["easterEggBeerLabels2021\CCR.ogg", chapter3Secret, false, getPosASL chapter3Secret, 1, 1, 8];
  removeAllActions chapter3Secret;
},[],1.5,true,true,"","true",10,false,"",""];

chapter4Secret addAction ["SECRET RADIO #4", {
  playSound3D ["easterEggBeerLabels2021\Grue.ogg", chapter4Secret, false, getPosASL chapter4Secret, 1, 1, 8];
  removeAllActions chapter4Secret;
},[],1.5,true,true,"","true",10,false,"",""];

chapter5Secret addAction ["SECRET RADIO #5", {
  playSound3D ["easterEggBeerLabels2021\AA.ogg", chapter5Secret, false, getPosASL chapter5Secret, 1, 1, 8];
  removeAllActions chapter5Secret;
},[],1.5,true,true,"","true",10,false,"",""];
