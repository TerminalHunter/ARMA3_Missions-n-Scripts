/*
TODO:

    HIGH PRIORITY
		Vic loot
		VEHICLES FLIP!
		do ammo trucks save current ammo value (ace thing)
		huron containers REQUIRE items (they are not vehicles)
		you can steal ammo from enemy vehicle
			(it'd be funnier if it only took more time if vehicle is crewed by enemy)
		FUEL LOCALITY ISSUE
		LOOT TO VIC
		box to vic
		make sure boxes get ammo

    MEDIUM PRIORITY
		----------
		DIRECTOR.
        	CONVOY SHOULD WAIT AT CERTAIN POINTS BETTER - pull out the waypoints - see if the wait time can be overridden. then maybe get a thingy director to fuck around.
            	wait time cannot be overridden, but setCurrentWaypoint works. 
            	wait X minutes after every car is within  Y meters? 10 minutes after all groups are detected to have the same waypoint
			Vehicle will take contact but then just ignore all further orders?
			maybe keep track of where the convoy is
		-----------
		make the factions better - more loot, weapons, designs, etc.
		more, harder enemies spawn as players build up -- kinda like a rimworld wealth->difficulty thing
        fuel siphoning and salvaging should take time (green bar ace thingy)
        toolkit market
            used cars salesmen. discounts for fucked up vics
        when saving vics, give feedback (little "this vehicle saved as BIRD 07" above it)
		autodoc at spawn?

    LOW PRIORITY
		ammo stealing - putting a box of ammo into full ammo truck eats ammo
        scrapping -- wrecks -> semi-random number of toolkits
        I guess also save arbitrary items? Let the players take things home.
        Hidden Caches and side-treasures
        see if you can't do kitbashing better than other missions
        sandstorms! see if you can get npc's to actually lose sight or reset their awareness
        Game Things.
			Start of game, no save game detected, what do the players start with?
			No-Toes Donny and the Coloracle of Save Deletion
        make perfidy script a script kitten?
        add lollipop suck sound to gas siphoning
        https://github.com/alezm00/ARMA-3-3D-Progress-Bar 
		clean all of this up, maybe have like. path objects or otherwise.
		add a check for DLC loaded?
		do we want to actually adjust where the new vics spawn so we aren't making a NorthSouth vertical line of cars everywhere? 
*/

#include "setUpMission.sqf"
#include "raiderArsenal.sqf"
#include "saveSystem.sqf"

#include "enemies.sqf"
#include "convoy.sqf"

#include "signalSimulator.sqf"
#include "perfidy.sqf"
#include "fuelSiphon.sqf"

waitUntil {time > 5};

[] call updateArsenal;
[exfilJackShack] call makePirateArsenal;
[exfilLoadoutBoxen] call checkRaiderStorage;


/*

OLDER NOTES:::

ARMA SHIT

	MAD MAX
		EXTRACTION! 
			Bring a bunch of cars to an area you specify and they all get saved
			CARS ARE YOUR INVENTORY. WANNA BRING MORE SHIT INTO THE NEXT MISSION? STUFF IT IN A BOX OR SOEMTHING AND STICK IT IN A CAR.
				cars blink or get a icon over them if they're within save zone
		Figure out how to get new cars to spawn in - in various states of disrepair and ammolessness
			Fuel, Ammo, toolkits, spare tires, etc. should be at a premium
		Shops? Make a new bottlecap? Bananas?
			Toolkits reskinned to useable scrap or something
				Large store of value being a dumb thing like a printed out NFT
					wait, the pamphlets could work
					wait, the pamphlets could work
					wait, the pamphlets could work
		BAAAA (that's 24 a's) wants to playtest
		THE VULTURES. When smoke rises, the vultures will converge. Put some old testimate shit in there about sacrifices being a pleasing smell to god or some shit.
			if you make a trailer, showcase this game mechanic
			FUCK IT. DANS DANS DANS by JACK PAROW, BEST THING SINCE SLICED BREAD
			and weird bible quotes misread and misinterpreted because burning vehicles smell good to god
		CROWS EWAR - keep it and have the ability to track shit
		TASTEFUL REWARDS FOR CAPTURING PEOPLE ALIVE
			encourage players to respawn -- but bring medical for... interns...
		KITBASH SCRIPT

Vehicles need to have in their save data:
	damage data
	inventory data
	ammo count/data

AMMO FROM ONE AMMO TRUCK TO ANOTHER?

arsenal needs ability to grab an antenna - since cool





*/