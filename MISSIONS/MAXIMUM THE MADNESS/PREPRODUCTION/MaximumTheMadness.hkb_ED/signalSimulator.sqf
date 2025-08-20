//init radio frequencies because this just doesn't work here... works if I 
//WAIT IM JUST STUPID, THE DUDES AREN'T IN THEIR CARS YET. THERE IS NO OBJECTPARENT.
        //experimental 520 - 1090
        //jammer 433-445
        //military 30-513
//okay, we extracted the vehicles and blinkies into their own arrays, easy to access and nobody needs to be riding in them

usedFreqs = [69, 70];

getUniqueMilFreq = {
    private _returnValue = floor (random 470) + 30;
    if (_returnValue in usedFreqs) then {
        _returnValue = [] call getUniqueMilFreq;
    };
    usedFreqs pushBack _returnValue;
    _returnValue
};

getUniqueExpFreq = {
    private _returnValue = floor (random 570) + 520;
    if (_returnValue in usedFreqs) then {
        _returnValue = [] call getUniqueExpFreq;
    };
    usedFreqs pushBack _returnValue;
    _returnValue
};

if (isServer) then { //spawn this?
    waitUntil {time > 15};
    {
        private _uniqueNum = [] call getUniqueMilFreq;
        ["crowsEW_spectrum_addBeacon", [_x, _uniqueNum, 5000 + (floor (random 10000)), "zeus"]] call CBA_fnc_serverEvent;
    } forEach enemyVics;
    {
        private _uniqueNum = [] call getUniqueExpFreq;
        ["crowsEW_spectrum_addBeacon", [_x, _uniqueNum, 15000 + (floor (random 15000)), "zeus"]] call CBA_fnc_serverEvent;
    } forEach missionCaches;
};