//////////
//SIPHON FUEL
//////////

fuelSiphonFunction = {
    params ["_target", "_player", "_params"];
    private _timeToSiphon = 4;
    private _siphonString = "Siphoning fuel... ";
    {
        if (side _x == east) then {
            _timeToSiphon = 30;
            _siphonString = "Squabbling with crew while attempting to siphon fuel... ";
        };
    } forEach crew _target;
    [_player, selectRandom immersion_pops_eatSounds] remoteExec ["say3D"];
    [_timeToSiphon, [_target, _player, _siphonString], 
    {
        params ["_this"]; //this is a hilarious work-around. [_args, _elapsedTime, _totalTime, _errorCode] gets passed in by the function, map _args to _this, params it again, lol
        params ["_target", "_player", "_siphonString"];
        private _newJerryCan = "Land_CanisterPlastic_F" createVehicle (getPos _player);
        [_newJerryCan, false] call ACE_dragging_fnc_setCarryable;
        private _fuelCapacity = getNumber (configFile >> "CfgVehicles" >> (typeOf _target) >> "ace_refuel_fuelCapacity");

        if (((fuel _target) * _fuelCapacity) > 100) then {
            //[_newJerryCan, 100] call ace_refuel_fnc_makeJerryCan;
            [_newJerryCan, 100] remoteExec ["ace_refuel_fnc_makeJerryCan", 0, true];
            _target setFuel (fuel _target - (100/_fuelCapacity));
        } else {
            //[_newJerryCan, ((fuel _target) * _fuelCapacity)] call ace_refuel_fnc_makeJerryCan;
            [_newJerryCan, ((fuel _target) * _fuelCapacity)] remoteExec ["ace_refuel_fnc_makeJerryCan", 0, true];
            _target setFuel 0;
        };
    }, 
    {
        //fuel not siphoned!
    }, _siphonString, 
    {
        params["_this"];
        params ["_target", "_player", "_siphonString"];
        _target distance player < 20
    }] call ace_common_fnc_progressBar;
    
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
    [floor (getMass _target / 1000) + 10, [_target], 
    {
        params ["_this"];
        params ["_target"];
        private _massScrap = getMass _target;
        private _numToolkits = floor (_massScrap / 10000) + 1;
        deleteVehicle _target;
        if (player canAdd ["toolkit", _numToolkits]) then {
            for "_i" from 1 to _numToolkits do {player addItem "toolkit"};
        } else {
            hint "Inventory Full! Toolkit(s) placed in a nearby box.";
            private _newBoxen = "Land_PlasticCase_01_small_F" createVehicle (getPos player);
            _newBoxen addItemCargoGlobal ["toolkit", _numToolkits];
        };  
    }, 
    {
        //on failure/interruption I guess do nothing
    }, 
    "Salvaging wreck into toolkits..."] call ace_common_fnc_progressBar; //TODO: change string - toolkit vs toolkits?
     
};

salvageCondition = {
    params ["_target", "_player", "_params"];
    damage _target == 1
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
    private _timeToSiphon = 10;
    private _siphonString = "Stealing ammo... ";
    {
        if (side _x == east) then {
            _timeToSiphon = 30;
            _siphonString = "Squabbling with crew while attempting to steal ammo... ";
        };
    } forEach crew _target;

    [_timeToSiphon, [_target, _player, _siphonString], 
    {
        params["_this"];
        params["_target", "_player", "_siphonString"];
        private _magazineArray = magazinesAllTurrets _target;
        private _pointsToGive = 0;
        {
            //TODO: if players abuse this, only grab box when it equals some kinda max value
            if (_x select 2 > 0) then {
                //private _extractedPoints = getNumber (configFile >> "CfgAmmo" >> (getText (configFile >> "CfgMagazines" >> (_x select 0) >> "ammo")) >> "ace_rearm_caliber");
                //_pointsToGive = _pointsToGive + _extractedPoints;
                [player, _x select 0] call ace_rearm_fnc_createDummy;
            };
        } forEach _magazineArray;

        [_target, 0] remoteExec ["setVehicleAmmo", _target];
    }, 
    {
        //whoa! nothing!
    }, 
    _siphonString,
    {
        params["_this"];
        params ["_target", "_player", "_siphonString"];
        _target distance player < 20
    }
    ] call ace_common_fnc_progressBar
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
//SCROUNGE UP A MAGAZINE
//////////

scroungeMagazineFunction = {
    params ["_target", "_player", "_params"];
    private _weaponName = getText(configfile >> "CfgWeapons" >> primaryWeapon player >> "descriptionShort");
    private _scroungeString = format ["Scrounging ammo and making a magazine for your %1", _weaponName];
    [2, [_target, _player], 
    {
        params["_this"];
        params["_target","_player"];
        if (primaryWeapon _player == "") then {
            hint "primary weapons only. TODO: add handgun magazine scrounging"
        } else {
            private _newMagazine = selectRandom compatibleMagazines primaryWeapon player;
            if (_player canAdd _newMagazine) then {
                player addItem _newMagazine;
                private _ammoSupplyCount = [_target] call ACE_rearm_fnc_getSupplyCount;
                [_target, _ammoSupplyCount - 2] call ACE_rearm_fnc_setSupplyCount;
            } else {
                hint "Your inventory's too full.";
            };
        };
    }, 
    {}, 
    _scroungeString] call ace_common_fnc_progressBar;

};

scroungeMagazineCondition = {
    params ["_target", "_player", "_params"];
    (damage _target < 1) && (getNumber(configfile >> "CfgVehicles" >> typeof _target >> "ace_rearm_defaultSupply") > 0) && ([_target] call ace_rearm_fnc_getSupplyCount > 1)
};

scroungeMagazineAction = [
    "ScroungeMagazine", 
    "Scrounge up a magazine", 
    "",
    scroungeMagazineFunction,
    scroungeMagazineCondition,
    {}, 
    [], 
    [0, 0, 0], 
    20
] call ace_interact_menu_fnc_createAction;

//////////
//DELETE BACKPACKS AND VESTS
//////////

removeBackpackAndVestFunction = {
    params ["_target", "_player", "_params"];
    clearBackpackCargoGlobal _target;
    private _itemsInTheVehicle = itemCargo _target;
    {
        if (_x isKindOf ["Vest_NoCamo_Base", configFile >> "CfgWeapons"]) then {
            _target addItemCargoGlobal [_x,-1];
        };
    } forEach _itemsInTheVehicle;
};

removeBackpackAndVestCondition = {
    params ["_target", "_player", "_params"];
    damage _target != 1
};

deleteBackpackAndVestsAction = [
    "DeleteBackpackAndVest", 
    "Remove Backpacks and Vests", 
    "",
    removeBackpackAndVestFunction,
    removeBackpackAndVestCondition,
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
["LandVehicle", 0, ["ACE_MainActions"], scroungeMagazineAction, true] call ace_interact_menu_fnc_addActionToClass;
["LandVehicle", 0, ["ACE_MainActions"], deleteBackpackAndVestsAction, true] call ace_interact_menu_fnc_addActionToClass;





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