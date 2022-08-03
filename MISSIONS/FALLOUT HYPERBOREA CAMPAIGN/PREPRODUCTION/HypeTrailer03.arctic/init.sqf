#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"



//Fuck Grass.
setTerrainGrid 50;

//Set the viewdistance
[4000,2500,100] call Zen_SetViewDistance;

//Forced Decrewing Script - Because Opioid Abuse is bad.
_decrewAction = ["ForceDecrew","Force Crew Out of Vehicle","",{[90, _target, {{_dude = _x select 0;doGetOut _dude;}forEach fullCrew (_this select 0);},{}, "Fighting Crew"] call ace_common_fnc_progressBar;},{true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _decrewAction, true] call ace_interact_menu_fnc_addActionToClass;

if ((!isServer) && (player != player)) then {waitUntil {player == player};};


// This will fade in from black, to hide jarring actions at mission start, this is optional and you can change the value. I don't know why I included this here, it was part of Zenophon's Framework.
//titleText ["Mission Initializing - This shit's prolly gonna lag a hot minute.", "BLACK FADED", 1.5];
// Some functions may not continue running properly after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
sleep 1;

[true,6000,5,false,10,false,true,true,true,false] execvm "AL_snowstorm\al_snow.sqf";

nul = [-1] execVM "AL_intro\intro.sqf";
