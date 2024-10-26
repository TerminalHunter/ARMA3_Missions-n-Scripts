params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

//*****
//EZ REVIVE INIT
//*****
[_newUnit] call EZReviveHelper;

//INVENTORY STUFF
removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

defaultLoadout = [[],[],[],["U_C_Poloshirt_blue",[["ACE_personalAidKit",1]]],[],[],"","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];

player setUnitLoadout(profileNamespace getVariable["EXTRALIFE2024_savedLoadout_FINAL", defaultLoadout]);

player linkItem "TFAR_anprc152";
player linkItem "ItemMap";
player linkItem "ItemGPS";
player linkItem "ItemCompass";
player linkItem "ItemWatch";