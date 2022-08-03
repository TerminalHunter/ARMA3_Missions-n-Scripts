//SPOILERINOS AHEAD!
//YOU PROBABLY SHOULDN'T BE READING THIS

loadStory = {

  //first story beat is just telling the players to find what happened to the previous Wendigo Company
  //maybe put that into the tutorial video

  //second storybeat is the computer in the command tent - be explicit about old maps calling it Alakyla -- somewhere nearby, not exactly on the mark
  baseComputer addAction ["RADIO UPLINK TO NCR HQ", {
      _longString = "<t color='#22aa22' size='1'>ERROR: HIGH UPLINK INTERFERENCE. TRY AGAIN LATER.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseComputer addAction ["COMMAND LOG 12/26/2282", {
      _longString = "<t color='#22aa22' size='1'>TEXT.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseComputer addAction ["COMMAND LOG 01/09/2283", {
      _longString = "<t color='#22aa22' size='1'>ERROR: UPLINK INTERFERENCE. TRY AGAIN LATER.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseComputer addAction ["COMMAND LOG 02/23/2283", {
      _longString = "<t color='#22aa22' size='1'>ERROR: UPLINK INTERFERENCE. TRY AGAIN LATER.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //jackShack1 addAction["Toggle Loadout Autosave",toggleLoadoutAutosave,[],1.5,true,true,"","true",10,false,"",""];

};

storyText = {
  params ["_text"];
  titleText [_text,"PLAIN DOWN",2.5,true,true];
};

/*

START DATE IS MARCH 11th - 2283



heard some more explosions than usual - the boys are probably at it again

written text should be maybe
<t color='#777777' size='1'>

and terminal text
<t color='#22aa22' size='1'>

titleText ["Show this text", "PLAIN DOWN", 2, true, true];
_longString = "<t color='#22ff22' size='1'>LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.</t>";

civilian test thing

_this setUnitLoadout (selectRandom [(getUnitLoadout "CUP_C_R_Villager_01"),(getUnitLoadout "CUP_C_R_Villager_04"),(getUnitLoadout "CUP_C_R_Woodlander_04"),(getUnitLoadout "CUP_C_R_Worker_04"),(getUnitLoadout "CUP_C_R_Worker_03"),(getUnitLoadout "CUP_C_R_Worker_02"),(getUnitLoadout "CUP_C_R_Worker_01"),(getUnitLoadout "republican_02_body"),(getUnitLoadout "republican_01_body"),(getUnitLoadout "republican_04_body")]);

*/
