/*

https://forums.bohemia.net/forums/topic/226608-simple-convoy-script-release/

Needs a group with waypoints placed beforehand.

spawn this. don't call. 

[group] spawn TOV_fnc_SimpleConvoy;

TODO
    figure out path convoy will take. maybe put something at destination like a cache.
    place convoy
        make some factions? loadouts, etc. cool-looking units with proper inventories
        make sure vics have fun ammo amounts and gas


NOTE
    The script doesn't exit himself, so once you reach your final waypoint, you'll have to end it with :

    terminate convoyScript;
    {(vehicle _x) limitSpeed 5000;(vehicle _x) setUnloadInCombat [true, false]} forEach (units convoyGroup);
    convoyGroup enableAttack true;

    SHIT. AI likes to lock up unless waypoints are kinda close. maybe 2km?

*/

TOV_fnc_SimpleConvoy = { 
    params ["_convoyGroup",["_convoySpeed",40],["_convoySeparation",15],["_pushThrough", false]];
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

/*

testVehicles = [
    "I_C_Offroad_02_LMG_F"
];

testUnits = [
    "O_Soldier_F"
];

initializeConvoy = {

};

createConvoy = {
    params ["_vicList", "_unitList", "_side", "_spawnPos", "_convoyGroup"];
    //private _testConvoy = createGroup [_side, true];

    for "_i" from 1 to ((floor (random 10)) + 2) do {
        private _newVic = createVehicle [selectRandom _vicList, _spawnPos vectorAdd [0, _i * -10, 0]];
        _convoyGroup addVehicle _newVic;
        private _crewCount = [typeOf _newVic, true] call BIS_fnc_crewCount;
        for "_j" from 1 to _crewCount do {
            (selectRandom _unitList) createUnit [_spawnPos, _convoyGroup];
        };
    };

    //{
    //    [_x] orderGetIn true;
    //} forEach units _convoyGroup;
    _convoyGroup
};

getEndPoint = {
    endPoint = [floor random worldSize, floor random worldSize, 0];

    if (
        (endPoint distance2D infilExfilArea < 3000)
        or
        (endPoint select 0 > worldSize - 4500)
        or
        (endPoint select 1 < 4500)
        or
        (endPoint select 1 > worldSize - 4500)
    ) then {
        endPoint = [] call getEndPoint;
    };
    endPoint
};

drawConvoyPath = {
    params ["_group", "_endPointConvoy"];

    _marker1 = createMarker ["ConvoyOrigin", _endPointConvoy];
    _marker1 setMarkerType "hd_dot";

    _randomDirection = (floor random 178) + 1;

    private _offMapPos = [worldSize*2,worldSize*2,0];

    for "_i" from 15 to 1 step -1 do {
        private _newPos = _endPointConvoy getPos [500*_i, _randomDirection + ((random 10) - 5)];
        if (_i == 15) then {
            _offMapPos = _newPos;
        };
        private _newMarker = createMarker ["CONVOIBOI" + str(_i), _newPos];
        _newMarker setMarkerType "hd_dot";
        private _justMoveWaypoint = _group addWaypoint [_newPos, 0];
        _justMoveWaypoint setWaypointType "MOVE";
    };

    _offMapPos
};

[] spawn {
    private _convoyEnd = [] call getEndPoint;
    private _convoyGroup = createGroup [west, true];
    _convoySpawnPoint = [_convoyGroup, _convoyEnd] call drawConvoyPath;
    private _okayGoNow = _convoyGroup addWaypoint [(_convoySpawnPoint vectorAdd [0, 50, 0]), 0, 1];
    _okayGoNow setWaypointType "GETIN";
    [testVehicles, testUnits, west, _convoySpawnPoint, _convoyGroup] call createConvoy;
    [_convoyGroup] spawn TOV_fnc_SimpleConvoy;
};




pick spot on map -- pick direction (away from player) -- go maybe 16km -- convoy can start off map. oh well, I guess it's still straight

*/

/*

OKAY - ALGORITHM 2

*/


//pick a spot off map.
pickSpotOffMap = {
    private _returnSpot = [0,0,0];

    switch (floor (random 3)) do {
        case 0: { //NORTH BORDER
            _returnSpot = [((worldSize/2) + random(worldSize/2)),worldSize + 100,0];
        };
        case 1: { //SOUTH BORDER
            _returnSpot = [((worldSize/2) + random(worldSize/2)),-100,0];
        };
        case 2: { //EAST BORDER
            _returnSpot = [worldSize + 100, random(worldSize), 0];
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

createTestConvoy = {
    params ["_location"];
    private _newGroup = createGroup [west, true];
    private _newVic = createVehicle ["I_C_Offroad_02_LMG_F", _location];
    _newGroup addVehicle _newVic;
    private _crewCount = [typeOf _newVic, true] call BIS_fnc_crewCount;
    for "_j" from 1 to _crewCount do {
        "O_Soldier_F" createUnit [_location, _newGroup];
    };
    _newGroup
};

giveConvoyOrders = {
    params ["_convoyGroup", "_startingPos", "destinationsArray"];
};

createTheWholeDamnConvoy = {
    params ["_debug"];

    //STEP 1
    private _startingPosition = [] call pickSpotOffMap;

    if (_debug) then {
        _debugStartPos = createMarker ["_debugStartPos", _startingPosition];
        _debugStartPos setMarkerType "hd_start";
        "_debugStartPos" setMarkerText "CONVOY_START";
    };

    //STEP 2
    private _convoyDestinations = [];
    for "_i" from 1 to ((floor (random 4)) + 2) do {
        _convoyDestinations pushBack ([] call pickConvoyDestinationPosition);
    };
    //sort nearest to farthest, adjust array
    _convoyDestinations = _convoyDestinations apply {[_x distance _startingPosition, _x]};
    _convoyDestinations sort true;

    if (_debug) then {
        {
            private _markerNameString = "_debugConvoyDestination" + str(_forEachIndex);
            private _debugDestinationPos = createMarker [_markerNameString, _x select 1];
            _debugDestinationPos setMarkerType "hd_start";
            _markerNameString setMarkerText ("CONVOY_STOP" + str(_forEachIndex));
        } forEach _convoyDestinations;
    };

    //STEP 3
    //TODO: use real values and not testing values
    private _convoyGroup = [_startingPosition] call createTestConvoy;

    //STEP 4
    [_convoyGroup, _startingPosition, _convoyDestinations] call giveConvoyOrders;

};

[true] call createTheWholeDamnConvoy;