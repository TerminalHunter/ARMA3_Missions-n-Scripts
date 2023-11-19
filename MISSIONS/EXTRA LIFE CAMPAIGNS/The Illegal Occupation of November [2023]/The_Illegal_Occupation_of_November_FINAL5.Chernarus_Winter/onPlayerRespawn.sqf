removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

//defaultLoadout = [[[],[],[],["U_civil_UN",[]],["V_UN_blue_ballistic",[]],["bc036_invisible_kitbag",[]],"rhsgref_helmet_pasgt_un","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]],[]];

defaultLoadout = [[],[],[],["U_civil_UN",[]],["V_UN_blue_ballistic",[]],["bc036_invisible_kitbag",[]],"rhsgref_helmet_pasgt_un","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152_2","ItemCompass","ItemWatch",""]];

player setUnitLoadout(defaultLoadout);

//defaultLoadout = [[[],[],[],["U_civil_UN",[["FirstAidKit",1]]],["V_UN_blue_ballistic",[]],["bc036_invisible_kitbag",[]],"rhsgref_helmet_pasgt_un","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]],[]];
//player setUnitLoadout(defaultLoadout);
//player setUnitLoadout(profileNamespace getVariable["EXTRALIFE2023_savedLoadout_FINAL", defaultLoadout]);
//player setUnitLoadout(defaultLoadout);
//player linkItem "TFAR_anprc152";