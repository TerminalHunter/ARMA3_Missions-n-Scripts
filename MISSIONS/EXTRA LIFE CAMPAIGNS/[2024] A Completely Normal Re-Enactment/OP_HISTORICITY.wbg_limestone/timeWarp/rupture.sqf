// by ALIAS

/*
if (!isServer) exitWith {};

_sky_obj = _this select 0;

if (!isNil {_sky_obj getVariable "is_ON"}) exitwith {}; 
_sky_obj setVariable ["is_ON",true,true];

[[_sky_obj],"AL_ambient_SFX\rupture_SFX.sqf"] remoteexec ["execvm",0,true];
*/

// by ALIAS
// space-time rupture

//if (!hasInterface) exitwith {};

//_sky_obj = _this select 0;

//while {!isNull _sky_obj} do 
createVerticalRupture = {
    params ["_sky_obj"];

	private _sp_rupture = "#particlesource" createVehicleLocal getPosATL _sky_obj;
	_sp_rupture setParticleCircle [0,[0,0,0]];
	_sp_rupture setParticleRandom [10,[1,1,250],[0,0,0],0.01,1,[0,0,0,0.1],1,0];
	_sp_rupture setParticleParams [["\A3\data_f\VolumeLight", 1, 0, 1], "", "SpaceObject", 1,60,[0,0,150],[0,0,0],0,9.996,7.84,0,[20,30,20],[[0,0,0,0],[1,1,0.25,1],[0.5,1,0.5,0]],[0.08],1,0,"","",_sky_obj];
	_sp_rupture setDropInterval 0.006;

    private _sp_rupture2 = "#particlesource" createVehicleLocal getPosATL _sky_obj;
	_sp_rupture2 setParticleCircle [0,[0,0,0]];
	_sp_rupture2 setParticleRandom [10,[1,1,250],[0,0,0],0.3,1,[0,0,0,0.1],1,0];
	_sp_rupture2 setParticleParams [["\A3\data_f\VolumeLight", 1, 0, 1], "", "SpaceObject", 1,60,[0,0,150],[0,0,0],0,9.996,7.84,0,[20,30,20],[[0,0,0,0],[1,1,0.25,1],[0.5,1,0.5,0]],[0.08],1,0,"","",_sky_obj];
	_sp_rupture2 setDropInterval 0.05;

    sleep 1;

    deleteVehicle _sp_rupture;
    deleteVehicle _sp_rupture2;
};

createHorizontalRupture = {
    params ["_sky_obj"];

	private _sp_rupture = "#particlesource" createVehicleLocal getPosATL _sky_obj;
	_sp_rupture setParticleCircle [0,[0,0,0]];
	_sp_rupture setParticleRandom [10,[700,5,5],[0,0,0],0.01,1,[0,0,0,0.1],1,0];
	_sp_rupture setParticleParams [["\A3\data_f\VolumeLight", 1, 0, 1], "", "SpaceObject", 1,180,[0,0,250],[0,0,0],0,9.996,7.84,0,[20,30,20],[[0,0,0,0],[1,1,0.25,1],[0.5,1,0.5,0]],[0.08],1,0,"","",_sky_obj];
	_sp_rupture setDropInterval 0.006;

	sleep 6;
	deleteVehicle _sp_rupture;


};



/*
plankton thingy
particle_emitter_0 = "#particlesource" createVehicleLocal getPos player;
particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,13,12,0],"","Billboard",1,5,[0,0,0],[0,0,0],0,1.275,1,0,[0.006],[[0.4,0.4,0.4,0.02],[0.4,0.4,0.4,0.6],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,2],[0.4,0.4,0.4,0.6],[0.4,0.4,0.4,0.02]],[1000],0.7,0.006,"","","",0,false,0,[[0,0,0,0]]];
particle_emitter_0 setParticleRandom [1,[4.5,4.5,3.5],[0.02,0.02,0.02],0,0,[0.06,0.06,0.06,0],0.3,0.0009,1,0];
particle_emitter_0 setParticleCircle [0,[0,0,0]];
particle_emitter_0 setParticleFire [0,0,0];
particle_emitter_0 setDropInterval 0.0015;
*/

/*
particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.05,[0.2,0.8,2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]];
particle_emitter_0 setParticleRandom [0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0];
particle_emitter_0 setParticleCircle [0,[0,0,0]];
particle_emitter_0 setParticleFire [0,0,0];
particle_emitter_0 setDropInterval 0.1;
*/