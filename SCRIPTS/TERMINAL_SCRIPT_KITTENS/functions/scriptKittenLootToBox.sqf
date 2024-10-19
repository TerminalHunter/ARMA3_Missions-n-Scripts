/*

SCRIPT KITTEN THAT TURNS A CORPSE INTO A BOX OF LOOT!

*/

lootBody = {
	params ["_target", "_player", "_params"];
	_corpse = _target;
	_corpseStuff = getUnitLoadout _corpse;
	_corpsePos = getPosASL _corpse;
	_uniformLoot = uniformItems _corpse;
	{
			_corpse removeItemFromUniform _x;
	} forEach _uniformLoot;
	_vestLoot = vestItems _corpse;
	{
			_corpse removeItemFromVest _x;
	} forEach _vestLoot;
	_backpackLoot = backpackItems _corpse;
	{
			_corpse removeItemFromBackpack _x;
	} forEach _backpackLoot;

	_allLoot = [];
	_allLoot append _uniformLoot;
	_allLoot append _vestLoot;
	_allLoot append _backpackLoot;
	_allLoot pushBack (uniform _corpse);
	_allLoot pushBack (vest _corpse);
	//_allLoot pushBack (backpack _corpse); //this doesn't put the backpack into the loot?
	_backpackHack = backpack _corpse;
	_allLoot pushBack (binocular _corpse);
	_allLoot pushBack (headgear _corpse);
	_allLoot pushBack (goggles _corpse);
	_allLoot append (_corpseStuff select 9);

  //If you'd like to change the box that spawns, change the "Land_MetalCase_01_small_F" in the following line (and the deleteLootBoxAction below)
  //Make sure it has an inventory items can be put into
	_lootBoxObjectString = "Land_MetalCase_01_small_F";
	_newLootPile =  _lootBoxObjectString createVehicle _corpsePos;

	{
	   _newLootPile addItemCargoGlobal [_x,1];
	} forEach _allLoot;

	//workaround for backpack
	if (_backpackHack != "") then {
			_newLootPile addBackpackCargoGlobal [_backpackHack, 1];
	};

	{ 
		clearMagazineCargoGlobal (_x # 1);
		clearItemCargoGlobal (_x # 1);
		clearWeaponCargoGlobal (_x # 1);
	} forEach everyContainer _newLootPile;

	//get weapons attached to corpse

	if (count (_corpseStuff select 0) > 1) then {
		_newLootPile addWeaponWithAttachmentsCargoGlobal [_corpseStuff select 0,1];
	};
	if (count (_corpseStuff select 1) > 1) then {
		_newLootPile addWeaponWithAttachmentsCargoGlobal [_corpseStuff select 1,1];
	};
	if (count (_corpseStuff select 2) > 1) then{
		_newLootPile addWeaponWithAttachmentsCargoGlobal [_corpseStuff select 2,1];
	};

	//get dropped weapons
	_weaponsOnGround = nearestObjects [getPos _corpse, ["WeaponHolderSimulated", "GroundWeaponHolder", "Default"], 10];
	{
			_thingOnGround = weaponsItemsCargo _x;
			{_newLootPile addWeaponWithAttachmentsCargoGlobal [_x,1];} forEach _thingOnGround;
			deleteVehicle _x;
	} forEach _weaponsOnGround;

	//set position again since createVehicle looks for nearby unoccupied space and it'd be better if it appeared right on the object interacted with
	_newLootPile setPosASL (_corpsePos);
	deleteVehicle _corpse;
};

lootAction = ["lootBody", "Loot Body","", lootBody, {!alive _target}] call ace_interact_menu_fnc_createAction;

["Man", "init",
  {
    [(_this select 0), 0, ["ACE_MainActions"], lootAction] call ace_interact_menu_fnc_addActionToObject;
  },
true, [], true] call CBA_fnc_addClassEventHandler;

//give players the ability to delete loot boxen

deleteLootBox = {
	params ["_target", "_player", "_params"];
	deleteVehicle _target;
};

deleteLootBoxAction = ["deleteLootBox", "Delete This Lootbox","", deleteLootBox, {true}] call ace_interact_menu_fnc_createAction;

["Land_MetalCase_01_small_F", "init",
  {
    [(_this select 0), 0, ["ACE_MainActions"], deleteLootBoxAction] call ace_interact_menu_fnc_addActionToObject;
  },
false, [], true] call CBA_fnc_addClassEventHandler;