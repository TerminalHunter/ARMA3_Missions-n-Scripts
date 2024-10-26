//[] spawn startFinale; on server
startFinale = {
    playSound3D [getMissionPath "timefuckery02.ogg", establishCamera, false, getPosASL establishCamera, 5, 1, 10000];
    sleep 5;
    [] spawn startTheGhostShips;
    _finaleMarkerBkgd = createMarker ["finaleStartBkgd", getPos ghostShipStart01];
    _finaleMarkerBkgd setMarkerType "mil_warning_noShadow";
    _finaleMarkerBkgd setMarkerShape "RECTANGLE";
    _finaleMarkerBkgd setMarkerSize [1000, 100];
    _finaleMarkerBkgd setMarkerColor "colorOPFOR";

    _finaleMarker = createMarker ["finaleStart", getPos ghostShipStart01];
    _finaleMarker setMarkerType "mil_warning_noShadow";
    _finaleMarker setMarkerColor "colorOPFOR";

    _finaleMarkerHelper = createMarker ["finaleArrow", (getPos ghostShipStart01) vectorAdd [0, 500, 0]];
    _finaleMarkerHelper setMarkerType "mil_arrow2_noShadow";
    _finaleMarkerHelper setMarkerColor "colorOPFOR";
};

currFinaleFrame = 0;

startTheGhostShips = {
    //starts on server
    //THE FINALE~!
    [] remoteExec ["finaleMusic"];

    ghostlyGlow attachTo [Motherfucking,[0,-25,-10]];
    ghostlyGlow2 attachTo [Gilbert,[0,-25,-10]];
    ghostlyGlow3 attachTo [Scantlebury,[0,-25,-10]];
    [Motherfucking] remoteExec ["spookySmoke"];

    [finaleRift1] remoteExec ["createHorizontalRupture"];
    [finaleRift1] remoteExec ["createVerticalRupture"];

    [] remoteExec ["finaleCameraWork"];
    [] spawn fireZeCannons;

    //playSound3D [getMissionPath "timefuckery02.ogg", establishCamera, false, getPosASL establishCamera, 1, 1, 0];

    onEachFrame {
        if (damage Motherfucking > 0.5 && damage Gilbert > 0.5 && damage Scantlebury > 0.5) then {
            onEachFrame {};
            //boss defeated!
        };
        currFinaleFrame = currFinaleFrame + 1;
        [Motherfucking, getPosASL ghostShipStart01, getPosASL ghostShipEnd01, currFinaleFrame] call floatGhostShip;
        [Gilbert, getPosASL ghostShipStart02, getPosASL ghostShipEnd02, currFinaleFrame] call floatGhostShip;
        [Scantlebury, getPosASL ghostShipStart03, getPosASL ghostShipEnd03, currFinaleFrame] call floatGhostShip;
    };

    [] spawn finaleAI;
    
};

floatGhostShip = {
    params ["_ship", "_start", "_end", "_frame"];
    if (damage _ship < 0.5) then {
        _ship setVelocityTransformation [
            _start,
            _end,
            [0,0,0],
            [0,0,0],
            [0,1,0],
            [0,1,0],
            [0,0,1],
            [0,0,1],
            (_frame/100000)// 200k worked in testing, too slow on server (_frame / 200000)
            //this should be 30-ish minutes.
        ];
    };
};

spookySmoke = {
    params ["_smokeSource"];
    private _ps1 = "#particlesource" createVehicleLocal (getPosATL _smokeSource); 
    _ps1 setParticleParams [ 
    ["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 16, 1], "", "Billboard", 
    1, 100, [0, 50, 0], [0, 0, -2], 0, 10, 7.9, 0.066, [40, 40, 70, 120], 
    [[0, 1, 0, 0], [0.05, 0.05, 0.05, 1], [0.05, 1, 0.05, 0.5], [0.05, 1, 0.05, 0.25], [0.1, 0.1, 0.1, 0.25], [0.125, 1, 0.125, 0]], 
    [0.25], 1, 0, "", "", _smokeSource]; 
    _ps1 setParticleRandom [0, [10, 10, 10], [2, 2, 0.5], 0, 0.25, [0, 0, 0, 0.1], 0, 0]; 
    _ps1 setDropInterval 0.8;
};

finalecameraWork = {
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
    _finaleCamera2 attachTo [Gilbert];
    sleep 44;
    _finaleCamera2 cameraEffect ["terminate", "back"];
	camDestroy _finaleCamera2;

    currentlyChapter1 = false;
    currentlyChapter2 = false;
    currentlyChapter3 = true; //might as well put this here since it's remoteExec'd
  
};

finaleCannonCrack = {
    params["_cannon", "_counter"];
    if (direction _cannon > 220) then {
        if (_counter mod 3 == 0) then {
            sleep (0.1 * _counter);  
            [_cannon, currentWeapon _cannon] call BIS_fnc_fire;   
            [_cannon, [currentWeapon _cannon, 1]] remoteExecCall ["setAmmo"];   
        };
    };
};

fireZeCannons = {
    sleep 12;
    sleep 12;
    sleep 12;
    sleep 34;
    private _counter = 0;
    {
        [_x, _counter] spawn finaleCannonCrack;
        _counter = _counter + 1;
    } forEach (Gilbert nearObjects ["1715_eng_6pounder", 100]);   
};

finaleMusic = {
    //run locally
    1 fadeMusic 0;
    sleep 1; //AAAAAAAAA OFF TIME!
    playMusic "hoistMetal";
    25 fadeMusic 1;
    sleep 93;
    10 fadeMusic 0;
    sleep 10;
    playMusic "";
    sleep 5;
    playMusic "hoistKaraoke";
    10 fadeMusic 1;
    _musicEventHandlerID = addMusicEventHandler ["MusicStop", {
        params ["_musicName", "_id"];
        switch _musicName do {
            case "hoistKaraoke":{
                playMusic "grim";
            };
            case "grim":{
                playMusic "million";
            };
            case "million":{
                playMusic "hoistKaraoke";
            };
        };
    }];
};

finaleAI = {
    sleep 120;

    [Motherfucking] spawn continuousFiringCanons;
    [Gilbert] spawn continuousFiringCanons;
    [Scantlebury] spawn continuousFiringCanons;

    [Motherfucking] spawn ghostShipFeedback;
    [Gilbert] spawn ghostShipFeedback;
    [Scantlebury] spawn ghostShipFeedback;
};

continuousFiringCanons = {
    params["_ship"];
    while {damage _ship < 0.5} do {
        sleep 20;
        {
            [_x] spawn fireCanonJustOnce;
        } forEach (_ship nearObjects ["1715_eng_6pounder", 30]); 
    };
};

fireCanonJustOnce = {
    params["_cannon"];
    sleep (random 10);
    [_cannon, currentWeapon _cannon] call BIS_fnc_fire;   
    [_cannon, [currentWeapon _cannon, 1]] remoteExecCall ["setAmmo"];   
};

ghostShipFeedback = {
    params ["_ship"];
    private _10percent = true;
    private _20percent = true;
    private _30percent = true;
    private _40percent = true;
    while {damage _ship < 0.5} do {
        sleep 0.7;
        if (damage _ship > 0.1 && _10percent) then {
            _10percent = false;
            [_ship, [0,0,-15]] remoteExec ["feedbackExplosion"];
        };
        if (damage _ship > 0.2 && _20percent) then {
            _20percent = false;
            [_ship, [0,-20,-15]] remoteExec ["feedbackExplosion"];
        };
        if (damage _ship > 0.3 && _30percent) then {
            _30percent = false;
            [_ship, [0,20,-15]] remoteExec ["feedbackExplosion"];
        };
        if (damage _ship > 0.4 && _40percent) then {
            _40percent = false;
            [_ship, [0,0,10]] remoteExec ["feedbackExplosion"];
        };
    };
    _ship setAngularVelocity [((random 2)-1), ((random 4) - 2), 0];
    _ship setVelocity [0,20,10];
};

feedbackExplosion = {
    params ["_ship", "_pos"];
    //_explosion = "DemoCharge_Remote_Ammo_Scripted" createVehicle (getPosASL _ship);
    //_explosion setDamage 1;
    private _ps1 = "#particlesource" createVehicleLocal ((getPosASL _ship) vectorAdd _pos); 
    _ps1 setParticleParams [ 
    ["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 10, 32], "", "Billboard", 
    1, 1, _pos, [0, 0, 0.5], 0, 1, 1, 3, [5,15], 
    [[0.4,0.9,0.4,0.8], [0.4,0.9,0.4,0.4], [0.4,0.9,0.4,0.1]], 
    [0.25,1], 1, 1, "", "", _ship]; 
    _ps1 setParticleRandom [0.2, [5, 5, 2], [0.25, 0.25, 0.25], 0.2, 0.2, [0, 0, 0, 0], 0, 0]; 
    _ps1 setDropInterval 0.1;
};

ghostShipHint = {
    if (currentlyChapter3) then {
        ghostShip01HP = addMissionEventHandler ["Draw3D", {
            drawIcon3D ["", [0.4,0.8,0.4,1], getPos (_thisArgs select 0), 0, 0, 0, str(floor(100 - (damage Motherfucking * 100 * 2))) + "%", 2, 0.05, "PuristaBold"];
        }, [Motherfucking]];
        ghostShip02HP = addMissionEventHandler ["Draw3D", {
            drawIcon3D ["", [0.4,0.8,0.4,1], getPos (_thisArgs select 0), 0, 0, 0, str(floor(100 - (damage Gilbert * 100 * 2))) + "%", 2, 0.05, "PuristaBold"];
        }, [Gilbert]];
        ghostShip03HP = addMissionEventHandler ["Draw3D", {
            drawIcon3D ["", [0.4,0.8,0.4,1], getPos (_thisArgs select 0), 0, 0, 0, str(floor(100 - (damage Scantlebury * 100 * 2))) + "%", 2, 0.05, "PuristaBold"];
        }, [Scantlebury]];
        sleep 60;
        removeMissionEventHandler ["Draw3D", ghostShip01HP];
        removeMissionEventHandler ["Draw3D", ghostShip02HP];
        removeMissionEventHandler ["Draw3D", ghostShip03HP];
    };
};

// [] remoteExec ["ghostShipHint"]