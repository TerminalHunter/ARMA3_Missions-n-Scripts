confettiExplosion = {

    params["_celebrationObject"];

    playSound3D ["terminal_script_kittens\content\confetti_sfx.ogg", _celebrationObject];

    [_celebrationObject, "terminal_script_kittens\content\blue_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "terminal_script_kittens\content\red_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "terminal_script_kittens\content\green_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "terminal_script_kittens\content\yellow_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "terminal_script_kittens\content\purple_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "terminal_script_kittens\content\pink_fetti"] spawn spawnColorConfetti;

};


spawnColorConfetti = {
    params ["_celebrationObject", "_fetti"];
    private _dir = direction _celebrationObject;
    private _vel = velocity _celebrationObject;
    _newConfetti = "#particlesource" createVehicleLocal (getPos _celebrationObject);
    _newConfetti setParticleParams [
        [_fetti,1,0,1,1],
        "",
        "SpaceObject",
        1,
        15, //lifetime
        _celebrationObject selectionPosition "head",

        [
	        (_vel select 0) + (sin _dir * 1),
	        (_vel select 1) + (cos _dir * 1),
	        (_vel select 2) + 2
	    ],

        1,
        0.005,
        0.0038,
        0.1,
        [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0],
        [[1,0,0,1]],
        [0.8,0.3,0.25],
        2,
        1,
        "",
        "",
        _celebrationObject,
        0,
        true,
        0.1,
        [[0,0,0,0]]
    ]; 
    //_newConfetti setParticleParams [[_fetti,1,0,1,1],"","SpaceObject",1,25,[0,0,1],[0,-0.2,0],1,0.005,0.0038,0.1,[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0],[[1,0,0,1]],[0.8,0.3,0.25],2,1,"","",_celebrationObject,0,true,0.1,[[0,0,0,0]]];
    _newConfetti setParticleRandom [5,[0.1,0.05,0.1],[0.6,0.6,1.6],0,0,[0,0,0,0],1,0,0,0];
    _newConfetti setParticleCircle [0,[0,0,0]];
    _newConfetti setParticleFire [0,0,0];
    _newConfetti setDropInterval 0.001;
    sleep 0.3;
    deleteVehicle _newConfetti;
};