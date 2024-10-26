#include "iamtired.sqf"
#include "arsenal.sqf"
#include "holidayLoot.sqf"
#include "twitchIntegration.sqf"
#include "beerCans.sqf"
#include "enemies.sqf"
#include "finale.sqf"
#include "stupidHolidayTricks.sqf"
#include "enemyAI.sqf"
#include "ambussies.sqf"

[arse01] call makeArsenal;
[arse02] call makeArsenal;
[arse03] call makeArsenal;
[arse04] call makeArsenal;
[arse05] call makeArsenal;

[beer01] call makeBoozeBox;
[beer02] call makeBoozeBox;

//make sure the face faces the right way on MECHA-RIAH SCARY
mariahLeft attachTo [mariah];
mariahRight attachTo [mariah];
maryTarget attachTo [mariah];
mariah attachTo [mecha];
[] spawn {
	sleep 5;
	mariah setDir ((getDir mecha) - 240);
	mariahLeft setDir ((getDir mecha) - 240);
	mariahRight setDir ((getDir mecha) - 240);
};

//start Twitch Integration and set in-game chat correctly
if(isServer) then {
	[] spawn {
		sleep 15;
		chat setGroupId ["NORAD Command"]; // changes the group's callsign
		chat sideChat "NORAD Command, radio check and standing by!";
		[] spawn startTwitchIntegration;
	};
};

//BOSS HEALTH SYSTEM
if (isServer) then {
	[] spawn {
		while {sleep 3; mariahHP > 0} do {
			{
				//hint str(_x distance mariah);
				//testData pushBack (_x distance mariah);
				if (_x distance mariah < 22) then {
					mariahHP = mariahHP - 1;
					publicVariable "mariahHP";
					//hint str(mariahHP);
				};
			} forEach allMissionObjects "#explosion";
		};
		if (mariahHP <= 0) then {
			_scriptedCharge1 = createVehicle ["DemoCharge_Remote_Ammo_Scripted", getPos mariahLeft, [], 0, "CAN_COLLIDE"];
			_scriptedCharge1 setDamage 1;
			[mariahLeft, nil, true] call BIS_fnc_moduleLightning;
			_scriptedCharge2 = createVehicle ["DemoCharge_Remote_Ammo_Scripted", getPos mariahRight, [], 0, "CAN_COLLIDE"];
			_scriptedCharge2 setDamage 1;
			[mariahRight, nil, true] call BIS_fnc_moduleLightning;
			_scriptedCharge3 = createVehicle ["DemoCharge_Remote_Ammo_Scripted", getPos mariah, [], 0, "CAN_COLLIDE"];
			_scriptedCharge3 setDamage 1;
			[mariah, nil, true] call BIS_fnc_moduleLightning;
			_lookForMariah = nearestObjects [mecha, ["Man","Car"], 20];
			maryArray = [];
			{if(alive _x && side _x == civilian) then {maryArray pushBack _x;}}forEach _lookForMariah;
			_mechaScaryMan = mary select 0;
			for "_i" from 0 to 10 do {
				_scriptedCharge1 = createVehicle ["DemoCharge_Remote_Ammo_Scripted", getPos _mechaScaryMan, [], 10, "CAN_COLLIDE"];
				_scriptedCharge1 setDamage 1;
			};
			[_mechaScaryMan, nil, true] call BIS_fnc_moduleLightning;
			_mechaScaryMan setDamage 1;
		};
	}; 
};