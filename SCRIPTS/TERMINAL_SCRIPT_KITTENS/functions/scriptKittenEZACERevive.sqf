/*
TERMINAL_EZ_REVIVE = false;

EZReviveHelper = {
    params ["_thingy"];
    [
        _thingy, 
        "REVIVE", 
        "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa", 
        "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa", 
        "_target getVariable ['ACE_isUnconscious', false] && TERMINAL_EZ_REVIVE", //condition to be shown
        "[_caller, 'ACE_personalAidKit'] call BIS_fnc_hasItem", //condition to progress
        {}, //codeStart
        {}, //codeProgress
        {
            [_caller, _target] call ace_medical_treatment_fnc_fullHeal;
            _caller removeItem 'ACE_personalAidKit';
        }, //codeFinished
        {if (!([_caller, 'ACE_personalAidKit'] call BIS_fnc_hasItem)) then {hint "You don't have a Personal Aid Kit!"}}, //codeInterrupted, 
        [], //arguments, 
        45, 
        1000, 
        false, 
        false, 
        true
    ] remoteExec ["BIS_fnc_holdActionAdd", 0, _thingy];
};

["B_Survivor_F", "init", {[_this select 0] call EZReviveHelper}, false, [], true] call CBA_fnc_addClassEventHandler; //this works but requires all players to be B_Survivor_F
//how to get all players including jip?
*/