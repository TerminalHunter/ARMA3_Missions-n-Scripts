//INIT FUNCTION DEFS

//manual save system init
campaignStartSave = {
	publicVariableServer "startSaveGame";
};

//START LOAD CODE
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
//END LOAD CODE

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

//tools to help players organize the bank
parseEasyCargo = {
  params ["_cargoList"];
  _return = "";
  if (count _cargoList == 0) then {
      //do nothing
    } else {
      _itemList = _cargoList select 0;
      _countList = _cargoList select 1;
      {
        //partyInventory addItemCargoGlobal [(_itemList select _forEachIndex),(_countList select _forEachIndex)];
        _addition = "[ " + (str (_countList select _forEachIndex)) + "x " + (_itemList select _forEachIndex) + " ] ";
        _return = _return + _addition;
      } forEach _itemList;
    };
    _return
};

parseWeaponCargo = {
  params ["_weaponList"];
  _return = "";
  {
    _addition = "[ 1x " + (str(_x select 0)) + " ] ";
    _return = _return + _addition;
  } forEach _weaponList;
  _return
};

bankCheck = {
  _return = "";
  _first = profileNamespace getVariable "partyInventoryItemContents";
  _parsedFirst = [_first] call parseEasyCargo;
  _second = profileNamespace getVariable "partyInventoryMagazineContents";
  _parsedSecond = [_second] call parseEasyCargo;
  _third = profileNamespace getVariable "partyInventoryBackpackContents";
  _parsedThird = [_third] call parseEasyCargo;
  _fourth = profileNamespace getVariable "partyInventoryWeaponContents";
  _parsedFourth = [_fourth] call parseWeaponCargo;
  _fifth = profileNamespace getVariable "partyInventoryExtraItemContents";
  _parsedFifth = [_fifth] call parseEasyCargo;
  _sixth = profileNamespace getVariable "partyInventoryExtraWeaponContents";
  _parsedSixth = [_sixth] call parseWeaponCargo;
  _return = "BANK: " + _parsedFirst + str _parsedSecond + str _parsedThird + str _parsedFourth + str _parsedFifth + str _parsedSixth;
  _return
};

//SERVER SIDE CODE

if (isServer) then {

  updateCampaignData = {
  	//gets the date & time and saves it
  	//hyperboreaCampaignDate IS VERY IMPORTANT. THIS VARIABLE DETERMINES IF GAME HAS BEEN STARTED BEFORE.
  	_currDate = date;
  	profileNamespace setVariable ["hyperboreaCampaignDate",_currDate];
  	//gets the position and direction of the two Jack Shacks and save them
  	[jackShack1] call saveObjectLocAndDir;
  	[jackShack2] call saveObjectLocAndDir;
  	//if at least one of the Jack Shacks is under the map or loaded in a vehicle -- push a big 'ol warning
  	if ((getPos jackShack1 select 2) < -80 or (getPos jackShack2 select 2) < -80) then {
  		[] spawn {
  			sleep 2;
  			["!!WARNING!!\nJACK SHACK STILL LOADED IN VEHICLE\n(or something's fucky with it)\nUNLOAD THE JACK SHACK AND SAVE AGAIN\n!!WARNING!!"] remoteExec ["hint",0,false];
  		};
  	};
  	//gets the position and direction of the spawn points and saves them
  	[jackShackRespawn1] call saveObjectLocAndDir;
  	[jackShackRespawn2] call saveObjectLocAndDir;
  	//gets the position and direction of the vehicles, if alive, and save them
  	if (alive junkTruck1) then {
  		[junkTruck1] call saveObjectLocAndDir;
  	} else {
  		profileNamespace setVariable ["junkTruck1Loc", nil];
  		profileNamespace setVariable ["junkTruck1Dir", nil];
  	};
  	if (alive junkTruck2) then {
  		[junkTruck2] call saveObjectLocAndDir;
  	}else {
  		profileNamespace setVariable ["junkTruck2Loc", nil];
  		profileNamespace setVariable ["junkTruck2Dir", nil];
  	};
  	//get the party inventory's cargo and save it
  	profileNamespace setVariable ["partyInventoryItemContents", getItemCargo partyInventory];
  	profileNamespace setVariable ["partyInventoryMagazineContents", getMagazineCargo partyInventory];
  	profileNamespace setVariable ["partyInventoryBackpackContents", getBackpackCargo partyInventory];
  	profileNamespace setVariable ["partyInventoryWeaponContents", weaponsItemsCargo partyInventory];

  	_theRestOfTheItems = [];
  	_theRestOfTheCount = [];
  	_theRestOfTheGuns = [];

  	{
  		_currObject = _x select 1;
  		_currItemCargo = getItemCargo _currObject;
  		_theRestOfTheItems = _theRestOfTheItems + (_currItemCargo select 0);
  		_theRestOfTheCount = _theRestOfTheCount + (_currItemCargo select 1);
  		_currMagCargo = getMagazineCargo _currObject;
  		_theRestOfTheItems = _theRestOfTheItems + (_currMagCargo select 0);
  		_theRestOfTheCount = _theRestOfTheCount + (_currMagCargo select 1);
  		_theRestOfTheGuns append (weaponsItemsCargo _currObject);
  	} forEach everyContainer partyInventory;

  	_theRestOfIt = [];
  	_theRestOfIt pushback _theRestOfTheItems;
  	_theRestOfIt pushBack _theRestOfTheCount;

  	profileNamespace setVariable ["partyInventoryExtraItemContents", _theRestOfIt];
  	profileNamespace setVariable ["partyInventoryExtraWeaponContents", _theRestOfTheGuns];

  };

  // this code loads the game or sets up a new save
  if (isNil {profileNamespace getVariable "hyperboreaCampaignDate"}) then {
  	["CAMPAIGN DATA NOT FOUND\nSTARTING NEW GAME"] remoteExec ["hint",0,false];
  	// NEW GAME
  	//sets default start date and time
  	setDate [2283, 3, 11, 15, 0];
  	//makes a new save - writes something to all of the profile namespace variables
  	call updateCampaignData;
  	//sets the base as a discoverable spawn point
  	//_baseTrigger = createTrigger ["EmptyDetector", baseSpawnTent, true];
  	//_baseTrigger setTriggerArea [75,75,0,false];
  	//_baseTrigger setTriggerActivation ["ANYPLAYER","PRESENT",false];
  	//_baseTrigger setTriggerStatements ["this","call BaseFound;",""];
  } else {
  	//grabs saved date & time and sets the game's time
  	_savedDate = profileNamespace getVariable "hyperboreaCampaignDate";
  	setDate _savedDate;
  	//Read the tin: load the whole damn game
  	call loadTheWholeDamnGame;
  };

  //autosave the game every half hour
  [] spawn {
  	while {true} do {
  		sleep 1800;
  		call updateCampaignData;
  		["AUTOSAVE COMPLETE"] remoteExec ["shorterHint",0,false];
  	};
  };

  //manual save server-side code
  "startSaveGame" addPublicVariableEventHandler{
  	call updateCampaignData;
  	["MANUAL SAVE COMPLETE"] remoteExec ["hint",0,false];
  };

};
