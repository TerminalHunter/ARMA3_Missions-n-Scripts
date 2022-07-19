savePirateLoadout = {

  //sets client-side variables saved to profile instead of mission namespace
  //should persist between missions
  profileNamespace setVariable["PIRATEVAR_savedLoadout",getUnitLoadout player];

  //keep the mission namespace variables just in case?
  player setVariable["PIRATEVAR_savedLoadout_local",getUnitLoadout player];

  hintSilent "Respawn Loadout Saved!";
  sleep 3;
  hintSilent "";

};
