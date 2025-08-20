TOV_fnc_SimpleConvoy = { 
    params ["_convoyGroup",["_convoySpeed",10],["_convoySeparation",15],["_pushThrough", false]];
    if (_pushThrough) then {
        _convoyGroup enableAttack !(_pushThrough);
        {(vehicle _x) setUnloadInCombat [false, false];} forEach (units _convoyGroup);
    };
    _convoyGroup setFormation "COLUMN";
    {
        (vehicle _x) limitSpeed _convoySpeed*1.15;
        (vehicle _x) setConvoySeparation _convoySeparation;
    } forEach (units _convoyGroup);
    (vehicle leader _convoyGroup) limitSpeed _convoySpeed;
    while {sleep 5; !isNull _convoyGroup} do {
        {
            if ((speed vehicle _x < 5) && (_pushThrough || (behaviour _x != "COMBAT"))) then {
                (vehicle _x) doFollow (leader _convoyGroup);
            };    
        } forEach (units _convoyGroup)-(crew (vehicle (leader _convoyGroup)))-allPlayers;
        {(vehicle _x) setConvoySeparation _convoySeparation;} forEach (units _convoyGroup);
    }; 
};

setupSimpleConvoy = {
    params["_convoyGroup"];
    _convoyGroup setFormation "COLUMN";
    {
        (vehicle _x) setUnloadInCombat [false, false];
        (vehicle _x) limitSpeed 30;
        (vehicle _x) setConvoySeparation 20;
    } forEach (units _convoyGroup);

    (vehicle leader _convoyGroup) limitSpeed 40;
};

//pick a spot off map. NOPE, THAT BREAKS PATHFINDING, ITS NOW JUST INSIDE THE MAP
pickSpotOffMap = {
    private _returnSpot = [0,0,0];

    switch (floor (random 3)) do {
        case 0: { //NORTH BORDER
            _returnSpot = [((worldSize/2) + random(worldSize/2)),worldSize - 100,0];
        };
        case 1: { //SOUTH BORDER
            _returnSpot = [((worldSize/2) + random(worldSize/2)),+100,0];
        };
        case 2: { //EAST BORDER
            _returnSpot = [worldSize - 100, random(worldSize), 0];
        };
        default {["Holy shit how did you break this? Tell terminal the thing in convoy.sqf has broken completely and utterly."] remoteExec ["hint"]};
    };

    _returnSpot
};

//grab a few more spots on the map to travel to
pickConvoyDestinationPosition = {
    private _returnSpot = [random(worldSize),random(worldSize),0];
    if ((_returnSpot select 0) < 3000) then {
        _returnSpot = [] call pickConvoyDestinationPosition;
    };
    _returnSpot
};

testVehicles = [
    "I_C_Offroad_02_LMG_F"
];

testUnits = [
    "O_Soldier_F"
];

insertAt = {
    params["_array","_index","_value"];
    for "_i" from count _array to _index step -1 do {
        _array set [_i, (_array select (_i - 1))];
    };
    _array set [_index, _value];
};

createTestConvoyWhyTheFuckIsThisOneHere = {
    params ["_location"];
    private _newGroup = createGroup [east, true];

    for "_i" from 1 to ((floor (random 10)) + 2) do {
        private _newVic = createVehicle [selectRandom testVehicles, _location vectorAdd [0, _i * -10, 0]];
        _newGroup addVehicle _newVic;
        private _crewCount = [typeOf _newVic, true] call BIS_fnc_crewCount;
        for "_j" from 1 to _crewCount do {
            (selectRandom testUnits) createUnit [_location, _newGroup];
        };
    };
    _newGroup

};

enemyVics = [];

createTestConvoy = { //jesus fuck we aint making the test anymore, rename this to something normal eventually
    params ["_location", "_faction"];
    private _newGroups = [];

    for "_i" from 1 to ((floor (random 6)) + 6) do {
        private _newGroup = createGroup [east, true];
        private _newVic = createVehicle [selectRandom (_faction select 1), _location vectorAdd [0, _i * -25, 0]];

        _newGroup addVehicle _newVic;
        clearItemCargoGlobal _newVic;
        clearMagazineCargoGlobal _newVic;
        clearWeaponCargoGlobal _newVic;
        clearBackpackCargoGlobal _newVic;
        private _crewCount = [typeOf _newVic, true] call BIS_fnc_crewCount; //sometimes this returns a wrong value
        for "_j" from 1 to _crewCount do {
            private _freshFuckMan = "O_G_Survivor_F" createUnit [_location, _newGroup];
        };
        enemyVics pushBack _newVic;
        _newGroups pushBack _newGroup;
    };
    _newGroups

};

/*
createSingleVehicle = {
    params ["_location"];
    private _newGroup = createGroup [east, true];
    private _newVic = createVehicle ["I_C_Offroad_02_LMG_F", _location];
    _newGroup addVehicle _newVic;
    private _crewCount = [typeOf _newVic, true] call BIS_fnc_crewCount;
    for "_j" from 1 to _crewCount do {
        "O_Soldier_F" createUnit [_location, _newGroup];
    };
    _newGroup
};
*/

giveConvoyOrders = {
    params ["_convoyGroup", "_startingPos", "_destinationsArray", "_stops"];
    //get in your vehicles
    //private _okayGoNow = _convoyGroup addWaypoint [(_startingPos vectorAdd [0, 50, 0]), 0, 1];
    //_okayGoNow setWaypointType "GETIN";
    //_okayGoNow setWaypointCompletionRadius 1500;
    //_okayGoNow setWaypointTimeout [68,69,70];

    _convoyGroup setCombatBehaviour "COMBAT";
    [_convoyGroup] call setupSimpleConvoy;

    for "_i" from 1 to ((count _destinationsArray) - 1) do {
        private _nextPos = _destinationsArray select _i;
        private _nextWaypoint = _convoyGroup addWaypoint [_nextPos, 100];
        _nextWaypoint setWaypointCompletionRadius 20;
        _nextWaypoint setWaypointType "MOVE";
        if (_nextPos in _stops) then {
            private _randWait = (floor (random 200)) + 50;
            _nextWaypoint setWaypointTimeout [_randWait,_randWait,_randWait];
            //TODO: any way to get vehicles to wait and all leave at the same time?
        };
    };

    //private _okayButSeriouslyGoNow = _convoyGroup addWaypoint [(_startingPos vectorAdd [0, 150, 0]), 0, 2];
    //_okayButSeriouslyGoNow setWaypointType "MOVE";
    //_okayButSeriouslyGoNow setWaypointCompletionRadius 50;

    private _fuckOffIntoTheSunset = _convoyGroup addWaypoint [_startingPos vectorAdd [worldSize-1000,0,0], 1000];
    _fuckOffIntoTheSunset setWaypointType "MOVE";
    _fuckOffIntoTheSunset setWaypointCompletionRadius 50;
};

    simpleMidPoint = {
        params["_pointA", "_pointB"];
        private _newPoint = [
            ((_pointA select 0) + (_pointB select 0)) / 2,
            ((_pointA select 1) + (_pointB select 1)) / 2,
            0
        ];
        _newPoint
    };

    addAllTheMidpoints = {
        params["_destinations"];
        private _repeat = false;
        for "_i" from 0 to (count _destinations) -2 do {
            private _pointA = _destinations select _i;
            private _pointB = _destinations select (_i + 1);
            if (_pointA distance _pointB > 800) then { //1500 too much?
                private _newPoint = [_pointA, _pointB] call simpleMidPoint;
                [_destinations, _i+1, _newPoint] call insertAt;
                _repeat = true;
            };
        };
        if (_repeat) then  {
            [_destinations] call addAllTheMidpoints;
        };
    };

createTheWholeDamnConvoy = {
    params ["_debug"];

    //STEP 1 - INIT
    private _startingPosition = [] call pickSpotOffMap;
    private _faction = selectRandom madnessFactions;
    private _convoyDestinations = [];

    //STEP 2 - BUILD ITENERARY
    _convoyDestinations pushBack _startingPosition;
    for "_i" from 1 to ((floor (random 2)) + 3) do {
        _convoyDestinations pushBack ([] call pickConvoyDestinationPosition);
    };
    _sortedConvoyDestinations = [_convoyDestinations, [], {_startingPosition distance _x}, "ASCEND"] call BIS_fnc_sortBy;
    _sortedConvoyDestinations pushBack (_startingPosition vectorAdd [worldSize-1000,0,0]); //fuckOffIntoSunset

    //STEP 3 - shit fucks up if points are too far away. fix by adding midpoints until it works.
    [_sortedConvoyDestinations] call addAllTheMidpoints;

    if (_debug) then {
        [_sortedConvoyDestinations] call debugPointDraw;
    };

    //STEP 4 -- MAKE THE CONVOY, GIVE IT ORDERS
    //TODO: use real values and not testing values
    private _convoyGroups = [_startingPosition, _faction] call createTestConvoy;

    {
        [_x, _startingPosition, _sortedConvoyDestinations, _convoyDestinations] call giveConvoyOrders;
    } forEach _convoyGroups;

    //STEP 5 -- PUT THINGS AT THE PLACE THE CONVOY STOPS
    {
        if (!(_x isEqualTo _startingPosition)) then {
            [_x] call addCache;
        };
    } forEach _convoyDestinations;

    //STEP 6 -- ARM THE MASSES
    [_faction] spawn ArmTheMasses;

    _convoyGroups

};

blinkies = ["Land_PortableHelipadLight_01_F","PortableHelipadLight_01_blue_F","PortableHelipadLight_01_green_F","PortableHelipadLight_01_red_F","PortableHelipadLight_01_white_F","PortableHelipadLight_01_yellow_F"];

missionCaches = [];

addCache = {
    //a little thing to find, eventually the convoy finds it
    //maybe blows it up when they leave?
    params["_location"];
    private _blinker = (selectRandom blinkies) createVehicle _location;
    missionCaches pushBack _blinker;
    
    /*
    ["crowsEW_spectrum_addBeacon", [_blinker, floor (random 400) + 600, 15000, "zeus"]] call CBA_fnc_serverEvent; //why no work?
    */
    
    //"Land_House_Big_01_V1_ruins_F" createvehicle _location;
    //the ruins clip into things, so might need to be spawn'd. or ensure that the blinkies are invincible.
};

debugPointDraw = {
    params["_pointArray"];
    {
        private _markerNameString = "_debugConvoyDestination" + str(_forEachIndex);
        private _debugDestinationPos = createMarker [_markerNameString, _x];
        _debugDestinationPos setMarkerType "hd_start";
        _markerNameString setMarkerText ("CONVOY_STOP" + str(_forEachIndex));
    } forEach _pointArray;
};

giveUnitWeapon = {
    params ["_unit", "_weaponArray"];
    private _chosenWeapon = selectRandom _weaponArray;
    _unit addWeapon (_chosenWeapon select 0);
    _unit addItem (_chosenWeapon select 1);
    _unit addItem (_chosenWeapon select 1);
    _unit addItem (_chosenWeapon select 1);
    _unit addItem (_chosenWeapon select 1);
    _unit addItem (_chosenWeapon select 1);
    _unit addItem (_chosenWeapon select 1);
    _unit addItem (_chosenWeapon select 1);
    _unit addItem (_chosenWeapon select 1);
    _unit addItem (_chosenWeapon select 1);
    _unit addItem (_chosenWeapon select 1);
};

giveUnitLoot = {
    params ["_unit", "_lootArray"];
    private _WIPTESTLOOTDELETEME = selectRandom _lootArray;
    _unit addItem _WIPTESTLOOTDELETEME;
};

armTheMasses = {
    params ["_factionArray"];
    {
        _x setUnitLoadout (selectRandom (_factionArray select 2));
        [_x, _factionArray select 3] call giveUnitWeapon;
        [_x, _factionArray select 4] call giveUnitLoot;
    } forEach units east;
    //TODO: ADD LOOT
    //AND MAYBE VEHICLE LOOT TOO?
};

putTheFuckmenInTheirSeats = {
    {
        private _theVic = assignedVehicles group _x;
        _x moveInAny (_theVic select 0);
    } forEach (units east);
};

if (isServer) then {
    theConvoyGroups = [false] call createTheWholeDamnConvoy;
    //[_selectedFaction] spawn ArmTheMasses;
    [] spawn putTheFuckmenInTheirSeats;
};

/*

OLD NOTES ABOUT STUPID OLD CONVOY THINGS GOD I HATE CONVOYS WHY DID I DECIDE THIS WAS A GOOD IDEA

https://forums.bohemia.net/forums/topic/226608-simple-convoy-script-release/
Needs a group with waypoints placed beforehand.
spawn this. don't call. 
[group] spawn TOV_fnc_SimpleConvoy;

NOTE
    The script doesn't exit himself, so once you reach your final waypoint, you'll have to end it with :

    terminate convoyScript;
    {(vehicle _x) limitSpeed 5000;(vehicle _x) setUnloadInCombat [true, false]} forEach (units convoyGroup);
    convoyGroup enableAttack true;

    SHIT. AI likes to lock up unless waypoints are kinda close. maybe 2km? kinDA FIXED fuck I hate it here

*/