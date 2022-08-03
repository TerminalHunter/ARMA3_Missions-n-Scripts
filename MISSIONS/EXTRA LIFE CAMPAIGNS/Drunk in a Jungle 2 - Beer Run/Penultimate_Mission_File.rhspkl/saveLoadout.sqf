saveLoadout = {
  player setVariable["Saved_Loadout",getUnitLoadout player];
  hintSilent "Respawn Loadout Saved!";
  sleep 3;
  hintSilent "";
};