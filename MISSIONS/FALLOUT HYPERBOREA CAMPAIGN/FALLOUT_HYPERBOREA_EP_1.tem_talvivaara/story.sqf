//SPOILERINOS AHEAD!
//YOU PROBABLY SHOULDN'T BE READING THIS

//since it's hard to see the gridrefs on the editor, location references are using battleship notation -- letters for X values and numbers for Y.
//A1 is the top left corner of the map. P16 is the bottom right.

loadStory = {

  //story corpses need to be excluded from garbage collection

  removeFromRemainsCollector [maybeKillDave, dumbInitiate, lostMan];

  //END GAME

  // end game base canada
  // E - 6

  domBaseIntel addAction ["Intelligence Documents", {
      _longString = "<t color='#777777' size='1'>FREE DOMINION OUTPOST 32A - ORDERS. MAINTAIN PRESENCE AND SCOUTING IN ASSIGNED REGION. SIGINT SUGGESTS HIGH-TECH THREAT ENCROACHING ONTO CANADIAN TERRITORY. IDENTIFIED AS BROTHERHOOD OF STEEL MONTANA CHAPTER. MONTANA NOMENCLATURE SUGGESTS AMERICAN ASSET. ON PID: CONTACT HQ FOR IMMEDIATE BACKUP. IF ABLE: TERMINATE ON SIGHT. AS PER PREVIOUS INQUIRY RE EXPLOSIONS EAST AND RETREATING GANG: AWAY TEAM DISPATCHED TO FOLLOW GANG RETREAT TO FACTORY - COORDINATES ATTACHED. IF CONTACTED BY AWAY TEAM - PROVIDE ASSISTANCE.</t>";
      [_longString] call storyText;
      sleep 30;
      _secondString = "<t color='#aaaa22' size='1'>SWARF GANG FACTORY COORDINATES FOUND. MISSION 02 UNLOCKED.</t>";
      [_secondString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //end game base khans
  // O - 2

  noToesDonny addAction ["No-Toes Donny's Diary", {
      _longString = "<t color='#777777' size='1'>Nobody believes me because of the Jet. I saw what I seen. A huge bird, the Roc! She's nestling in the Stormy Mountains. I climbed to the highest mountain on the map -- far to the west past the roads that nobody uses. It was there I saw her! Nobody wants to go with me to get the Roc eggs. Toothy's wrong! It ain't no Vertibird, it's bigger. Besides, no vertibirds go this far north and they don't lay eggs. Traipsing Tommy ain't never seen a vertibird anyhow.</t>";
      [_longString] call storyText;
      //sleep 30;
      //_secondString = "<t color='#aaaa22' size='1'>MOUNTAIN BASE COORDINATES FOUND. MISSION 03 UNLOCKED.</t>";
      //[_secondString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  // end game mountain radio tower
  // A - 1

  finalTerminal addAction ["Information", {
      _secondString = "<t color='#22aa22' size='1'>WARNING: UNAUTHORIZED USE OR TAMPERING WITH THIS COMMUNICATIONS DEVICE IS A CLASS 2 FELONY UNDER 18 U.S. CODE § 2381.This device is a communications platform constructed in 2072 under US Department of Defense Operation LOCUST and Operation NEW PONY EXPRESS.</t>";
      [_secondString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  finalTerminal addAction ["Query Telecontrol Uplink Location", {
      _secondString = "<t color='#aaaa22' size='1'>MOUNTAIN BASE COORDINATES FOUND. MISSION 03 UNLOCKED.</t>";
      [_secondString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  finalTerminal attachTo [terminalCabinet];

  //first story beat is just telling the players to find what happened to the previous Wendigo Company
  //maybe put that into the tutorial video. It didn't make it into the tutorial video.
  //player base is in F14

  //second storybeat is the computer in the command tent - be explicit about old maps calling it Alakyla -- somewhere nearby, not exactly on the mark
  //F14
  baseComputer addAction ["RADIO UPLINK TO NCR HQ", {
      _longString = "<t color='#22aa22' size='1'>UPLOAD IN PROGRESS...</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseComputer addAction ["LIST OF FUCKERS", {
      _longString = "<t color='#22aa22' size='1'>1. Viking fucks. They hate us because of something the boys back home did. Full of drugs. 2. The other army. They keep attacking us saying we're on their land. Our army is bigger. 3. Cannibal fuck faces. Wear hockey masks. Eat people. Fuck 'em. 4. Double chump gangsters. Always wearing sun glasses. Like to play with cars. 5. Blindfolded scary fucks. Creepy people who live on the ice. Just shoot them. </t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseComputer addAction ["COMMAND LOG 12/03/2282", {
      _longString = "<t color='#22aa22' size='1'>Stupid, shitty, maps. If the dumbasses ask: the food isn't at Alakyla. It's NEAR Alakyla. Follow the road to the crotch. Half of the shit on this map isn't there. Or just ask Kill-Dave. He knows where it is and is pretty good at bringing back extra.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseComputer addAction ["COMMAND LOG 12/26/2282", {
      _longString = "<t color='#22aa22' size='1'>Merry Christmas everyone! I dunno what the locals were bringing in a ton of sheet metal for, but it's ours now. Made a good barrier for the HQ. Had to shoot a few of the gangsters intruding on our turf, which was fun. This winter's looking pretty good, actually. Might make the frostbite worth it.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseComputer addAction ["COMMAND LOG 01/09/2283", {
      _longString = "<t color='#22aa22' size='1'>Some NCR chucklefuck claiming to be from command had the nerve to chew me out for our methods of surviving out here. They say 'don't call it tribute' but I say to them we're Rangers and we do what we want. I'm going to stop returning their calls. </t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseComputer addAction ["COMMAND LOG 02/23/2283", {
      _longString = "<t color='#22aa22' size='1'>More shooting than usual around base today. I gave Kill-Dave a gun and told him to quiet down the locals yesterday and he iy68m</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //second major story beat is at the destroyed village near Alakyla
  //H13

  scragglyNote addAction ["Scraggly Note", {
      _longString = "<t color='#777777' size='1'>You know what you need to do. Shoot a flare if you need help. We don't see eye-to-eye on things, but we ain't as bad as they are. Better under our rules than theirs. Invite's always open if you want to feel the wind in your hair. -The Swarf</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  alaBook addAction ["Herbalist's Book", {
      _longString = "<t color='#777777' size='1'> Our new neighbors have made foraging to the west difficult. Best to avoid those forests for now. East is a good bet, as there's nice hidden valleys up there with plenty to find if you don't mind the hike. Keep an eye on the coast and DO NOT go past the second lighthouse to the east. The crazies should keep to the ice and the shore, but don't take any more risks than you need to.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  alaLetter addAction ["Letter", {
      _longString = "<t color='#777777' size='1'> If you're going up north to join that gang, know that you will not have a home to return to. Shiny cars and loose women aren't worth abandoning your family. Make the right choice.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //further up north in a destroyed church is the third story beat
  //H11

  recruiterStuff addAction ["Strange Instructions", {
      _longString = "<t color='#777777' size='1'>Step 1. Seperate them - have them come to you. Alone. Dazzle them with the castle (if Tim isn't grumpy) or a car (if someone's parked here). Step 2. Make em do something stupid, like taking a mine from one of the blind freaks. If they're tough and dumb enough to do it, they're in. Tell 'em where our garages are. If they find the farms or the khans, they've gone too far north. Oh, and step 3: charge 'em for the pleasure.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  recruiterNote addAction ["Stranger Instructions", {
      _longString = "<t color='#777777' size='1'> YOU ARE OFFICIALLY ON NOTICE. WE'RE NOT CALLED THE SWARF. JUST SWARF. SWARF GANG. SWARF GROUP. SWARF CORP. NO THE. STOP PUTTING A THE IN FRONT OF IT. If one more recruit asks me who the swarf is I'm going to shoot you.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //recruiterSafe addItemCargoGlobal ["AM_BCap100",1];
  //recruiterSafe addItemCargoGlobal ["AM_BCap",4];

  //in a nearby castle with gasoline
  //G11

  mechNotepad addAction ["Badly Written Notes", {
      _longString = "<t color='#777777' size='1'>Keep an eye out for flares. Tell anyone parked here where they were lit. Fix up the swarf gang things. Trust nobody in a uniform. Grab dank kush from the Khan living up north.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //mechBox addItemCargoGlobal ["AM_turpentine",6];
  //mechBox addItemCargoGlobal ["AM_9battery",2];
  //mechBox addItemCargoGlobal ["AM_FixTh",2];
  //mechBox addItemCargoGlobal ["AM_scrapelectronics",2];

/*
  //This one's been found. Re-added. Put it in the new base. And unreadded since the second was found.
  [gasBarrel01,true,[-0.5,0.75,0]] call ace_dragging_fnc_setDraggable;

  gasBarrel01 addAction ["Check Barrels", {
      _longString = "<t color='#aaaa22' size='1'>This fuel is still good. You could bring it back to base and increase our fuel rations.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];
*/

  //path scout - east of first town
  // I-13

  pathScout addAction ["Scout's Notes", {
      _longString = "<t color='#777777' size='1'>Keep an eye on the lighthouse. Blinking means Barry's seen something and needs help. Solid with occasional blinks means send someone to get his report or bring a snack. Notes for gatherers: avoid castles and ruins. Don't go too far north. If you have to go north, avoid roads. Try and teach people what a motor sounds like. Don't go too far east. Don't go too far west. I feel like we're boxed in here.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //first lighthouse
  // I - 14

  scoutNotes addAction ["Scouting Report", {
      _longString = "<t color='#777777' size='1'> 1. Strange men in blindfolds keep doing things out on the ice. 2. Two different government types keep tresspassing around here. One straight west, undisciplined rabble. Another far to the north east. Keep to themselves. 3. A lot of fucking snow.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //weed shack
  // G - 9
  weedShack addAction ["Dank-Smelling Notes", {
      _longString = "<t color='#777777' size='1'>Good news: No-Toes Donny was right. Primo bud just growing out in the wild. Bad news: It's near the crazy Canucks and I had to talk to No-Toes Donny. I swear, if he laid off the jet and stopped talking about magical sky birds he'd be a decent person. I'll pick what I can and hike another, what... maybe 10km back to base? How do you get high enough to wander 10km from base? Why did we build it on top of a goddadmn hill.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //weedCrate addItemCargoGlobal ["murshun_cigs_cigpack",12];

  // dominion outpost
  // G - 10

  domScoutReport addAction ["CIVILIAN SCOUTING REPORT", {
      _longString = "<t color='#777777' size='1'> CIVILIAN CITIES LOCATED AT SECTOR L 4 AND SECTOR H 13. MAINTAIN DISTANCE. LOCAL CIVILIAN POPULATION HAS UNEASY ALLIANCE WITH LOCAL GANG. RECENT VIOLENCE HAS CREATED REFUGEES HEADING FROM SOUTH TO NORTH. IF CIVILIANS ENCOUNTERED UNACCOMPANIED BY GANG MEMBERS - MAINTAIN GOOD RELATIONS AND DIRECT TO BASE AT SECTOR E 6.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  domScoutReport addAction ["HOSTILE SCOUTING REPORT A", {
      _longString = "<t color='#777777' size='1'>(A) LOCAL GANG IS HOSTILE TOWARDS FREE DOMINION FORCES. MAINTAINS PRESENCE AT FORTIFIED HISTORICAL SITES. OUTPOST AT HISTORICAL SITE KAKOLA RECENTLY LIBERATED. MAINTAIN PATROLS AND WATCH FOR VEHICULAR REINFORCEMENT AND CONSTRUCTION EFFORTS.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  domScoutReport addAction ["HOSTILE SCOUTING REPORT B", {
      _longString = "<t color='#777777' size='1'>(B) SECONDARY GANG IS NEUTRAL TOWARDS FREE DOMINION FORCES AND MAINTAINS ALLIANCE WITH HOSTILE GANG. SECONDARY GANG DISTRIBUTES CHEMS AND RISKS DETERIORATING FREE DOMINION FORCES COMBAT EFFECTIVENESS.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  domScoutReport addAction ["HOSTILE SCOUTING REPORT C", {
      _longString = "<t color='#777777' size='1'>(C) HOSTILE PARAMILITARY AT SECTOR F 14 HAS NOT BEEN SPOTTED FOR >1 WEEK. INVESTIGATE AT YOUR OWN DISCRETION.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //lost man
  // G - 10

  lostNotes addAction ["Hasty Instructions with two different handwriting styles", {
      _longString = "<t color='#777777' size='1'>If you get lost, follow the eastern coast north until you find a ship. Then head to the big hill west. WHAT ARE COMPASS? NORTH?? EASTERN?? WEST?? I FIND E.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //airport base

  smut addAction ["Various Documents?", {
      _longString = "<t color='#aaaa22' size='1'>This is just a pile of dirty magazines. You think better of yourself and put them back.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseDocument01 addAction ["HOSTILE SCOUTING REPORT A", {
      _longString = "<t color='#777777' size='1'>(A) LOCAL GANG IS HOSTILE TOWARDS FREE DOMINION FORCES. MAINTAINS PRESENCE AT FORTIFIED HISTORICAL SITES. OUTPOST AT HISTORICAL SITE KAKOLA RECENTLY LIBERATED. MAINTAIN PATROLS AND WATCH FOR VEHICULAR REINFORCEMENT AND CONSTRUCTION EFFORTS.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseDocument02 addAction ["HOSTILE SCOUTING REPORT B", {
      _longString = "<t color='#777777' size='1'>(B) SECONDARY GANG IS NEUTRAL TOWARDS FREE DOMINION FORCES AND MAINTAINS ALLIANCE WITH HOSTILE GANG. SECONDARY GANG DISTRIBUTES CHEMS AND RISKS DETERIORATING FREE DOMINION FORCES COMBAT EFFECTIVENESS.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseDocument03 addAction ["HOSTILE SCOUTING REPORT C", {
      _longString = "<t color='#777777' size='1'>(C) HOSTILE PARAMILITARY AT SECTOR F 14 HAS NOT BEEN SPOTTED FOR >1 WEEK. INVESTIGATE AT YOUR OWN DISCRETION.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseDocument04 addAction ["CIVILIAN SCOUTING REPORT", {
      _longString = "<t color='#777777' size='1'> CIVILIAN CITIES LOCATED AT SECTOR L 4 AND SECTOR H 13. MAINTAIN DISTANCE. LOCAL CIVILIAN POPULATION HAS UNEASY ALLIANCE WITH LOCAL GANG. RECENT VIOLENCE HAS CREATED REFUGEES HEADING FROM SOUTH TO NORTH. IF CIVILIANS ENCOUNTERED UNACCOMPANIED BY GANG MEMBERS - MAINTAIN GOOD RELATIONS AND DIRECT TO BASE AT SECTOR E 6.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  baseDocument05 addAction ["Memo To Self", {
      _longString = "<t color='#777777' size='1'>To do list: 1) Find/Scavenge new socks. 2) Bum jet off of a Khan. 3) Call? Radio? Write? Mother.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //garage area on the top of the hill
  dogTags addAction ["Bag of NCR Dogtags", {
      _longString = "<t color='#aaaa22' size='1'>Ranger Clytus, Ranger Troger, Ranger Loverick, Ranger... Davos? But it's scratched out and the word 'Kill' is etched in its place. Some of these names are the Rangers you're looking for, but there's more names here than your original mission described.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  burnThisNote addAction ["Hey, jackass, for once you can play with fire", {
      _longString = "<t color='#777777' size='1'>Burn anything that mentions the factory. The uniformed jackasses have been asking around looking for our main base and shot up everyone at Kakola who refused to tell them. Shoot anyone who talks to someone in a uniform. Shoot anyone with a uniform.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  //the village person

  villagePerson addAction ["Say Hello Once More", {
      _longString = "<t color='#777777' size='1'>Well, Mary-Beth is rather happy one of her rugs sold. Raiders and soldiers usually never buy anything domestic like that.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  villagePerson addAction ["Ask about missing comrades", {
      _longString = "<t color='#777777' size='1'>Your predecesors weren't exactly welcoming folk. Imagine those that survived got run off. For all of our sakes, consider them dead and let them freeze in the wilderness or wherever they're hiding.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  villagePerson addAction ["Ask about life", {
      _longString = "<t color='#777777' size='1'>What? Me? Not all that much to say. Pretty sure I feed anyone living around here who isn't party of some invading army. Winter's been harsh and the crossbreeding program almost made a frost-proof plant, but needs some time. We've got plenty stored for the year, but extra is always welcome to bribe off hungry raiders.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  villagePerson addAction ["Ask about Viking Fucks", {
      _longString = "<t color='#777777' size='1'>Oh the horned helmets. You're talking about the Khans. They moved in fairly recently, main camp somewhere to the north of here. Seems like they got driven off their lands. Decent neighbors if you're used to drug-addled trigger-happy invalids wandering around your town. And we're used to that around here. They trade decent medicine along with the drugs, so a mixed blessing at best.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  villagePerson addAction ["Ask about Other Army", {
      _longString = "<t color='#777777' size='1'>Some gang probably raided an old-world armory and think they own the place. Keep talking about Canada, which I think is some Old World country nobody cares about anymore. Excepting, of course, them lot.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  villagePerson addAction ["Ask about Cannibals", {
      _longString = "<t color='#777777' size='1'>What is there to say? Fuck 'em. Don't go west.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  villagePerson addAction ["Ask about Sunglasses Gang", {
      _longString = "<t color='#777777' size='1'>The Swarf Gang? Yeah, decent folk if a bit eccentric. Love their cars. Only group of people that haven't bothered us all that much. Much of the gang's local folk. Guess it's as close to a standing army as one can ask for around here. Trade fairly, keep out the worst of it, allow us some measure of peace.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  villagePerson addAction ["Ask about Cult", {
      _longString = "<t color='#777777' size='1'>What is there to say? Fuck 'em. Don't go east or south.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  villagePerson addAction ["Ask about Nets", {
      _longString = "<t color='#777777' size='1'>Wind screens. Ambient temperature is already a pain, but the winter burn will dry any plant right out. Also they're a bitch to weave together so don't go touching them.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  farmTractor addAction ["The nearby man says: 'Could you maybe not there chief?'", {
      _longString = "<t color='#777777' size='1'>Get your leering lusty eyes off my tractor. She's a working girl and too tired for your shenanigans.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  // KAKOLA

  domScoutReport_1 addAction ["CIVILIAN SCOUTING REPORT", {
      _longString = "<t color='#777777' size='1'> CIVILIAN CITIES LOCATED AT SECTOR L 4 AND SECTOR H 13. MAINTAIN DISTANCE. LOCAL CIVILIAN POPULATION HAS UNEASY ALLIANCE WITH LOCAL GANG. RECENT VIOLENCE HAS CREATED REFUGEES HEADING FROM SOUTH TO NORTH. IF CIVILIANS ENCOUNTERED UNACCOMPANIED BY GANG MEMBERS - MAINTAIN GOOD RELATIONS AND DIRECT TO BASE AT SECTOR E 6.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  domScoutReport_1 addAction ["HOSTILE SCOUTING REPORT A", {
      _longString = "<t color='#777777' size='1'>(A) LOCAL GANG IS HOSTILE TOWARDS FREE DOMINION FORCES. MAINTAINS PRESENCE AT FORTIFIED HISTORICAL SITES. OUTPOST AT HISTORICAL SITE KAKOLA RECENTLY LIBERATED. MAINTAIN PATROLS AND WATCH FOR VEHICULAR REINFORCEMENT AND CONSTRUCTION EFFORTS.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  domScoutReport_1 addAction ["HOSTILE SCOUTING REPORT B", {
      _longString = "<t color='#777777' size='1'>(B) SECONDARY GANG IS NEUTRAL TOWARDS FREE DOMINION FORCES AND MAINTAINS ALLIANCE WITH HOSTILE GANG. SECONDARY GANG DISTRIBUTES CHEMS AND RISKS DETERIORATING FREE DOMINION FORCES COMBAT EFFECTIVENESS.</t>";
      [_longString] call storyText;
  },[],1.5,true,true,"","true",10,false,"",""];

  domScoutReport_1 addAction ["HOSTILE SCOUTING REPORT C", {
      _longString = "<t color='#777777' size='1'>(C) HOSTILE PARAMILITARY AT SECTOR F 14 HAS NOT BEEN SPOTTED FOR >1 WEEK. INVESTIGATE AT YOUR OWN DISCRETION.</t>";
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

  //hide ode to a werewolf near cult

};

storyText = {
  params ["_text"];
  titleText [_text,"PLAIN DOWN",2.5,true,true];
};

/*

START DATE IS MARCH 11th - 2283



heard some more explosions than usual - the boys are probably at it again

written text should be
<t color='#777777' size='1'>

and terminal text
<t color='#22aa22' size='1'>

thought text or other text should be
<t color='#aaaa22' size='1'> </t>

titleText ["Show this text", "PLAIN DOWN", 2, true, true];
_longString = "<t color='#22ff22' size='1'>LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.LET'S PUT A WHOLE BUNCH OF TEXT IN HERE HOLY SHIT MY DUDES.</t>";

civilian test thing

_this setUnitLoadout (selectRandom [(getUnitLoadout "CUP_C_R_Villager_01"),(getUnitLoadout "CUP_C_R_Villager_04"),(getUnitLoadout "CUP_C_R_Woodlander_04"),(getUnitLoadout "CUP_C_R_Worker_04"),(getUnitLoadout "CUP_C_R_Worker_03"),(getUnitLoadout "CUP_C_R_Worker_02"),(getUnitLoadout "CUP_C_R_Worker_01"),(getUnitLoadout "republican_02_body"),(getUnitLoadout "republican_01_body"),(getUnitLoadout "republican_04_body")]);

Step 1. Seperate them - have them come to you. Alone. Step 2. Make em do something stupid, like taking a mine from one of the blind freaks. If they're tough and dumb enough to do those two things, they're in. Tell 'em where our garage is. If they find the farms or the khans, they've gone too far north.

YOU ARE OFFICIALLY ON NOTICE. WE'RE NOT CALLED THE SWARF. JUST SWARF. SWARF GANG. SWARF GROUP. SWARF CORP. NO THE. STOP PUTTING A THE IN FRONT OF IT. If one more recruit asks me who the swarf is I'm going to shoot you.

*/
