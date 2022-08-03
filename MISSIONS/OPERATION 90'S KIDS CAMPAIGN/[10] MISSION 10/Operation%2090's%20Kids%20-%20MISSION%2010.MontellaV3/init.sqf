#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

//Fuck Grass.
setTerrainGrid 50;

introDone = false;

//Set the viewdistance
[4000,2500,100] call Zen_SetViewDistance;

//Forced Decrewing Script - Because Opioid Abuse is bad.
_decrewAction = ["ForceDecrew","Force Crew Out of Vehicle","",{[90, _target, {{_dude = _x select 0;doGetOut _dude;}forEach fullCrew (_this select 0);},{}, "Fighting Crew"] call ace_common_fnc_progressBar;},{true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _decrewAction, true] call ace_interact_menu_fnc_addActionToClass;

// This will fade in from black, to hide jarring actions at mission start, this is optional and you can change the value. I don't know why I included this here, it was part of Zenophon's Framework.
//titleText ["Mission Initializing - This shit's prolly gonna lag a hot minute.", "BLACK FADED", 1.5];
// Some functions may not continue running properly after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
//if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
//sleep 1;

//INTRODUCTION

if ((!isServer) && (player != player)) then {waitUntil {player == player};};

[] spawn {
sleep 12;
//the timing between when players load in and when AI start moving is ridiculous. NEVER EVER ATTEMPT TO SYNC AI MOVEMENT TO A SONG EVER AGAIN.
intro_cutscene = [82] execVM "AL_intro\intro.sqf";
sleep 1;
joker_1 enableAI "MOVE";
targetTankD enableAI "MOVE";
cameraTankD enableAI "MOVE";
waitUntil{scriptdone intro_cutscene};
introDone = true;
};

// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
sleep 1;

//INTRODUCTION END

//ACEX Fortify

[independent, 3000, [["Land_BagFence_Long_F", 20], ["Land_BagFence_Corner_F", 20], ["Land_BagFence_Round_F", 20], ["Land_BagFence_Short_F", 10], ["Land_BagBunker_Small_F", 100], ["Land_BagBunker_Tower_F", 400], ["Land_CncBarrier_F", 10], ["Land_CncBarrierMedium_F", 20], ["Land_CncBarrierMedium4_F", 80], ["Land_CncWall1_F", 30], ["Land_CncWall4_F", 120],["Land_Camping_Light_F", 5], ["Land_PortableLight_double_F", 20]]] call acex_fortify_fnc_registerObjects;

//Destroy the Armory
{_x setdammage 1} foreach ((markerPos "perfidy") nearObjects ["Building", 50]); 

//Delete all the things I added for the intro and move things where they need to go.
[] spawn {
	sleep 90;
	waitUntil {introDone};

	deleteVehicle joker;

	//delete NATO dudes
	deleteVehicle actorHeli;
	deleteVehicle targetTank;
	deleteVehicle cameraTank;

	natoExtra = [nat1,nat2,nat3,nat4,nat5,nat6,nat7,nat8,nat9,nat10,nat11,nat12,nat13,nat14,nat15,nat16,nat17,nat18,nat19,nat20,nat21,nat22,nat23,nat24,nat25,nat26,nat27,nat28,nat29,nat30,nat31,nat32,nat33,nat34,nat35,nat37,nat38,nat39,nat40,nat41,nat42,nat43,nat44,nat45,nat46,nat47,nat48,nat49,nat50,targetTankD,targetTankC,targetTankG,nat51,nat52,cameraTankD,cameraTankC,cameraTankG,actorHeliD,actorHeliG,nat53,nat54];

	{deleteVehicle _x} forEach natoExtra;

	//delete Commonwealth dudes
	deleteVehicle comspot;
	deleteVehicle comvic;
	deleteVehicle comvicD;
	deleteVehicle comvicG;
	deleteVehicle comdude;
	deleteVehicle comdude2;
	deleteVehicle comdude3;

	//delete extra rebels
	deleteVehicle reb1;
	deleteVehicle reb2;
	deleteVehicle reb3;
	deleteVehicle reb4;
	deleteVehicle reb5;
	deleteVehicle reb6;
	deleteVehicle reb7;
	deleteVehicle reb8;

	//delete all the cameras - because they're invisible helipads and I don't want helicopters fucking around

	deleteVehicle commonCamera;
	deleteVehicle commonCameraTarget;
	deleteVehicle craneCameraEnd;
	deleteVehicle craneCameraStart;
	deleteVehicle craneCameraTarget;
	deleteVehicle ctrgCamera;
	deleteVehicle ctrgCameraTarget;
	deleteVehicle hallwayCameraEnd;
	deleteVehicle hallwayCameraStart;
	deleteVehicle hallwayCameraTarget;
	deleteVehicle jokerCamera;
	deleteVehicle lectureCamera1;
	deleteVehicle lectureCamera2;
	deleteVehicle magicCamera;
	deleteVehicle magicCameraTarget;
	deleteVehicle natoCamera;
	deleteVehicle natoCameraTarget;
	deleteVehicle rebCamera;
	deleteVehicle rebCameraTarget;
	deleteVehicle snowCamera;
	deleteVehicle snowCameraTarget;

	//put actual units down

	placement = [bodyguard1,"rebelspot1",100] spawn SBGF_fnc_groupGarrison;
	placement2 = [bodyguard2,"rebelspot2",100] spawn SBGF_fnc_groupGarrison;
	placement3 = [bodyguard3,"rebelspot3",100] spawn SBGF_fnc_groupGarrison;
	placement4 = [bodyguard4,"rebelspot4",100] spawn SBGF_fnc_groupGarrison;
	placement5 = [bodyguard5,"rebelspot5",100] spawn SBGF_fnc_groupGarrison;
	placement6 = [bodyguard6,"rebelspot6",100] spawn SBGF_fnc_groupGarrison;
	placement7 = [bodyguard7,"rebelspot7",100] spawn SBGF_fnc_groupGarrison;
	placement8 = [bodyguard8,"perfidy",100] spawn SBGF_fnc_groupGarrison;

	//before moving the magician, allow him to be damaged again
	//he's close to the perfidy point and apparently gets hurt by the collapsing buildings
	magician allowDamage true;

	//randomly select places for VIP targets to be

	vipLocs = [bodyguard1,bodyguard2,bodyguard3,bodyguard4,bodyguard5,bodyguard6,bodyguard7,bodyguard8];

	rebVips = [magician, judgement, tower, justice, empress, priestess];

	waitUntil {scriptdone placement8};
	{_x setPos (getPosATL (selectRandom vipLocs))} forEach rebVips;

};