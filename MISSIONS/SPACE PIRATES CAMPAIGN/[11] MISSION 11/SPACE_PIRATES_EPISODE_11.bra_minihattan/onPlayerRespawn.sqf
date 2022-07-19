removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

player setUnitLoadout(profileNamespace getVariable["PIRATEVAR_savedLoadout",[]]);
