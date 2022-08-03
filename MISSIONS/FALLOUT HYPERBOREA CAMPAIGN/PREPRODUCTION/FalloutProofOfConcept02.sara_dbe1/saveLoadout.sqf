player setVariable["Saved_Vest", vest player];
player setVariable["Saved_Uniform", uniform player];
player setVariable["Saved_Headgear", headgear player];
player setVariable["Saved_Backpack", backpack player];
player setVariable["Saved_Facewear", goggles player];
player setVariable["Saved_HMD", hmd player];

player setVariable["Saved_Loadout",getUnitLoadout player];
hintSilent "Respawn Loadout Saved!";