removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

//player setUnitLoadout(player getVariable["Saved_Loadout",[]]);
player linkItem "ItemMap";
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

//mission related

//radiation zone init
player setVariable ["Pcolor", 0.75];
player setVariable ["Pbright", 1.0];
player setVariable ["Pgrain", 0.005];
player setVariable ["Pblur", 0];
player setVariable ["Pdamage", 0];
player setVariable ["Pstamina", 60];

"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.75],[0.5,0.3,1.0,-0.1]];
"colorCorrections" ppEffectCommit 0;

"DynamicBlur" ppEffectAdjust [0];
"DynamicBlur" ppEffectCommit 0;
"DynamicBlur" ppEffectEnable TRUE;
