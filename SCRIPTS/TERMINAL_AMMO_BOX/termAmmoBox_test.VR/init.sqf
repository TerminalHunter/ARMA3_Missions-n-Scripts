#include "terminalAmmoBoxen.sqf"

/*

[currentWeapon player] call BIS_fnc_compatibleMagazines

 ["30rnd_65x39_caseless_mag","30rnd_65x39_caseless_khaki_mag","30rnd_65x39_caseless_black_mag","30rnd_65x39_caseless_mag_tracer","30rnd_65x39_caseless_khaki_mag_tracer","30rnd_65x39_caseless_black_mag_tracer","100rnd_65x39_caseless_mag","100rnd_65x39_caseless_khaki_mag","100rnd_65x39_caseless_black_mag","100rnd_65x39_caseless_mag_tracer","100rnd_65x39_caseless_khaki_mag_tracer","100rnd_65x39_caseless_black_mag_tracer"]

configfile >> "CfgMagazines" >> "30Rnd_45ACP_Mag_SMG_01" >> displayName

getText(configfile >> "CfgMagazines" >> "30Rnd_45ACP_Mag_SMG_01" >> "displayName")

We're going to go with Primary, Secondary, Sidearm for now.

*/

if (isServer) then {
    [testBoxen] call initTerminalPrimaryAmmoBox;
    [testBoxen2] call initTerminalPrimaryAmmoBox;
};
