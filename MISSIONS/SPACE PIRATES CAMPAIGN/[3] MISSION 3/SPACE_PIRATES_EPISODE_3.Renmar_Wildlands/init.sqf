#include "dumbShit.sqf"
#include "pirateArsenal.sqf"
#include "autodoc.sqf"
#include "glowstickEat.sqf"
#include "story.sqf"
//#include "spaceTeamDirector.sqf"

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

/*
Known for it's suspiciously flat mesas that are perfect to park space ships on
*/

storyBitTwo addAction ["RE: PACKAGE", {
      _longString = "<t color='#22aa22' size='1'>THE SAMPLE OF X IS IN THE DEADDROP AT THE ACHILLES TENDON</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

storyBitOne addAction ["ORDERS: STANDARD CK-CODEX #447", {
      _longString = "<t color='#22aa22' size='1'>PLANET OVERRUN BY LAWLESS FORCES - ORDERS TO RESTORE LAWFUL ORDER THROUGH PURGE<br/><br/>Tactical Notes: Local grid clear. Prisoner Escort Ship has arrived. Codex matches hull to known private courier enterprise skilled in prisoner transport. High Command has not authorized the capture of prisoners. Muster to investigate post-haste. Purge any possible data leakage.<br/><br/>FORCE LOCALIZER: Mining Site 19 - Outpost Site ZETA - Residential Site ARQIETIS - Tech Site OLD</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

respawnerLocation = getPosASL spareFighter;

vehicleSpawner addAction ["Replicate Atmospheric Vehicle - DANGER CLEAR FLIGHT DECK", {
  _newVic = "OPTRE_UNSC_falcon" createVehicle [-1000,-1000,0];
  _newVic setDir 180;
  _newVic setObjectTextureGlobal [0,"OPTRE_Vehicles\Falcon\data\falcon_hull_night_CO.paa"];
  _newVic setObjectTextureGlobal [1,"optre_vehicles\falcon\data\falcon_hullextra_night_co.paa"];
  _newVic setObjectTextureGlobal [2,"optre_vehicles\falcon\data\falcon_wingtips_night_co.paa"];
  //_newVic setObjectTextureGlobal [3,"optre_vehicles\falcon\data\falcon_skid_night_co.pa"];
  _newVic setPosASL respawnerLocation;
},[],1.5,true,true,"","true",10,false,"",""];

if (isServer) then {
  weedBox1 addItemCargoGlobal ["murshun_cigs_cigpack", 120];
};

storyBitThree addAction ["INTELLIGENCE DOSSIER: ARQUIETIS", {
      _longString = "<t color='#22aa22' size='1'>Confiscated supplies seem to indicate sortie to [REDACTED ENEMY PROPAGANDA: NAME OF ENEMY STRONGHOLD]. Purpose: Unknown. Hypothesized to be combination of larceny and trade. Actionable intel has been forwarded to Department 3. [Coordinate File Attached - DANGER:BLACKOPS] Subjects Terminated. Data Leakage Threat: Low.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

storyBitFour addAction ["INTELLIGENCE DOSSIER: ZETA", {
      _longString = "<t color='#22aa22' size='1'>Confiscated supplies are a variety of star charts with no apparent purpose. All depicted areas are inaccurate as they differ from Official charts and are of no use to Imperial Logistics. [Coordinate File Attached - DANGER:GREEN] Subjects Terminated. Data Leakage Threat: Low.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

storyBitFive addAction ["INTELLIGENCE DOSSIER: MINING SITE 19", {
      _longString = "<t color='#22aa22' size='1'>Confiscated supplies include cleanroom materials and vehicle parts. High-performance military-grade parts found amongst standard-grade mining equipment. Subjects <t color ='#aa2222' size='1'>ESCAPED</t>. Data Leakage Threat: <t color ='#aa2222' size='1'>INTOLERABLE</t>. <br/>[Coordinate File Attached: PURSUIT VECTOR IMMEDIATE]</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

/*
Maps:

Kholo - War torn map we're absolutely going to

Halgar - Winter map we're more than likely going to

ONE LAST HEIST:
Fake boarding thing 40k inspired
Fake the landing craft - put a screen in there that shows an off-map thing crashing into

Data Leakage Threat: Guaranteed. PURSUIT ENGAGED.
*/
