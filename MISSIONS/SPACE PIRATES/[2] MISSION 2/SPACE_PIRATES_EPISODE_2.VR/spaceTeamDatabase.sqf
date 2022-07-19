//objective Terminals should have 3 states, signified by the icon displayed on the screen
// green - objective complete - check.paa, yellow - objective in progress - warn.paa, red - objective failed - failX.paa

objectiveTerminals = [
  statusScreen01,
  statusScreen02,
  statusScreen03,
  statusScreen04,
  statusScreen05,
  statusScreen06
];

//reminder: The directory sentences take the form of [LAST PART OF MASTER OBJECTIVE TABLE] + is + [MIDDLE SENTENCE HERE].
//EX: [The Muffin Button] is [lost behind the couch in the Rec Room].
//I'm calling tablets "interface screens" - so X is accessible via interface screen in the ROOM.
//NOTICE! There absolutely positively needs to be more objects than randomized objectives.
randomizedObjectiveObjects = [
  //lower hangar
  [lowerHangarTab,"accessible via interface screen in the Lower Hangar.",lowerHangarDirectory],
  [sensorArray,"attached to the sensor array in the Lower Hangar.",lowerHangarDirectory],
  //main hangar
  [hangarFabricator, "in a drawer under the weird machine with arms in the Main Hangar.", mainHangarDirectory],
  [cheesePile, "a thing that looks like a series of cylinders in the Main Hangar.", mainHangarDirectory],
  [repairDepot, "in a drawer near the small crane in the Main Hangar.", mainHangarDirectory],
  [mainHangarTab, "accessible via interface screen in the Main Hangar.", mainHangarDirectory],
  [wireSpool, "the thing that looks like a wire spool in the Main Hangar.", mainHangarDirectory],
  [spareEngine, "usually put into fighter engines. Check the spare engine in the Main Hangar.", mainHangarDirectory],
  [biggestBarrel, "in the cabinet right next to the giant fuel barrel in the Main Hangar. It should be fine.", mainHangarDirectory],
  //armory
  [bigWrench, "heavy and shaped like a weapon, so it was left in the Armory.", armoryDirectory],
  [oddDevice, "wierd, glowy, and slightly menacing. Check the Armory.", armoryDirectory],
  //gym
  [camcorder, "a device that looks like a camcorder and was left in the Gym.", gymDirectory],
  [gymRack, "heavy, so someone put it on one of the Gym racks.", gymDirectory],
  [gymFan, "cold and has a fan on it, so it's cooling the Gym.", gymDirectory],
  [waterDispenser, "leaking what we hope is water. It's refilling the water dispenser in the Gym.", gymDirectory],
  //squad bay 1
  [riceCooker,"a tall looking device that can hold pressure, so it's the rice cooker in Squad Bay 1.",squadBay1Directory],
  [gamerPC, "accessible through the personal terminal in Squad Bay 1.", squadBay1Directory],
  [gamerKeyboard, "taped to the back of the keyboard in Squad Bay 1.", squadBay1Directory],
  //squad bay 2
  [funBall, "somewhat bouncy, so we're using it as a ball in the Playground.", squadBay2Directory],
  //drop bay
  [weirdAI, "not on the ship, but can be activated by talking to the weird glowing thing in the Drop Bay.", dropBayDirectory],
  // engine (starboard)
  [fanBox, "a box with fans all over it in the Starboard Engine Room.", rightEngineRoomDirectory],
  [starboardSideStarboardBankStarboardEngineInterface, "accessible via Starboard-Bank Starboard-Side interface screen in the Starboard Engine Room.", rightEngineRoomDirectory],
  [portSideStarboardBankStarboardEngineInterface, "accessible via Starboard-Bank Port-Side interface screen in the Starboard Engine Room.", rightEngineRoomDirectory],
  [starboardSidePortBankStarboardEngineInterface, "accessible via Port-Bank Starboard-Side interface screen in the Starboard Engine Room.", rightEngineRoomDirectory],
  [portSidePortBankStarboardEngineInterface, "accessible via Port-Bank Port-Side interface screen in the Starboard Engine Room.", rightEngineRoomDirectory],
  // engine (port)
  [whiteMachine, "a white machine in the Port Engine Room.", leftEngineRoomDirectory],
  [junkEngine, "some tiny device someone left on the Port Engine.", leftEngineRoomDirectory],
  [starboardSideStarboardBankPortEngineInterface, "accessible via Starboard-Bank Starboard-Side interface screen in the Port Engine Room.", leftEngineRoomDirectory],
  [portSideStarboardBankPortEngineInterface, "accessible via Starboard-Bank Port-Side interface screen in the Port Engine Room.", leftEngineRoomDirectory],
  [starboardSidePortBankPortEngineInterface, "accessible via Port-Bank Starboard-Side interface screen in the Port Engine Room.", leftEngineRoomDirectory],
  [portSidePortBankPortEngineInterface, "accessible via Port-Bank Port-Side interface screen in the Port Engine Room.", leftEngineRoomDirectory],
  //rec room
  [lostBehindCouch, "lost behind the couch in the Rec Room.", recRoomDirectory],
  [gamingConsole, "being used to play games in the Rec Room.", recRoomDirectory],
  [vendingMachine, "available for purchase in the Rec Room vending machine.", recRoomDirectory],
  //head
  [headTab, "accessible via interface screen in the Head.", headDirectory],
  //waffle house
  [lostToolWaffle, "a small tool that someone left in the Waffle House.", waffleHouseDirectory],
  [prankTab, "accessible via interface screen someone taped to the ceiling of the Waffle House as a prank.", waffleHouseDirectory],
  //infirmary
  [defib, "probably short circuiting, but we're using it as a defribillator. It's somewhere in the Infirmary", infirmaryDirectory],
  [futureIV, "holding up IV bags in the Infirmary", infirmaryDirectory],
  [medTab, "accessible via interface screen in the Infirmary", infirmaryDirectory],
  //cryo BAY
  [cryoTab, "accessible via interface screen in the Cryo Bay.", cryoBayDirectory],
  //briefing room
  [projector, "projecting slides in the Briefing Room.", briefRoomDirectory],
  //slipdrive
  //maintenance
  [roofDish, "a dish on the outside of the ship. Use the ladder in Maintenance to find it.", maintenanceDirectory],
  [dStick, "a stick we keep in Maintenance.", maintenanceDirectory],
  [maintBlu, "activated by the Blue Button in Maintenance.", maintenanceDirectory],
  [maintRed, "activated by the Red Button in Maintenance.", maintenanceDirectory],
  [maintGreen, "activated by the Green Button in Maintenance.", maintenanceDirectory],
  //storage room
  [somethingInStorage01, "some kind of square machine we put in Storage.", storageDirectory],
  [spaceNipple, "the weird rusty nipple in Storage.", storageDirectory],
  [tinyDevice, "a small device somewhere in Storage.", storageDirectory],
  [teleport, "a machine in Storage we piled a bunch of boxes onto.", storageDirectory],
  [bigGreen, "a big green box in Storage.", storageDirectory],
  [printer, "a device in storage that kinda looks like a printer.", storageDirectory],
  //unnamed rooms
  [trashPile, "a thing we recently threw away. Check the pile of trash in one of the Unlabeled Rooms.", unnamedDirectory],
  //data room
  [theRouter, "a little thing with antennas on the floor of the Data Room.", dataRoomDirectory],
  [serverBox, "a device... thingy... in the Data Room.", dataRoomDirectory],
  //mess hall
  [smallSpeakers, "a device that can also play music. It's somewhere in the Mess Hall.", messHallDirectory],
  [messDispenser, "currently dispensing edible substances in the Mess Hall.", messHallDirectory],
  [spaceTriangle, "a small triangle that looks pretty. It's displayed in the Mess Hall.", messHallDirectory],
  [messCylinder, "a small cylinder in the Mess Hall.", messHallDirectory],
  [messMicrowave, "being used as a microwave in the Mess Hall.", messHallDirectory],
  //security
  // captain's room
  [capTop, "a program on the previous captain's ancient laptop.", captainsDirectory],
  [capPen, "a small device that looks like a pen in the previous captain's room.", captainsDirectory],
  [capDesk, "in one of the shelves in the previous Captain's desk.", captainsDirectory],
  [doll01, "definitely NOT one of the previous captain's holodolls.", captainsDirectory],
  //officer's room
  [officerDesk, "in one of the Officer's desk drawers.", officersDirectory],
  [eReader, "the previous Officer's pReader.", officersDirectory],
  [offSeat, "small enough to fall between the seat cushions in the Officer's quarters.", officersDirectory]
  //bridge
];

//anchor management

/*FORMAT:
What the ship tells you to do.
What the object says when you highlight it.
An object the objective should be put onto. If objNull, then randomly put it somewhere.
What the object is called.
HARDMODE what the object says when you highlight it. Don't mention what the object is.

*/
masterObjectiveTable = [
  //randomized Objectives
  ["Honk the Space Horn", ["Honk the Space Horn", objNull, "The Space Horn", honkSpaceHorn, "Honk"]],
  ["Flip the Handwavinite Reactor", ["Flip the Handwavinite Reactor", objNull, "The Handwavinite Reactor", {}, "Flip"]],
  ["Direct the Spurving Bearings", ["Direct the Spurving Bearings", objNull, "The Spurving Bearings", {}, "Direct"]],
  ["Wind the Lotus-O-Deltoid", ["Wind the Lotus-O-Deltoid", objNull, "The Lotus-O-Deltoid", {}, "Wind"]],
  ["Turbo the Retroencabulator", ["Turbo the Retroencabulator", objNull, "The Retroencabulator", {}, "Turbo"]],
  ["Push the Turbo Button", ["Push the Turbo Button", objNull, "The Turbo Button", {}, "Push button"]],
  ["Push the Button Button", ["Push the Button Button", objNull, "The Button Button", {}, "Push button"]],
  ["Reduce Sinusoidal Depleneration", ["Reduce Sinusoidal Depleneration", objNull, "The Depleneration Reducer", {}, "Reduce"]],
  ["There is no Orth Effect", ["There is no Orth Effect.", objNull, "There is no Orth Effect. But, if there was it", {}, "There is no Orth Effect."]],
  ["Reboot the Plasma-State Disc Drive", ["Reboot the Plasma-State Disc Drive", objNull, "The Plasma-State Disc Drive", rebootNoise, "Reboot"]],
  ["Cancel the Three-Ring Circus", ["Cancel the Three-Ring Circus", objNull, "The device to cancel events", {}, "Cancel"]],
  ["Cancel Ludicrious Speed", ["Cancel Ludicrious Speed", objNull, "The speed limiter", {}, "Cancel"]],
  ["Stop the Unspecifidium Chemical Reaction", ["Stop the Unspecifidium Chemical Reaction", objNull, "The Unspecifidium Reactor", {}, "Stop"]],
  ["Wipe the Write-Only Memory", ["Wipe the Write-Only Memory", objNull, "The Write-Only Memory Bank", {}, "Wipe"]],
  ["Empty the Bit Bucket", ["Empty the Bit Bucket", objNull, "The Bit Bucket", {}, "Empty"]],
  ["Wipe the First-In-Never-Out Buffer", ["Wipe the First-In-Never-Out Buffer", objNull, "The First-In-Never-Out Buffer", {}, "Wipe"]],
  ["Calculate the Farnsfarfle Paradox", ["Calculate the Farnsfarfle Paradox", objNull, "The Farnsfarfle Calculator", {}, "Calculate"]],
  ["Reboot the Dark-Emitting Diode", ["Reboot the Dark-Emitting Diode", objNull, "The Dark-Emitting Diode", rebootNoise, "Reboot"]],
  ["Bypass Extraneous Security Device", ["Bypass Extraneous Security Device", objNull, "The Extraneous Security Device", {}, "Bypass"]],
  ["Search for Combos", ["No Combos Here...", objNull, "I think a bag of Combos", {}, "Found nothing here..."]],
  ["Develop New Lollipop Flavor", ["Develop New Lollipop Flavor", objNull, "The Lollipop Flavor Developer", {}, "Develop"]],
  ["Search for Money", ["No money here...", objNull, "I think some money", {}, "Found nothing here..."]],
  ["Reconfigure the Main Power Converter", ["Reconfigure the Main Power Converter", objNull, "The Main Power Converter", {}, "Reconfigure"]],
  ["Recharge the Psuedo-Laser Bank", ["Recharge the Psuedo-Laser Bank", objNull, "The Psuedo-Laser Bank", {}, "Recharge"]],
  ["Open the Anti-Fairings", ["Open the Anti-Fairings", objNull, "The Anti-Fairing Opener", {}, "Open"]],
  ["Void the Warranty", ["Void the Warranty", objNull, "The Warranty", {}, "Void"]],
  ["Brew the Radar Coffee", ["Brew the Radar Coffee", objNull, "The Mr. Coffee", {}, "Brew"]],
  ["De-Quark the Quorxian Cord", ["De-Quark the Quorxian Cord", objNull, "The Quorxian Cord", {}, "De-Quark"]],
  ["Refill the Space Juul", ["Refill the Space Juul", objNull, "The Space Juul", {}, "Refill"]],
  ["Degauss the Gaussian Distributions", ["Degauss the Gaussian Distributions", objNull, "The Gaussian Distributor", {}, "Degauss"]],
  ["Adjust the Magical Suppression Fields", ["Adjust the Magical Suppression Fields", objNull, "The Magical Suppression Fields", {}, "Adjust"]],
  ["Adjust the Main Deflector Dish", ["Adjust the Main Deflector Dish", objNull, "The Main Deflector Dish", {}, "Adjust"]],
  ["Screw the Pooch", ["Screw the Pooch", objNull, "The Pooch Screwer", {}, "Screw"]],
  ["Bounce the Graviton Particle Beam", ["Bounce the Graviton Particle Beam", objNull, "The Graviton Particle Beam", {}, "Bounce"]],
  ["Refill the Replicator Tanks", ["Refill the Replicator Tanks", objNull, "The Replicator Tanks", {}, "Refill"]],
  ["Flip the Dark Matter Isospin", ["Flip the Dark Matter Isospin", objNull, "The Isospinner", {}, "Flip"]],
  ["Flavor the Quantum Numbers", ["Flavor the Quantum Numbers", objNull, "The Quantum Number Tape", {}, "Flavor"]],
  ["Perturbate the Sphalerons", ["Perturbate the Sphalerons", objNull, "The Sphaleron Transistor", {}, "Perturbate"]],
  ["Plug in the Theta Vacuum", ["Plug in the Theta Vacuum", objNull, "The Theta Vacuum", {}, "Plug in"]],
  ["Reconfigure the Riemannian Manifolds", ["Reconfigure the Riemannian Manifolds", objNull, "The Reimannian Manifolds", {}, "Reconfigure"]],
  ["Reduce Charge-Parity Non-Conservation", ["Reduce Charge-Parity Non-Conservation", objNull, "The Charge-Parity Conservator", {}, "Reduce"]],
  ["Check the Chiral Anomaly", ["Check the Chiral Anomaly", objNull, "The device holding the Chiral Anomaly", {}, "Check"]],
  ["Renormalize the Amplitudes", ["Renormalize the Amplitudes", objNull, "The Amplituder", {}, "Renormalize"]],
  ["Replace the Psuedoscalar Coupling", ["Replace the Psuedoscalar Coupling", objNull, "The Psuedoscalar Coupling", {}, "Replace"]],
  ["Spin the Accretion Disc", ["Spin the Accretion Disc", objNull, "The Accretion Disc", {}, "Spin"]],
  ["Exceed the Eddington Limit", ["Exceed the Eddington Limit", objNull, "The Eddington Limiter", {}, "Exceed"]],
  ["Wipe the Excess Bose-Einstein Condensation", ["Wipe the Bose-Einstein Condensation", objNull, "The Bose-Einstein Condenser", {}, "Wipe"]],
  ["Read the Interferomorphosonometer", ["Read the Interferomorphosonometer", objNull, "The Interferomorphosonometer", {}, "Read"]],
  ["Read the Non-Abelian Gauge", ["Read the Non-Abelian Gauge", objNull, "The Non-Abelian Gauge", {}, "Read"]],
  ["Purify the Blotch Spheres", ["Purify the Blotch Spheres", objNull, "The Blotch Sphere Container", {}, "Purify"]],
  ["Push the Muffin Button", ["Push the Muffin Button", objNull, "The Muffin Button", {}, "Push button"]],
  ["Push the Science Button", ["Push the Science Button", objNull, "The Science Button", {}, "Push button"]],
  ["Calculate the Kerr Metric", ["Calculate the Kerr Metric", objNull, "The machine that calculates the Kerr Metric", {}, "Calculate"]],
  ["Pay Down the Reconciliation Debt", ["Pay Down Reconciliation Debt", objNull, "The thing we use to pay down reconciliation debts", {}, "Pay Down"]],
  ["Jerk the Wrobel knocker", ["Jerk the Wrobel knocker", objNull, "The Wrobel knocker", {}, "Jerk"]],
  ["Space the Space Space",["Space", objNull, "The Space Space", {}, "Space"]],
  ["Flip the PentaFLOP",["Flip the PentaFLOP", objNull, "The PentaFLOP", {}, "Flip"]],
  ["Reboot the Router", ["Reboot the Router", objNull, "The Router", rebootNoise, "Reboot"]],
  //lower hangar
  ["Inspect the fighter",["Inspect", spareFighter, "The Fighter", {}, "Inspect"]],
  //main hangar
  //armory
  //gym
  //squad bay 1
  //squad bay 2
  ["Play pretend",["Play pretend", pretend, "The Playground", {}, "Play"]],
  ["Check the Self Destruct device",["Check the Self Destruct Device", theNuke, "The Self Destruct Device", {}, "Check"]],
  //drop bay
  //engine (starboard)
  //engine (port)
  //rec room
  ["Start a shanty at the Rec Room Bar",["Start a shanty", shantyRadio,"Shanty Singer", singShanty, "Start a shanty"]],
  ["Refill the beer",["Refill the beer", beerContainer,"", {}, "Refill"]],
  //head
  ["Recharge the Big Battery",["Recharge the Big Battery", headBattery, "The Big Battery", {}, "Recharge"]],
  //waffle house
  ["Put in an order for Hash Browns", ["Order Hash Browns", waffleHouseMenu, "The Waffle House menu tablet", {}, "Order Hash Browns"]],
  ["Put in an order for Steak and Eggs", ["Order Steak and Eggs", waffleHouseMenu, "The Waffle House menu tablet", {}, "Order Steak and Eggs"]],
  ["Put in an order for Waffles", ["Order Waffles", waffleHouseMenu, "The Waffle House menu tablet", {}, "Order Waffles"]],
  ['Put in an order for "Waffles"', ['Order "Waffles"', waffleHouseMenu, "The Waffle House menu tablet", {}, 'Order "Waffles"']],
  //infirmary
  //cryo bay
  //briefing room
    //a3\structures_f\civ\infoboards\data\mapboard_default_co.paa
  ["Draw a dick on the whiteboard", ["Draw a dick", whiteboard, "The Whiteboard", drawADick, "Draw a dick"]],
  //slip drive
  ["Check fuel cell for leaks",["Check for leaks", fuelCell, "The Fuel Cell", {}, "Check"]],
  ["Adjust Slipperyspace Drive Telemetry",["Adjust Slipperyspace Drive Telemetry", slipTab, "Telemetry Computer", {}, "Adjust"]],
  ["Spin Slipperyspace Drive",["Spin", invisSpin, "The Price is Right Wheel", {}, "Spin"]],
  //maintenance
  ["Read the Better Manual",["Read the Better Manual",maintShelf,"The Better Manual",{},"Read"]],
  //storage
  //unnamed
  ["Resist the temptations of the Mysterious Plinth",["Resist the Temptations",mysteriousPlinth,"The Mysterious Plinth",{},"Resist the Temptations"]],
  //data room
  ["Check the Holo Map",["Check the Holo Map", holoMap, "The Holo Map", {}, "Check"]],
  ["Read the Manual",["Read the Manual", manualData, "The Manual", {}, "Read"]],
  //mess hall
  //brig
  //captain's room
  ["Water the Ship's Plant",["Water the plant", capPlant, "The Ship's Plant", {}, "Water"]],
  //officer's
  ["Phone it in",["Phone it in", telephone, "The telephone", {}, "Phone it in"]],
  //bridge
  ["Go to Red Alert", ["Red Alert", redAlertConsole, "The Bridge's Alert Console", redAlert, "Red Alert"]],
  ["Go to Yellow Alert", ["Yellow Alert", redAlertConsole, "The Bridge's Alert Console", {}, "Yellow Alert"]],
  ["Go to Green Alert", ["Green Alert", redAlertConsole, "The Bridge's Alert Console", greenAlert, "Green Alert"]],
  ["Go to Purple Alert", ["Purple Alert", redAlertConsole, "The Bridge's Alert Console", purpleAlert, "Purple Alert"]],
  ["Go to Plaid Alert", ["Plaid Alert", redAlertConsole, "The Bridge's Alert Console", plaidAlert, "Plaid Alert"]]
];

spaceVerbs = [
  "Reboot",
  "Flip",
  "Direct",
  "Wind",
  "Push Button",
  "Reduce",
  "Cancel",
  "Stop",
  "Wipe",
  "Empty",
  "Calculate",
  "Bypass",
  "Develop",
  "Recharge",
  "Reconfigure",
  "Adjust",
  "Check",
  "Replace",
  "Spin",
  "Read"
];

directoryInit = {

  [lowerHangarDirectory,["LOWER HANGAR DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [mainHangarDirectory,["MAIN HANGAR DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [armoryDirectory,["ARMORY DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [armoryDirectory,["The Armory is in the Aft Deck off the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [gymDirectory,["GYMNASIUM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [gymDirectory,["The Gym is in the Aft Deck off the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [squadBay1Directory,["SQUAD BAY 1 DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [squadBay1Directory,["Squad Bay 1 is in the Aft Deck off the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [squadBay2Directory,["SQUAD BAY 2 DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [squadBay2Directory,["Squad Bay 2 is in the Aft Deck off the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [squadBay2Directory,["Squad Bay 2 has been converted into a playground.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [squadBay2Directory,["The Self Destruct Device has a blanket thrown over it in Squad Bay 2.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [rightEngineRoomDirectory,["STARBOARD ENGINE ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [rightEngineRoomDirectory,["The Starboard Engine Room is in the Aft Deck off the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [leftEngineRoomDirectory,["PORT ENGINE ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [leftEngineRoomDirectory,["The Port Engine Room is in the Aft Deck off the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [dropBayDirectory,["DROP BAY DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [dropBayDirectory,["The Drop Bay is in the Aft Deck off the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [recRoomDirectory,["RECREATION DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [recRoomDirectory,["The Rec Room is in the Aft Deck off the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [headDirectory,["RESTROOM/HEAD DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [headDirectory,["The Head is, ironically, in the Aft Deck off the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [headDirectory,["Someone left the Big Battery in the Head.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [waffleHouseDirectory,["WAFFLE HOUSE DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [waffleHouseDirectory,["The Waffle House is in the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [waffleHouseDirectory,["Breakfast foods can be ordered using one of the tablets on the counter.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [infirmaryDirectory,["INFIRMARY DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [infirmaryDirectory,["The Infirmary is in the Main Hangar, towards the front of the ship.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [cryoBayDirectory,["CRYONICS BAY DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [cryoBayDirectory,["The Cryonics Bay is in the Infirmary.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [cryoBayDirectory,["The Fire Suppression system can be found in the Cryonics Bay.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [briefRoomDirectory,["COMBAT INFORMATION CENTER DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [briefRoomDirectory,["The Combat Information Center is in the Middle Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [slipdriveDirectory,["SLIPDRIVE DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [slipdriveDirectory,["The Slipperyspace Drive is in the Middle Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [slipdriveDirectory,["We store fuel cells near the Slipperyspace Drive.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [maintenanceDirectory,["MAINTENANCE ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [maintenanceDirectory,["The Maintenance Room is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [maintenanceDirectory,["The Better Manual is in Maintenance.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [storageDirectory,["STORAGE ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [storageDirectory,["The Storage Room is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [unnamedDirectory,["UNLABELED ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [unnamedDirectory,["The Unlabeled Rooms are in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [unnamedDirectory,["The Mysterious Plinth is in one of the Unlabeled Rooms.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [dataRoomDirectory,["DATA ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [dataRoomDirectory,["The Data Room is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [dataRoomDirectory,["The Manual is deep within the Data Room, on a small shelf.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [dataRoomDirectory,["The spare Holo Map is stashed somewhere in the Data Room.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [messHallDirectory,["MESS HALL DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [messHallDirectory,["The Mess Hall is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [securityDirectory,["SECURITY ROOM AND BRIG DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [securityDirectory,["Security is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [captainsDirectory,["CAPTAIN'S QUARTERS DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [captainsDirectory,["The Captain's Quarters are in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [captainsDirectory,["The Ship's Plant is in the Captain's Quarters.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [officersDirectory,["OFFICER'S QUARTERS DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [officersDirectory,["The Officer's Quarters are in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [officersDirectory,["The ship's old-school phone is in the Officer's Quarters.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

};

//there are probably better places to put these, but oh well
fireSuppressionSystem addAction ["Activate Fire Suppression System",{[] remoteExec ["fireSuppression", 2, false];},[],1.5,true,true,"","true",10,false,"",""];
