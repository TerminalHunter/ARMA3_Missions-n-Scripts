#include "arsenal.sqf"
#include "holidayLoot.sqf"
#include "twitchIntegration.sqf"
#include "beerCans.sqf"
#include "enemies.sqf"
#include "finale.sqf"
#include "stupidHolidayTricks.sqf"
#include "enemyAI.sqf"

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