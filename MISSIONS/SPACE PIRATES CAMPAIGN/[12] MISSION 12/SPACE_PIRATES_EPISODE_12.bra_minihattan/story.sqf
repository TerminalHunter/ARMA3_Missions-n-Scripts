storyText = {
  params ["_text"];
  titleText [_text,"PLAIN DOWN",2.5,true,true];
};

veryImportantStoryText = {
  params ["_text"];
  titleText ["<t color='#ff0000' size='5'><br/><br/>" + _text + "</t>", "PLAIN", -1, true, true];
};

veryImportantGOODStoryText = {
  params ["_text"];
  titleText ["<t color='#00ff00' size='5'><br/><br/>" + _text + "</t>", "PLAIN", -1, true, true];
};

SENPAIStoryText = {
  //params ["_text"];
  //titleText ["<t color='#ff0000' size='5' font='LucidaConsoleB'>" + _text + "</t>", "PLAIN", -1, true, true];
  ["<t color='#ff0000' size='2' font='LucidaConsoleB'>CATASTROPHIC ENTROPIC ERROR<br/><br/>YOUR SHATTERED SOUL IS TO BE VOID</t>",-1,0.1,6,1,0,789] spawn BIS_fnc_dynamicText;
};

/*

TERMINAL EXAMPLE

baseComputer addAction ["Contact NCR HQ", {
      _longString = "<t color='#22aa22' size='1'>UPLINK SIGNAL DEGRADED: TRY AGAIN LATER.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

terminal = #22aa22

STORY IMPORTANT EXAMPLE

dude07 addAction ["Why did you stay behind?", {
      _longString = "<t color='#aaaa22' size='1'>...</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

story/non-dialogue = #aaaa22

DIALOGUE EXAMPLE

donny addAction ["Why did you stay behind?", {
      _longString = "<t color='#777777' size='1'>Hey. Hey. C'mere a bit. Lemme tell you a secret. Donny's still got a knuckle on the right ring toe. I should be half-a-toe donny. Hehe. Heh.</t>";
      [_longString] call storyText;
},[],1.5,true,true,"","true",10,false,"",""];

dialogue = #777777

SECRET RADIO EXAMPLE

secretRadio11 addAction ["SECRET RADIO #11", {
  playSound3D ["Hyperborea_Music\BlastRadius\StepOnMyFace.ogg", secretRadio11];
  removeAllActions secretRadio11;
},[],1.5,true,true,"","true",10,false,"",""];

secretRadioEND addAction ["SECRET RADIO #FINALE", {
  playSound3D [getMissionPath "HyperboreaFinale.ogg", secretRadioEND];
  removeAllActions secretRadioEND;
},[],1.5,true,true,"","true",10,false,"",""];

*/
