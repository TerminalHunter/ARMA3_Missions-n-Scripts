/*

SAVE SYSTEM TODO:
    MUST BE IN THE EXFIL AREA!
        All Players current inventories
        Vehicles
            gas
            ammo count

            
I guess also save arbitrary items? Let the players take things home.
Nothing mission-related should spawn within 1km of the western edge of the map.
ARSENAL but it only gives uniform/vest/backpack. Arsenal also draws a big ol circle to show what gets saved.
Gas siphons?

HIDDEN CACHES TODO:

SCRAPPING MECHANIC:


*/

#include "saveSystem.sqf"

initMission = {

    infilExfilArea = [0, floor random worldSize, 0];

    infilExfilMarker = createMarker ["infilExfil", infilExfilArea];
    infilExfilMarker setMarkerColor "colorBLUFOR";
    infilExfilMarker setMarkerType "hd_end";

    infilExfilMarkerBkgd = createMarker ["infilExfilBkgd", infilExfilArea];
    infilExfilMarkerBkgd setMarkerSize [60,60];
    infilExfilMarkerBkgd setMarkerShape "ELLIPSE";
    infilExfilMarkerBkgd setMarkerColor "colorBLUFOR";
    infilExfilMarkerBkgd setMarkerBrush "DiagGrid";
    infilExfilMarkerBkgd setMarkerType "Empty";

    //let players see eachother's TFAR radio signals -- https://crowdedlight.github.io/Crows-Electronic-Warfare/spectrum/tracking/tfar_tracking_scripting.html
    ["crowsEW_spectrum_toggleRadioTracking", [true]] call CBA_fnc_globalEventJIP;

    //Jack Shack setup
    exfilJackShack = "Land_FieldToilet_F" createVehicle (infilExfilArea vectorAdd [-40,0,0]);
    exfilJackShack setDir 270;

    exfilTent = "Land_MedicalTent_01_NATO_generic_inner_F" createVehicle (infilExfilArea vectorAdd [-50,0,0]);
    exfilTent setDir 270;
    exfilTent setPos (infilExfilArea vectorAdd [-50,10,0]);
    exfilTarp = "Tarp_01_Large_Black_F" createVehicle (infilExfilArea vectorAdd [-50,0,0]);
    exfilTarp setDir 270;
    exfilTarp setPos (infilExfilArea vectorAdd [-50,10,0]);
    exfilFire = "Land_PortableLight_02_single_sand_F" createVehicle (infilExfilArea vectorAdd [-60,0,0]);
    exfilFire setDir 270;
    exfilFire setPos (infilExfilArea vectorAdd [-54,11,0]);

    initRespawner = [west, exfilJackShack, "EXFIL"] call BIS_fnc_addRespawnPosition;

    remoteExec ["lightUpExfil", 0, true];

    setDate[2050,7,21,floor random 25,0];

};

lightUpExfil = {
    staticLightPoint = "#lightpoint" createVehicleLocal [0,0,0]; 
    staticLightPoint attachTo [exfilFire, [0, 0, 0.5]]; 
    staticLightPoint setLightColor [0,0,0]; 
    staticLightPoint setLightAmbient [1,1,1]; 
    staticLightPoint setLightIntensity 6;
    staticLightPoint setLightAttenuation [100,0,4.31918e-005,0];
};

if (isServer) then {
    [] call initMission;
};