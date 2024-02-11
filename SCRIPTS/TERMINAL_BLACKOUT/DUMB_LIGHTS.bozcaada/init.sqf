everyFuckingLight = [];
everyFuckingFakeLight = [];

setDistantLightParticle = {
	params ["_object"];
	_partiBoi = "#particlesource" createVehicleLocal (getPosATL _object);
	_partiBoi setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,0.5,[0,0,6],[0,0,0],0,0.05,0.04,0,[2.5],[[1,1,0.170434,-100]],[1],1,0,"","","",0,false,0,[[0,0,0,0]],[0,1,0]];
	_partiBoi setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0,1,0];
	_partiBoi setParticleCircle [0,[0,0,0]];
	_partiBoi setParticleFire [0,0,0];
	_partiBoi setDropInterval 0.03;
	everyFuckingFakeLight pushBack _partiBoi;
};

giveEveryoneAstigmatism = {
	params ["_object"];
	_partiBoi = "#particlesource" createVehicleLocal (getPosATL _object);
	_partiBoi setParticleParams [["\A3\data_f\ParticleEffects\Universal\SparksBall.p3d",16,7,48,1],"","SpaceObject",1,0.5,[0,0,6],[0,0,0],0,0.05,0.04,0,[15],[[1,1,0.170434,-100]],[1],1,0,"","","",0,false,0,[[0,0,0,0]],[0,1,0]];
	_partiBoi setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0,1,0];
	_partiBoi setParticleCircle [0,[0,0,0]];
	_partiBoi setParticleFire [0,0,0];
	_partiBoi setDropInterval 0.06;
	everyFuckingFakeLight pushBack _partiBoi;
};

{
	/*
	if (typeOf _x == "Land_LampStreet_small_F") then {
		_x call setDistantLightParticle;
	};
	*/

	if(!((lightIsOn _x) == "ERROR")) then {
		//_x call setDistantLightParticle;
		everyFuckingLight pushBack _x;
	};
} forEach (1 allObjects 0);

{
	//_x call setDistantLightParticle;
	everyFuckingLight pushBack _x;
} forEach nearestTerrainObjects [[0,0,0],["House"],worldSize*2,false];

{
	_x call setDistantLightParticle;
	//_x call giveEveryoneAstigmatism; //YEAH THIS DOESN'T WORK ALL THAT NICE
} forEach everyFuckingLight;

xThingy = worldSize;

[] spawn {
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
};


/*
itslitfam = [
	lit,
	lit_1,
	lit_2,
	lit_3,
	lit_4,
	lit_5
];

{
	_x call setDistantLightParticle;
} forEach itslitfam;
*/

/*
allLamps = [];

{
	if (typeOf _x == "Land_LampStreet_small_F") then {
		allLamps pushBack _x;
		_x switchLight "OFF";
		//_newLight =  "Land_HelipadEmpty_F" createVehicle (getPos _x);
		//_x hideObject true;
		//_newLight call setDistantLightParticle;
	};
} forEach nearestTerrainObjects [getPos player, [], 1000];
*/

// 13000 -> 15000 in 100 increments

/*
lightSwitchArray = ["ON", "OFF"];
lightState = 0;
xValueNow = 13000;

[] spawn {
	while {true} do {
		if (xValueNow < 15000) then {
			xValueNow = xValueNow + 100;
			{
				if ((getPos _x) select 0 < xValueNow) then {
					_x switchLight (lightSwitchArray select lightState);
				};
			} forEach (1 allObjects 0);
		} else {
			xValueNow = 13000;
			if (lightState == 0) then {
				lightState = 1;
			} else {
				lightState = 0;
			}
		};
		sleep 0.01;
	};
};
*/