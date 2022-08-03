// by ALIAS
// nul = [JIP] execVM "AL_intro\intro.sqf";

waitUntil {time > 0};

_jip_enable	= _this select 0;

[[_jip_enable],"AL_intro\time_srv.sqf"] remoteExec ["execVM"];
waitUntil {!isNil "curr_time"};

if (!hasInterface) exitWith {};

if ((!curr_time) or (_jip_enable<0)) then {
cutText ["", "BLACK IN", 0];
_txt_1 = ["Episode 10",8,"center_top","2","#FFFFFF"] execVM "AL_intro\txt_display.sqf";
[] spawn {
sleep 5;
_txt_2 = ["The Phantom Withdrawal",3,"center","1","#FFFFFF"] execVM "AL_intro\txt_display.sqf";
};

playMusic "intro_music";

/* ----- how to use camera script -----------------------------------------------------------------------

_camera_shot = [position_1_name, position_2_name, target_name, duration, zoom_level1, zoom_level_2, attached, x_rel_coord, y_rel_coord, z_rel_coord,last_shot] execVM "camera_work.sqf";

Where
_camera_shot	- string, is the name/number of the camera shot, you can have as many as you want see examples from down bellow
position_1_name - string, where camera is created, replace it with the name of the object you want camera to start from
position_2_name - string, the object where you want camera to move, if you don't want to move from initial position put the same name as for position_1_name
target_name   	- string, name of the object you want the camera to look at
duration 		- seconds, how long you want the camera to function on current shot
zoom_level_1 	- takes values from 0.01 to 2, FOV (field of view) value for initial position
zoom_level_2	- takes values from 0.01 to 2, FOV value for second position, if you don't to change you can give the same value as you did for zoom_level_1
attached		- boolean, if you want to attach camera to an moving object its value has to be true, otherwise must be false
					in this case position_1_name must have the same value as position_2_name
x_rel_coord		- meters, relative position to the attached object on x coordinate
y_rel_coord		- meters, relative position to the attached object on y coordinate
z_rel_coord		- meters, relative position to the attached object on z coordinate
last_shot		- boolean, true if is the last shot in your movie, false otherwise

-----------------------------------------------------------------------------------------------------------*/

// - do not edit or delete the lines downbelow, this line must be before first camera shot
loopdone = false;
while {!loopdone} do {
//^^^^^^^^^^^^^^^^^^^^^^ DO NOT EDIT OR DELETE ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


// EXAMPLES------ insert your lines for camera shots starting from here -----------------------------------------

_firstshot = [introCreditCamera, introCreditCamera, introCreditBackground, 9, 0.1, 0.1, false, 0, 0, 0, FALSE] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _firstshot};

_txt_5 = ["Starring",4,"center_bottom","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
[] spawn {
sleep 3;
_txt_6 = ["Boots",4,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
};

_bootshot = [joker, joker, term, 8, 1, 1, false, 0, 0, 0, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _bootshot};

[] spawn {
sleep 4;
_txt_7 =  ["Lecture",2.5,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
};

_lectshot = [lectureCamera1, lectureCamera2, term, 8, 1, 0.75, false, 0, 0, 0, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _lectshot};

_txt_8 = ["Enemy Combatants",3,"left_bottom","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
_txt_9 = ["NATO Response Force",3,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

_natoshot = [targetTank, targetTank, natoCameraTarget, 4, 1, 0.75, true, 0, -10, 2, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _natoshot};

_txt_10 = ["The Commonwealth Armed Forces",3,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

_commonshot = [commonCamera, commonCamera, commonCameraTarget, 4, 1, 1, false, 0, 0, 0, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _commonshot};

_txt_11 = ["CTRG Commonwealth Special Task Force",3,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

_ctrgshot = [ctrgCamera, ctrgCamera, ctrgCameraTarget, 4, 0.75, 0.95, false, 0, 0, 0, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _ctrgshot};

_txt_12 = ["Szczepan 'Monarch' Snowe",2.5,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

_snowshot = [snowCamera, snowCamera, snowCameraTarget, 4, 0.75, 0.95, false, 0, 0, 0, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _snowshot};

_txt_13 = ["Guest Starring",1.5,"left_bottom","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

_txt_14 = ["The Rebellion",1.5,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

_rebshot = [rebCamera, rebCamera, rebCameraTarget, 2, 1, 1, false, 0, 0, 0, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _rebshot};

_txt_15 = ["The Magician",1.1,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

_magicshot = [magicCamera, magicCamera, magicCameraTarget, 2, 1, 1, false, 0, 0, 0, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _magicshot};

_txt_16 = ["The High Priestess",1.1,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

[] spawn {
sleep 2;
_txt_17 =  ["The Empress",1.1,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
sleep 2;
_txt_18 =  ["Justice",1.1,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
sleep 2;
_txt_19 =  ["The Tower",1.1,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
sleep 2;
_txt_20 =  ["Judgement",1.1,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
};

_hallshot = [hallwayCameraStart, hallwayCameraEnd, hallwayCameraTarget, 11, 1, 1, false, 0, 0, 0, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _hallshot};

_txt_21 = ["The Fool",1.1,"left_bottom","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

[] spawn {
sleep 2;
_txt_22 =  ["The Jester",1.1,"left_bottom","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
sleep 2;
_txt_23 =  ["The Joker",1.1,"left_bottom","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
};

_craneshot = [craneCameraStart, craneCameraEnd, craneCameraTarget, 6.5, 1, 1, false, 0, 0, 0, false] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _craneshot};

_txt_24 = ["Intern",1.1,"bottom_right","1","#dddddd"] execVM "AL_intro\txt_display.sqf";

[] spawn {
sleep 20;
_txt_25 =  ["That cutscene was definitely worth the two days I spent on it",3,"left_bottom","1","#dddddd"] execVM "AL_intro\txt_display.sqf";
};

_jokeshot = [stolenHeli, stolenHeli, joker_1, 6, 0.3, 0.1, true, 5, 10, 0, true] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _jokeshot};

/*
if you want to add a forth or a fifth camera shot use a code like:
_forthshot = [cam5, cam6, target4, 7, 1, 1, false] execVM "camera_work.sqf";
waitUntil {scriptDone _forthshot};

** Note that last boolean parameter will tell the script if the camera shot is the last one or not,
make sure that last camera has that parameter true and the intermediar cameras has it false as in my examples above

>>!! don't forget to name the objects cam5, cam6, target4 in editor 

You can add as many camera shots as you want 
but you have to name the script differently 
and don't forget to add the wait line after each shot
waitUntil {scriptDone _xxxshot};
*/

// --------------->> end of camera shots <<---------------------------------------------------------
};

cutText [" ", "BLACK IN", 3];
_camera = "camera" camCreate (getpos player);
_camera cameraeffect ["terminate", "back"];
camDestroy _camera;
"dynamicBlur" ppEffectEnable true;   
"dynamicBlur" ppEffectAdjust [100];   
"dynamicBlur" ppEffectCommit 0;     
"dynamicBlur" ppEffectAdjust [0.0];  
"dynamicBlur" ppEffectCommit 4;
};