removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

player forceAddUniform (profileNamespace getVariable["JUNK_Saved_Uniform2","U_C_Poloshirt_salmon"]);
player setUnitLoadout(profileNamespace getVariable["JUNK_Saved_Loadout2",[]]);
//player linkItem "ItemMap";
player linkItem "TFAR_anprc152";
//player linkItem "ItemCompass";
//player linkItem "TFAR_microdagr";
//player addVest (profileNamespace getVariable["JUNK_Saved_Vest",""]);
//player forceAddUniform (profileNamespace getVariable["JUNK_Saved_Uniform","U_C_Poloshirt_salmon"]);
//player addHeadgear (profileNamespace getVariable["JUNK_Saved_Headgear",""]);
//player addBackpack (profileNamespace getVariable["JUNK_Saved_Backpack",""]);
//player addGoggles (profileNamespace getVariable["JUNK_Saved_Facewear",""]);
//player addItem (profileNamespace getVariable["JUNK_Saved_HMD",""]);
//player assignItem (profileNamespace getVariable["JUNK_Saved_HMD",""]);

if (isFinale) then {
  player unassignItem "ItemMap";
  player removeItem "ItemMap";
} else {
  player setDir 225;
};

player enableStamina false;
