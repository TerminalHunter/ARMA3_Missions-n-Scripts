storyText = {
  params ["_text"];
  titleText [_text,"PLAIN DOWN",2.5,true,true];
};

setDate [2283,4,20,12,0];

roadblockGuy addAction ["'Please stop, this is a toll road' says the man.", {
      _longString = "<t color='#777777' size='1'>You see how nice these roads are? They don't come free. Someone's got to pay the guy chiselling out the old concrete equipment.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

roadblockGuy addAction ["How much is the toll?", {
      _longString = "<t color='#777777' size='1'>For all of your military vehicles? 100 caps. That's a lot of tonnage you're putting down our road.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

roadblockGuy addAction ["Can't I just go around?", {
      _longString = "<t color='#777777' size='1'>You could. And you look more armed than I am, so I wouldn't stop you. But you really shouldn't.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

roadblockGuy addAction ["I don't have that much.", {
      _longString = "<t color='#777777' size='1'>Guess you aren't the trading type. That's fine, I'll let you by if you do me a favor.</t>";
      [_longString] call storyText;
      [] call mentionedFavor;
},[],1.5,true,true,"","true",10,false,"",""];

mentionedFavor = {
  roadblockGuy addAction ["What kind of favor?", {
        _longString = "<t color='#777777' size='1'>Something has been creeping around an industrial what'sit south of here, probably an animal or the like. It's got the town spooked. Figure out what it is, take care of it, and I'll let you pass.</t>";
        [_longString] call storyText;
        [] call mentionedWhatsIt;
  },[],1.5,true,true,"","true",10,false,"",""];
};

mentionedWhatsIt = {
  roadblockGuy addAction ["Where's the what'sit?", {
        _longString = "<t color='#777777' size='1'>A kilometer south of here. Follow the paved road that leaves town south east, near the fire station.</t>";
        [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];
};

//if players actually pay toll, put [] call tollComplete; into the console and run globally
tollComplete = {
  rewardBox2 addItemCargoGlobal ["ItemMap",2];
  roadblockGuy addAction ["Alright, I'll pay.", {
        _longString = "<t color='#777777' size='1'>Thank you kindly. There's a spot of radiation to the immediate east, so take a map from the box behind me and follow our detour.</t>";
        [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];
};

questComplete = {
  rewardBox2 addItemCargoGlobal ["ItemMap",2];
  roadblockGuy addAction ["Alright, I took care of the Super Mutant.", {
        _longString = "<t color='#777777' size='1'>Thank you kindly, but super what-now? Is that serious? Take a map from the box behind me and follow our detour, but talk to our odd neighbors who live on the hill. If it's real bad, they'll help us out with it.</t>";
        [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];
};

//if players run roughshod into the radiation zone, put [] call theyDidNotPay; into the console and run globally
theyDidNotPay = {
  roadblockGuy addAction ["Why didn't you tell me about the radiation?", {
        _longString = "<t color='#777777' size='1'>You didn't pay the toll. Surprised you survived.</t>";
        [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];
};

// RETIREMENT VILLAGE

manInWhite addAction ["Park as close to the gate as you can", {
      _longString = "<t color='#777777' size='1'>We don't want any escapees today. Talk to my coworker past the gate when you're ready to load up.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

manInWhite_1 addAction ["Hey, you aren't Borus. He out today?", {
      _longString = "<t color='#777777' size='1'>Well, you've got the bus. Make sure our vintage friends get to town safely. Let me know when you want them to load up.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

manInWhite_1 addAction ["Say 'Time to load up!'", {
      _longString = "<t color='#777777' size='1'>Alright folks, one at a time, plenty of seats for everyone. No pushing.</t>";
      [_longString] call storyText;
      [] call loadUpOldMen;
      [] call domRunsAway;
      [] call placeReward;
},[],1.5,true,true,"","true",10,false,"",""];

domRunsAway = {
  manInWhite_1 addAction ["Say 'Did one of them just run away?'", {
        _longString = "<t color='#777777' size='1'>Yeah, that's Dominick. He's been fussy today. Go make sure he's okay and maybe talk to him.</t>";
        [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];
};

allTheOldMen = [
  oldman_1,
  oldman_2,
  oldman_3,
  oldman_4,
  oldman_5,
  oldman_6
];

if (isServer) then {
  {
    _x setBehaviour "CARELESS";
  } forEach allTheOldMen;
  flightRisk setBehaviour "CARELESS";
};

flightRiskAction =  ["Ask 'Is everything okay?'", {
      _longString = "<t color='#777777' size='1'>No. I don't want to go to town today. Nobody is nice to me and it's boring. Go away.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

loadUpOldMen = {
  {
    [_x] spawn {
    params ["_olddude"];
    _bussyDoor = getPos bussy vectorAdd [3.79102,2.12769,0];
    sleep 2;
    //_stepUpAction = (group _olddude) addWaypoint [_bussyDoor,-1];
    //_stepUpAction setWaypointType "MOVE";
    _getOnAction = (group _olddude) addWaypoint [bussy, -1];
    _getOnAction setWaypointType "GETIN";
    _getOnAction waypointAttachVehicle bussy;
    };
  }forEach allTheOldMen;
  _runAway = (group flightRisk) addWaypoint [getMarkerPos "hidingBush", -1];
  _runAway setWaypointType "MOVE";
  _runAway setWaypointBehaviour "COMBAT";

  [flightRisk, flightRiskAction] remoteExec ["addAction", 0 ,true];
};

//BUS SIDE QUEST START

busMan addAction ["Hey, want to make a few caps?", {
      _longString = "<t color='#777777' size='1'>I'm feeling awful today and this arm rash is preventing me from driving. The retirement home is expecting a pickup right now.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

busMan addAction ["Reply 'Sure, I'll help'", {
      _longString = "<t color='#777777' size='1'>Thanks, you'll be picking up some retirees in an old folks home just outside the village.</t>";
      [_longString] call storyText;
      [] remoteExec ["bussyStart", 0, false];
},[],1.5,true,true,"","true",10,false,"",""];

busMan addAction ["Ask 'Where am I going?'", {
      _longString = "<t color='#777777' size='1'>Left out of the depot. Take a right after the pub, a left immediately after, and another left down the road. A bit down that road on the left will be an orchard, a dirt road, and a compound with three white buildings surrounded by a concrete wall. Go there and come back here.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

bussyStart = {
  if (local bussy) then {
	   bussy setFuel (0.25);
  };
};

placeReward = {
  rewardBox addItemCargoGlobal ["AM_BCap",4];
  [busMan, thankYouAction] remoteExec ["addAction",0,true];
};

thankYouAction = ["Thanks!", {
      _longString = "<t color='#777777' size='1'>You saved my bacon there, I don't want to think about what would have happened had I driven while this dizzy.</t>";
      [_longString] call storyText;
},[],2.5,true,true,"","true",10,false,"",""];

//WINERY

tourGuide addAction ["Are you my noon tour?", {
      _longString = "<t color='#777777' size='1'>Thought you guys took a rain check. Also thought there were only two of you? No matter, we barely get anyone around here anyway. Let me know when you want to start.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

tourGuide addAction ["Go on the tour", {
      _longString = "<t color='#777777' size='1'>Excellent, we'll head for the vineyard right away.</t>";
      [_longString] call storyText;
      _tourStart = (group tourGuide) addWaypoint [getMarkerPos "tour", -1];
      _tourStart setWaypointType "MOVE";
      [tourguide] remoteExec ["removeAllActions", 0, true];
},[],1.5,true,true,"","true",10,false,"",""];

//BROTHERHOOD BASE
//terminalFront, terminalLibrary, terminalEngineering, terminalComms, terminalOfficer, terminalIntel

terminalFront addAction ["ALERT - ALL HANDS FULL MUSTER", {
      _longString = "<t color='#22aa22' size='1'>ALL HANDS IMMEDIATELY DON BATTLE GEAR AND REPORT TOPSIDE FOR BRIEFING</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalFront addAction ["Standing Orders", {
      _longString = "<t color='#22aa22' size='1'>Civilians are to be allowed in the bunker's atrium. Please listen to whatever they want to say, but do not let them past the front door and your guard post. Forward interesting petitions to your Senior, but be descerning.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalLibrary addAction ["ALERT - ALL HANDS FULL MUSTER", {
      _longString = "<t color='#22aa22' size='1'>ALL HANDS IMMEDIATELY DON BATTLE GEAR AND REPORT TOPSIDE FOR BRIEFING</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalLibrary addAction ["[120 TABS OPEN]", {
      _longString = "<t color='#22aa22' size='1'>The tabs all concern various pathogens and known interactions between them. Of particular interest in many tabs is an 'FEV.'</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalEngineering addAction ["ALERT - ALL HANDS FULL MUSTER", {
      _longString = "<t color='#22aa22' size='1'>ALL HANDS IMMEDIATELY DON BATTLE GEAR AND REPORT TOPSIDE FOR BRIEFING</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalEngineering addAction ["General Notice", {
      _longString = "<t color='#22aa22' size='1'>Something has command spooked. New orders for the Knights are to expedite construction and repairs of transport vehicles.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalComms addAction ["ALERT - ALL HANDS FULL MUSTER", {
      _longString = "<t color='#22aa22' size='1'>ALL HANDS IMMEDIATELY DON BATTLE GEAR AND REPORT TOPSIDE FOR BRIEFING</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalComms addAction ["Scouting Report Concerning Restoration of Rail", {
      _longString = "<t color='#22aa22' size='1'>The situation has resolved itself against our favor. Representatives from the Swarf Gang were hospitable to our restoration plans but were attacked during negotiations. Survivors seem unlikely but status is unknown. Scribes in charge of negotiations briefly captured by hostile mercenary force.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalOfficer addAction ["ALERT - ALL HANDS FULL MUSTER", {
      _longString = "<t color='#22aa22' size='1'>ALL HANDS IMMEDIATELY DON BATTLE GEAR AND REPORT TOPSIDE FOR BRIEFING</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalOfficer addAction ["Omega Level Intervention Authorization", {
      _longString = "<t color='#22aa22' size='1'>Authorized in full. Our core mission is at stake and the tenets of our organization are to be tested. The Brotherhood marches to war. Ad Victoriam. -Elder Patrocolus</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalIntel addAction ["ALERT - ALL HANDS FULL MUSTER", {
      _longString = "<t color='#22aa22' size='1'>ALL HANDS IMMEDIATELY DON BATTLE GEAR AND REPORT TOPSIDE FOR BRIEFING</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalIntel addAction ["Potential Omega Level Event", {
      _longString = "<t color='#22aa22' size='1'>Super Mutant populations have risen dramatically within Canadian sector 228. Cause is unknown but SIGINT and scans of the area confirm overwhelming presence. Other sources have been entirely destroyed. Estimated time until they reach the bunker is days. Recommend intervention at all costs.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminalIntel addAction ["Evacuation Plans", {
      _longString = "<t color='#22aa22' size='1'>Mass civilian evacuation will be impossible considering loss of Swarf Gang vehiclular assets. Direct intervention necessary to spare civilian casualties.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

/*

canadianOfficer addAction ["Anything new?", {
      _longString = "<t color='#777777' size='1'>Indeed. We recieved an SOS over radio from somewhere inside the city. If you're going in there, check high places. Signal reaches further the higher you are.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

canadianOfficer addAction ["Hello!", {
      _longString = "<t color='#777777' size='1'>Major Fannar. Doubt you want the serial number and I doubt I should say anything else. Command has... appraised us of your situation. Behave.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

canadianOfficer addAction ["What are you doing?", {
      _longString = "<t color='#777777' size='1'> We're forward scouts. I intend to eventually seige the gangsters. Their base is on an island. Take out the bridges, surround them, and starve them out.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

canadianOfficer addAction ["Can we help?", {
      _longString = "<t color='#777777' size='1'>Doubtful... but we have extra explosives. If you're going to get captured or killed, pretend you're us. The gang'll think they took care of the threat and lower their guard.</t>";
      [_longString] call storyText;
      [] call askedToHelp;
},[],1.5,true,true,"","true",10,false,"",""];

askedToHelp = {
  canadianOfficer addAction ["Where are the explosives?", {
        _longString = "<t color='#777777' size='1'>Northwest bunker.</t>";
        [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];
  canadianOfficer addAction ["How do I use the explosives?", {
        _longString = "<t color='#777777' size='1'>Carry the box to the bridge, light the fuse, and run. Make sure you're within 6 meters of the exact mark on the map.</t>";
        [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];
};

canadianOfficer addAction ["Can I have a map?", {
      _longString = "<t color='#777777' size='1'>I suppose. It'd be real nice of you to return them when you're done. Especially because they contain vital intel like the location of our outposts.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

canadianOfficer addAction ["Good loot around?", {
      _longString = "<t color='#777777' size='1'>No. The Swarf are notorious scavengers and have picked this area clean. We checked. They often convoy elsewhere for materials.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

canadianOfficer addAction ["Advice?", {
      _longString = "<t color='#777777' size='1'>Stay put? Don't do anything? No? Fine. If you're going onto the island, be prepared for CQC and urban fighting. It's better than a mounted 50 cal shooting at you in the flat terrain surrounding the island. Watch for patrols near the water. Best ingress is the north bridge. Has better cover.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

canadianOfficer addAction ["Like our ride?", {
      _longString = "<t color='#777777' size='1'>The vertibird? Not a fan. We have powerful enemies who use them. I hope that bird's stolen. Keep in mind the gang favors vehicle mounted heavy machine guns, so try not to get shot down. We wont come to your rescue.</t>";
      [_longString] call storyText;
      [] call askedVert;
},[],1.5,true,true,"","true",10,false,"",""];

askedVert = {
  canadianOfficer addAction ["Powerful enemies?", {
        _longString = "<t color='#777777' size='1'>That's on a need to know basis and outside of this theater.</t>";
        [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];
};

bloop addAction ["Assorted Blueprints and Technical Diagrams", {
      _longString = "<t color='#777777' size='1'>The diagrams are mostly above your head, but in shaky handwriting one has a note that reads: 'Train good? Car bad?'</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

interrogations addAction ["Examine Papers", {
      _longString = "<t color='#777777' size='1'>The papers are dictations of interrogations: the only detail of note being one of the prisoners is called a 'Brotherhood scribe.' </t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

broDude addAction ["What's up?", {
      _longString = "<t color='#777777' size='1'>A few wounded after a bad ambush. We recovered who we could, but we still have 2 unaccounted for. I hope the scouts turn up something.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

hostage01 addAction ["Examine", {
      _longString = "<t color='#777777' size='1'>The, visibly confused, hostage maintains his composure and refuses to speak.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

eradio addAction ["Examine", {
      _longString = "<t color='#777777' size='1'>Looks like a radio, tuned to the Canadian's emergency frequency, and a corpse.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

canadaHostage addAction ["Examine", {
      _longString = "<t color='#777777' size='1'>He's still in shock and not fully coherent, but keeps mentioning another group of American prisoners at the Swarf Gang's HQ.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","alive canadaHostage",10,false,"",""];

logiOfficer addAction ["Say Hi", {
      _longString = "<t color='#777777' size='1'>Don't talk to me and don't touch anything. I don't get to sleep tonight because someone needed a rush delivery on these mortars.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","alive canadaHostage",10,false,"",""];


*/
