#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "story.sqf"
#include "spacePirateShip.sqf"
//#include "carbonBetatronTreasureScanner.sqf"
#include "spaceTeamDirector.sqf"
#include "spaceTeamCustomActions.sqf"
enableSaving [false, false];

[jackShack] call makePirateArsenal;
[jackShack2] call makePirateArsenal;

intel01 addAction ["VENERATOR SCHEMATIC [TOP SECRET]", {
      _longString = "<t color='#22aa22' size='1'>This is a large schematic file that details a carrier-class starship. The schematic is annotated with weak points and other tactical information.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

intel02 addAction ["[REDACTED] SCHEMATIC [EXTRA TOP SECRET]", {
      _longString = "<t color='#22aa22' size='1'>This is a schematic file that details... something? It's extraordinarily complicated, but it seems to be some kind of weapon of mass destruction -- housed in and powered by a Venerator-class starship. Is this what's been glassing all those planets?</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

mapApocalypsizing = {
	_worldObjects = [];
	{
		if (not (toLower(str _x) find 'castle' > -1)) then {
			if (not (toLower(str _x) find 'wall_stone' > -1)) then {
				if (not (toLower(str _x) find 'ruin' > -1)) then {
					if (not (toLower(str _x) find 'wreck' > -1)) then {
						_worldObjects pushBack (getPos _x);
						hideObject _x;
					};
				};
			};
		};
	//} forEach nearestTerrainObjects [theActualShip,["BUILDING","HOUSE","FENCE","WALL", "VIEW-TOWER","HIDE","FOUNTAIN"],worldSize*2,false];
  } forEach nearestTerrainObjects [theActualShip,
      ["BUILDING",
      "HOUSE",
      "CHURCH",
      "CHAPEL",
      "CROSS",
      "BUNKER",
      "FORTRESS",
      "FOUNTAIN",
      "VIEW-TOWER",
      "LIGHTHOUSE",
      "QUAY",
      "FUELSTATION",
      "HOSPITAL",
      "FENCE",
      "WALL",
      "HIDE",
      "BUSSTOP",
      "ROAD",
      "TRANSMITTER",
      "STACK",
      "TOURISM",
      "WATERTOWER",
      "TRACK",
      "MAIN ROAD",
      "ROCK",
      "ROCKS",
      "POWER LINES",
      "RAILWAY",
      "POWERSOLAR",
      "POWERWAVE",
      "POWERWIND",
      "SHIPWRECK",
      "TRAIL"
    ],worldSize*2,true];
	_worldObjects
};

//ENEMY CODE AND AI?

OPFORMedievalUniforms = [
  "HL_UNI_2",
  "DKoK_Gren_Uniform_1490th",
  "1715_slops_3_browngreenbrown",
  "1715_slops_3_browngreenwhite2",
  "1715_justa_3a_a_green"
];

medievalMeleeWeapons = [
  "WBK_SmallSword",
  "WBK_Spear",
  "WBK_Halbert",
  "WBK_SmallWarHammer_Hammer",
  "WBK_FeudalMaul"
];

medievalRangedWeapons = [
  "1715_LandPat",
  "1715_LandPatRifle",
  "1715_Seapat",
  "1715_Blunderbuss"
];

BLUFORMedievalUniforms = [
  "U_TIOW_Valhallan_brown_Blu",
  "U_TIOW_Valhallan_brown_Blu",
  "1715_slops_3_whitetanbrown",
  "1715_justa_3a_c_tan"
];

BLUFORHats = [
  "TIOW_Valhallan_Cap_brown_2",
  "1715_cockedhat_2_brown",
  "1715_headwrap_2_brown",
  "1715_cockedhat_3_brown",
  "IC_SL_HELMET_01"
];

equipMedievalBLUFOR = {
  params ["_dude"];
  removeAllWeapons _dude;
  removeGoggles _dude;
  removeHeadgear _dude;
  removeVest _dude;
  removeUniform _dude;
  removeAllAssignedItems _dude;
  clearAllItemsFromBackpack _dude;
  removeBackpack _dude;
  _dude forceAddUniform selectRandom BLUFORMedievalUniforms;
  _dude addHeadgear selectRandom BLUFORHats;
  _dude addBackpackGlobal "TIOW_VAlhallan_Bandolier";
  waitUntil {!isNull backpackContainer _dude};
  _dude addMagazines ["1715_cartridge_ball_69", 35];
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addWeapon (selectRandom medievalRangedWeapons);
};

equipMedievalOPFOR_ranged = {
  params ["_dude"];
  removeAllWeapons _dude;
  removeGoggles _dude;
  removeHeadgear _dude;
  removeVest _dude;
  removeUniform _dude;
  removeAllAssignedItems _dude;
  clearAllItemsFromBackpack _dude;
  removeBackpack _dude;
  _dude forceAddUniform selectRandom OPFORMedievalUniforms;
  _dude addHeadgear "Dos_Kettle_Helm_1";
  _dude addBackpackGlobal "TIOW_CadBackpack";
  waitUntil {!isNull backpackContainer _dude};
  clearAllItemsFromBackpack _dude;
  _dude addMagazines ["1715_cartridge_ball_69", 50];
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "1715_grenado";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addItemToBackpack "ACE_fieldDressing";
  _dude addWeapon (selectRandom medievalRangedWeapons);
};

equipMedievalOPFOR_melee = {
  params ["_dude"];
  removeAllWeapons _dude;
  removeGoggles _dude;
  removeHeadgear _dude;
  removeVest _dude;
  removeUniform _dude;
  removeAllAssignedItems _dude;
  clearAllItemsFromBackpack _dude;
  removeBackpack _dude;
  _dude forceAddUniform "HL_Uni_1";
  _dude addVest "Vest_HL_1";
  _dude addHeadgear "HT_Sallet_Helm_2";
  _dude addWeapon (selectRandom medievalMeleeWeapons);
};

BLUFORGROUPGENERIC = [
  "I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F"
];

OPFORGROUPGENERIC = [
  "O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_F"
];

OPFORGROUPMELEE = [
  "O_soldier_Melee","O_soldier_Melee","O_soldier_Melee","O_soldier_Melee"
];

spawnBLUFORGroup = {
  params ["_object"];
  _eventPos = getPos _object;
	_returnGroup = [_eventPos, INDEPENDENT, BLUFORGROUPGENERIC] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
  {
    [_x] call equipMedievalBLUFOR;
  } forEach units _returnGroup;
  sleep 0.5;
  _returnGroup setFormation "LINE";
};

spawnOPFORGroup = {
  params ["_object"];
  _eventPos = getPos _object;
	_returnGroup = [_eventPos, EAST, OPFORGROUPGENERIC] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
  {
    [_x] call equipMedievalOPFOR_ranged;
  } forEach units _returnGroup;
  sleep 0.5;
  _returnGroup setFormation "LINE";
};

spawnOPFORGroupStationary = {
  params ["_object"];
  _eventPos = getPos _object;
	_returnGroup = [_eventPos, EAST, OPFORGROUPGENERIC] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
  {
    [_x] call equipMedievalOPFOR_ranged;
    _x disableAI "PATH";
  } forEach units _returnGroup;
  sleep 0.5;
  _returnGroup setFormation "LINE";
};

spawnOPFORGroupMelee = {
  params ["_object"];
  _eventPos = getPos _object;
	_returnGroup = [_eventPos, EAST, OPFORGROUPMELEE] call BIS_fnc_spawnGroup;
	_returnGroup deleteGroupWhenEmpty true;
  sleep 0.5;
  {
    [_x] call equipMedievalOPFOR_melee;
  } forEach units _returnGroup;
  sleep 0.5;
  _returnGroup setFormation "LINE";
};

/* 9.5 code -- buildings and making shit D Y N A M I C */

fillBuildingMedieval = {
  params ["_building"];
  _positionArray = _building buildingPos -1;
  if (count _positionArray > 1) then {
    _buildingGroup = [[-1000,-1000,0], EAST, ["O_G_Soldier_F"]] call BIS_fnc_spawnGroup;
    _buildingGroup deleteGroupWhenEmpty true;
    for "_i" from 1 to ((count _positionArray) - 1) do {
        _buildingGroup createUnit ["O_G_Soldier_F", [-1000,-1000,0], [], 0, "NONE"];
    };
    {
        _currSoldier = (units _buildingGroup) select _forEachIndex;
        _currSoldier setPosASL (AGLtoASL _x);
        [_currSoldier] call equipMedievalOPFOR_ranged;
        _currSoldier disableAI "PATH";
    } forEach _positionArray;
    {
      if (!(floor random 3 == 1)) then {
        deleteVehicle _x;
      };
    } forEach units _buildingGroup;

  };
};

if (isServer) then {

  _trigger01 = createTrigger ["EmptyDetector", getPos towery];
  _trigger01 setTriggerArea [375,375,0,false];
  _trigger01 setTriggerActivation ["WEST", "PRESENT", false];
  _trigger01 setTriggerStatements ["this", "{[_x] call fillBuildingMedieval;} forEach (nearestObjects [towery, ['BUILDING'], 200]);", ""];

  _trigger02 = createTrigger ["EmptyDetector", getPos towery2];
  _trigger02 setTriggerArea [485,485,0,false];
  _trigger02 setTriggerActivation ["WEST", "PRESENT", false];
  _trigger02 setTriggerStatements ["this",
  "
    {[_x] call fillBuildingMedieval;} forEach (nearestObjects [towery2, ['BUILDING'], 300]);
    {[_x] call fillBuildingMedieval;} forEach (nearestObjects [towery2, ['BUILDING'], 100]);
    [finalMeleeHelper] spawn spawnOPFORGroupMelee;
    [meleehelper2] spawn spawnOPFORGroupMelee;
    {_x spawn keepFiringAssholes;} forEach cannonArray;
  ", ""];
};

shipTeleporter addAction ["Teleport to Village", {
      player setPosATL (getPosATL groundTeleporter01);
},[],1.5,true,true,"","true",10,false,"",""];

groundTeleporter01 addAction ["Teleport to Waffle House", {
      player setPosATL (getPosATL shipTeleporter);
},[],1.5,true,true,"","true",10,false,"",""];

//FIRING CANNONS VIA SCRIPT

cannonArray = [
  [enemyCannon01, cannonGuy_1, getDir enemyCannon01],
  [enemyCannon02, cannonGuy_2, getDir enemyCannon02],
  [enemyCannon03, cannonGuy_3, getDir enemyCannon03],
  [enemyCannon04, cannonGuy_4, getDir enemyCannon04],
  [enemyCannon05, cannonGuy_5, getDir enemyCannon05],
  [enemyCannon06, cannonGuy_6, getDir enemyCannon06]
];

keepFiringAssholes = {
  params ["_cannon", "_asshole", "_defaultDir"];
  sleep random 2;
  while {!(_asshole getVariable ["ACE_isUnconscious" , false])} do {
    _poorSchmuck = selectRandom (call BIS_fnc_listPlayers);
    _newDir = _cannon getDir _poorSchmuck;
    if (_poorSchmuck inArea cannonFireZone) then {
      _offset = random 2 - 1;
      _cannon setDir (_newDir + _offset);
      //if (floor random 4 == 1) then {
      //  _cannon setDir _newDir;
      //};
    } else {
      _cannon setDir _defaultDir;
    };
    //_cannon setVectorUp [(((random 3)/10)*-1), 0, 1];
    _cannon setVectorUp [(-0.12 - ((random 2) / 10)), 0, 1];
    [_cannon, currentWeapon _cannon] call BIS_fnc_fire;
    sleep floor random 10;
    [_cannon, [currentWeapon _cannon, 1]] remoteExecCall ["setammo", _cannon];
    sleep floor random 10;
    sleep 15;
  };
};

//story shit~!

journo addAction ["He shouts: 'Hold your arms! I'm but a maven and hold no strong allegiance to court or King.'", {
      _longString = "<t color='#777777' size='1'>I have no quarrel in this fight and no arms to speak of. Prithee move on with the battle.</t>";
      [_longString] call storyText;
      [] call secondStoryBeat;
},[],5,true,true,"",'alive journo && !(journo getVariable ["ACE_isUnconscious", false]);',10,false,"",""];

journo addAction ["Lol, why are you wearing a polo?", {
      _longString = "<t color='#777777' size='1'>What do you mean by Lol?... Oh, shit, you're from off-planet. Aren't you?</t>";
      [_longString] call storyText;
},[],4,true,true,"",'alive journo && !(journo getVariable ["ACE_isUnconscious", false]);',10,false,"",""];

secondStoryBeat = {
  journo addAction ["Ask what he knows about the Empire", {
        _longString = "<t color='#777777' size='1'>Oh. You're from offworld. I didn't think anyone survived. I planned to live here the rest of my life. Can you even do anything about them? All of my offworld tech is stashed in a cache at 251034. Take it, you'd be doing me a favor.</t>";
        [_longString] call storyText;
        [] call thirdStoryBeat;
  },[],7,true,true,"",'alive journo && !(journo getVariable ["ACE_isUnconscious", false]);',10,false,"",""];

  journo addAction ["What's a maven?", {
        _longString = "<t color='#777777' size='1'>A cognoscente, a meister? Smart man go brrrr?</t>";
        [_longString] call storyText;
  },[],6,true,true,"",'alive journo && !(journo getVariable ["ACE_isUnconscious", false]);',10,false,"",""];
};

thirdStoryBeat = {
  journo addAction ["Ask what he knows about SENPAI", {
        _longString = "<t color='#777777' size='1'>What is there to even know? They fill your head with their rules and you follow them. I'm sure I've broken plenty of mandates over the years, but I never planned on leaving. I wonder if they can send me to a hell of their choosing for dying with a broken mandate.</t>";
        [_longString] call storyText;
  },[],8,true,true,"",'alive journo && !(journo getVariable ["ACE_isUnconscious", false]);',10,false,"",""];
};

backupRadio addAction ["<t color='#FF0000' size='1'>TEMPORAL ANOMALY DETECTED - SENPAI PSYCHIC FIELD ENGORGED</t>", {
      _longString = "<t color='#777777' size='1'>That doesn't sound good....</t>";
      [_longString] call storyText;
},[],6,true,true,"",'!alive journo;',10,false,"",""];

backupRadio addAction ["<t color='#FF0000' size='1'>ERROR - DETONATION CHARGE FAILURE - MANUAL DESTRUCTION REQUIRED - 251034</t>", {
      _longString = "<t color='#777777' size='1'>That still doesn't sound good....</t>";
      [_longString] call storyText;
},[],5,true,true,"",'!alive journo;',10,false,"",""];

journo addAction ["He looks important and dead...", {
      _longString = "<t color='#777777' size='1'>Hopefully this doesn't cause any strange time shenaningans.</t>";
      [_longString] call storyText;
},[],5,true,true,"",'!alive journo;',10,false,"",""];

journo addAction ["He looks important and hurt...", {
      _longString = "<t color='#777777' size='1'>You think to yourself: 'Maybe I should help this guy up, he doesn't look like an enemy combatant.'</t>";
      [_longString] call storyText;
},[],5,true,true,"",'journo getVariable ["ACE_isUnconscious", false];',10,false,"",""];

//KEEP ME LAST
[] spawn mapApocalypsizing;
