if (isServer) then {
    firstAmbussy01 = createTrigger ["EmptyDetector", getPos firstAmbussy, true];
    firstAmbussy01 setTriggerArea [30, 30, 0, false];
    firstAmbussy01 setTriggerActivation ["ANYPLAYER", "PRESENT", false];
    firstAmbussy01 setTriggerStatements ["this", "[] spawn firstAmbush;", ""];
};

firstAmbush = {
    [getPos firstAmbussyTear, [getPos firingRangeRadio]] spawn britishAISAD;
    //["hit the thing"] remoteExec ["hint"];
    [firstAmbussyTear] remoteExec ["createVerticalRupture"];
    [firstAmbussyTear] remoteExec ["createVerticalRupture"];
    playSound3D [getMissionPath "timefuckery01.ogg", firstAmbussy, false, getPosASL firstAmbussy, 5, 1, 10000];
    [] remoteExec ["beginChapter2"];
    [chapter2Arsenal] spawn updateAllArsenals;
    ["National Guard Default", [["CUP_arifle_M4A1_BUIS_GL","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","CUP_optic_ACOG2_PIP",["CUP_30Rnd_556x45_Stanag_Tracer_Green",30],["1Rnd_HE_Grenade_shell",1],""],[],[],["CUP_U_B_USArmy_ACU_Rolled_UCP",[["ACE_EntrenchingTool",1],["CUP_30Rnd_556x45_Stanag_Tracer_Green",1,30]]],["CUP_V_B_IOTV_UCP_Empty_USArmy",[["CUP_30Rnd_556x45_Stanag_Tracer_Green",7,30]]],["bc036_invisible_kitbag",[["ACE_splint",2],["ACE_surgicalKit",1],["ACE_tourniquet",2],["ACE_plasmaIV_500",2],["ACE_personalAidKit",3],["ACE_morphine",2],["ACE_epinephrine",3],["ACE_quikclot",3],["ACE_packingBandage",12],["ACE_painkillers",1,10],["1Rnd_HE_Grenade_shell",9,1],["SmokeShell",2,1]]],"CUP_H_US_patrol_cap_UCP","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152_3","ItemCompass","ItemWatch","NVGoggles"]], true] call ace_arsenal_fnc_addDefaultLoadout;
    sleep 10;
    //[getPos firstAmbussyTear, getPos firingRangeRadio] spawn britishAISAD;
    [] spawn secondAmbush;
};

beginChapter2 = {
    currentlyChapter1 = false;
    currentlyChapter2 = true; //starts after the players are interrupted at the firing range
    currentlyChapter3 = false; //the finale, ghost ships on the horizon
};

allBritPrivates = ["1715_Eng_MR_Private","1715_Eng_MR_Private","1715_Eng_MR_Private","1715_Eng_MR_Private","1715_Eng_MR_Private","1715_Eng_MR_Private","1715_Eng_MR_Private","1715_Eng_MR_Private","1715_Eng_MR_Private","1715_Eng_MR_Private"];

britishAISAD = {
    params ["_position", "_targets"];
    private _newGroup = [_position, east, allBritPrivates] call BIS_fnc_spawnGroup;
    {
        _x forceWalk true;
    } forEach units _newGroup;
    _newGroup setFormation "LINE";
    _newGroup setBehaviourStrong "SAFE";

    {
        private _sadWaypoint1 = _newGroup addWaypoint [_x, 50];
	    _sadWaypoint1 setWaypointType "SAD";
    } forEach _targets;

    private _sadWaypoint2 = _newGroup addWaypoint [getPos (selectRandom allPlayers), 50];
	_sadWaypoint2 setWaypointType "SAD";
    //set to not aggressive?
};

secondAmbush = {
    waitUntil {sleep 10; count (units opfor) < 2};
    ["practice", "SUCCEEDED", true] call BIS_fnc_taskSetState;
    [getPos secondAmbussy, [getPos secondAmbussyTarget]] spawn britishAISAD;
    [secondAmbussy] remoteExec ["createVerticalRupture"];
    [secondAmbussy] remoteExec ["createVerticalRupture"];
    playSound3D [getMissionPath "timefuckery01.ogg", secondAmbussy, false, getPosASL secondAmbussy, 5, 1, 10000];
    [true, "light1", 
        ["What in the world was that?", "Follow the light/sound", "?"], 
        getPos secondAmbussy, "CREATED", -1, true, "scout", true
    ] call BIS_fnc_taskCreate;
    sleep 15;
    [getPos secondAmbussy, [getPos secondAmbussyTarget]] spawn britishAISAD;
    [] spawn thirdAmbush;
};

thirdAmbush = {
    waitUntil {sleep 10; count (units opfor) < 4};
    [getPos thirdAmbussy, [getMarkerPos "marker_11", getMarkerPos "marker_12"]] spawn britishAISAD;
    [getPos thirdAmbussy, [getMarkerPos "marker_12", getMarkerPos "marker_11"]] spawn britishAISAD;
    [getPos thirdAmbussy, [getPos ambussyWest]] spawn britishAISAD;
    [thirdAmbussy] remoteExec ["createVerticalRupture"];
    [thirdAmbussy] remoteExec ["createVerticalRupture"];
    playSound3D [getMissionPath "timefuckery01.ogg", thirdAmbussy, false, getPosASL thirdAmbussy, 5, 1, 10000];
    ["light1", "SUCCEEDED", true] call BIS_fnc_taskSetState;
    [true, "light2", 
        ["Oh shit, did that come from town?", "Keep following the light/sound", "?"], 
        getPos thirdAmbussy, "CREATED", -1, true, "scout", true
    ] call BIS_fnc_taskCreate;
};

/*
ambussyEast
ambussyEast2
ambussyNorth
ambussySouth
ambussyWest
ambussyWest2
*/

townDefense = {
    ["light2", "SUCCEEDED", true] call BIS_fnc_taskSetState;
    [true, "light3", 
        ["Uh oh.", "Oh shit.", "?"], 
        getMarkerPos "marker_12", "CREATED", -1, true, "defense", true
    ] call BIS_fnc_taskCreate;
};