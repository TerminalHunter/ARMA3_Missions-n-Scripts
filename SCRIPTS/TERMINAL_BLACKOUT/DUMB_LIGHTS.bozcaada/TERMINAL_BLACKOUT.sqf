/*


TERMINALHUNTER'S CINEMATIC BLACKOUT SCRIPT

CLIENTSIDE FUNCTIONS ONLY
No Mods Should be needed.

INSTRUCTIONS:

Mission script should, when the cinematic blackout needs to be triggered, run the following:

[] remoteExec ["triggerBlackout"];


If needed, Zeus can run the following under GLOBAL context:

[] spawn triggerBlackout;



*/

/////
// DATA
/////

everyFuckingLight = [];
everyFuckingFakeLight = [];

blackoutEnabled = false;

/////
// FUNCTIONS
/////

setDistantLightParticle = {
	params ["_object"];
	_partiBoi = "#particlesource" createVehicleLocal (getPosATL _object);
	_partiBoi setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,0.5,[0,0,6],[0,0,0],0,0.05,0.04,0,[2.5],[[1,1,0.170434,-100]],[1],1,0,"","","",0,false,0,[[0,0,0,0]],[0,1,0]];
	_partiBoi setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0,1,0];
	_partiBoi setParticleCircle [0,[0,0,0]];
	_partiBoi setParticleFire [0,0,0];
	_partiBoi setDropInterval 0.05;
	everyFuckingFakeLight pushBack _partiBoi;
};

buildLights = {
	//Every literal light
	{
		if(!((lightIsOn _x) == "ERROR")) then {
			everyFuckingLight pushBack _x;
		};
	} forEach (1 allObjects 0);

	//Every building, should conceivably have a light
	{
		//TODO: maybe randomize the position a bit
		if (floor(random(2)) == 0) then {
			everyFuckingLight pushBack _x;
		};
	} forEach nearestTerrainObjects [[0,0,2],["House"],worldSize*2,false];

	//Actually spawn the particle emitters
	{
		_x call setDistantLightParticle;
	} forEach everyFuckingLight;
};

hideCloseLights = {
	while {!blackoutEnabled} do {
		sleep 3;
		{
			if (_x distance2D player > 800) then {
				//_x setDropInterval 0.05;
				_x setParticleCircle [0,[0,0,0]];
			} else {
				//_x setDropInterval 10000;
				_x setParticleCircle [100000,[0,0,0]];
			};
		} forEach everyFuckingFakeLight;
	};
};

triggerBlackout = {
	xThingy = worldSize;
	while {xThingy > 0} do {
		hint str(xThingy);
		sleep 1;
		{
			if (((getPos _x) select 0) > xThingy) then {
				deleteVehicle _x;
			};
		} forEach everyFuckingFakeLight;
		{
			if (((getPos _x) select 0) > xThingy) then {
				_x switchLight "OFF";
			}
		} forEach everyFuckingLight;
		xThingy = xThingy - 1000;
	};
	blackoutEnabled = true;
};

/////
// START IT UP
/////

[] call buildLights;
[] spawn hideCloseLights;

// TODO: JIP after blackout consideration
// TODO: Funni noises
// TODO: See if Digi's 'tism needs the lights to be a certain color