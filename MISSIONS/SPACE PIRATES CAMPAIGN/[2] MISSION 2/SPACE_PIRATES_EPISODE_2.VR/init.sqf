#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "spaceTeamDirector.sqf"

enableSaving [false, false];

[jackShack] call makePirateArsenal;
[jackShack2] call makePirateArsenal;

//brig respawn position
// [4078.662,3632.705,435.804]
//ASL [4078.57,3632.1,440.805]
//ATL [4078.57,3632.1,435.805]

skeetSkeet addAction ["PULL - Launch Pigeon Probe",launchSkeetHigh,[],1.5,true,true,"","true",10,false,"",""];

if (isServer) then {
  _theFuckingTable = (getPosASL redAlertConsole) nearObjects ["OPTRE_holotable_sm", 10];
  deleteVehicle (_theFuckingTable select 0);
};
