removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

//player setUnitLoadout(player getVariable["Saved_Loadout",[]]);

player addUniform "SC_Uniform_Gloves_Black";
player linkItem "ItemMap";
player linkItem "TFAR_anprc152";
player linkItem "ItemCompass";
player linkItem "ItemGPS";
