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

createTestConvoy = {
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

createTestConvoy = {
    params ["_location"];
    private _newGroups = [];

    for "_i" from 1 to ((floor (random 10)) + 2) do {
        private _newGroup = createGroup [east, true];
        private _newVic = createVehicle [selectRandom testVehicles, _location vectorAdd [0, _i * -10, 0]];
        _newGroup addVehicle _newVic;
        private _crewCount = [typeOf _newVic, true] call BIS_fnc_crewCount;
        for "_j" from 1 to _crewCount do {
            (selectRandom testUnits) createUnit [_location, _newGroup];
        };
        _newGroups pushBack _newGroup;
    };
    _newGroups

};

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

giveConvoyOrders = {
    params ["_convoyGroup", "_startingPos", "_destinationsArray"];
    //get in your vehicles
    private _okayGoNow = _convoyGroup addWaypoint [(_startingPos vectorAdd [0, 50, 0]), 0, 1];
    _okayGoNow setWaypointType "GETIN";

    _convoyGroup setCombatBehaviour "COMBAT";
    [_convoyGroup] call setupSimpleConvoy;

    for "_i" from 1 to ((count _destinationsArray) - 1) do {
        private _nextPos = _destinationsArray select _i;
        private _nextWaypoint = _convoyGroup addWaypoint [_nextPos, 100];
        _nextWaypoint setWaypointType "MOVE";
    };

    private _okayButSeriouslyGoNow = _convoyGroup addWaypoint [(_startingPos vectorAdd [0, 150, 0]), 0, 2];
    _okayButSeriouslyGoNow setWaypointType "MOVE";

    private _fuckOffIntoTheSunset = _convoyGroup addWaypoint [_startingPos vectorAdd [worldSize-1000,0,0], 1000];
    _fuckOffIntoTheSunset setWaypointType "MOVE";
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
            if (_pointA distance _pointB > 1500) then {
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

    //CHECK OFF-MAP POINTS.

    if (_debug) then {
        [_sortedConvoyDestinations] call debugPointDraw;
    };

    //STEP 3
    //TODO: use real values and not testing values
    //TODO: each vehicle its own group?
    private _convoyGroups = [_startingPosition] call createTestConvoy;
    //private _testConvoy = [_startingPosition] call createSingleVehicle;
    //private _testConvoy2 = [_startingPosition] call createSingleVehicle;
    //private _testConvoy3 = [_startingPosition] call createSingleVehicle;

    //STEP 4 -- RE-ENABLE ME ONCE FINISHED I GUESS
    //[_convoyGroup, _startingPosition, _sortedConvoyDestinations] call giveConvoyOrders;
    //[_testConvoy, _startingPosition, _sortedConvoyDestinations] call giveConvoyOrders;
    //[_testConvoy2, _startingPosition vectorAdd [0,-10,0], _sortedConvoyDestinations] call giveConvoyOrders;
    //[_testConvoy3, _startingPosition vectorAdd [0,-20,0], _sortedConvoyDestinations] call giveConvoyOrders;
    //[_convoyGroup] spawn TOV_fnc_SimpleConvoy;

    {
        [_x, _startingPosition, _sortedConvoyDestinations] call giveConvoyOrders;
    } forEach _convoyGroups;

    _convoyDestinations

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

stupidDumbArrayPlz = [true] call createTheWholeDamnConvoy;

//this shit still breaks on occasion. maybe just reset it if nothing's moving after 4-5 minutes
//if the next waypoint is too far away, it seems to bork. 
    //cool I guess I fixed it by arduously making a new travel point every x meters. 


/*

TAKE 3 MOTHERFUCKERS!

    spawn all the vehicles and people, give it a load order, give it some time to load up.


[[0,[16484,2103.12,0]],[13169,[3826.98,5739.5,0]],[13366.9,[3236.84,3888.56,0]],[13965,[15728.9,16047.7,0]]]

[[[0,[16484,2103.12,0]],[13169,[3826.98,5739.5,0]],[13366.9,[3236.84,3888.56,0]],[13965,[15728.9,16047.7,0]]], 1000] call midPointAdder;

THIS ONE WORKED!

    private _newMidpoints = [];
    for "_i" from 0 to ((count _convoyDestinations) - 2) do {
        private _newMidpoint = [_convoyDestinations select _i, _convoyDestinations select _i + 1] call simpleMidPoint;
        _newMidpoints pushBack _newMidpoint;
    };
    _convoyDestinations append _newMidpoints;


THE FUCK

    midPointAdder = {
        params ["_arrayToEdit", "_maximumThePointArray"];
        private _doWeNeedToRecurse = false;
        private _rawPos = [];
        for "_i" from 0 to (count _arrayToEdit - 2) do {
            hint str(((_arrayToEdit select _i select 1) distance (_arrayToEdit select (_i+1) select 1)));
            if (((_arrayToEdit select _i select 1) distance (_arrayToEdit select (_i+1) select 1)) > 1000) then {
                
                _rawPos = [(_arrayToEdit select _i) select 1, (_arrayToEdit select (_i+1)) select 1] call simpleMidPoint;
                _distanceAverage = ((_arrayToEdit select _i) select 0) + ((_arrayToEdit select (_i+1) select 0)) / 2;
                //hint str(_rawPos);
                //_arrayToEdit pushBack [_rawPos distance ((_arrayToEdit select 0) select 1),_rawPos]; 
                _arrayToEdit pushBack [_distanceAverage,_rawPos]; 
                _doWeNeedToRecurse = true;
            };
        };
        _doWeNeedToRecurse
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

    while {[_convoyDestinations, 1000] call midPointAdder} do {
        _convoyDestinations sort true;
    };

pickConvoyDestinationPosition2 = {
    params["_previousPos"];
    private _returnSpot = [random(worldSize),random(worldSize),0];
    if ((_returnSpot select 0) < 3000) then {
        _returnSpot = [_previousPos] call pickConvoyDestinationPosition2;
    };
    if (_returnSpot distance _previousPos > 2000) then {
        _returnSpot = [_previousPos] call pickConvoyDestinationPosition2;
    };
    _returnSpot
};

    //sort nearest to farthest, adjust array
    //_convoyDestinations = _convoyDestinations apply {[_x distance _startingPosition, _x]};
    //_convoyDestinations sort true;

actuallyFuckingSortThePoints = {
    params["_theFuckingPoints"];
    private _newSortedArray = [];
    //grab that last point since it's the start point
    _newSortedArray pushBack (_theFuckingPoints select count _theFuckingPoints - 1);
    _theFuckingPoints deleteAt ((count _theFuckingPoints) - 1);
    while {count _theFuckingPoints > 1} do {
        private _nextOnTheChoppingBlock = [];
        private _lastPointDistance = 0;
        {
            if (_newSortedArray select (count _newSortedArray - 1) distance _x > _lastPointDistance) then {
                _nextOnTheChoppingBlock = _x;
                _lastPointDistance = _newSortedArray select (count _newSortedArray - 1) distance _x;
            };
        } forEach _theFuckingPoints;
        _newSortedArray pushBack _nextOnTheChoppingBlock;
        _theFuckingPoints = _theFuckingPoints - _nextOnTheChoppingBlock;
    };
    _newSortedArray
};

        // I don't know why the game is having issues with the timeout and statements. Apparently a scripted waypoint that just waits works the best?
            //nah, I'm doing the director thing again because fuck this.

        //_nextWaypoint setWaypointTimeout [30, 40, 50];
        //_nextWaypoint setWaypointStatements ["true", '"FUCK SHIT PISS" remoteExec ["hint",0];'];
        //private _waitWaypoint = _convoyGroup addWaypoint [_nextPos, -1];
        //_waitWaypoint setWaypointType "SCRIPTED";
        //_waitWaypoint setWaypointScript "dumbWait.sqf";

*/

