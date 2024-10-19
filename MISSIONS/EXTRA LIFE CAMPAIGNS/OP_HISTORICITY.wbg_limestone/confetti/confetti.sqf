confettiExplosion = {

    params["_celebrationObject"];

    sleep 2;

    playSound3D [getMissionPath "confetti\confetti_sfx.ogg", _celebrationObject];

    [_celebrationObject, "confetti\blue_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "confetti\red_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "confetti\green_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "confetti\yellow_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "confetti\purple_fetti"] spawn spawnColorConfetti;
    [_celebrationObject, "confetti\pink_fetti"] spawn spawnColorConfetti;

};


spawnColorConfetti = {
    params ["_celebrationObject", "_fetti"];
    _newConfetti = "#particlesource" createVehicleLocal (getPos _celebrationObject vectorAdd [0,0,0.5]);
    _newConfetti setParticleParams [[getMissionPath _fetti,1,0,1,1],"","SpaceObject",1,25,[0,0,1],[0,-0.2,0],1,0.005,0.0038,0.1,[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0],[[1,0,0,1]],[0.8,0.3,0.25],2,1,"","","",0,true,0.1,[[0,0,0,0]]];
    _newConfetti setParticleRandom [5,[0.1,0.05,0.1],[0.6,0.6,1.6],0,0,[0,0,0,0],1,0,0,0];
    _newConfetti setParticleCircle [0,[0,0,0]];
    _newConfetti setParticleFire [0,0,0];
    _newConfetti setDropInterval 0.001;
    sleep 0.5;
    deleteVehicle _newConfetti;
};

//[player] spawn confettiExplosion;