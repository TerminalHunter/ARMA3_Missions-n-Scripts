OPFORMedievalUniforms = [
  "HL_UNI_2",
  "DKoK_Gren_Uniform_1490th",
  "1715_slops_3_browngreenbrown",
  "1715_slops_3_browngreenwhite2",
  "1715_justa_3a_a_green"
];

medievalMeleeWeapons = [
  "WBK_SmallSword",
  "WBK_Spear",
  "WBK_Halbert",
  "WBK_SmallWarHammer_Hammer",
  "WBK_FeudalMaul"
];

medievalRangedWeapons = [
  "1715_LandPat",
  "1715_LandPatRifle",
  "1715_Seapat",
  "1715_Blunderbuss"
];

equipMedievalOPFOR_ranged = {
  params ["_dude"];
  removeAllWeapons _dude;
  removeGoggles _dude;
  removeHeadgear _dude;
  removeVest _dude;
  removeUniform _dude;
  removeAllAssignedItems _dude;
  clearAllItemsFromBackpack _dude;
  removeBackpack _dude;
  _dude forceAddUniform selectRandom OPFORMedievalUniforms;
  _dude addHeadgear "Dos_Kettle_Helm_1";
  //_dude addBackpackGlobal "Fued_Dos_Pack_1";
  _dude addBackpackGlobal "TIOW_CadBackpack";
  waitUntil {!isNull backpackContainer _dude};
  _dude addMagazines ["1715_cartridge_ball_69", 50];
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addWeapon (selectRandom medievalRangedWeapons);
};

equipMedievalOPFOR_melee = {
  params ["_dude"];
  removeAllWeapons _dude;
  removeGoggles _dude;
  removeHeadgear _dude;
  removeVest _dude;
  removeUniform _dude;
  removeAllAssignedItems _dude;
  clearAllItemsFromBackpack _dude;
  removeBackpack _dude;
  _dude forceAddUniform "HL_Uni_1";
  _dude addVest "Vest_HL_1";
  _dude addHeadgear "HT_Sallet_Helm_2";
  _dude addWeapon (selectRandom medievalMeleeWeapons);
};