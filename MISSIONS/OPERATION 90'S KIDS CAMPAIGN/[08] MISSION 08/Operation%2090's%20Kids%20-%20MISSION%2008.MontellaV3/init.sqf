#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

//Fuck Grass.
setTerrainGrid 50;

//Set the viewdistance
[4000,2500,100] call Zen_SetViewDistance;

//Forced Decrewing Script - Because Opioid Abuse is bad.
_decrewAction = ["ForceDecrew","Force Crew Out of Vehicle","",{[90, _target, {{_dude = _x select 0;doGetOut _dude;}forEach fullCrew (_this select 0);},{}, "Fighting Crew"] call ace_common_fnc_progressBar;},{true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _decrewAction, true] call ace_interact_menu_fnc_addActionToClass;

// This will fade in from black, to hide jarring actions at mission start, this is optional and you can change the value. I don't know why I included this here, it was part of Zenophon's Framework.
titleText ["Mission Initializing - Hold on for a second, you drunk fucks.", "BLACK FADED", 0.5];
// Some functions may not continue running properly after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
sleep 1;

//ACEX Fortify

[independent, 7000, [["Land_BagFence_Long_F", 20], ["Land_BagFence_Corner_F", 20], ["Land_BagFence_Round_F", 20], ["Land_BagFence_Short_F", 10], ["Land_BagBunker_Small_F", 100], ["Land_BagBunker_Tower_F", 400], ["Land_CncBarrier_F", 10], ["Land_CncBarrierMedium_F", 20], ["Land_CncBarrierMedium4_F", 80], ["Land_CncWall1_F", 30], ["Land_CncWall4_F", 120],["Land_Camping_Light_F", 5], ["Land_PortableLight_double_F", 20]]] call acex_fortify_fnc_registerObjects;

