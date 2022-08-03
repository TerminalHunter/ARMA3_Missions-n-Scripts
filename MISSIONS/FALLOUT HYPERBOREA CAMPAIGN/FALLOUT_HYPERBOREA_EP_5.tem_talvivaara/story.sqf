storyText = {
  params ["_text"];
  titleText [_text,"PLAIN DOWN",2.5,true,true];
};

decNews addAction ["NOVEMBER 2281: TRAITOR HANLON DEAD BY SUICIDE. RANGERS DISGRACED.", {
      _longString = "<t color='#777777' size='1'>Senate implicates NCR Rangers in mass conspiracy to surrender to the Legion and murder our service members. An independent investigation is thought to have lead to Chief Ranger Hanlon's suicide. [continued on 3a]</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

decNews addAction ["This paper is 7 months old.", {
      _longString = "<t color='#777777' size='1'>Better late than never.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

febNews addAction ["FEBURARY 2282: DAM BLOODY 3-WAY. PYRRHIC VICTORY FOR THE REPUBLIC.", {
      _longString = "<t color='#777777' size='1'>The Dam stands as a tombstone. A concrete edifice covered in corpses and wreckage. A survivor we interviewed tells of robotic army gone haywire complicating an otherwise routine battle. [continued on 2c]</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

febNews addAction ["This paper is 4 months old.", {
      _longString = "<t color='#777777' size='1'>You are surprised these papers made it this far north.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

//EMBASSY STORY BITS

baseComputer addAction ["Contact NCR HQ", {
      _longString = "<t color='#22aa22' size='1'>UPLINK SIGNAL DEGRADED: TRY AGAIN LATER.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

//VILLAGER DIALOGUE

chiefRonald addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>Well, I have to protect my work here. Finally got something to fruit and it needs another month till it seeds. I make it out of here with those seeds, entire generations could feed themselves despite the cold. The legacy's worth it alone.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

villagerConstantine addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>Seems I cheated death once, wanted to play it fair this time. And maybe pay someone back for the swank suit.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

villagerConstantine addAction ["Where did you get that gun?", {
      _longString = "<t color='#777777' size='1'>Old gang caches still hold a suprise every now and then. With the gang gone, figured I'd cash out all of them.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

rescuedSwarf addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>Well back at the factory I didn't have a choice, I was unconscious. But after killing off our gang you rescued me and dropped me off here. I don't get you. One of our mechies and his lady talk sense into you? Fuck if I even want to know.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

rescuedSwarf2 addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>I don't trust you with a real answer. I'm here because my boys are here.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

secretSwarf addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>I live here. You didn't kill all of us, jackass. Least not yet, anyway. Fuck off.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

dude01 addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>I have the worst luck. Didn't want to take my chances on something new. Leaving would guarantee I'd mess up everything for those getting out of here. Better to stay and fuck it up for fewer.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

dude02 addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>Rest of the wasteland is fucked. I've travelled enough to know. I can die a violent death anywhere these days. This is as good of a place as any to die and you get the added bonus of a picturesque landscape.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

dude03 addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>Honestly? Just want to kill things. Can't be happier than that moment, breath held, about to plow a round right through something's skull and end them.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

dude04 addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>Owed someone important money. Said we'd be square if he had something to come back to. Think they just wanted to be rid of me, but it was already hard to look them in the face day after day.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

dude05 addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>Someone has to. Time's an expensive thing to buy.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

dude06 addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>I've always guarded this village. Know every nook and cranny. Don't know how to do anything else. Don't want to do anything else.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

dude07 addAction ["Why did you stay behind?", {
      _longString = "<t color='#aaaa22' size='1'>...</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

donny addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>Hey. Hey. C'mere a bit. Lemme tell you a secret. Donny's still got a knuckle on the right ring toe. I should be half-a-toe donny. Hehe. Heh.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

//SECRET RADIOS

  secretRadio01 addAction ["SECRET RADIO #01", {
    playSound3D ["Hyperborea_Music\BlastRadius\NuclearLove.ogg", secretRadio01];
    removeAllActions secretRadio01;
  },[],1.5,true,true,"","true",10,false,"",""];
  secretRadio01 addAction ["'Nuclear Love' by Pepper Coyote", {
    playSound3D ["Hyperborea_Music\BlastRadius\NuclearLove.ogg", secretRadio01];
    removeAllActions secretRadio01;
  },[],1.5,true,true,"","true",10,false,"",""];

  secretRadio02 addAction ["SECRET RADIO #02", {
    playSound3D ["Hyperborea_Music\GenocidalHumanoidz.ogg", secretRadio02];
    removeAllActions secretRadio02;
  },[],1.5,true,true,"","true",10,false,"",""];
  secretRadio02 addAction ["'Genocidal Humanoidz' by System of a Down", {
    playSound3D ["Hyperborea_Music\GenocidalHumanoidz.ogg", secretRadio02];
    removeAllActions secretRadio02;
  },[],1.5,true,true,"","true",10,false,"",""];

  secretRadio03 addAction ["SECRET RADIO #03", {
    playSound3D ["Hyperborea_Music\BlastRadius\YoullNeedADuke.ogg", secretRadio03];
    removeAllActions secretRadio03;
  },[],1.5,true,true,"","true",10,false,"",""];

  secretRadio04 addAction ["SECRET RADIO #04", {
    playSound3D ["Hyperborea_Music\ProtectTheLand.ogg", secretRadio04];
    removeAllActions secretRadio04;
  },[],1.5,true,true,"","true",10,false,"",""];

  secretRadio06 addAction ["SECRET RADIO #06", {
    playSound3D ["Hyperborea_Music\BlastRadius\OneThing.ogg", secretRadio06];
    removeAllActions secretRadio06;
  },[],1.5,true,true,"","true",10,false,"",""];
  secretRadio06 addAction ["'One Thing' by Pepper Coyote", {
    playSound3D ["Hyperborea_Music\BlastRadius\OneThing.ogg", secretRadio06];
    removeAllActions secretRadio06;
  },[],1.5,true,true,"","true",10,false,"",""];

  secretRadio07 addAction ["SECRET RADIO #07", {
    playSound3D ["Hyperborea_Music\BlastRadius\BackEndBlues.ogg", secretRadio07];
    removeAllActions secretRadio07;
  },[],1.5,true,true,"","true",10,false,"",""];

  secretRadio08 addAction ["SECRET RADIO #08", {
    playSound3D ["Hyperborea_Music\BlastRadius\NoCockLikeHorseCock.ogg", secretRadio08];
    removeAllActions secretRadio08;
  },[],1.5,true,true,"","true",10,false,"",""];

  secretRadio09 addAction ["SECRET RADIO #09", {
    playSound3D ["Hyperborea_Music\BigColdWind.ogg", secretRadio09];
    removeAllActions secretRadio09;
  },[],1.5,true,true,"","true",10,false,"",""];

  secretRadio11 addAction ["SECRET RADIO #11", {
    playSound3D ["Hyperborea_Music\BlastRadius\StepOnMyFace.ogg", secretRadio11];
    removeAllActions secretRadio11;
  },[],1.5,true,true,"","true",10,false,"",""];
  secretRadio11 addAction ["'Step On My Face (And Tell Me That You Love Me)' by Pepper Coyote", {
    playSound3D ["Hyperborea_Music\BlastRadius\StepOnMyFace.ogg", secretRadio11];
    removeAllActions secretRadio11;
  },[],1.5,true,true,"","true",10,false,"",""];

secretRadioLAST addAction ["SECRET RADIO #20", {
  playSound3D [getMissionPath "EndOfTime.ogg", secretRadioLAST];
  removeAllActions secretRadioLAST;
},[],1.5,true,true,"","true",10,false,"",""];

secretRadioEND addAction ["SECRET RADIO #FINALE", {
  playSound3D [getMissionPath "HyperboreaFinale.ogg", secretRadioEND];
  removeAllActions secretRadioEND;
},[],1.5,true,true,"","true",10,false,"",""];
