// TODO
// kick crate of tea into the harbor ?

#include "shoreCannonAI.sqf"

saveTEMPLoadout = {

  //sets client-side variables saved to profile instead of mission namespace
  //should persist between missions
  profileNamespace setVariable["TEMPVAR_savedLoadout",getUnitLoadout player];

  //keep the mission namespace variables just in case?
  player setVariable["TEMPVAR_savedLoadout_local",getUnitLoadout player];

  hintSilent "Respawn Loadout Saved!";
  sleep 3;
  hintSilent "";

};

//init the spawn stuff
arse addAction  ["SAVE RESPAWN LOADOUT!",
  {[] call saveTEMPLoadout},
  [],1.5,true,true,"","true",10,false,"",""];

arse addAction  ["Take Default Bullet-Heavy Loadout",
  {player setUnitLoadout [["1715_Seapat","","","",["1715_cartridge_ball_69",1],[],""],[],["1715_HeavyDragoon","","","",["1715_cartridge_ball_62",1],[],""],["1715_justa_3a_b_brown",[["1715_cartridge_ball_62",5,1]]],["1715_vest_engblk_soldier",[["FirstAidKit",3],["1715_bayonet_plug_eng",1],["1715_cartridge_ball_62",1,1],["1715_cartridge_ball_69",12,1]]],["1715_haversack_black",[["1715_cartridge_ball_69",26,1],["1715_grenado",2,1]]],"Guer_Beret_02_EL","",["1715_spyglass","","","",[],[],""],["ItemMap","","","ItemCompass","",""]]},
  [],1.5,true,true,"","true",10,false,"",""];

arse addAction  ["Take Default Grenade-Heavy Loadout",
  {player setUnitLoadout [["1715_Seapat","","","",["1715_cartridge_ball_69",0],[],""],[],[],["1715_justa_3a_b_brown",[["FirstAidKit",1],["1715_cartridge_ball_69",1,1]]],["1715_vest_engblk_soldier",[["1715_bayonet_plug_eng",1],["FirstAidKit",1],["1715_grenado",3,1],["1715_cartridge_ball_69",1,1]]],["1715_haversack_black",[["1715_grenado",4,1],["1715_cartridge_ball_69",14,1]]],"Guer_Beret_02_EL","",["1715_spyglass","","","",[],[],""],["ItemMap","","","ItemCompass","",""]]},
  [],1.5,true,true,"","true",10,false,"",""];

arse addAction  ["Take Default Medical-Heavy Loadout",
  {player setUnitLoadout [["1715_Seapat","","","",["1715_cartridge_ball_69",1],[],""],[],["1715_HeavyDragoon","","","",["1715_cartridge_ball_62",1],[],""],["1715_justa_3a_b_brown",[["1715_cartridge_ball_62",5,1]]],["1715_vest_engblk_soldier",[["FirstAidKit",6],["1715_bayonet_plug_eng",1],["1715_cartridge_ball_62",1,1]]],["1715_haversack_black",[["1715_cartridge_ball_69",26,1],["1715_grenado",2,1]]],"Guer_Beret_02_EL","",["1715_spyglass","","","",[],[],""],["ItemMap","","","ItemCompass","",""]]},
  [],1.5,true,true,"","true",10,false,"",""];

teleporter addAction ["Teleport to the Sloop Adventure",
  {player setPosASL ((getPosASL sloop1) vectorAdd [0,0,6])},
  [],1.5,true,true,"","true",10,false,"",""];

teleporter addAction ["Teleport to the Sloop Albas",
  {player setPosASL ((getPosASL sloop2) vectorAdd [0,0,6])},
  [],1.5,true,true,"","true",10,false,"",""];

teleporter addAction ["Teleport to the Sloop Antelope",
  {player setPosASL ((getPosASL sloop3) vectorAdd [0,0,6])},
  [],1.5,true,true,"","true",10,false,"",""];

adventureBox attachTo [sloop1];
albasBox attachTo [sloop2];
antelopeBox attachTo [sloop3];

//teleporter addAction ["Teleport to the Frigate Whydah (that we probably wont use)",
//  {player setPosASL ((getPosASL frigate1) vectorAdd [0,0,6])},
//  [],1.5,true,true,"","true",10,false,"",""];

listTeaCrates = [];
lastPlayerDir = 0;

kickInDirection = {
  params ["_dirObject", "_kickObject"];
  private _direction = getDir _dirObject;
  _kickObject setVelocity [(sin _direction) * 12, (cos _direction) * 12, 10];
};

makeTeaCrate = {
  params ["_crate"];
  _crate addAction ["A Crate of Tea?",{},[],1.5,true,true,"","true",10,false,"",""];
  _crate addAction ["Kick towards the Ocean",{[(_this select 0),[0, 12, 10]] remoteExec ["setVelocity", _this select 0];},[],1.5,true,true,"","true",10,false,"",""];
  //[(_this select 0),[0, 12, 10]] remoteExec ["setVelocity", _this select 0];
  _crate addAction ["Kick direction I'm facing", {
    //[(this select 0), [(sin  getDir (_this select 1) * 12),(cos  getDir (_this select 1) * 12),10]] remoteExec ["setVelocity", _this select 0];
    [_this select 1, _this select 0] remoteExec ["kickInDirection", _this select 0];
    },[],1.5,true,true,"","true",10,false,"",""];
  //[(this select 0), [(sin (getDir (_this select 1)) * 12),(cos (getDir (_this select 1)) * 12),(10)]] remoteExec ["setVelocity", (_this select 0)];
  listTeaCrates pushBack _crate;
};

[teaCrate1] call makeTeaCrate;
[teaCrate2] call makeTeaCrate;
[teaCrate3] call makeTeaCrate;

if (isServer) then {
  [] spawn {
    while {!([] isEqualTo listTeaCrates)} do {
      sleep 15;
      {
        if (surfaceIsWater getPos _x) then {
          listTeaCrates deleteAt _forEachIndex;
          _x setVectorUp [0,0,1];
          nul = [_x, 900] execvm "ALfireworks\alias_fireworks.sqf";
        };
      } forEach listTeaCrates;
    };
  };
};

//get rid of (hopefully) all the modern stuff
mapApocalypsizing = {
	_worldObjects = [];
	{
		if (not (toLower(str _x) find 'castle' > -1)) then {
			if (not (toLower(str _x) find 'stone' > -1)) then {
				if (not (toLower(str _x) find 'ruin' > -1)) then {
					if (not (toLower(str _x) find 'rock' > -1)) then {
						_worldObjects pushBack (getPos _x);
						hideObject _x;
					};
				};
			};
		};
	//} forEach nearestTerrainObjects [theActualShip,["BUILDING","HOUSE","FENCE","WALL", "VIEW-TOWER","HIDE","FOUNTAIN"],worldSize*2,false];
  } forEach nearestTerrainObjects [arse,
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
    ],worldSize,true];
	//_worldObjects
};

[] spawn mapApocalypsizing;


/*

Grenade-Heavy
[["1715_Seapat","","","",["1715_cartridge_ball_69",0],[],""],[],[],["1715_justa_3a_b_brown",[["FirstAidKit",1],["1715_cartridge_ball_69",1,1]]],["1715_vest_engblk_soldier",[["1715_bayonet_plug_eng",1],["FirstAidKit",1],["1715_grenado",3,1],["1715_cartridge_ball_69",1,1]]],["1715_haversack_black",[["1715_grenado",4,1],["1715_cartridge_ball_69",14,1]]],"Guer_Beret_02_EL","",["1715_spyglass","","","",[],[],""],["ItemMap","","","ItemCompass","",""]]

Medpack-Heavy
[["1715_Seapat","","","",["1715_cartridge_ball_69",1],[],""],[],["1715_HeavyDragoon","","","",["1715_cartridge_ball_62",1],[],""],["1715_justa_3a_b_brown",[["1715_cartridge_ball_62",5,1]]],["1715_vest_engblk_soldier",[["FirstAidKit",6],["1715_bayonet_plug_eng",1],["1715_cartridge_ball_62",1,1]]],["1715_haversack_black",[["1715_cartridge_ball_69",26,1],["1715_grenado",2,1]]],"Guer_Beret_02_EL","",["1715_spyglass","","","",[],[],""],["ItemMap","","","ItemCompass","",""]]

Bullet-Heavy
[["1715_Seapat","","","",["1715_cartridge_ball_69",1],[],""],[],["1715_HeavyDragoon","","","",["1715_cartridge_ball_62",1],[],""],["1715_justa_3a_b_brown",[["1715_cartridge_ball_62",5,1]]],["1715_vest_engblk_soldier",[["FirstAidKit",3],["1715_bayonet_plug_eng",1],["1715_cartridge_ball_62",1,1],["1715_cartridge_ball_69",12,1]]],["1715_haversack_black",[["1715_cartridge_ball_69",26,1],["1715_grenado",2,1]]],"Guer_Beret_02_EL","",["1715_spyglass","","","",[],[],""],["ItemMap","","","ItemCompass","",""]]

*/
