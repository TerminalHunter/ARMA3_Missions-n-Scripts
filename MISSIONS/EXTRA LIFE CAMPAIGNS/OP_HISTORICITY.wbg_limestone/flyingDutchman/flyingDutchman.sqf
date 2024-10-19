/*
https://old.reddit.com/r/armadev/comments/tb7jyd/a_question_about_key_frame_animations_in_a/
maybe look into other solutions later... the whole 2mb animation data thing is... silly...
https://forums.bohemia.net/forums/topic/212108-key-frame-animation/ 
https://forums.bohemia.net/forums/topic/210987-keyframe-animation-system-in-dev/?page=2 
*/

ghostlyGlow attachTo [Motherfucking,[0,-25,-10]];

//We want this to run only on clientside, or there will be desync, so teleport to final position exit script if it's on server

testFlyingDutchman = {

    if (!hasInterface) then {

        //Loop code a couple of times since for some obscene reason Arma doesn't wanna do certain things sometimes
        //Dunno if I need this since the animation plays out and... theoretically... Scantlebury gets away.
        for "_i" from 1 to 3 do {
        private _finalPosition = finalPosition;
        private _position = getPosASLW _finalPosition; 
        private _vectorDirUp = [vectorDir _finalPosition, vectorUp _finalPosition];  

        flyingDutchman setPosASLW _position;
        flyingDutchman setVectorDirAndUp _vectorDirUp;
        };

    } else {
        dothings = [flyingDutchman, twentyMoveData, [], true, 0, 0, 0] spawn BIS_fnc_UnitPlay;
    };
};

testThreeShips = {
    [Motherfucking, twentyMoveData, [], true, 0, 0, 0] remoteExec ["BIS_fnc_unitPlay"];
    [Motherfucking] remoteExec ["spookySmoke"];
    sleep 12;
    [Gilbert, twentyMoveData, [], true, 0, 0, 0] remoteExec ["BIS_fnc_unitPlay"];
    sleep 12;
    [Scantlebury, twentyMoveData, [], true, 0, 0, 0] remoteExec ["BIS_fnc_unitPlay"];
    sleep 12;
    [] spawn fireZeCannons;
};

spookySmoke = {
    params ["_smokeSource"];
    //private _posATL = player modelToWorld [0,10,0]; 
    
    private _ps1 = "#particlesource" createVehicleLocal (getPosATL _smokeSource); 
    _ps1 setParticleParams [ 
    ["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 16, 1], "", "Billboard", 
    1, 120, [0, 50, 0], [0, 0, -2], 0, 10, 7.9, 0.066, [40, 40, 70, 120], 
    [[0, 1, 0, 0], [0.05, 0.05, 0.05, 1], [0.05, 1, 0.05, 0.5], [0.05, 1, 0.05, 0.25], [0.1, 0.1, 0.1, 0.25], [0.125, 1, 0.125, 0]], 
    [0.25], 1, 0, "", "", _smokeSource]; 
    _ps1 setParticleRandom [0, [10, 10, 10], [2, 2, 0.5], 0, 0.25, [0, 0, 0, 0.1], 0, 0]; 
    _ps1 setDropInterval 0.6;
};

spookySmokeQuick = {
    params ["_smokeSource"];
    private _ps1 = "#particlesource" createVehicleLocal (getPosATL _smokeSource); 
    _ps1 setParticleParams [ 
    ["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 16, 1], "", "Billboard", 
    1, 120, [0, 0, 0], [0, 0, -2], 0, 10, 7.9, 0.066, [40, 40, 70, 120], 
    [[0, 1, 0, 0], [0.05, 0.05, 0.05, 0.1], [0.05, 1, 0.05, 0.1], [0.05, 1, 0.05, 0.1], [0.1, 0.1, 0.1, 0.1], [0.125, 1, 0.125, 0]], 
    [0.25], 1, 0, "", "", _smokeSource]; 
    _ps1 setParticleRandom [0, [10, 10, 10], [2, 2, 0.5], 0, 0.25, [0, 0, 0, 0.1], 0, 0]; 
    _ps1 setDropInterval 0.02;
    sleep 1;
    deleteVehicle _ps1;
};

cameraFinale = {
    private _finaleCamera = "camera" camCreate (getPos establishCamera);
    _finaleCamera camPrepareTarget establishAngle;
    _finaleCamera cameraEffect ["internal", "back"];
    _finaleCamera camCommitPrepared 0;
    waitUntil {camCommitted _finaleCamera};
    sleep 17.5;
    _finaleCamera cameraEffect ["terminate", "back"];
	camDestroy _finaleCamera;

    private _finaleCamera3 = "camera" camCreate (getPosASL establish2nd);
    _finaleCamera3 camPrepareTarget establish2ndAngle;
    _finaleCamera3 cameraEffect ["internal", "back"];
    _finaleCamera3 camCommitPrepared 0;
    waitUntil {camCommitted _finaleCamera3};
    sleep 18;
    _finaleCamera3 cameraEffect ["terminate", "back"];
	camDestroy _finaleCamera3;

    private _finaleCamera2 = "camera" camCreate (getPos finaleCutscene);
    _finaleCamera2 camPrepareTarget finaleCameraAngle;
    _finaleCamera2 cameraEffect ["internal", "back"];
    _finaleCamera2 camCommitPrepared 0;
    waitUntil {camCommitted _finaleCamera};
    sleep 40;
    _finaleCamera2 cameraEffect ["terminate", "back"];
	camDestroy _finaleCamera2;
};

beginFinale = {
    //runs server-side
    ["hoistMetal"] remoteExec ["playMusic"];
    [] remoteExec ["cameraFinale"];
    [finaleRift1] remoteExec ["createHorizontalRupture"];
    //[finaleRift1] remoteExec ["createVerticalRupture"];
    [finaleRift1] remoteExec ["createVerticalRupture"];
    [] call testThreeShips;
};

fireIndividualCannon = {
    params["_cannon", "_counter"];
    if (direction _cannon > 220) then {
        if (_counter mod 3 == 0) then {
            sleep (random 3);  
            [_cannon, currentWeapon _cannon] call BIS_fnc_fire;   
            [_cannon, [currentWeapon _cannon, 1]] remoteExecCall ["setAmmo"];   
        };
    };
};

fireZeCannons = {
    sleep 32;
    private _counter = 0;
    {
        [_x, _counter] spawn fireIndividualCannon;
        _counter = _counter + 1;
    } forEach (Gilbert nearObjects ["1715_eng_6pounder", 100]);   
};

/*
FADE OUT MUSIC
SEE IF LAG CAN BE HELPED?
START FIRING CANNONS.
Maybe exit portal
Test all this on production
*/




/*

{
    [_x, currentWeapon _x] remoteExecCall ["BIS_fnc_fire"];
} forEach (flyingDutchman nearObjects ["1715_eng_6pounder", 100]);


THIS FIRES ALL GUNS RUN SERVER-SIDE
[] spawn {
[_x, currentWeapon _x] remoteExecCall ["BIS_fnc_fire"];
} forEach (flyingDutchman nearObjects ["1715_eng_6pounder", 100]);


[] spawn { 
["haha"] remoteExec ["hint"]; 
{  
[_x, currentWeapon _x] remoteExecCall ["BIS_fnc_fire"]; 
[_x, [currentWeapon _x, 1]] remoteExecCall ["setAmmo"]; 
} forEach (flyingDutchman nearObjects ["1715_eng_6pounder", 100]); 
};

[] spawn { [] call { 
["haha"] remoteExec ["hint"];  
{  sleep 0.1; 
[_x, currentWeapon _x] remoteExecCall ["BIS_fnc_fire"];  
[_x, [currentWeapon _x, 1]] remoteExecCall ["setAmmo"];  
}; 
} forEach (flyingDutchman nearObjects ["1715_eng_6pounder", 100]);  
};


[] spawn { [] call {  
["haha"] remoteExec ["hint"];   
{  sleep 0.3;  
[_x, currentWeapon _x] call BIS_fnc_fire;   
[_x, [currentWeapon _x, 1]] remoteExecCall ["setAmmo"];   
};  
} forEach (flyingDutchman nearObjects ["1715_eng_6pounder", 100]);   
};

SEEMS TO WORK FOR NOW:
CRITICAL BUG: CANNONS/GREEN LIGHT/ATTACHTO OBJECTS sometimes zip back to server-side position.
    Less Critical Bugs - solve as time allows.
        BUG! Explosions happen where the server-side cannons are pointed. 
            Server only, move the canon to local position? How would one even?
            Also add all cannons to movedata?

*/