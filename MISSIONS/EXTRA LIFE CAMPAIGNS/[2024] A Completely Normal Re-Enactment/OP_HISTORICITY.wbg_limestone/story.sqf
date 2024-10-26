[true, "gearP", 
    ["Re-enactment day! Let's get our gear together and have a good one!", "GEAR", "?"], 
    objNull, "CREATED", -1, false, "default"
] call BIS_fnc_taskCreate;

[true, "foodP", 
    ["We're going to party hard after the re-enactment, so we should provision accordingly.", "FOOD", "?"],
     objNull, "CREATED", -1, false, "default"
] call BIS_fnc_taskCreate;

[true, ["food1", "foodP"], 
    ["We have a massive catering order waiting for us at Pizza Place. We should pick it up while it's still hot and before the greasy teen behind the counter takes one for himself.", "Pickup Pizza", "?"], 
    [2709.38,2927.63,0.00143886], "CREATED", -1, false, "mine", true
] call BIS_fnc_taskCreate;

[true, ["food2", "foodP"], ["Herb said our special order came in, so let's go pick that up.", "Pickup Beer", "?"], 
    [2592.37,2966.59,0.00143886], "CREATED", -1, false, "box", true
] call BIS_fnc_taskCreate;

[true, ["gear1", "gearP"], 
    ["Bubba's got the uniforms all done. Pick out your favorite and make sure all the ruffles are tucked in the right places.", "Get Dressed", "?"], 
    [2507.72,3385.67,0.00160718], "CREATED", -1, false, "backpack", true
] call BIS_fnc_taskCreate;

[true, ["gear2", "gearP"], 
    ["The rest of the gear is in the trailer. Since we're using a bunch of fun explosives we should check in with Trucker Jolyon and make sure the permits are all set.", "Get Gear and Paperwork", "?"], 
    [2590.94,2685.93,0.00142884], "CREATED", -1, false, "destroy", true
] call BIS_fnc_taskCreate;

//after the intro, the rain has begun, so all the descriptions need to be re-written

rainTaskUpdate = {

    [true, "fuck", 
        ["Well, shit. Typical Florida weather. Hopefully it's just a popcorn squall and it'll go away by the time we're done prepping.", "Fuck.", "?"], 
        objNull, "CREATED", -1, true, "wait", false
    ] call BIS_fnc_taskCreate;

    sleep 2;

    [true, "brits", 
        ["Just got a call from the nerds playing the British, they're taking a rain check...", "The Guys Playing the British", "?"], 
        objNull, "CANCELED", -1, true, "meet", false
    ] call BIS_fnc_taskCreate;

    ["gearP",
        [
            "Re-enactment day... Let's get our gear together and hope this all turns around soon.",
            "GEAR",
            ""
        ]
    ] call BIS_fnc_taskSetDescription;
    //note: gear1 should be completed before the intro/rain
    ["gear2",
        [
            "The rest of the gear is in the trailer. Since we... might... be using a bunch of fun explosives we should check in with Trucker Jolyon and make sure the permits are all set. Make sure your powder doesn't get wet.",
            "Get Gear and Paperwork",
            ""
        ]
    ] call BIS_fnc_taskSetDescription;

    ["foodP",
        [
            "We're going to party hard, even if we're not doing the re-enactment, so we should provision accordingly.",
            "FOOD",
            ""
        ]
    ] call BIS_fnc_taskSetDescription;

    ["food1",
        [
            "We have a massive catering order waiting for us at Pizza Place. We should pick it up while it's still hot... and hey, since the Brits canceled that means more for us! Let the greasy teen behind the counter take one for himself!",
            "Pickup Pizza",
            ""
        ]
    ] call BIS_fnc_taskSetDescription;

    ["food2",
        [
            "Herb said our special order came in, so let's go pick that up. Might as well drown our sorrows in beer instead of rain.",
            "Pickup Beer",
            ""
        ]
    ] call BIS_fnc_taskSetDescription;

    sleep 10;
    ["gear1", "SUCCEEDED", true] call BIS_fnc_taskSetState;

};

//what do you mean Kenneth has it?
if (isServer) then {
    beerNoHereTrigger = createTrigger ["EmptyDetector", [2592.91,2962.99,0.00143886], true];
    beerNoHereTrigger setTriggerArea [1, 1, 0, false];
    beerNoHereTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
    beerNoHereTrigger setTriggerStatements ["this", "[] spawn kennethSideQuest;", ""];
};

kennethSideQuest = {
    [true, ["food3", "foodP"], 
        ["Oh boy. Kenneth. Piece of work, that one. Nice kid and all, really helpful, does a lot to help out the re-enactments, but has a few screws loose. Hopefully he hasn't drank too much. Does he even drink?", "What do you mean Kenneth has it?", "?"], 
        [3044.04,2734.76,0.00143886], "CREATED", -1, true, "run", true
    ] call BIS_fnc_taskCreate;
    
    sleep 2;
    
    ["food2", "FAILED", true] call BIS_fnc_taskSetState;

    ["food2",
        [
            "Herb said our special order came in and was picked up by Kenneth.",
            "Pickup Beer",
            ""
        ]
    ] call BIS_fnc_taskSetDescription;

    beerActualTrigger = createTrigger ["EmptyDetector", [3050.31,2731.67,0.00143886], true];
    beerActualTrigger setTriggerArea [1, 1, 0, false];
    beerActualTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
    beerActualTrigger setTriggerStatements ["this", "[] spawn beerAcquired;", ""];

};

beerAcquired = {
    ["food2", "SUCCEEDED", true] call BIS_fnc_taskSetState;
    ["food3", "SUCCEEDED", true] call BIS_fnc_taskSetState;

    ["food2",
        [
            "Herb said our special order came in and was picked up by Kenneth. Kenneth iced it down and packed it all into coolers for us. That was actually really helpful, Kenneth. Would it have killed you to give us a call and let us know you did it? Actually, considering Kenneth, it might have.",
            "Pickup Beer",
            ""
        ]
    ] call BIS_fnc_taskSetDescription;

    _kennethDigSiteMarker = createMarker ["kennethDigSite", scantleburyGrave];
    _kennethDigSiteMarker setMarkerType "hd_unknown";

    sleep 2;

    [true, "digSite", 
        ["Huh, Kenneth's been digging holes again. Kenneth said he found something weird. We should go see what's got him spooked.", "Kenneth went digging again...", "?"], 
        [3113.13,2556.09,0.000953078], "CREATED", -1, true, "danger", true
    ] call BIS_fnc_taskCreate;

    kennethDigTrigger = createTrigger ["EmptyDetector", [3113.13,2556.09,0.000953078], true];
    kennethDigTrigger setTriggerArea [3, 3, 0, false];
    kennethDigTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
    kennethDigTrigger setTriggerStatements ["this", '["digSite", "SUCCEEDED", true] call BIS_fnc_taskSetState;', ""];
};

pizzPayment hideObjectGlobal true;

if (isServer) then {
    pizzaPickupTrigger = createTrigger ["EmptyDetector", [2713.03,2925.86,0.00143886], true];
    pizzaPickupTrigger setTriggerArea [1, 1, 0, false];
    pizzaPickupTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
    pizzaPickupTrigger setTriggerStatements ["this", "[] spawn pizzaQuest;", ""];
};

pizzaQuest = {
    ["food1", "SUCCEEDED", true] call BIS_fnc_taskSetState;

    deleteVehicle pizz;
    sleep 0.5;
    deleteVehicle pizz_1;
    sleep 0.5;
    deleteVehicle pizz_2;
    sleep 0.5;
    deleteVehicle pizz_3;
    sleep 0.5;
    deleteVehicle pizz_4;
    sleep 0.5;
    deleteVehicle pizz_5;
    sleep 0.5;
    deleteVehicle pizz_6;
    sleep 0.5;
    deleteVehicle pizz_7;
    sleep 0.5;
    deleteVehicle pizz_8;
    sleep 0.5;
    deleteVehicle pizz_9;
    sleep 0.5;
    deleteVehicle pizz_10;
    sleep 0.5;
    deleteVehicle pizz_11;
    sleep 0.5;
    deleteVehicle pizz_12;
    sleep 0.5;
    deleteVehicle pizz_13;
    sleep 0.5;
    deleteVehicle pizz_14;
    sleep 1.5;

    pizzPayment hideObjectGlobal false;
};

//gear tree - 

if (isServer) then {
    gearWarehouseTrigger = createTrigger ["EmptyDetector", [2590.94,2685.93,0.00142884], true];
    gearWarehouseTrigger setTriggerArea [5, 5, 0, false];
    gearWarehouseTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
    gearWarehouseTrigger setTriggerStatements ["this", "[] spawn fortPaperwork;", ""];
};

fortPaperwork = {
    ["gear2", "SUCCEEDED", true] call BIS_fnc_taskSetState;

    [chapter1Arsenal] spawn updateAllArsenals;

    [true, ["gear3", "gearP"], 
        ["Ah, one last signature is needed from the Sheriff and we're good to blow shit up. Jolyon says the Sheriff went down to Fort Lopez to take care of something.", "One Last Sign Off", "?"], 
        [889.857,3180.7,0.00145084], "CREATED", -1, true, "documents", true
    ] call BIS_fnc_taskCreate;

    policeTrigger = createTrigger ["EmptyDetector", [862.88,3227.24,0.00143886], true];
    policeTrigger setTriggerArea [3, 3, 0, false];
    policeTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
    policeTrigger setTriggerStatements ["this", "[] spawn sheriffSignature;", ""];

};

//oh yeah, this is just so any 9-1-1 calls I tell people to ignore have a paper trail.

sheriffSignature = {
    ["gear3", "SUCCEEDED", true] call BIS_fnc_taskSetState;

    sleep 2;

    [true, "practice", 
        ["Well, the rain's not letting up, but we can still blow off some steam at the range.", "Shoot Shit at the Range", "?"], 
        [1119.51,2158.4,0.00142407], "CREATED", -1, true, "rifle", true
    ] call BIS_fnc_taskCreate;
};

//just go on in, I don't even want to try to stop if you if you're here to make mischeif. 

bigCar1 setVehicleLock "LOCKED";
bigCar2 setVehicleLock "LOCKED";
bigCar3 setVehicleLock "LOCKED";
bigCar4 setVehicleLock "LOCKED";
bigCar5 setVehicleLock "LOCKED";

lopezBribe hideObjectGlobal true;

lopezKeys addAction ["Swipe Keys", "
        [] remoteExec ['keysStolen'];
        deleteVehicle lopezKeysActual;
        sleep 0.5;
        deleteVehicle lopezKeysActual_1;
        sleep 0.5;
        lopezBribe hideObjectGlobal false;
        [lopezKeys] remoteExec ['removeAllActions'];
    "
    , nil, 15, true, true, "", "true", 3, false, "", ""
];

keysSwiped = false;

keysStolen = {
    bigCar1 setVehicleLock "UNLOCKED";
    bigCar2 setVehicleLock "UNLOCKED";
    bigCar3 setVehicleLock "UNLOCKED";
    bigCar4 setVehicleLock "UNLOCKED";
    bigCar5 setVehicleLock "UNLOCKED";
    keysSwiped = true;
};

//DIALOGUE!

currentlyChapter1 = true;
currentlyChapter2 = false; //starts after the players are interrupted at the firing range
currentlyChapter3 = false; //the finale, ghost ships on the horizon

displayingText = false;
ONLYONEDIALOGUEPLEASE = nil;

showDialogue = {
    params ["_speaker", "_text", "_time"];
    if (displayingText) then {
        removeMissionEventHandler ["Draw3D", ONLYONEDIALOGUEPLEASE];
    };
    displayingText = true;
    ONLYONEDIALOGUEPLEASE = addMissionEventHandler ["Draw3D", {
        drawIcon3D ["", [1,1,1,1], (getPos (_thisArgs select 0)) vectorAdd [0,0,2.2], 0, 0, 0, _thisArgs select 1, 2, 0.05, "PuristaBold"];
    }, [_speaker, _text]];
    sleep _time;
    removeMissionEventHandler ["Draw3D", ONLYONEDIALOGUEPLEASE];
    displayingText = false;
};

addDialogueOption = {
    params ["_character", "_dialogue", "_logic"];
    private _dialogueAction = _character addAction [
        _dialogue, 
        "
        [_this select 3 select 0, _this select 3 select 1, 10] remoteExec ['showDialogue'];
        ", 
        [_character, _dialogue], 15, true, true, "", _logic, 5, false, "", ""
    ];
};

//kenneth
[kenneth, "Kenneth went digging again.", "currentlyChapter1"] call addDialogueOption;
[kenneth, "Kenneth found something weird.", "currentlyChapter1"] call addDialogueOption;
[kenneth, "The rain started when Kenneth dug it up.", "currentlyChapter1"] call addDialogueOption;
[kenneth, "Kenneth doesn't like it.", "currentlyChapter1"] call addDialogueOption;

[kenneth, "Kenneth still doesn't like it.", "currentlyChapter2"] call addDialogueOption;
[kenneth, "The loud noises hurt Kenneth's ears.", "currentlyChapter2"] call addDialogueOption;

//herb
//Republic of East Florida

[herb, "Here about the order? Kenneth came round and picked it up.", "currentlyChapter1"] call addDialogueOption;
[herb, "Sorry to hear about the rain, folks. Hopefully it'll pass soon.", "currentlyChapter1"] call addDialogueOption;
[herb, "I was looking forward to putting on a whole production about the Republic of East Florida, too.", "currentlyChapter1"] call addDialogueOption;

[herb, "What is all that racket? I'm trying to run three businesses, here!", "currentlyChapter2"] call addDialogueOption;

[herb, "Look, this place is already torn to hell and back, use the cannons.", "currentlyChapter3"] call addDialogueOption;

//pizzer
[pizzer, "Yeah, that's all 16. I dunno what else you want, man.", "currentlyChapter1"] call addDialogueOption;
[pizzer, "Also: it's Gracey Ten. Please get my name right.", "currentlyChapter1"] call addDialogueOption;
[pizzer, "That sounded like my pseudo-oscillating wormhole model I did my thesis on.", "currentlyChapter2"] call addDialogueOption;
[pizzer, "Yeah, theoretical physics degree and I work in a nowheresville pizza joint.", "currentlyChapter2"] call addDialogueOption;
[pizzer, "If I had 2 million dollars of equipment here, I'd have a Nobel Prize by now, man.", "currentlyChapter2"] call addDialogueOption;
[pizzer, "Wish I had gotten that defense contractor job.", "currentlyChapter3"] call addDialogueOption;

//trucker

[trucker, "And they call this place the Sunshine State...", "currentlyChapter1"] call addDialogueOption;
[trucker, "If you still want it, gear is all unpacked. Before you go blowing too much up, there's one more thing.", "currentlyChapter1"] call addDialogueOption;
[trucker, "Looks like it needs the Sheriff's signature. Saw him turning westbound on my way in. Probably went to the fort.", "currentlyChapter1"] call addDialogueOption;

[trucker, "The northern lights normally don't make noises like that.", "currentlyChapter2"] call addDialogueOption;
[trucker, "Nor are they seen this far south, come to think of it.", "currentlyChapter2"] call addDialogueOption;

[trucker, "This is what I get for staying in town because I wanted to see some cannons firing.", "currentlyChapter3"] call addDialogueOption;

//gateGuard
//there's also keysSwiped from above
[gateGuard, "Looking for the Sheriff? Go on in, he's somewhere inside.", "currentlyChapter1"] call addDialogueOption;
[gateGuard, "If you want to sit in the vics, fine, but don't do anything stupid. The sheriff's right there.", "currentlyChapter1 and keysSwiped"] call addDialogueOption;
[gateGuard, "I know it's raining and the re-enactment is probably canceled, but I don't want to get chewed out for this.", "currentlyChapter1 and keysSwiped"] call addDialogueOption;

[gateGuard, "Couple of guys in redcoats took a pot shot at me, with a live round!", "currentlyChapter2"] call addDialogueOption;
[gateGuard, "Look, I'm the only one here, grab what you want from the armory and help me out.", "currentlyChapter2"] call addDialogueOption;
[gateGuard, "You'll be forgiven for swiping the keys if ya'll can resolve all this.", "currentlyChapter2 and keysSwiped"] call addDialogueOption;

[gateGuard, "A ghost ship? Like a golden age of sail ship? And you're looking to shoot it down?", "currentlyChapter3"] call addDialogueOption;
[gateGuard, "Well, if it's thick oak, you're going to want at least .50 cal to punch through the hull.", "currentlyChapter3"] call addDialogueOption;
[gateGuard, "Maybe we still got ammo for the M119 somewhere around here.", "currentlyChapter3"] call addDialogueOption;
[gateGuard, "(4th wall break) Seriously!? Nobody stole the keys until chapter 3?! TAKE THE VICS!", "currentlyChapter3 and (!keysSwiped)"] call addDialogueOption;

//sheriff
[sheriff, "Oh yeah, those papers, just coverin' my ass when the inevitable 9-1-1 calls come in due to explosions.", "currentlyChapter1"] call addDialogueOption;
[sheriff, "Should all be signed and dotted, don't cause no trouble and have fun ya'll.", "currentlyChapter1"] call addDialogueOption;

[sheriff, "Those guys aren't with you? And they're shooting back? And they're breaking noise ordinances?!", "currentlyChapter2"] call addDialogueOption;

[sheriff, "Yeah, the ham radio guys around here are going nuts. Whatever you gotta do, do it.", "currentlyChapter3"] call addDialogueOption;


//dumb easter egg
rockmania addAction ["A 'Rockmanian' passport?", 
    ""
    , nil, 15, true, true, "", "true", 3, false, "", ""
];

//scantlebury epitaph

scantleburyGrave addAction ["A large memorial, recently unburied, with something engraved into it.", 
    "[] call epitaph;"
    , nil, 15, true, true, "", "true", 6, false, "", ""
];

epitaph = {
    titleText ["
    <t color='#666666' size='3'>F**R GO*<br/>
    H*NOUR THE KI*G<br/>
    COMMANDER GILBERT SCANTLEBURY<br/>
    *OYAL NAV*</t>
    <t color='#666666' size ='2'><br/> 
    Lo** i* Pursuit *f the *oun*a*n O* **u** <br/>
    *ay *e find *ternity, *ne wa* or ano**er<br/>
    </t>", "PLAIN", -1, true, true];
};