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

76BED0 <- this blue for nouns
DA7422 <- dark orange for verbs

<t color='#76BED0'> </t> <- noun blue
<t color='#DA7422'> </t> <- verb orange
<t color='#613DC1'> </t> <- other purple

*/
masterObjectiveTable = [
  //randomized Objectives
  ["<t color='#DA7422'>Honk</t> the <t color='#76BED0'>Space Horn</t>", ["Honk the Space Horn", objNull, "The <t color='#76BED0'>Space Horn</t>", honkSpaceHorn, "Honk"]],
  ["<t color='#DA7422'>Flip</t> the <t color='#76BED0'>Handwavinite Reactor</t>", ["Flip the Handwavinite Reactor", objNull, "The <t color='#76BED0'>Handwavinite Reactor</t>", {}, "Flip"]],
  ["<t color='#DA7422'>Direct</t> the <t color='#76BED0'>Spurving Bearings</t>", ["Direct the Spurving Bearings", objNull, "The <t color='#76BED0'>Spurving Bearing</t> <t color='#DA7422'>Director</t>", {}, "Direct"]],
  ["<t color='#DA7422'>Wind</t> the <t color='#76BED0'>Lotus-O-Deltoid</t>", ["Wind the Lotus-O-Deltoid", objNull, "The <t color='#76BED0'>Lotus-O-Deltoid</t>", {}, "Wind"]],
  ["<t color='#DA7422'>Turbo</t> the <t color='#76BED0'>Retroencabulator</t>", ["Turbo the Retroencabulator", objNull, "The <t color='#76BED0'>Retroencabulator</t>", {}, "Turbo"]],
  ["<t color='#DA7422'>Push</t> the <t color='#76BED0'>Turbo Button</t>", ["Push the Turbo Button", objNull, "The <t color='#76BED0'>Turbo Button</t>", {}, "Push button"]],
  ["<t color='#DA7422'>Push</t> the <t color='#76BED0'>Button Button</t>", ["Push the Button Button", objNull, "The <t color='#76BED0'>Button Button</t>", {}, "Push button"]],
  ["<t color='#DA7422'>Reduce</t> <t color='#76BED0'>Sinusoidal Depleneration</t>", ["Reduce Sinusoidal Depleneration", objNull, "The <t color='#76BED0'>Sinusoidal Depleneration</t> <t color='#DA7422'>Reducer</t>", {}, "Reduce"]],
  ["<t color='#613DC1'>There is no Orth Effect.</t>", ["<t color='#613DC1'>There is no Orth Effect.</t>", objNull, "<t color='#613DC1'>There is no Orth Effect.</t> But, if there was it", {}, "<t color='#613DC1'>There is no Orth Effect.</t>"]],
  ["<t color='#DA7422'>Reboot</t> the <t color='#76BED0'>Plasma-State Disc Drive</t>", ["Reboot the Plasma-State Disc Drive", objNull, "The <t color='#76BED0'>Plasma-State Disc Drive</t>", rebootNoise, "Reboot"]],
  ["<t color='#DA7422'>Cancel</t> the Three-Ring <t color='#76BED0'>Circus</t>", ["Cancel the Three-Ring Circus", objNull, "The <t color='#76BED0'>Event/Circus</t> <t color='#DA7422'>Canceler</t>", {}, "Cancel"]],
  ["<t color='#DA7422'>Cancel</t> Ludicrious <t color='#76BED0'>Speed</t>", ["Cancel Ludicrious Speed", objNull, "The <t color='#76BED0'>Speed</t> Limiter/<t color='#DA7422'>Canceler</t>", {}, "Cancel"]],
  ["<t color='#DA7422'>Stop</t> the <t color='#76BED0'>Unspecifidium Chemical Reaction</t>", ["Stop the Unspecifidium Chemical Reaction", objNull, "The <t color='#76BED0'>Unspecifidium Reactor</t>", {}, "Stop"]],
  ["<t color='#DA7422'>Wipe</t> the <t color='#76BED0'>Write-Only Memory</t>", ["Wipe the Write-Only Memory", objNull, "The <t color='#76BED0'>Write-Only Memory</t> Bank", {}, "Wipe"]],
  ["<t color='#DA7422'>Empty</t> the <t color='#76BED0'>Bit Bucket</t>", ["Empty the Bit Bucket", objNull, "The <t color='#76BED0'>Bit Bucket</t>", {}, "Empty"]],
  ["<t color='#DA7422'>Wipe</t> the <t color='#76BED0'>First-In-Never-Out Buffer</t>", ["Wipe the First-In-Never-Out Buffer", objNull, "The <t color='#76BED0'>First-In-Never-Out Buffer</t>", {}, "Wipe"]],
  ["<t color='#DA7422'>Calculate</t> the <t color='#76BED0'>Farnsfarfle</t> Paradox", ["Calculate the Farnsfarfle Paradox", objNull, "The <t color='#76BED0'>Farnsfarfle</t> <t color='#DA7422'>Calculator</t>", {}, "Calculate"]],
  ["<t color='#DA7422'>Reboot</t> the <t color='#76BED0'>Dark-Emitting Diode</t>", ["Reboot the Dark-Emitting Diode", objNull, "The <t color='#76BED0'>Dark-Emitting Diode</t>", rebootNoise, "Reboot"]],
  ["<t color='#DA7422'>Bypass</t> the <t color='#76BED0'>Extraneous Security Device</t>", ["Bypass the Extraneous Security Device", objNull, "The <t color='#76BED0'>Extraneous Security Device</t>", {}, "Bypass"]],
  ["<t color='#DA7422'>Search</t> for <t color='#76BED0'>Combos</t>", ["Combos!", objNull, "I think someone left a bag of <t color='#76BED0'>Combos</t> near the thing. You know, it", findCombos, "Bags of Combos are hidden here"]],
  ["<t color='#DA7422'>Develop</t> New <t color='#76BED0'>Lollipop Flavor</t>", ["Develop New Lollipop Flavor", objNull, "The <t color='#76BED0'>Lollipop Flavor</t> <t color='#DA7422'>Developer</t>", {}, "Develop"]],
  ["<t color='#DA7422'>Search</t> for <t color='#76BED0'>Money</t>", ["Money!", objNull, "I think some <t color='#76BED0'>Money</t> is under the thingy... the thing that", findMoney, "Money is hidden here"]],
  ["<t color='#DA7422'>Reconfigure</t> the <t color='#76BED0'>Main Power Converter</t>", ["Reconfigure the Main Power Converter", objNull, "The <t color='#76BED0'>Main Power Converter</t>", {}, "Reconfigure"]],
  ["<t color='#DA7422'>Recharge</t> the <t color='#76BED0'>Psuedo-Laser Bank</t>", ["Recharge the Psuedo-Laser Bank", objNull, "The <t color='#76BED0'>Psuedo-Laser Bank</t>", {}, "Recharge"]],
  ["<t color='#DA7422'>Open</t> the <t color='#76BED0'>Anti-Fairings</t>", ["Open the Anti-Fairings", objNull, "The <t color='#76BED0'>Anti-Fairing</t> <t color='#DA7422'>Opener</t>", {}, "Open"]],
  ["<t color='#DA7422'>Void</t> the <t color='#76BED0'>Warranty</t>", ["Void the Warranty", objNull, "The <t color='#76BED0'>Warranty</t>", {}, "Void"]],
  ["<t color='#DA7422'>Brew</t> the Radar <t color='#76BED0'>Coffee</t>", ["Brew the Radar Coffee", objNull, "The Mr. <t color='#76BED0'>Coffee</t>", {}, "Brew"]],
  ["<t color='#DA7422'>De-Quark</t> the <t color='#76BED0'>Quorxian Cord</t>", ["De-Quark the Quorxian Cord", objNull, "The <t color='#76BED0'>Quorxian Cord</t>", {}, "De-Quark"]],
  ["<t color='#DA7422'>Refill</t> the <t color='#76BED0'>Space Juul</t>", ["Refill the Space Juul", objNull, "The <t color='#76BED0'>Space Juul</t>", {}, "Refill"]],
  ["<t color='#DA7422'>Degauss</t> the <t color='#76BED0'>Gaussian Distributions</t>", ["Degauss the Gaussian Distributions", objNull, "The <t color='#76BED0'>Gaussian Distributor</t>", {}, "Degauss"]],
  ["<t color='#DA7422'>Adjust</t> the <t color='#76BED0'>Magical Suppression Fields</t>", ["Adjust the Magical Suppression Fields", objNull, "The <t color='#76BED0'>Magical Suppression Field</t> Generator", {}, "Adjust"]],
  ["<t color='#DA7422'>Adjust</t> the <t color='#76BED0'>Main Deflector Dish</t>", ["Adjust the Main Deflector Dish", objNull, "The <t color='#76BED0'>Main Deflector Dish</t>", {}, "Adjust"]],
  ["<t color='#DA7422'>Screw</t> the <t color='#76BED0'>Pooch</t>", ["Screw the Pooch", objNull, "The <t color='#76BED0'>Pooch</t> <t color='#DA7422'>Screwer</t>", {}, "Screw"]],
  ["<t color='#DA7422'>Bounce</t> the <t color='#76BED0'>Graviton Particle Beam</t>", ["Bounce the Graviton Particle Beam", objNull, "The <t color='#76BED0'>Graviton Particle Beam</t>", {}, "Bounce"]],
  ["<t color='#DA7422'>Refill</t> the <t color='#76BED0'>Replicator Tanks</t>", ["Refill the Replicator Tanks", objNull, "The <t color='#76BED0'>Replicator Tanks</t>", {}, "Refill"]],
  ["<t color='#DA7422'>Flip</t> the <t color='#76BED0'>Dark Matter Isospinner</t>", ["Flip the Dark Matter Isospin", objNull, "The <t color='#76BED0'>Dark Matter Isospinner</t>", {}, "Flip"]],
  ["<t color='#DA7422'>Flavor</t> the <t color='#76BED0'>Quantum Numbers</t>", ["Flavor the Quantum Numbers", objNull, "The <t color='#76BED0'>Quantum Number</t> Tape", {}, "Flavor"]],
  ["<t color='#DA7422'>Perturbate</t> the <t color='#76BED0'>Sphalerons</t>", ["Perturbate the Sphalerons", objNull, "The <t color='#76BED0'>Sphaleron</t> Transistor", {}, "Perturbate"]],
  ["<t color='#DA7422'>Plug In</t> the <t color='#76BED0'>Theta Vacuum</t>", ["Plug in the Theta Vacuum", objNull, "The <t color='#76BED0'>Theta Vacuum</t>", {}, "Plug in"]],
  ["<t color='#DA7422'>Reconfigure</t> the <t color='#76BED0'>Riemannian Manifolds</t>", ["Reconfigure the Riemannian Manifolds", objNull, "The <t color='#76BED0'>Reimannian Manifolds</t>", {}, "Reconfigure"]],
  ["<t color='#DA7422'>Reduce</t> <t color='#76BED0'>Charge-Parity</t> Non-Conservation", ["Reduce Charge-Parity Non-Conservation", objNull, "The <t color='#76BED0'>Charge-Parity</t> Conservator", {}, "Reduce"]],
  ["<t color='#DA7422'>Check</t> the <t color='#76BED0'>Chiral Anomaly</t>", ["Check the Chiral Anomaly", objNull, "The device holding the <t color='#76BED0'>Chiral Anomaly</t>", {}, "Check"]],
  ["<t color='#DA7422'>Renormalize</t> the <t color='#76BED0'>Amplitudes</t>", ["Renormalize the Amplitudes", objNull, "The <t color='#76BED0'>Amplituder</t>", {}, "Renormalize"]],
  ["<t color='#DA7422'>Replace</t> the <t color='#76BED0'>Psuedoscalar Coupling</t>", ["Replace the Psuedoscalar Coupling", objNull, "The <t color='#76BED0'>Psuedoscalar Coupling</t>", {}, "Replace"]],
  ["<t color='#DA7422'>Spin</t> the <t color='#76BED0'>Accretion Disc</t>", ["Spin the Accretion Disc", objNull, "The <t color='#76BED0'>Accretion Disc</t>", {}, "Spin"]],
  ["<t color='#DA7422'>Exceed</t> the <t color='#76BED0'>Eddington Limit</t>", ["Exceed the Eddington Limit", objNull, "The <t color='#76BED0'>Eddington Limiter</t>", {}, "Exceed"]],
  ["<t color='#DA7422'>Wipe</t> the Excess <t color='#76BED0'>Bose-Einstein Condensation</t>", ["Wipe the Bose-Einstein Condensation", objNull, "The <t color='#76BED0'>Bose-Einstein Condenser</t>", {}, "Wipe"]],
  ["<t color='#DA7422'>Read</t> the <t color='#76BED0'>Interferomorphosonometer</t>", ["Read the Interferomorphosonometer", objNull, "The <t color='#76BED0'>Interferomorphosonometer</t>", {}, "Read"]],
  ["<t color='#DA7422'>Read</t> the <t color='#76BED0'>Non-Abelian Gauge</t>", ["Read the Non-Abelian Gauge", objNull, "The <t color='#76BED0'>Non-Abelian Gauge</t>", {}, "Read"]],
  ["<t color='#DA7422'>Purify</t> the <t color='#76BED0'>Blotch Spheres</t>", ["Purify the Blotch Spheres", objNull, "The <t color='#76BED0'>Blotch Sphere</t> Container", {}, "Purify"]],
  ["<t color='#DA7422'>Push</t> the <t color='#76BED0'>Muffin Button</t>", ["Push the Muffin Button", objNull, "The <t color='#76BED0'>Muffin Button</t>", {}, "Push button"]],
  ["<t color='#DA7422'>Push</t> the <t color='#76BED0'>Science Button</t>", ["Push the Science Button", objNull, "The <t color='#76BED0'>Science Button</t>", {}, "Push button"]],
  ["<t color='#DA7422'>Calculate</t> the <t color='#76BED0'>Kerr Metric</t>", ["Calculate the Kerr Metric", objNull, "The machine that <t color='#DA7422'>calculates</t> the <t color='#76BED0'>Kerr Metric</t>", {}, "Calculate"]],
  ["<t color='#DA7422'>Pay Down</t> the <t color='#76BED0'>Reconciliation Debt</t>", ["Pay Down Reconciliation Debt", objNull, "The thing we use to <t color='#DA7422'>pay down</t> <t color='#76BED0'>reconciliation debts</t>", {}, "Pay Down"]],
  ["<t color='#DA7422'>Jerk</t> the <t color='#76BED0'>Wrobel Knocker</t>", ["Jerk the Wrobel Knocker", objNull, "The <t color='#76BED0'>Wrobel Knocker</t>", {}, "Jerk"]],
  ["<t color='#DA7422'>Space</t> the <t color='#76BED0'>Space Space</t>",["Space", objNull, "The <t color='#76BED0'>Space Space</t>", {}, "Space"]],
  ["<t color='#DA7422'>Flip</t> the <t color='#76BED0'>PentaFLOP</t>",["Flip the PentaFLOP", objNull, "The <t color='#76BED0'>PentaFLOP</t>", {}, "Flip"]],
  ["<t color='#DA7422'>Reboot</t> the <t color='#76BED0'>Router</t>", ["Reboot the Router", objNull, "The <t color='#76BED0'>Router</t>", rebootNoise, "Reboot"]],
  //lower hangar
  //["Inspect the fighter",["Inspect", spareFighter, "The Fighter", {}, "Inspect"]],
  //main hangar
  //armory
  //gym
  //squad bay 1
  //squad bay 2
  ["<t color='#DA7422'>Play</t> pretend",["Play pretend", pretend, "The Playground", {}, "Play"]],
  ["<t color='#DA7422'>Check</t> the <t color='#76BED0'>Self Destruct device</t>",["Check the Self Destruct Device", theNuke, "The Self Destruct Device", {}, "Check"]],
  //drop bay
  //engine (starboard)
  //engine (port)
  //rec room
  ["<t color='#DA7422'>Start a Shanty</t> at the <t color='#76BED0'>Rec Room</t> Bar",["Start a shanty", shantyRadio,"Shanty Singer", singShanty, "Start a shanty"]],
  ["<t color='#DA7422'>Refill</t> the <t color='#76BED0'>Beer</t>",["Refill the beer", beerContainer,"", {}, "Refill"]],
  //head
  ["<t color='#DA7422'>Recharge</t> the <t color='#76BED0'>Big Battery</t>",["Recharge the Big Battery", headBattery, "The Big Battery", {}, "Recharge"]],
  //waffle house
  ["Put in an <t color='#DA7422'>order</t> for <t color='#76BED0'>Hash Browns</t>", ["Order Hash Browns", waffleHouseMenu, "The Waffle House menu tablet", {}, "Order Hash Browns"]],
  ["Put in an <t color='#DA7422'>order</t> for <t color='#76BED0'>Steak and Eggs</t>", ["Order Steak and Eggs", waffleHouseMenu, "The Waffle House menu tablet", {}, "Order Steak and Eggs"]],
  ["Put in an <t color='#DA7422'>order</t> for <t color='#76BED0'>Waffles</t>", ["Order Waffles", waffleHouseMenu, "The Waffle House menu tablet", {}, "Order Waffles"]],
  ['Put in an <t color="#DA7422">order</t> for <t color="#76BED0">"Waffles"</t>', ['Order "Waffles"', waffleHouseMenu, "The Waffle House menu tablet", {}, 'Order "Waffles"']],
  //infirmary
  //cryo bay
  //briefing room
    //a3\structures_f\civ\infoboards\data\mapboard_default_co.paa
  ["<t color='#DA7422'>Draw a Dick</t> on the <t color='#76BED0'>Whiteboard</t>", ["Draw a dick", whiteboard, "The Whiteboard", drawADick, "Draw a Dick"]],
  //slip drive
  ["<t color='#DA7422'>Check</t> <t color='#76BED0'>Fuel Cell</t> for Leaks",["Check for leaks", fuelCell, "The Fuel Cell", {}, "Check"]],
  ["<t color='#DA7422'>Adjust</t> Slipperyspace Drive <t color='#76BED0'>Telemetry</t>",["Adjust Slipperyspace Drive Telemetry", slipTab, "Telemetry Computer", {}, "Adjust"]],
  ["<t color='#DA7422'>Spin</t> <t color='#76BED0'>Slipperyspace Drive</t>",["Spin", invisSpin, "The Price is Right Wheel", {}, "Spin"]],
  //maintenance
  ["<t color='#DA7422'>Read</t> the <t color='#76BED0'>Better Manual</t>",["Read the Better Manual",maintShelf,"The Better Manual",{},"Read"]],
  //storage
  //unnamed
  ["<t color='#DA7422'>Resist the Temptations</t> of the <t color='#613DC1'>Mysterious Plinth</t>",["Resist the Temptations",mysteriousPlinth,"The Mysterious Plinth",{},"Resist the Temptations"]],
  //data room
  ["<t color='#DA7422'>Check</t> the <t color='#76BED0'>Holo Map</t>",["Check the Holo Map", holoMap, "The Holo Map", {}, "Check"]],
  ["<t color='#DA7422'>Read</t> the <t color='#76BED0'>Manual</t>",["Read the Manual", manualData, "The Manual", {}, "Read"]],
  //mess hall
  //brig
  //captain's room
  ["<t color='#DA7422'>Water</t> the <t color='#76BED0'>Ship's Plant</t>",["Water the plant", capPlant, "The Ship's Plant", {}, "Water"]],
  //officer's
  ["<t color='#DA7422'>Phone it in</t>",["Phone it in", telephone, "The telephone", {}, "Phone it in"]],
  //bridge
  ["Go to <t color='#990000'>Red</t> Alert", ["Red Alert", redAlertConsole, "The Bridge's Alert Console", redAlert, "<t color='#990000'>Red</t> Alert"]],
  ["Go to <t color='#CCCC00'>Yellow</t> Alert", ["Yellow Alert", redAlertConsole, "The Bridge's Alert Console", {}, "<t color='#CCCC00'>Yellow</t> Alert"]],
  ["Go to <t color='#009900'>Green</t> Alert", ["Green Alert", redAlertConsole, "The Bridge's Alert Console", greenAlert, "<t color='#009900'>Green</t> Alert"]],
  ["Go to <t color='#613DC1'>Purple</t> Alert", ["Purple Alert", redAlertConsole, "The Bridge's Alert Console", purpleAlert, "<t color='#613DC1'>Purple</t> Alert"]],
  ["Go to Plaid Alert", ["<t color='#990000'>P</t><t color='#009900'>l</t><t color='#990000'>a</t><t color='#009900'>i</t><t color='#990000'>d</t> Alert", redAlertConsole, "The Bridge's Alert Console", plaidAlert, "<t color='#990000'>P</t><t color='#009900'>l</t><t color='#990000'>a</t><t color='#009900'>i</t><t color='#990000'>d</t> Alert"]]
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
  [squadBay2Directory,["The <t color='#76BED0'>Self Destruct Device</t> has a blanket thrown over it in Squad Bay 2.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

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
  [headDirectory,["Someone left the <t color='#76BED0'>Big Battery</t> in the Head.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [waffleHouseDirectory,["WAFFLE HOUSE DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [waffleHouseDirectory,["The Waffle House is in the Main Hangar.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [waffleHouseDirectory,["<t color='#76BED0'>Breakfast foods</t> can be <t color='#DA7422'>ordered</t> using one of the tablets on the counter.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [infirmaryDirectory,["INFIRMARY DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [infirmaryDirectory,["The Infirmary is in the Main Hangar, towards the front of the ship.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [cryoBayDirectory,["CRYONICS BAY DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [cryoBayDirectory,["The Cryonics Bay is in the Infirmary.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [cryoBayDirectory,["The <t color='#76BED0'>Fire Suppression System</t> can be found in the Cryonics Bay.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [briefRoomDirectory,["COMBAT INFORMATION CENTER DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [briefRoomDirectory,["The Combat Information Center is in the Middle Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [slipdriveDirectory,["SLIPDRIVE DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [slipdriveDirectory,["The <t color='#76BED0'>Slipperyspace Drive</t> is in the Middle Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [slipdriveDirectory,["We store <t color='#76BED0'>Fuel Cells</t> near the Slipperyspace Drive.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [maintenanceDirectory,["MAINTENANCE ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [maintenanceDirectory,["The Maintenance Room is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [maintenanceDirectory,["The <t color='#76BED0'>Better Manual</t> is in Maintenance.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [storageDirectory,["STORAGE ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [storageDirectory,["The Storage Room is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [unnamedDirectory,["UNLABELED ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [unnamedDirectory,["The Unlabeled Rooms are in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [unnamedDirectory,["The <t color='#613DC1'>Mysterious Plinth</t> is in one of the Unlabeled Rooms.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [dataRoomDirectory,["DATA ROOM DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [dataRoomDirectory,["The Data Room is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [dataRoomDirectory,["The <t color='#76BED0'>Manual</t> is deep within the Data Room, on a small shelf.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [dataRoomDirectory,["The spare <t color='#76BED0'>Holo Map</t> is stashed somewhere in the Data Room.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [messHallDirectory,["MESS HALL DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [messHallDirectory,["The Mess Hall is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [securityDirectory,["SECURITY ROOM AND BRIG DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [securityDirectory,["Security is in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [captainsDirectory,["CAPTAIN'S QUARTERS DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [captainsDirectory,["The Captain's Quarters are in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [captainsDirectory,["The <t color='#76BED0'>Ship's Plant</t> is in the Captain's Quarters.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

  [officersDirectory,["OFFICER'S QUARTERS DIRECTORY",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [officersDirectory,["The Officer's Quarters are in the Upper Deck.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];
  [officersDirectory,["The Ship's Old-School <t color='#DA7422'>Phone</t> is in the Officer's Quarters.",{},[],1.5,true,true,"","true",10,false,"",""]] remoteExec ["addAction", 0, true];

};

//there are probably better places to put these, but oh well
fireSuppressionSystem addAction ["Activate Fire Suppression System",{[] remoteExec ["fireSuppression", 2, false];},[],1.5,true,true,"","true",10,false,"",""];
