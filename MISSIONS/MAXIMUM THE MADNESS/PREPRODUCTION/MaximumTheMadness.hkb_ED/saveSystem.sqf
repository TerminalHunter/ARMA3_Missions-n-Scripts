/*

VEHICLE SAVE

example magazinesAmmo [VEHICLE,true]
[["CUP_70Rnd_TE1_Red_Tracer_25mm_M242_APFSDS",0],["CUP_70Rnd_TE1_Red_Tracer_25mm_M242_APFSDS",0],["CUP_70Rnd_TE1_Red_Tracer_25mm_M242_APFSDS",0],["CUP_230Rnd_TE1_Red_Tracer_25mm_M242_HE",0],["CUP_230Rnd_TE1_Red_Tracer_25mm_M242_HE",0],["CUP_230Rnd_TE1_Red_Tracer_25mm_M242_HE",0],["CUP_800Rnd_TE4_Red_Tracer_762x51_M240_M",0],["CUP_800Rnd_TE4_Red_Tracer_762x51_M240_M",0],["CUP_800Rnd_TE4_Red_Tracer_762x51_M240_M",0],["CUP_2Rnd_TOW2_M",0],["CUP_2Rnd_TOW2_M",0],["CUP_2Rnd_TOW2_M",0],["CUP_1Rnd_TOW2_M",0]]

example getAllHitPointsDamage
[["hithull","hitengine","hitltrack","hitrtrack","hitfuel","hitera_l1","hitera_l2","hitera_l3","hitera_l4","hitera_l5","hitera_l6","hitera_l7","hitera_l8","hitera_r1","hitera_r2","hitera_r3","hitera_r4","hitera_r5","hitera_r6","hitera_r7","hitera_r8","hitera_t1","hitera_t2","hitera_t3","hitera_t4","hitera_t5","hitera_t6","hitera_t7","hitera_t8","hitera_fr1","hitera_fr2","hitera_fr3","hitera_fr4","hitera_fr5","hitera_fr6","hitera_fr7","hitera_fr8","hitera_fr9","hitera_fl1","hitera_fl2","hitera_fl3","hitera_fl4","hitera_fl5","hitturret","hitgun","hitcommanderturret","#light_l","#light_r"],["hit_hull_point","hit_engine_point","hit_trackl_point","hit_trackr_point","hit_fuel_point","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","hit_main_turret_point","hit_main_gun_point","hit_com_turret_point","light_l","light_r"],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]

*/

birdArray = ["Abyssinian Yellow-rumped Seedeater","Albatross","Avocet","Bantam","Basilisk","Bee-eater","Blackbird","Bluebird","Budgerigar","Bustard","Buzzard","Canary","Caracal","Cardinal","Cassowary","Catbird","Charon","Chicken","Cockatiel","Cockatoo","Condor","Conure","Coot","Corax","Cormorant","Crane","Crow","Cuckoo","Dodo","Dove","Drake","Duck","Dunnock","Eagle","Emu","Falcon","Ferox","Finch","Flycatcher","Gadwall","Gannet","Goldfinch","Goose","Grebe","Griffin","Harpy","Hawk","Heron","Hoatzin","Hornbill","Hummingbird","Ibis","Jackdaw","Jay","Kea","Kestrel","Kingfisher","Kite","Kitsune","Kiwi","Kookaburra","Leviathan","Lovebird","Macaw","Magpie","Mallard","Manticore","Megapode","Merlin","Minokawa","Moa","Myna","Nighthawk","Nightingale","Nightjar","Oilbird","Onyx","Oriole","Osprey","Ostrich","Owl","Parakeet","Parrot","Partridge","Passerine","Peacock","Pelican","Penguin","Pheasant","Phoenix","Pigeon","Pintail","Pipit","Potoo","Quail","Racket","Rail","Rallidae","Raptor","Raven","Rhea","Roadrunner","Robin","Rokh","Rook","Sandpiper","Seagull","Shoveler","Shrike","Siskin","Skylark","Sparrow","Spoonbill","Starling","Stork","Swallow","Swan","Swift","Tailorbird","Teal","Tengu","Tern","Thrush","Toucan","Turkey","Vulture","Wagtail","Warbler","Weaverbird","Woodpecker","Wren","Wyvern"];

randomVehicleName = {
    _nameString = (selectRandom birdArray) + " " + str(floor random 100);
    _nameString
};

saveInventory = {
    params["_box"];

    private _rawItemCargo = getItemCargo _box;
    private _rawMagazineCargo = getMagazineCargo _box;
    private _rawWeaponsCargo = weaponsItemsCargo _box;
    private _rawBackpackCargo = getBackpackCargo _box;
    private _backPacksToCheckForMoreCargo = everyBackpack _box;

    {
        private _singleBackpackInventory = [_x] call saveInventory;
        (_rawItemCargo select 0) append ((_singleBackpackInventory select 0) select 0);
        (_rawItemCargo select 1) append ((_singleBackpackInventory select 0) select 1);
        (_rawMagazineCargo select 0) append ((_singleBackpackInventory select 1) select 0);
        (_rawMagazineCargo select 1) append ((_singleBackpackInventory select 1) select 1);
        _rawWeaponsCargo append (_singleBackpackInventory select 2);
    } forEach _backPacksToCheckForMoreCargo;

    private _returnArray = [_rawItemCargo,_rawMagazineCargo,_rawWeaponsCargo,_rawBackpackCargo];
    _returnArray

};

//[[["FirstAidKit","Medikit","ToolKit"],[20,2,1]],[["CUP_30Rnd_556x45_Stanag","CUP_200Rnd_TE4_Red_Tracer_556x45_M249","CUP_1Rnd_HEDP_M203","CUP_HandGrenade_M67","SmokeShell","SmokeShellOrange","Chemlight_red"],[20,4,10,4,4,4,4]],[["CUP_arifle_M4A1_black","","","",[],[],""],["CUP_arifle_M4A1_black","","","",[],[],""],["CUP_arifle_M4A1_black","","","",[],[],""],["CUP_arifle_M4A1_black","","","",[],[],""],["CUP_launch_M136","","","",[],[],""],["CUP_launch_M136","","","",[],[],""],["CUP_launch_M136","","","",[],[],""],["CUP_launch_M136","","","",[],[],""]],[["CUP_B_USPack_Coyote"],[8]]]

flattenBoxCargo = { //TODO: DON'T LEAVE YET MORE TECH DEBT. GET THIS WORKING IN A RECURSIVE WAY.
    params["_box"]; 
    
    private _rawItemCargo = getItemCargo _box;
    private _rawMagazineCargo = getMagazineCargo _box;
    private _rawWeaponsCargo = weaponsItemsCargo _box;
    private _rawBackpackCargo = getBackpackCargo _box;
    private _backPacksToCheckForMoreCargo = everyBackpack _box;

    //okay, but backpacks.
    private _backpackRawItemCargo = [];
    private _backpackRawMagazineCargo = [];
    private _backpackRawWeaponCargo = [];
    {
        private _flattenedBackpack = [_x] call flattenBackpackCargo;
        _backpackRawItemCargo pushBack (_flattenedBackpack select 0);
        _backpackRawMagazineCargo pushBack (_flattenedBackpack select 1);
        _backpackRawWeaponCargo append (_flattenedBackpack select 2);
    } forEach _backPacksToCheckForMoreCargo;

    //zipper
    {
        private _itemNames = _x select 0;
        private _itemNums = _x select 1;
        (_rawItemCargo select 0) append _itemNames;
        (_rawItemCargo select 1) append _itemNums; 
    } forEach _backpackRawItemCargo;

    {
        private _itemNames = _x select 0;
        private _itemNums = _x select 1;
        (_rawMagazineCargo select 0) append _itemNames;
        (_rawMagazineCargo select 1) append _itemNums; 
    } forEach _backpackRawMagazineCargo;

    _rawWeaponsCargo append _backpackRawWeaponCargo;

    private _returnArray = [];
    _returnArray pushBack _rawItemCargo;
    _returnArray pushBack _rawMagazineCargo;
    _returnArray pushBack _rawWeaponsCargo;
    _returnArray pushBack _rawBackpackCargo;

    _returnArray

};

flattenBackpackCargo = {
    params["_backpack"]; //this is so shitty, ya'll need to fix this
    private _rawItemCargo2 = getItemCargo _backpack;
    private _rawMagazineCargo2 = getMagazineCargo _backpack;
    private _rawWeaponsCargo2 = weaponsItemsCargo _backpack;

    private _returnArray2 = [_rawItemCargo2, _rawMagazineCargo2, _rawWeaponsCargo2];
    _returnArray2
};

saveVehicle = {
    params ["_vehicle"];
    //TODO: figure out how to save callsign/name between missions.
    _vehicleSaveArray = [];
    _vehicleSaveArray pushBack (call randomVehicleName);
    _vehicleSaveArray pushBack (getDescription _vehicle select 0);
    _vehicleSaveArray pushBack (fuel _vehicle);
    _vehicleSaveArray pushBack (magazinesAmmo [_vehicle,true]);
    _vehicleSaveArray pushBack (getAllHitPointsDamage _vehicle);
    _vehicleSaveArray pushBack ([_vehicle] call flattenBoxCargo); //bluh. [itemCargo, MagazineCargo, weaponsItemsCargo, backpackCargo]
    _vehicleSaveArray
};

loadVehicle = {
    params["_pos", "_vehicleArray"];
};

/*

vehicle save data should be:

    [
        "name",
        "kindOfVehicle",
        fuel amount,
        [magazinesAmmo],
        [getAllHitPointsDamage],
        [inventory]
    ]

["Buzzard 5","CUP_B_M2Bradley_USA_D",1,[["CUP_70Rnd_TE1_Red_Tracer_25mm_M242_APFSDS",70],["CUP_70Rnd_TE1_Red_Tracer_25mm_M242_APFSDS",70],["CUP_70Rnd_TE1_Red_Tracer_25mm_M242_APFSDS",70],["CUP_230Rnd_TE1_Red_Tracer_25mm_M242_HE",230],["CUP_230Rnd_TE1_Red_Tracer_25mm_M242_HE",230],["CUP_230Rnd_TE1_Red_Tracer_25mm_M242_HE",230],["CUP_800Rnd_TE4_Red_Tracer_762x51_M240_M",800],["CUP_800Rnd_TE4_Red_Tracer_762x51_M240_M",800],["CUP_800Rnd_TE4_Red_Tracer_762x51_M240_M",800],["CUP_2Rnd_TOW2_M",2],["CUP_2Rnd_TOW2_M",2],["CUP_2Rnd_TOW2_M",2],["CUP_1Rnd_TOW2_M",1]],[["hithull","hitengine","hitltrack","hitrtrack","hitfuel","hitera_l1","hitera_l2","hitera_l3","hitera_l4","hitera_l5","hitera_l6","hitera_l7","hitera_l8","hitera_r1","hitera_r2","hitera_r3","hitera_r4","hitera_r5","hitera_r6","hitera_r7","hitera_r8","hitera_t1","hitera_t2","hitera_t3","hitera_t4","hitera_t5","hitera_t6","hitera_t7","hitera_t8","hitera_fr1","hitera_fr2","hitera_fr3","hitera_fr4","hitera_fr5","hitera_fr6","hitera_fr7","hitera_fr8","hitera_fr9","hitera_fl1","hitera_fl2","hitera_fl3","hitera_fl4","hitera_fl5","hitturret","hitgun","hitcommanderturret","#light_l","#light_r"],["hit_hull_point","hit_engine_point","hit_trackl_point","hit_trackr_point","hit_fuel_point","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","hit_main_turret_point","hit_main_gun_point","hit_com_turret_point","light_l","light_r"],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]],[[["FirstAidKit","Medikit","ToolKit"],[20,2,1]],[["CUP_30Rnd_556x45_Stanag","CUP_200Rnd_TE4_Red_Tracer_556x45_M249","CUP_1Rnd_HEDP_M203","CUP_HandGrenade_M67","SmokeShell","SmokeShellOrange","Chemlight_red"],[20,4,10,4,4,4,4]],[["CUP_arifle_M4A1_black","","","",[],[],""],["CUP_arifle_M4A1_black","","","",[],[],""],["CUP_arifle_M4A1_black","","","",[],[],""],["CUP_arifle_M4A1_black","","","",[],[],""],["CUP_launch_M136","","","",[],[],""],["CUP_launch_M136","","","",[],[],""],["CUP_launch_M136","","","",[],[],""],["CUP_launch_M136","","","",[],[],""],[],[],[],[],[],[],[],[]],[["CUP_B_USPack_Coyote"],[8]]]]
*/