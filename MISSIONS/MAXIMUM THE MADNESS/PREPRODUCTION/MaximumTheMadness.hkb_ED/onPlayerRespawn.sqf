defaultLoadout = [[],[],[],["U_I_C_Soldier_Bandit_5_F",[]],[],[],"","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];

stripEm = {
    removeAllWeapons player;
    removeGoggles player;
    removeHeadgear player;
    removeVest player;
    removeUniform player;
    removeAllAssignedItems player;
    clearAllItemsFromBackpack player;
    removeBackpack player;

    player setUnitLoadout defaultLoadout;

    if (isNil {profileNamespace getVariable "TESTING_MAXIMUMTHEMADNESS_RESPAWNLOADOUT"}) then {
        //do nothing since there's no saved loadout
    } else {
        // head to toe: [helm, goggles, uniform, vest, backpack]
        private _unpackingLoadout = profileNamespace getVariable "TESTING_MAXIMUMTHEMADNESS_RESPAWNLOADOUT";
        player addHeadgear (_unpackingLoadout select 0);
        player addGoggles (_unpackingLoadout select 1);
        player forceAddUniform (_unpackingLoadout select 2);
        player addVest (_unpackingLoadout select 3);
        player addBackpack (_unpackingLoadout select 4);
    }; 
};

/*
Dark Souls-esque light source. Just a little thingy on the player.
*/

localDarkSoulsLight = nil; //delete the old one if it exists
//TODO?: This appears to not work, but it's nice to have your corpse a little lit up to find it easily at night, so bug is feature.

lightUpExfil = {
    //staticLightPoint = "#lightpoint" createVehicleLocal [0,0,0]; 
    //staticLightPoint attachTo [exfilFire, [0, 0, 0.5]]; 
    //staticLightPoint setLightColor [0,0,0]; 
    //staticLightPoint setLightAmbient [1,1,1]; 
    //staticLightPoint setLightIntensity 3;
    //staticLightPoint setLightAttenuation [100,0,4.31918e-005,0];

    localDarkSoulsLight = "#lightpoint" createVehicleLocal [0,0,0]; 
    localDarkSoulsLight attachTo [player, [0, 0, 1.5]]; 
    localDarkSoulsLight setLightColor [0,0,0]; 
    localDarkSoulsLight setLightAmbient [1, 0.8, 0.25]; 
    localDarkSoulsLight setLightBrightness 0.05;
};

[] call lightUpExfil;
[] call stripEm;