removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

defaultLoadout = [["rhs_weap_m1garand_sa43","","","",["rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle",8],[],""],[],[],["fow_u_us_m37_02_private",[["ACE_EntrenchingTool",1],["ACE_Fortify",1],["ACE_Flashlight_MX991",1],["ACE_MapTools",1]]],["fow_v_us_garand_bandoleer",[["ACE_epinephrine",1],["ACE_morphine",2],["ACE_packingBandage",12],["ACE_splint",2],["ACE_tourniquet",2],["rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle",12,8]]],[],"fow_h_us_m1","",[],["ItemMap","","TFAR_anprc152_2","ItemCompass","ItemWatch",""]];

player setUnitLoadout(profileNamespace getVariable["EXTRALIFE2022_savedLoadout_FINAL", defaultLoadout]);

player linkItem "TFAR_rf7800str";



/*
spawn positions
CASTLE: [1639.39,9427.16,0.550186]
LUMBER: [989.034,7418.35,0.495514]
WONSON: [1770.7,4992.2,0.322556]
*/

[] spawn {
  sleep 0.2;
  if (player distance2D [1639.39,9427.16,0.00143433] < 10) then {
    player setPosASL [1639.39,9427.16,221.361];
  };
  if (player distance2D [988.673,7418.44,0.00143433] < 10) then {
    player setPosASL [988.673,7418.44,175.852];
  };
  if (player distance2D [1769.91,4992.75,0.00143433] < 10) then {
    player setPosASL [1769.91,4992.75,172.414];
  };
};
