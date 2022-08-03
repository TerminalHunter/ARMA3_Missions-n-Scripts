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
//Not a defense mission, but why not? Plenty of reasons... it might go full Fortnite... eh...
//GREAT IDEA. LET THEM ACE FORTIFY MINE WARNING SIGNS AND MARKER FLAGS!

[west, 2000, [["Land_BagFence_Long_F", 20], ["Land_BagFence_Corner_F", 20], ["Land_BagFence_Round_F", 20], ["Land_BagFence_Short_F", 10], ["Land_BagBunker_Small_F", 100], ["Land_BagBunker_Tower_F", 400], ["Land_CncBarrier_F", 10], ["Land_CncBarrierMedium_F", 20], ["Land_CncBarrierMedium4_F", 80], ["Land_CncWall1_F", 30], ["Land_CncWall4_F", 120],["Land_Camping_Light_F", 5], ["Land_PortableLight_double_F", 20],["Land_Sign_MinesDanger_English_F", 1],["FlagMarker_01_F",1]]] call acex_fortify_fnc_registerObjects;

//pop all the intel we collected earlier

_artyTask = [true, "art", ["This is an exploded shell from either a mortar or artillery piece. You're not exactly sure due to damage. From the cratering, it looks like it impacted facing bearing 049. The explosions from these shells likely caused the levee to fail.","Spent Shell Intel",""], objNull, "SUCCEEDED",1,false] call BIS_fnc_taskCreate;


//Commonwealth officer near the warehouse
_comTask = [true, "com", ["The officer states: ""I've seen a lot of NATO assets in the region. Moreso than could reasonably fit in the one base the rebels hit a while ago. You'd think NATO would tell us something, but they've been quiet since Stralsund. I guess I just sit here and wait for orders, as per usual.""","Commonwealth Officer Intel",""], objNull, "SUCCEEDED",1,false] call BIS_fnc_taskCreate;

//Idap dude near north waystation

_idapTask = [true, "idap", ["The aid worker states: ""The rebels have been infighting, it's been a bitch trying to get the two sides to play nice while they're getting medical treatment. We had to kick everyone out a day or two ago. Didn't stop them from stealing shit on their way out.""","IDAP Worker Intel",""], objNull, "SUCCEEDED",1,false] call BIS_fnc_taskCreate;

//Idap dude near west waystation
_idapTask2 = [true, "idap2", ["The aid worker states: ""The NATO convoys are going east instead of north. Didn't they lose their base to the north?""","More IDAP Worker Intel",""], objNull, "SUCCEEDED",1,false] call BIS_fnc_taskCreate;

//Rebel dude near north waystation
_rebTask2 = [true, "reb", ["The rebel states: ""Oh, you guys must be those mercs. Yeah, Alojzy's let the power go to his head. Started looting the town we were supposed to be protecting. Few people speak up and get shot. Only one who hasn't is Hubert, the old education secretary. Much as I like the guy, I don't think he's going to talk any sense into Alojzy. Fuckin' gangsters... Us? We're fucking off back to base in Montella. We were supposed to wait for Hubert, but I doubt his negotiations are going to work. If you see him, get him back here. And I guess if Alojzy's listened to reason he can come, too. That or hogtied. I think I'd prefer hogtied.""","Friendly Rebel Intel",""], objNull, "SUCCEEDED",1,false] call BIS_fnc_taskCreate;

_sideQuest = [true, "side", ["A rebel asked you to find someone named Hubert (and maybe Alojzy) and extract him to their camp. ","Rebel Side Quest",""], [8666.424,6555.989,0], "ASSIGNED",1,false] call BIS_fnc_taskCreate;