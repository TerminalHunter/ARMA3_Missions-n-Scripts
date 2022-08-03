loadTheWholeDamnGame = {
  //load and set positions and directions of all items necessary
  stuffToLoad = [
    jackShack1,
    jackShack2,
    jackShackRespawn1,
    jackShackRespawn2,
    junkTruck1,
    junkTruck2
  ];

  {
    if (!isNil {profileNamespace getVariable (str _x + "Loc")}) then {
      _stuffLoc = profileNamespace getVariable (str _x + "Loc");
      _stuffDir = profileNamespace getVariable (str _x + "Dir");
      _x setDir _stuffDir; //the biki says set direction first, so we're doing that here.
      _x setPos _stuffLoc;
    };
  } forEach stuffToLoad;

  //Delete the temporary FOB things
  tempFob = [
    spawnStorageTent,
    spawnBarracksTent,
    spawnBarracksTent2,
    spawnStartingEquip1,
    spawnStartingEquip2,
    spawnStartingEquip3,
    spawnStartingEquip4,
    spawnStartingEquip5
  ];
  {deleteVehicle _x} forEach tempFob;

  //assume if the players have gotten to the point where they save then they found the first thing I told them to find
  call baseFound;

  //empty the box, since it contains first-run getContainerMaxLoad
  clearItemCargoGlobal partyInventory;
  //load all the items in the party inventory and put them there
  //step 1, do the easy stuff
  [profileNamespace getVariable "partyInventoryItemContents"] call loadEasyCargo;
  [profileNamespace getVariable "partyInventoryMagazineContents"] call loadEasyCargo;
  [profileNamespace getVariable "partyInventoryBackpackContents"] call loadEasyCargo;
  //step 2, do the guns - they use a different function
  _partyInventoryWeaponContents = profileNamespace getVariable "partyInventoryWeaponContents";
  {
    partyInventory addWeaponWithAttachmentsCargoGlobal [_x, 1];
  } forEach _partyInventoryWeaponContents;
  //step 3, do the containers. Fuck you.
  [profileNamespace getVariable "partyInventoryExtraItemContents"] call loadEasyCargo;
  _partyInventoryExtraWeaponContents = profileNamespace getVariable "partyInventoryExtraWeaponContents";
  {
    partyInventory addWeaponWithAttachmentsCargoGlobal [_x, 1];
  } forEach _partyInventoryExtraWeaponContents;
};

saveObjectLocAndDir = {
	params ["_savedObject"];

  _objectLoc = getPos _savedObject;
  _objectDir = getDir _savedObject;

  profileNamespace setVariable [(str _savedObject) + "Loc", _objectLoc];
  profileNamespace setVariable [(str _savedObject) + "Dir", _objectDir];
};

loadEasyCargo = {
  params ["_cargoList"];
  if (count _cargoList == 0) then {
      //do nothing
    } else {
      _itemList = _cargoList select 0;
      _countList = _cargoList select 1;
      {
        partyInventory addItemCargoGlobal [(_itemList select _forEachIndex),(_countList select _forEachIndex)];
      } forEach _itemList;
    };
};

baseFound = {
	//delete Temp Spawnpoint
  [west,0] remoteExec ["BIS_fnc_removeRespawnPosition",0,true];
	//Add spawn point at base
	[missionNamespace, baseFlag,"Wendigo Company FOB"] call BIS_fnc_addRespawnPosition;
	//rename base marker
	["baseSpawnpoint", "Wendigo Company FOB"] remoteExec ["setMarkerText",0,true];
};

//profileNamespace setVariable ["partyInventoryItemContents", getItemCargo partyInventory];
//profileNamespace setVariable ["partyInventoryBackpackContents", getBackpackCargo partyInventory];
//profileNamespace setVariable ["partyInventoryWeaponContents", getWeaponCargo partyInventory];
//profileNamespace setVariable ["partyInventoryMagazineContents", getMagazineCargo partyInventory];

//[["AM_AvBagInvis",20b314ca080# 1177553: dummyweapon_single.p3d],["armor_ncr_trooper_01_winter_uniform",20b314c9600# 1177554: dummyweapon_single.p3d]]
//[["AM_HuntingRifle","","","",["10Rnd_308_Mag",10],[],""],["AM_HuntingRifle","","","",["10Rnd_308_Mag",10],[],""]]
//profileNamespace setVariable ["hyperboreaCampaignDate",nil];
//EVERY CONTAINER! WHAT?!

//[["armor_ncr_trooper_01_winter_uniform",20bc406ab00# 1177568: dummyweapon_single.p3d],["Backpack_02",20cf671f580# 1177572: backpack_02.p3d],["Backpack_02",20ca8a0b580# 1177595: backpack_02.p3d]]

//shit, uniforms and vests count as containers and items
//backpacks aren't items, though
//everyContainer
//[["armor_ncr_trooper_01_winter_uniform",20bc406ab00# 1177568: dummyweapon_single.p3d],["AM_AvBagInvis",20bc406b580# 1177567: dummyweapon_single.p3d],["Backpack_02",20cf671f580# 1177572: backpack_02.p3d],["Backpack_02",20ca8a0b580# 1177595: backpack_02.p3d]]
//getItemCargo
//[["ToolKit","ACE_EntrenchingTool","armor_ncr_trooper_01_winter_uniform","AM_AvBagInvis"],[2,12,1,1]]
