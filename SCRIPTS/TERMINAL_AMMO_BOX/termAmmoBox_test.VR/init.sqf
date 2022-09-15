#include "terminalAmmoBoxen.sqf"

if (isServer) then {
    [testBoxen, "PRIMARY", 100, true] call initTerminalAmmoBox;
    [testBoxen2, "PRIMARY", 100, true] call initTerminalAmmoBox;
    [testBoxen3, "SECONDARY", 10, true] call initTerminalAmmoBox;
    [testBoxen4, "HANDGUN", 100, true] call initTerminalAmmoBox;
};
