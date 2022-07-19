removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

player setUnitLoadout(player getVariable["Saved_Loadout",[]]);
player linkItem "TFAR_anprc152";

//script to stop skydiving
[] spawn {
  //spawns player in brig - prevents parachute spawning
  player setPosASL [4078.57,3632.1,440.805]; //BRIG
  //player setPosASL [4077.2,3650.21,440.806]; //Crew Quarters
  ["Artificial Gravity Calibrating - Please Wait"] spawn shorterHint;
  player switchmove "";
  sleep 0.15;
  player switchmove "";
  sleep 0.15;
  player switchmove "";
  sleep 0.15;
  player switchmove "";
  sleep 0.15;
  player switchmove "";
  ["Artificial Gravity Calibrated"] call shorterHint;
  sleep 1;
  hint "Reminder: \n No enhanced movement on the ship.";
};
