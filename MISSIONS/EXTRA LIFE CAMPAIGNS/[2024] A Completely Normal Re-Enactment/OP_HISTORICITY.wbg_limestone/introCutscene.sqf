beginIntroCutscene = {
    //first 30 seconds of black powder and alcohol.
    //immediate rain.

    playMusic "blackPowderAndAlcohol";

    ["<t color='#ffffff' size='2'>Tactical Tuesday<br />Presents</t>",0.5,-1,7,1,0,789] spawn BIS_fnc_dynamicText;

    _camera = "camera" camCreate (getPos introCamera01Begin);
	showCinemaBorder true;
	_camera cameraEffect ["internal", "BACK"];
	_camera camCommand "inertia off";
    _camera camSetDir ((getPos introCamera01Begin) vectorFromTo (getPos introCamera01Target));
	//_camera camPrepareTarget _targetcam;
	//_camera camPrepareFOV _zoom_level1;
	_camera camCommitPrepared 0;

	// poz 2 - where camera is moving next - target2
	_camera camPreparePos (getPos introCamera01End);
	//_camera camPrepareTarget _targetcam;
	//_camera camPrepareFOV _zoom_level2;
	_camera camCommitPrepared 7.5;
	sleep 7.5;

    _camera camPreparePos (getPos chickenCamera);
    _camera camPrepareTarget chickenTarget;
    _camera camCommitPrepared 0;
    sleep 4; //11.5

    

    _camera camPreparePos (getPos introCamera02);
    _camera camPrepareTarget introCamera2Angle;
    _camera camCommitPrepared 0;
    sleep 5.5; //17

    _camera camPreparePos (getPos beerCam);
    _camera camPrepareTarget beerTarget;
    _camera camCommitPrepared 8;
    sleep 10; //27

    ["<t color='#ffffff' size='2'>A Completely Normal Re-Enactment</t>",-0.5,-1,12,1,0,789] spawn BIS_fnc_dynamicText;
    //_camera camPreparePos (getPos introCamera01End);
    //_camera camPrepareTarget arse_bubba;
    //_camera camCommitPrepared 5;
    sleep 1.8;


    [[2035,1,10,17,45]] remoteExec ["setDate"];
    sleep 2.5;
    0 setOvercast 0.7;
    0 setRain 1;
    forceWeatherChange;


    playMusic "";
    //END EXACTLY AT 31.5 SECONDS!


    sleep 5;

    _camera cameraEffect ["terminate", "back"];
	camDestroy _camera;



    if(isServer) then {
        sleep 3;
        [] spawn rainTaskUpdate;
            //DELETE A LOT OF THINGS.
        deleteVehicle clutterCooler;
        deleteVehicle clutterCooler2;
        deleteVehicle clutterCooler3;

        deleteVehicle nerd1;
        deleteVehicle nerd2;
        deleteVehicle nerd3;
        deleteVehicle nerd4;
        deleteVehicle nerd5;

        deleteVehicle clutt1;
        deleteVehicle clutt2;
        deleteVehicle clutt3;
        deleteVehicle clutt4;
        deleteVehicle clutt5;

    };
};

startIntro = {
    [] remoteExec ["beginIntroCutscene"];
};
//[] spawn startIntro; on server
//[] spawn startFinale; on server