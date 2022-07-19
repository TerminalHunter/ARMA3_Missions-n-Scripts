#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "saveLoadout.sqf"
#include "glowstickEat.sqf"
//#include "spaceTeamDirector.sqf"

enableSaving [false, false];

[jackShack] call makePirateArsenal;
//[jackShack2] call makePirateArsenal;

//brig respawn position
// [4078.662,3632.705,435.804]
//ASL [4078.57,3632.1,440.805]
//ATL [4078.57,3632.1,435.805]

if (isServer) then {
  [] spawn {
    waitUntil {time > 0};
    while {alive veryDistractedGuard} do {
      playSound3D [getMissionPath "sfx\T-Bag(Muffled).ogg", veryDistractedGuard, false, getPosASL veryDistractedGuard vectorAdd [0,0,0.5], 2, 1, 40];
      sleep 200;
    };
  };
};


randomBillList = [
  "YOU ARE IN FINANCIAL NON-COMPLIANCE",
  "FINE FOR ISSUANCE OF EXCESSIVE FINES",
  "TICKET AND NOTICE OF NON-PAYMENT",
  "OVERDRAW",
  "NOTICE TO APPEAR",
  "COLLECTIONS NOTICE",
  "IMPORTANT -- OPEN NOW!",
  "HOW TO: TRANSLATE LEGALESE",
  "DEFENDING YOURSELF IN SPACE COURT FOR DUMMIES",
  "WARNING: LATE PAYMENT",
  "NEBULA TAX",
  "TIME COP FINE",
  "BUREAU OF BUREAUCRACY ORGANIZATION FEE",
  "DUE NOW!",
  "OVERDUE",
  "PARKING TICKET",
  "SPACE BILL",
  "WE'RE WRITING ABOUT YOUR SHIPS EXTENDED WARRANTY"
];

for "_i" from 1 to 100 do {
  pileOfBills addAction [selectRandom randomBillList, {},[],1.5,true,true,"","true",10,false,"",""];
};

/*
TODO: ADD SHIT TO
Captains
Cryo
Drop Bay?
Engine Rooms
Gym
Head
Hangar and Lower
Officers
Rec Room
Squad Bays

we had to cancel the pirate rave -- we subsisted on glowsticks for weeks

*/


shanties = [
  "DawsonsChristian.ogg",
  "DrunkSpacePirate.ogg",
  "HanrahansBar.ogg",
  "ProvidenceSkies.ogg",
  "PushinTheSpeedOfLight.ogg",
  "SpacersHome.ogg",
  "SpaceShanty.ogg"
];

pirateClothes = [
  "1715_justa_1c_b_redblue",
  "1715_justa_1a_b_whitered",
  "1715_justa_1a_b_redgold",
  "1715_justa_1b_b_redgold",
  "1715_justa_1c_b_redgold",
  "1715_justa_1d_b_redgold",
  "1715_justa_1g_b_redgold",
  "1715_justa_3c_a_black",
  "1715_justa_3c_b_black",
  "1715_justa_3c_c_black",
  "1715_justa_3c_a_red",
  "1715_justa_3c_a_grey",
  "1715_justa_3c_a_brown",
  "1715_justa_3c_c_brown",
  "1715_justa_3c_a_tan",
  "1715_justa_3c_a_orange",
  "1715_justa_3c_b_red",
  "1715_justa_3c_c_red",
  "1715_justa_3f_a_green",
  "1715_justa_3f_b_green",
  "1715_justa_3f_c_green",
  "1715_justa_3f_a_puke",
  "1715_justa_3f_b_puke",
  "1715_justa_3f_c_puke",
  "1715_justa_3g_a_tan",
  "1715_justa_3g_b_tan",
  "1715_justa_3g_c_tan",
  "1715_justa_3g_a_red",
  "1715_justa_3g_b_red",
  "1715_justa_3g_c_red",
  "1715_justa_3g_a_grey",
  "1715_justa_3g_a_black",
  "1715_justa_3g_c_black",
  "1715_justa_3a_a_brown",
  "1715_justa_3a_b_brown",
  "1715_justa_3a_c_brown",
  "1715_justa_3a_a_black",
  "1715_justa_3a_a_green",
  "1715_justa_3a_a_tan",
  "1715_justa_3a_c_tan",
  "1715_justa_3a_a_grey",
  "1715_justa_3a_a_navblumas",
  "1715_justa_3a_a_navblu",
  "1715_justa_3a_b_navblu",
  "1715_justa_3a_c_navblu",
  "1715_justa_3c_a_navblu",
  "1715_justa_3c_b_navblu",
  "1715_justa_3c_c_navblu",
  "1715_justa_3d_a_navblu",
  "1715_justa_3d_b_navblu",
  "1715_justa_3d_c_navblu",
  "1715_justa_3i_b_span",
  "1715_justa_3i_c_span",
  "1715_justa_3j_b_span",
  "1715_justa_3j_c_span",
  "1715_justa_3k_b_span",
  "1715_justa_3k_c_span",
  "1715_justa_3l_a_span",
  "1715_justa_3_eng_r_pvt",
  "1715_justa_3_eng_r_cpl",
  "1715_justa_3_eng_r_sgt",
  "1715_justa_3_eng_r_lt",
  "1715_justa_3_eng_r_cpt",
  "1715_justa_3_eng_b_pvt",
  "1715_justa_3_eng_b_cpl",
  "1715_justa_3_eng_g_pvt",
  "1715_justa_3_eng_g_cpl",
  "1715_slops_1_brown",
  "1715_slops_2_brown",
  "1715_slops_1_white",
  "1715_slops_2_white",
  "1715_slops_1_redwhite",
  "1715_slops_2_redwhite",
  "1715_slops_1_blackstripe",
  "1715_slops_2_blackstripe",
  "1715_slops_1_black",
  "1715_slops_2_black",
  "1715_slops_3_browngreenwhite2",
  "1715_slops_3_greyblackblack",
  "1715_slops_3_whitetanbrown",
  "1715_slops_3_whiteredwhite2",
  "1715_slops_3_browngreenbrown",
  "1715_slops_3_tanbrownwhite1",
  "1715_slops_3_greyblackwhite1"
];

pirateVests = [
  "1715_vest_eng_cartouche",
  "1715_vest_engblk_cartouche"
];

pirateBackPacks = [
  "1715_haversack_tan",
  "1715_haversack_black",
  "1715_haversack_white"
];

singShanty = {
  params ["_singer"];
  _path = "easterEggBeerLabels2021\" + (selectRandom shanties);
  playSound3D [_path, _singer];
};

shantyRadio addAction ["Queue Shanty", {
    [shantyRadio] call singShanty;
    [shantyRadio] remoteExec ["removeAllActions", 0, true];
  },[],1.5,true,true,"","true",10,false,"",""];

popTable addItemCargoGlobal ["immersion_pops_poppack", 2];

dumm addAction ["Grab a Pirate Costume - May delete items, secure inventory first", {
  removeVest player;
  removeUniform player;
  removeBackpack player;
  player forceAddUniform (selectRandom pirateClothes);
  player addVest (selectRandom pirateVests);
  player addBackpack (selectRandom pirateBackPacks);
  },[],1.5,true,true,"","true",10,false,"",""];
