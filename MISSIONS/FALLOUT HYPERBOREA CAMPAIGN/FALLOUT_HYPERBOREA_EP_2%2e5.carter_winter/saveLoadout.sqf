saveHyperboreaLoadout = {

  //sets client-side variables saved to profile instead of mission namespace
  //should persist between missions
  profileNamespace setVariable["Saved_Vest", vest player];
  profileNamespace setVariable["Saved_Uniform", uniform player];
  profileNamespace setVariable["Saved_Headgear", headgear player];
  profileNamespace setVariable["Saved_Backpack", backpack player];
  profileNamespace setVariable["Saved_Facewear", goggles player];
  profileNamespace setVariable["Saved_HMD", hmd player];

  profileNamespace setVariable["Saved_Loadout",getUnitLoadout player];

  //keep the mission namespace variables just in case?

  player setVariable["Saved_Vest", vest player];
  player setVariable["Saved_Uniform", uniform player];
  player setVariable["Saved_Headgear", headgear player];
  player setVariable["Saved_Backpack", backpack player];
  player setVariable["Saved_Facewear", goggles player];
  player setVariable["Saved_HMD", hmd player];

  player setVariable["Saved_Loadout",getUnitLoadout player];

  hintSilent "Respawn Loadout Saved!";
  sleep 3;
  hintSilent "";

};

arsenalAntiCheat = {
  params ["_player"];
  _previousLoadout = _player getVariable "arsenalCheatCheck";
  _currentLoadout = getUnitLoadout _player;
  //if ( ((_currentLoadout select 3) select 1) isEqualTo ((_previousLoadout select 3) select 1) ) then {
  //set previous loadout to new loadout -

  if (count (_previousLoadout select 3) == 2 && count (_currentLoadout select 3) == 2) then {
    _uniformCheck = ((_currentLoadout select 3) select 1) - ((_previousLoadout select 3) select 1);
    if (count _uniformCheck == 0) then {
      //do nothing
    } else {
      sleep 5;
      hint ("I see you UNIFORM sinning. Throw that " + str _uniformCheck + " away.");
    };
  };

  if (count (_previousLoadout select 4) == 2 && count (_currentLoadout select 4) == 2) then {
    _vestCheck = ((_currentLoadout select 4) select 1) - ((_previousLoadout select 4) select 1);
    if (count _vestCheck == 0) then {
      //do nothing
    } else {
      sleep 5;
      hint ("I see you VEST sinning. Throw that " + str _vestCheck + " away.");
    };
  };

  if (count (_previousLoadout select 5) == 2 && count (_currentLoadout select 5) == 2) then {
    _backpackCheck = ((_currentLoadout select 5) select 1) - ((_previousLoadout select 5) select 1);
    if (count _backpackCheck == 0) then {
      //do nothing
    } else {
      hint ("I see you BACKPACK sinning. Throw that " + str _backpackCheck + " away.");
    };
  };
};

/*

[
  [],
  [],
  [],
  ["combat_ranger_winter_uniform",[]],
  ["AM_AvBagInvis",[]],
  ["FRXA_tf_rt1523g_big_UCP",[]],
  "armor_ncr_trooper_helm_winter",
  "",
  [],
  ["ItemMap","","TFAR_rf7800str_2","ItemCompass","TFAR_microdagr",""]
]

*/
