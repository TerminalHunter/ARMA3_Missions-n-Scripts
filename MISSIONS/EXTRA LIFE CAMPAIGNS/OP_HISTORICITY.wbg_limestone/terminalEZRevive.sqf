TERMINAL_EZ_REVIVE = true;

EZReviveHelper = {
    params ["_thingy"];
    [
        _thingy, 
        "REVIVE", 
        "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa", 
        "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa", 
        "_target getVariable ['ACE_isUnconscious', false] && TERMINAL_EZ_REVIVE && ((_this distance _target) < 3)", //condition to be shown
        "[_caller, 'ACE_personalAidKit'] call BIS_fnc_hasItem", //condition to progress
        
        {}, //codeStart
        
        {}, //codeProgress
        
        {
            [_caller, _target] call ace_medical_treatment_fnc_fullHeal;
            _caller removeItem 'ACE_personalAidKit';
        }, //codeFinished
        
        {
            if (!([_caller, 'ACE_personalAidKit'] call BIS_fnc_hasItem)) then {
                "pakReminder" cutText ["<t size='2' color='#ff0000'>You don't have a Personal Aid Kit!</t>", "PLAIN", 0.5, false, true, true];
            };
        }, //codeInterrupted, 
        
        [], //arguments, 
        45, 
        1000, 
        false, 
        false, 
        true
    ] remoteExec ["BIS_fnc_holdActionAdd", 0, _thingy];
    //] call BIS_fnc_holdActionAdd;
};