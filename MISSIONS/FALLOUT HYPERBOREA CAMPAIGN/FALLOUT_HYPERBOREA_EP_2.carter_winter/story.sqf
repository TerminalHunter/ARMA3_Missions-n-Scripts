storyText = {
  params ["_text"];
  titleText [_text,"PLAIN DOWN",2.5,true,true];
};

secretRadio addAction ["SECRET RADIO #ILOSTCOUNT", {
  playSound3D ["Hyperborea_Music\ProcessMan.ogg", secretRadio];
  removeAllActions secretRadio;
},[],1.5,true,true,"","true",10,false,"",""];

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

setDate [2283,4,15,21,0];
