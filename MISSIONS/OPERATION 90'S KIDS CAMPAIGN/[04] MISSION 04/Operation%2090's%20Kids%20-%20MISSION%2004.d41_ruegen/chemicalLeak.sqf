//This script uses chemical weapon's spawnMist function to semi-permanently contaminate an area and slowly spread that contamination for about 3-4 hours
//3 hours is 10800 seconds
//4 hours is 14400 seconds
//no more than 100 m radius in 3 hours, the AO 
//though it'd be fun to extend this script and do a howLongTheCloudSticksAround vs maximumRadius 
//[test] execVM "chemicalLeak.sqf";

//KNOWN BUGS: Inventory menu lags like crazy?
//caused by constant calling, it seems. Singular instance of spawnMist is fine.
//I wonder if it's a server thing? ACE medical menu is FINE, so it's not a weird UI thing.
//inventory ui talks to server?

params ["_leakyObject","_chemType"];

_radius = 5;
sleep 10;

while {_radius < 120} do {
	[_leakyObject, _radius, 2.5, _chemType, 5, 10] call CBRN_fnc_spawnMist;
	_radius = _radius + .02;
	sleep 1.5; //still causes inventory menu lag, though
};