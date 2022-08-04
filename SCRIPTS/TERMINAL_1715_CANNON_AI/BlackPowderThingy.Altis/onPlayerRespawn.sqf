removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

player setUnitLoadout(profileNamespace getVariable["TEMPVAR_savedLoadout",[[],[],[],["1715_slops_3_greyblackwhite1",[]],["1715_vest_engblk_soldier",[]],["1715_haversack_black",[]],"","",["1715_spyglass", "", "", "", [], [], ""],["ItemMap","","","ItemCompass","",""]]]);

player setDir 180;
