//////////
//SIPHON FUEL
//////////

fuelSiphonFunction = {
    params ["_target", "_player", "_params"];
    private _newJerryCan = "Land_CanisterPlastic_F" createVehicle (getPos _player);
    private _fuelCapacity = getNumber (configFile >> "CfgVehicles" >> (typeOf _target) >> "ace_refuel_fuelCapacity");

    if (((fuel _target) * _fuelCapacity) > 100) then {
        [_newJerryCan, 100] call ace_refuel_fnc_makeJerryCan;
        _target setFuel (fuel _target - (100/_fuelCapacity));
    } else {
        [_newJerryCan, ((fuel _target) * _fuelCapacity)] call ace_refuel_fnc_makeJerryCan;
        _target setFuel 0;
    };
};

fuelSiphonCondition = {
    params ["_target", "_player", "_params"];
    private _return = false;
    if (fuel _target > 0 AND damage _target < 1) then {
        _return = true;
    };
    _return
};

FuelSiphonAction = [
    "FuelSiphon", 
    "Siphon Fuel", 
    "",
    fuelSiphonFunction,
    fuelSiphonCondition,
    {}, 
    [], 
    [0, 0, 0], 
    20
] call ace_interact_menu_fnc_createAction;

///////////
//SIPHON TOOLKITS? SALVAGE.
///////////

salvageFunction = {
    params ["_target", "_player", "_params"];
    private _massScrap = getMass _target;
    private _numToolkits = floor (_massScrap / 10000) + 1;
    deleteVehicle _target;
    if (!(player canAddItemToBackpack "toolkit")) then {
        hint "Inventory Full! Toolkit(s) placed in a nearby box.";
        private _newBoxen = "Land_PlasticCase_01_small_F" createVehicle (getPos player);
        _newBoxen addItemCargoGlobal ["toolkit", _numToolkits];
    } else {
        for "_i" from 1 to _numToolkits do {player addItem "toolkit"};
    };
};

salvageCondition = {
    params ["_target", "_player", "_params"];
    private _return = false;
    if (damage _target == 1) then {
        _return = true;
    };
    _return
};

SalvageAction = [
    "SalvageAction", 
    "Salvage into Toolkit(s)", 
    "",
    salvageFunction,
    salvageCondition,
    {}, 
    [], 
    [0, 0, 0], 
    20
] call ace_interact_menu_fnc_createAction;

//////////
//SIPHON AMMO
//////////

ammoSiphonFunction = {
    params ["_target", "_player", "_params"];
    /*
        grab all ammo that isn't empty in vic
        convert to points
        spawn box with points 
        empty out vic's ammo
    */
    private _magazineArray = magazinesAllTurrets _target;
    private _pointsToGive = 0;
    {
        //if players abuse this, only grab box when it equals some kinda max value
        if (_x select 2 > 0) then {
            //private _extractedPoints = getNumber (configFile >> "CfgAmmo" >> (getText (configFile >> "CfgMagazines" >> (_x select 0) >> "ammo")) >> "ace_rearm_caliber");
            //_pointsToGive = _pointsToGive + _extractedPoints;
            [player, _x select 0] call ace_rearm_fnc_createDummy;
        };
    } forEach _magazineArray;

    //_target setVehicleAmmo 0; //LOCAL!!!!! AAAAAAAAAAAAA?
    [_target, 0] remoteExec ["setVehicleAmmo", _target];

};

checkIfVicHasAmmo = {
    params ["_vic"];
    private _return = false;
    {
        if (_x select 2 > 0) exitWith{_return = true};
    } forEach magazinesAllTurrets _vic; 
    _return
};

ammoSiphonCondition = {
    params ["_target", "_player", "_params"];
    (damage _target < 1) && (count (magazinesAllTurrets _target) > 0) && [_target] call checkIfVicHasAmmo
};

ammoSiphonAction = [
    "AmmoSiphonAction", 
    "Steal Ammo", 
    "",
    ammoSiphonFunction,
    ammoSiphonCondition,
    {}, 
    [], 
    [0, 0, 0], 
    20
] call ace_interact_menu_fnc_createAction;

//////////
//ADDACTIONS
//////////

["LandVehicle", 0, ["ACE_MainActions"], FuelSiphonAction, true] call ace_interact_menu_fnc_addActionToClass;
["LandVehicle", 0, ["ACE_MainActions"], SalvageAction, true] call ace_interact_menu_fnc_addActionToClass;
["LandVehicle", 0, ["ACE_MainActions"], ammoSiphonAction, true] call ace_interact_menu_fnc_addActionToClass;





//notes

//magazines[] = {"vn_m2_v_100_mag","vn_m2_v_100_mag","vn_m2_v_100_mag","vn_m2_v_100_mag","vn_m2_v_100_mag","vn_m2_v_100_mag"};
//configfile >> "CfgMagazines" >> "vn_m2_v_100_mag" >> "ammo" 
//vn_127x99
//configfile >> "CfgAmmo" >> "vn_127x99" >> "ace_rearm_caliber"

/*
WHOA MAMA THAT'S A CONFIGFILE STRING
getNumber (configFile >> "CfgAmmo" >> (getText (configFile >> "CfgMagazines" >> (magazinesAllTurrets cursorObject select 0 select 0) >> "ammo")) >> "ace_rearm_caliber")
*/

//["cba_xeh_deleted","ace_rearm_magazineclass","ace_interact_menu_atcache_ace_mainactions","cba_xeh_incomingmissile","cba_xeh_getin","cba_xeh_local","cba_xeh_isprocessed","cba_xeh_init","cba_xeh_initpost","cba_xeh_fired","cba_xeh_engine","cba_xeh_respawn","cba_xeh_killed","cba_xeh_getout","cba_xeh_isinitialized"]