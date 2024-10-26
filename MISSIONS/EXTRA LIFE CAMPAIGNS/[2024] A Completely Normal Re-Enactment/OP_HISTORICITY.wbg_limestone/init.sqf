#include "arsenal.sqf"
#include "terminalEZRevive.sqf"
#include "timeWarp\rupture.sqf"
#include "finale\flyingDutchman2.sqf"
#include "introCutscene.sqf"
#include "story.sqf"
#include "canCode.sqf"
#include "british.sqf"

/*
mission starts with
redeemsPaused = true;
inCutscene = true;
*/

setTimeMultiplier 0;
ace_hearing_disableVolumeUpdate = true; //maybe not needed? Turn off combat deafness in settings just to be sure.

[booze1] call makeBoozeBox;
[booze2] call makeBoozeBox;

musicTest addAction [
    "Begin Music Test", 
    "
        playMusic 'woodpileMedium';
    ", 
    [], 15, true, true, "", "", 5, false, "", ""
];

musicTest addAction [
    "Stop Music", 
    "
        playMusic '';
    ", 
    [], 14, true, true, "", "", 5, false, "", ""
];

//SECRET RADIOS
pizzaRadio addAction [
    "SECRET RADIO #1", 
    "
        playSound3D [getMissionPath 'music\sillyMetal.ogg', _this select 0, false, getPosASL (_this select 0), 1, 1, 20];
    ", 
    [], 15, true, true, "", "", 5, false, "", ""
];
pizzaRadio addAction [
    "The Pirates Who Don't Do Anything by Jonathan Young", 
    "

    ", 
    [], 14, true, true, "", "", 5, false, "", ""
];
// kennethRadio woodpileSlow
kennethRadio addAction [
    "SECRET RADIO #2", 
    "
        playSound3D [getMissionPath 'music\woodpileSlow.ogg', _this select 0, false, getPosASL (_this select 0), 1, 1, 20];
    ", 
    [], 15, true, true, "", "", 5, false, "", ""
];
kennethRadio addAction [
    "Roll the Woodpile Down by Daniel Kelly", 
    "

    ", 
    [], 14, true, true, "", "", 5, false, "", ""
];
//lopezRadio
lopezRadio addAction [
    "SECRET RADIO #3", 
    "
        playSound3D [getMissionPath 'music\blackPowderAlcohol.ogg', _this select 0, false, getPosASL (_this select 0), 1, 1, 20];
    ", 
    [], 15, true, true, "", "", 5, false, "", ""
];
lopezRadio addAction [
    "Black Powder and Alcohol by Leslie Fish", 
    "

    ", 
    [], 14, true, true, "", "", 5, false, "", ""
];
//firingRangeRadio
firingRangeRadio addAction [
    "SECRET RADIO #4", 
    "
        playSound3D [getMissionPath 'music\halloween.ogg', _this select 0, false, getPosASL (_this select 0), 1, 1, 20];
    ", 
    [], 15, true, true, "", "", 5, false, "", ""
];
firingRangeRadio addAction [
    "You Make Me Feel Like It's Halloween by Muse", 
    "

    ", 
    [], 14, true, true, "", "", 5, false, "", ""
];