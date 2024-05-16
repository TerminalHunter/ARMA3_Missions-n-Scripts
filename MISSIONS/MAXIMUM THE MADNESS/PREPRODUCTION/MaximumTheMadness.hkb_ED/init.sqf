/*
TODO:
    I guess also save arbitrary items? Let the players take things home.
    Nothing mission-related should spawn within 1km of the western edge of the map.
    Gas siphons?
    Hidden Caches and side-treasures
    SCRAPPING MECHANIC: wrecks -> toolkits
    see if you can't do kitbashing better than other missions
*/

#include "setUpMission.sqf"
#include "raiderArsenal.sqf"
#include "saveSystem.sqf"
#include "convoy.sqf"

[] call updateArsenal;
[exfilJackShack] call makePirateArsenal;