initMission = {

    infilExfilArea = [125, floor random worldSize, 0];

    infilExfilMarker = createMarker ["infilExfil", infilExfilArea];
    infilExfilMarker setMarkerColor "colorBLUFOR";
    infilExfilMarker setMarkerType "hd_end";

    infilExfilMarkerBkgd = createMarker ["infilExfilBkgd", infilExfilArea];
    infilExfilMarkerBkgd setMarkerSize [65,65];
    infilExfilMarkerBkgd setMarkerShape "ELLIPSE";
    infilExfilMarkerBkgd setMarkerColor "colorBLUFOR";
    infilExfilMarkerBkgd setMarkerBrush "DiagGrid";
    infilExfilMarkerBkgd setMarkerType "Empty";

    //let players see eachother's TFAR radio signals -- https://crowdedlight.github.io/Crows-Electronic-Warfare/spectrum/tracking/tfar_tracking_scripting.html
    ["crowsEW_spectrum_toggleRadioTracking", [true]] call CBA_fnc_globalEventJIP;

    //
    //infilExfilFlagpole = "SC_Flag_AC" createVehicle (infilExfilArea);
    infilExfilFlagpole = "Flag_Burstkoke_inverted_F" createVehicle (infilExfilArea);

    //Jack Shack setup
    exfilJackShack = "Land_FieldToilet_F" createVehicle (infilExfilArea vectorAdd [-40,0,0]);
    exfilJackShack setDir 270;
    exfilJackShack setPos (infilExfilArea vectorAdd [-40,0,0]);
    exfilJackShack allowDamage false;
    //exfilJackShack enableSimulationGlobal false; can't be a respawn point if it does this?
    exfilJackShackTarp = "Tarp_01_Small_Black_F" createVehicle (infilExfilArea vectorAdd [-40,0,0]);
    exfilJackShackTarp setPos (infilExfilArea vectorAdd [-40.5,0,0.005]);

    //Loadout Boxen setup
    exfilLoadoutBoxen = "Land_WoodenCrate_01_stack_x5_F" createVehicle (infilExfilArea vectorAdd [-50,16,0]);
    exfilLoadoutBoxen allowDamage false;
    //exfilLoadoutBoxen enableSimulationGlobal false;
    exfilLoadoutBoxenTarp = "Tarp_01_Small_Black_F" createVehicle (infilExfilArea vectorAdd [-50,16,0]);
    exfilLoadoutBoxenTarp setPos (infilExfilArea vectorAdd [-50,16,0.005]);

    exfilTent = "Land_MedicalTent_01_NATO_generic_inner_F" createVehicle (infilExfilArea vectorAdd [-50,0,0]);
    exfilTent setDir 270;
    exfilTent setPos (infilExfilArea vectorAdd [-50,10,0]);
    exfilTent allowDamage false;
    exfilTarp = "Tarp_01_Large_Black_F" createVehicle (infilExfilArea vectorAdd [-50,0,0]);
    exfilTarp setDir 270;
    exfilTarp setPos (infilExfilArea vectorAdd [-50,10,0]);
    exfilLight = "Land_PortableLight_02_single_sand_F" createVehicle (infilExfilArea vectorAdd [-60,0,0]);
    exfilLight setDir 270;
    exfilLight setPos (infilExfilArea vectorAdd [-54,11,0]);

    exfilBorderN = "Land_Bunker_01_blocks_3_F" createVehicle (infilExfilArea vectorAdd [0,65,0]);
    exfilBorderN setDir 0;
    exfilBlinkyN = "RoadBarrier_small_F" createVehicle (infilExfilArea vectorAdd [0,63,0]);
    exfilBlinkyN setDir 0;
    exfilBlinkyN setPos (infilExfilArea vectorAdd [0,63,0]); //motherfucker why will you not stay consistently still!?
    exfilBorderS = "Land_Bunker_01_blocks_3_F" createVehicle (infilExfilArea vectorAdd [0,-65,0]);
    exfilBorderS setDir 180;
    exfilBlinkyS = "RoadBarrier_small_F" createVehicle (infilExfilArea vectorAdd [0,-63,0]);
    exfilBlinkyS setDir 180;
    exfilBorderE = "Land_Bunker_01_blocks_3_F" createVehicle (infilExfilArea vectorAdd [65,0,0]);
    exfilBorderE setDir 90;
    exfilBlinkyE = "RoadBarrier_small_F" createVehicle (infilExfilArea vectorAdd [63,0,0]);
    exfilBlinkyE setDir 90;
    exfilBorderW = "Land_Bunker_01_blocks_3_F" createVehicle (infilExfilArea vectorAdd [-65,0,0]); 
    exfilBorderW setDir 270;
    exfilBlinkyW = "RoadBarrier_small_F" createVehicle (infilExfilArea vectorAdd [-63,0,0]);
    exfilBlinkyW setDir 270;
    exfilBlinkyW setPos (infilExfilArea vectorAdd [-63,0,0]); //dunno why this is needed but okay.

    initRespawner = [west, exfilJackShack, "EXFIL"] call BIS_fnc_addRespawnPosition;

    setDate[2050,7,(floor random 25) + 1,floor random 25,0];

    publicVariable "exfilJackShack";
    publicVariable "exfilLoadoutBoxen";
    publicVariable "infilExfilFlagpole";

};


if (isServer) then {
    [] call initMission;
};

//we have other mods installed that take care of mass looting, so turn off the loot to box script kitten
scriptKittenLootToBoxEnabled = false;