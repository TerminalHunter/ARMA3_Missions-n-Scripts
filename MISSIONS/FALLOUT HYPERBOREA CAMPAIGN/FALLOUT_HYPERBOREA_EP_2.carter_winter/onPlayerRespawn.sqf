removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

//player setUnitLoadout(player getVariable["Saved_Loadout",[]]);
//player linkItem "ItemMap"; no map for uncharted territory
player linkItem "TFAR_rf7800str";
player linkItem "ItemCompass";
player linkItem "TFAR_microdagr";
player addVest (profileNamespace getVariable["Saved_Vest","AM_AvBagInvis"]);
player addUniform (profileNamespace getVariable["Saved_Uniform","armor_ncr_trooper_01_winter_uniform"]);
player addHeadgear (profileNamespace getVariable["Saved_Headgear","armor_ncr_trooper_helm_winter"]);
player addBackpack (profileNamespace getVariable["Saved_Backpack",""]);
player addGoggles (profileNamespace getVariable["Saved_Facewear",""]);
player addItem (profileNamespace getVariable["Saved_HMD",""]);
player assignItem (profileNamespace getVariable["Saved_HMD",""]);

//mission related - this probably shouldn't be here
/*

player addAction ["Stake Climbing Rope Here",{
    [player, 500, (getPosASL player), (vectorDir player)] spawn AUR_Rappel_Unit;
  },[],1.5,true,true,"","true"];

*/
