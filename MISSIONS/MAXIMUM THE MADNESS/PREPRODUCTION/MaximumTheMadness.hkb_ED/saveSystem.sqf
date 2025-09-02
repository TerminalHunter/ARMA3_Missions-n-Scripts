/*

SAVE GAME IS

profileNameSpace
    TESTING_MAXIMUMTHEMADNESS_PLAYERDATA -- player array
    TESTING_MAXIMUMTHEMADNESS_VEHICLEDATA -- vehicle array
    TESTING_MAXIMUMTHEMADNESS_OBJECTDATA -- object array, I guess, maybe only do pick-up-able objects.
    TESTING_MAXIMUMTHEMADNESS_ARSENALDATA -- all the uniforms, vests, backpacks, facewear, etc. I guess basic radios too?


TODO:   vehicles should probably keep their appearance between saves
        make it more obvious that inventories are stored in the arsenal

*/

/*
------------
VEHICLE SAVE
------------
*/

birdArray = ["Abyssinian Yellow-rumped Seedeater","Albatross","Avocet","Bantam","Basilisk","Bee-eater","Blackbird","Bluebird","Booby","Budgerigar","Bustard","Buzzard","Canary","Caracal","Cardinal","Cassowary","Catbird","Charon","Chicken","Cockatiel","Cockatoo","Condor","Conure","Coot","Corax","Cormorant","Crane","Crow","Cuckoo","Dodo","Dove","Drake","Duck","Dunnock","Eagle","Emu","Falcon","Ferox","Finch","Flycatcher","Gadwall","Gannet","Goldfinch","Goose","Grebe","Griffin","Harpy","Hawk","Heron","Hoatzin","Hornbill","Hummingbird","Ibis","Jackdaw","Jay","Kea","Kestrel","Kingfisher","Kite","Kitsune","Kiwi","Kookaburra","Leviathan","Lovebird","Macaw","Magpie","Mallard","Manticore","Megapode","Merlin","Minokawa","Moa","Myna","Nighthawk","Nightingale","Nightjar","Oilbird","Onyx","Oriole","Osprey","Ostrich","Owl","Parakeet","Parrot","Partridge","Passerine","Peacock","Pelican","Penguin","Pheasant","Phoenix","Pigeon","Pintail","Pipit","Potoo","Quail","Racket","Rail","Rallidae","Raptor","Raven","Rhea","Roadrunner","Robin","Rokh","Rook","Sandpiper","Seagull","Shoveler","Shrike","Siskin","Skylark","Sparrow","Spoonbill","Starling","Stork","Swallow","Swan","Swift","Tailorbird","Teal","Tengu","Tern","Thrush","Tit","Toucan","Turkey","Vulture","Wagtail","Warbler","Weaverbird","Woodpecker","Wren","Wyvern"];

randomVehicleName = {
    _nameString = (selectRandom birdArray) + " " + str(floor random 100);
    _nameString
};

saveBoxenInventory = {
    params["_box"];

    private _rawItemCargo = getItemCargo _box;
    private _rawMagazineCargo = getMagazineCargo _box;
    private _rawWeaponsCargo = weaponsItemsCargo _box;
    private _rawBackpackCargo = getBackpackCargo _box;
    private _backPacksToCheckForMoreCargo = everyBackpack _box;

    {
        private _singleBackpackInventory = [_x] call saveBoxenInventory;
        (_rawItemCargo select 0) append ((_singleBackpackInventory select 0) select 0);
        (_rawItemCargo select 1) append ((_singleBackpackInventory select 0) select 1);
        (_rawMagazineCargo select 0) append ((_singleBackpackInventory select 1) select 0);
        (_rawMagazineCargo select 1) append ((_singleBackpackInventory select 1) select 1);
        _rawWeaponsCargo append (_singleBackpackInventory select 2);
    } forEach _backPacksToCheckForMoreCargo;

    private _returnArray = [_rawItemCargo,_rawMagazineCargo,_rawWeaponsCargo,_rawBackpackCargo];
    _returnArray

};

loadBoxenInventory = {
    params["_box","_savedBoxenInventory"];
    {
        _box addItemCargoGlobal [_x, (((_savedBoxenInventory select 0) select 1) select _forEachIndex)];
    } forEach ((_savedBoxenInventory select 0) select 0);

    {
        _box addMagazineCargoGlobal [_x, (((_savedBoxenInventory select 1) select 1) select _forEachIndex)];
    } forEach ((_savedBoxenInventory select 1) select 0);

    {
        _box addWeaponWithAttachmentsCargoGlobal [_x, 1];
    } forEach (_savedBoxenInventory select 2);

    {
        _box addBackpackCargoGlobal [_x, (((_savedBoxenInventory select 3) select 1) select _forEachIndex)];
    } forEach ((_savedBoxenInventory select 3) select 0);
};

saveVehicle = {
    params ["_vehicle"];
    //TODO: figure out how to save callsign/name between missions.
    _vehicleSaveArray = [];
    _vehicleSaveArray pushBack (_vehicle getVariable ["vehicleBirdName", call randomVehicleName]);
    _vehicleSaveArray pushBack (getDescription _vehicle select 0);
    _vehicleSaveArray pushBack (fuel _vehicle);
    _vehicleSaveArray pushBack (magazinesAllTurrets _vehicle);
    _vehicleSaveArray pushBack (getAllHitPointsDamage _vehicle);
    _vehicleSaveArray pushBack ([_vehicle] call saveBoxenInventory); //bluh. [itemCargo, MagazineCargo, weaponsItemsCargo, backpackCargo]
    _vehicleSaveArray pushBack (getObjectTextures _vehicle);
    _vehicleSaveArray pushBack ([_vehicle] call ace_rearm_fnc_getSupplyCount);
    _vehicleSaveArray pushBack ([_vehicle] call ACE_refuel_fnc_getFuel);
    //getObjectTextures
    //["cox_factionmod_framework\textures\vans\van_trashed.paa","a3\soft_f_orange\van_02\data\van_wheel_co.paa","a3\soft_f_orange\van_02\data\van_glass_utility_ca.paa","cox_factionmod_framework\textures\vans\van_trashed.paa"]
    _vehicleSaveArray
};

loadVehicle = {
    params["_pos", "_vehicleArray"];
    private _newVehicle = (_vehicleArray select 1) createVehicle _pos;

    clearItemCargoGlobal _newVehicle;
    clearMagazineCargoGlobal _newVehicle;
    clearWeaponCargoGlobal _newVehicle;
    clearBackpackCargoGlobal _newVehicle;

    private _vehicleRespawn = [west, _newVehicle, _vehicleArray select 0] call BIS_fnc_addRespawnPosition;
    _newVehicle setVariable ["vehicleBirdName", _vehicleArray select 0, true];

    _newVehicle setFuel (_vehicleArray select 2);
    _newVehicle setVehicleAmmo 0;

    {
        //_newVehicle removeMagazineTurret [_x select 0, _x select 1];
        _newVehicle addMagazineTurret [_x select 0, _x select 1, _x select 2];
    } forEach (_vehicleArray select 3);
    
    {
        _newVehicle setHitPointDamage [_x, (((_vehicleArray select 4) select 2) select _forEachIndex), false];
    } forEach ((_vehicleArray select 4) select 0);
    
    [_newVehicle, _vehicleArray select 5] call loadBoxenInventory;

    {
        _newVehicle setObjectTextureGlobal [_forEachIndex, _x];
    } forEach (_vehicleArray select 6);

    [_newVehicle, _vehicleArray select 7] call ace_rearm_fnc_setSupplyCount;
    [_newVehicle, _vehicleArray select 8] call ace_refuel_fnc_setFuel;
};

/*
------------
PLAYER INVENTORY SAVE
------------
*/

savePlayerInventory = {
    params["_player"];
    private _playerUID = getPlayerUID _player;
    private _playerInventory = getUnitLoadout _player;
    playerSaveHashmap set [_playerUID, _playerInventory];
    _player setUnitLoadout [[],[],[],["",[]],[],[],"","",[],["ItemMap","","rhsusf_radio_anprc152","ItemCompass","ItemWatch",""]];
};

saveAllPlayerInventories = {
    {
        [_x] call savePlayerInventory;
    } forEach allPlayers;
};

loadPlayerInventory = {
    params ["_playa"];
    _playa setUnitLoadout (playerSaveHashmap get (getPlayerUID _playa));
    playerSaveHashmap deleteAt (getPlayerUID _playa);
};

loadAllPlayersInventories = {
    {
        [_x] call loadPlayerInventory;
    } forEach allPlayers;
};

hardSavePlayerInventories = {
    profileNamespace setVariable ["TESTING_MAXIMUMTHEMADNESS_PLAYERDATA", playerSaveHashmap];
};

hardLoadPlayerInventories = {
    playerSaveHashmap = profileNamespace getVariable "TESTING_MAXIMUMTHEMADNESS_PLAYERDATA";
};

if (isServer) then{
    playerSaveHashmap = createHashMap;
    [] call hardLoadPlayerInventories;
};


/*
------------
ARSENAL SAVE
------------
*/

// raiderArsenal.sqf takes care of this

/*
------------
OBJECT SAVE
------------
*/

//TODO: TBD

/*
------------
THE BIG BUTTON
------------
*/

fullSave = {
    private _grabbedVehicles = nearestObjects [infilExfilArea, ["LandVehicle"], 120, true];
    private _vehiclesToSave = [];
    {
        private _newVehicleArray = [_x] call saveVehicle;
        _vehiclesToSave pushBackUnique _newVehicleArray;
    } forEach _grabbedVehicles;
    profileNamespace setVariable ["TESTING_MAXIMUMTHEMADNESS_VEHICLEDATA", _vehiclesToSave];
    private _hintString = str(count _grabbedVehicles) + " vehicles saved.";
    [_hintString] remoteExec ["hint"];

    //[] call saveAllPlayerInventories;
    //[] call hardSavePlayerInventories;
};

infilExfilFlagpole addAction ["Save Vehicles", {
    [] remoteExec ["fullSave", 2];
},[],1.5,true,true,"","true",10,false,"",""];

/*
------------
LOAD ON START
------------
*/

getExfilOffset = {
    params ["_slotNumber"];
    private _kindaX = (_slotNumber mod 4) * 15;
    private _kindaY = (floor (_slotNumber / 4)) * 15;
    _returnValue = (infilExfilArea vectorAdd [10,-50,0]) vectorAdd [_kindaX, _kindaY, 0];
    _returnValue
};

if (isServer) then {
    _initVehicles = profileNamespace getVariable ["TESTING_MAXIMUMTHEMADNESS_VEHICLEDATA",[]];
    {
        [[_forEachIndex] call getExfilOffset, _x] call loadVehicle;
    } forEach _initVehicles;
};



















/*
[["vn_m2_v_100_mag",[1],100,1.00086e+07,2],["vn_m2_v_100_mag",[1],100,1.00086e+07,2],["vn_m2_v_100_mag",[1],100,1.00086e+07,2],["vn_m2_v_100_mag",[1],100,1.00086e+07,2],["vn_m2_v_100_mag",[1],100,1.00086e+07,2],["vn_m2_v_100_mag",[1],100,1.00086e+07,2],["vn_m2_v_100_mag",[2],100,1.00086e+07,2],["vn_m2_v_100_mag",[2],100,1.00086e+07,2],["vn_m2_v_100_mag",[2],100,1.00086e+07,2],["vn_m2_v_100_mag",[2],100,1.00086e+07,2],["vn_m2_v_100_mag",[2],100,1.00086e+07,2],["vn_m2_v_100_mag",[2],100,1.00086e+07,2],["vn_m2_v_100_mag",[3],100,1.00086e+07,2],["vn_m2_v_100_mag",[3],100,1.00086e+07,2],["vn_m2_v_100_mag",[3],100,1.00086e+07,2],["vn_m2_v_100_mag",[3],100,1.00086e+07,2],["vn_m2_v_100_mag",[3],100,1.00086e+07,2],["vn_m2_v_100_mag",[3],100,1.00086e+07,2]]
*/