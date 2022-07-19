/* The Menu:
Chemlight (Blue) - Chemlight_blue
Chemlight (Green) - Chemlight_green
Chemlight (Hi Blue) - ACE_Chemlight_HiBlue
Chemlight (Hi Green) - ACE_Chemlight_HiGreen
Chemlight (Hi Red) - ACE_Chemlight_HiRed
Chemlight (Hi White) - ACE_Chemlight_HiWhite
Chemlight (Hi Yellow) - ACE_Chemlight_HiYellow
Chemlight (IR) - ACE_Chemlight_IR
Chemlight (Orange) - ACE_Chemlight_Orange
Chemlight (Red) - Chemlight_red
Chemlight (Ultra-Hi Orange) - ACE_Chemlight_UltraHiOrange
Chemlight (White) - ACE_Chemlight_White
Chemlight (Yellow) - Chemlight_yellow
*/

glowstickEat = {
  params ["_playerEating","_emmissive","_color"];
  _particleDribble = "#particlesource" createVehicleLocal (getPosASL _playerEating);
  _particleDribble attachTo [_playerEating,[0,0.11,-1],"neck"];
  _particleDribble setParticleParams [["WarFXPE\ParticleEffects\Flare\Flare.p3d",1,0,1,0],"","Billboard",0.1,0.004,[0,0,1],[0,0,0],1,60,0.1,0.30,[0.1],_color,[-2],1,0.1,"","","",0,false,0,_emmissive];
  _particleDribble setParticleRandom [9.5,[0,0,0],[0.02,0.02,0],1,0.5,[0.05,0.05,0.05,0],1,1,360,0];
  _particleDribble setDropInterval 0.01;

  _particleCrunch = "#particlesource" createVehicleLocal (getPosASL _playerEating);
  _particleCrunch attachTo [_playerEating,[0,0.11,-1],"neck"];
  _particleCrunch setParticleParams [["WarFXPE\ParticleEffects\Flare\Flare.p3d",1,0,1,0],"","Billboard",0.1,0.004,[0,0,1],[0,0,0],1,60,0.1,0.30,[0.1],_color,[-2],1,0.1,"","","",0,false,0,_emmissive];
  _particleCrunch setParticleRandom [9.5,[0,0,0],[1,1,1.5],1,0.5,[0.05,0.05,0.05,0],1,1,360,0];
  _particleCrunch setDropInterval 0.002;

  sleep 0.1;

  deleteVehicle _particleCrunch;

  sleep 0.25;

  _particleCrunch2 = "#particlesource" createVehicleLocal (getPosASL _playerEating);
  _particleCrunch2 attachTo [_playerEating,[0,0.11,-1],"neck"];
  _particleCrunch2 setParticleParams [["WarFXPE\ParticleEffects\Flare\Flare.p3d",1,0,1,0],"","Billboard",0.1,0.004,[0,0,1],[0,0,0],1,60,0.1,0.30,[0.1],_color,[-2],1,0.1,"","","",0,false,0,_emmissive];
  _particleCrunch2 setParticleRandom [9.5,[0,0,0],[1,1,1.5],1,0.5,[0.05,0.05,0.05,0],1,1,360,0];
  _particleCrunch2 setDropInterval 0.002;

  sleep 0.1;

  deleteVehicle _particleCrunch2;

  sleep 0.35;

  _particleCrunch3 = "#particlesource" createVehicleLocal (getPosASL _playerEating);
  _particleCrunch3 attachTo [_playerEating,[0,0.11,-1],"neck"];
  _particleCrunch3 setParticleParams [["WarFXPE\ParticleEffects\Flare\Flare.p3d",1,0,1,0],"","Billboard",0.1,0.004,[0,0,1],[0,0,0],1,60,0.1,0.30,[0.1],_color,[-2],1,0.1,"","","",0,false,0,_emmissive];
  _particleCrunch3 setParticleRandom [9.5,[0,0,0],[1,1,1.5],1,0.5,[0.05,0.05,0.05,0],1,1,360,0];
  _particleCrunch3 setDropInterval 0.002;

  sleep 0.1;

  deleteVehicle _particleCrunch3;

  sleep 2;

  deleteVehicle _particleDribble
};

greenGlowstickEat = {
  params ["_playerEating"];
  _particleDribble = "#particlesource" createVehicleLocal (getPosASL _playerEating);
  _particleDribble attachTo [_playerEating,[0,0.11,-1],"neck"];
  _particleDribble setParticleParams [["WarFXPE\ParticleEffects\Flare\Flare.p3d",1,0,1,0],"","Billboard",0.1,0.004,[0,0,1],[0,0,0],1,60,0.1,0.30,[0.1],[[0,1,0,-0.25],[1,1,0.7,0]],[-2],1,0.1,"","","",0,false,0,[[0,10000,0,0.1]]];
  _particleDribble setParticleRandom [9.5,[0,0,0],[0.02,0.02,0],1,0.5,[0.05,0.05,0.05,0],1,1,360,0];
  _particleDribble setDropInterval 0.01;

  _particleCrunch = "#particlesource" createVehicleLocal (getPosASL _playerEating);
  _particleCrunch attachTo [_playerEating,[0,0.11,-1],"neck"];
  _particleCrunch setParticleParams [["WarFXPE\ParticleEffects\Flare\Flare.p3d",1,0,1,0],"","Billboard",0.1,0.004,[0,0,1],[0,0,0],1,60,0.1,0.30,[0.1],[[0,1,0,-0.25],[1,1,0.7,0]],[-2],1,0.1,"","","",0,false,0,[[0,10000,0,0.1]]];
  _particleCrunch setParticleRandom [9.5,[0,0,0],[1,1,1.5],1,0.5,[0.05,0.05,0.05,0],1,1,360,0];
  _particleCrunch setDropInterval 0.002;

  sleep 0.1;

  deleteVehicle _particleCrunch;

  sleep 0.25;

  _particleCrunch2 = "#particlesource" createVehicleLocal (getPosASL _playerEating);
  _particleCrunch2 attachTo [_playerEating,[0,0.11,-1],"neck"];
  _particleCrunch2 setParticleParams [["WarFXPE\ParticleEffects\Flare\Flare.p3d",1,0,1,0],"","Billboard",0.1,0.004,[0,0,1],[0,0,0],1,60,0.1,0.30,[0.1],[[0,1,0,-0.25],[1,1,0.7,0]],[-2],1,0.1,"","","",0,false,0,[[0,10000,0,0.1]]];
  _particleCrunch2 setParticleRandom [9.5,[0,0,0],[1,1,1.5],1,0.5,[0.05,0.05,0.05,0],1,1,360,0];
  _particleCrunch2 setDropInterval 0.002;

  sleep 0.1;

  deleteVehicle _particleCrunch2;

  sleep 0.35;

  _particleCrunch3 = "#particlesource" createVehicleLocal (getPosASL _playerEating);
  _particleCrunch3 attachTo [_playerEating,[0,0.11,-1],"neck"];
  _particleCrunch3 setParticleParams [["WarFXPE\ParticleEffects\Flare\Flare.p3d",1,0,1,0],"","Billboard",0.1,0.004,[0,0,1],[0,0,0],1,60,0.1,0.30,[0.1],[[0,1,0,-0.25],[1,1,0.7,0]],[-2],1,0.1,"","","",0,false,0,[[0,10000,0,0.1]]];
  _particleCrunch3 setParticleRandom [9.5,[0,0,0],[1,1,1.5],1,0.5,[0.05,0.05,0.05,0],1,1,360,0];
  _particleCrunch3 setDropInterval 0.002;

  sleep 0.1;

  deleteVehicle _particleCrunch3;

  sleep 2;

  deleteVehicle _particleDribble
};

//Chemlight_blue
_blueCondition = {
     "Chemlight_blue" in (itemsWithMagazines player);
};
_blueStatement = {
    [_target,[[0,0,10000,0.1]],[[0,0,1,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "Chemlight_blue";
};
_blueAction = ["EatBlueGlowstick","Eat Chemlight (Blue)","",_blueStatement,_blueCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _blueAction] call ace_interact_menu_fnc_addActionToClass;

//Chemlight_green
_greenCondition = {
     "Chemlight_green" in (itemsWithMagazines player);
};
_greenStatement = {
    [_target,[[0,10000,0,0.1]],[[0,1,0,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "Chemlight_green";
};
_greenAction = ["EatGreenGlowstick","Eat Chemlight (Green)","",_greenStatement,_greenCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _greenAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_HiBlue
_hiblueCondition = {
     "ACE_Chemlight_HiBlue" in (itemsWithMagazines player);
};
_hiblueStatement = {
    [_target,[[0,0,10000,0.1]],[[0,0,1,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "ACE_Chemlight_HiBlue";
};
_hiblueAction = ["EatHiBlueGlowstick","Eat Chemlight (Hi Blue)","",_hiblueStatement,_hiblueCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _hiblueAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_HiGreen
_higreenCondition = {
     "ACE_Chemlight_HiGreen" in (itemsWithMagazines player);
};
_higreenStatement = {
    [_target,[[0,10000,0,0.1]],[[0,1,0,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "ACE_Chemlight_HiGreen";
};
_higreenAction = ["EatHiGreenGlowstick","Eat Chemlight (Hi Green)","",_higreenStatement,_higreenCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _higreenAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_HiRed
_hiredCondition = {
     "ACE_Chemlight_HiRed" in (itemsWithMagazines player);
};
_hiredStatement = {
    [_target,[[10000,0,0,0.1]],[[1,0,0,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "ACE_Chemlight_HiRed";
};
_hiredAction = ["EatHiRedGlowstick","Eat Chemlight (Hi Red)","",_hiredStatement,_hiredCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _hiredAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_HiWhite
_hiwhiteCondition = {
     "ACE_Chemlight_HiWhite" in (itemsWithMagazines player);
};
_hiwhiteStatement = {
    [_target,[[10000,10000,10000,0.1]],[[1,1,1,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "ACE_Chemlight_HiWhite";
};
_hiwhiteAction = ["EatHiWhiteGlowstick","Eat Chemlight (Hi White)","",_hiwhiteStatement,_hiwhiteCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _hiwhiteAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_HiYellow
_hiyellowCondition = {
     "ACE_Chemlight_HiYellow" in (itemsWithMagazines player);
};
_hiyellowStatement = {
    [_target,[[10000,10000,0,0.1]],[[1,1,0,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "ACE_Chemlight_HiYellow";
};
_hiyellowAction = ["EatHiYellowGlowstick","Eat Chemlight (Hi Yellow)","",_hiyellowStatement,_hiyellowCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _hiyellowAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_IR
_irCondition = {
     "ACE_Chemlight_IR" in (itemsWithMagazines player);
};
_irStatement = {
    [_target,[[0,0,0,0.1]],[[0,0,0,-10],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "ACE_Chemlight_IR";
};
_irAction = ["EatIRGlowstick","Eat Chemlight (IR)","",_irStatement,_irCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _irAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_Orange
_orangeCondition = {
     "ACE_Chemlight_Orange" in (itemsWithMagazines player);
};
_orangeStatement = {
    [_target,[[10000,2000,0,0.1]],[[1,0.5,0,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "ACE_Chemlight_Orange";
};
_orangeAction = ["EatOrangeGlowstick","Eat Chemlight (Orange)","",_orangeStatement,_orangeCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _orangeAction] call ace_interact_menu_fnc_addActionToClass;

//Chemlight_red
_redCondition = {
     "Chemlight_red" in (itemsWithMagazines player);
};
_redStatement = {
    [_target,[[10000,0,0,0.1]],[[1,0,0,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "Chemlight_red";
};
_redAction = ["EatRedGlowstick","Eat Chemlight (Red)","",_redStatement,_redCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _redAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_UltraHiOrange
_hiorangeCondition = {
     "ACE_Chemlight_UltraHiOrange" in (itemsWithMagazines player);
};
_hiorangeStatement = {
    [_target,[[10000,2000,0,0.1]],[[1,0.5,0,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "ACE_Chemlight_UltraHiOrange";
};
_hiorangeAction = ["EatHiOrangeGlowstick","Eat Chemlight (Ultra-Hi Orange)","",_hiorangeStatement,_hiorangeCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _hiorangeAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_White
_whiteCondition = {
     "ACE_Chemlight_White" in (itemsWithMagazines player);
};
_whiteStatement = {
    [_target,[[10000,10000,10000,0.1]],[[1,1,1,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "ACE_Chemlight_White";
};
_whiteAction = ["EatWhiteGlowstick","Eat Chemlight (White)","",_whiteStatement,_whiteCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _whiteAction] call ace_interact_menu_fnc_addActionToClass;

//ACE_Chemlight_Yellow
_yellowCondition = {
     "Chemlight_yellow" in (itemsWithMagazines player);
};
_yellowStatement = {
    [_target,[[10000,10000,0,0.1]],[[1,1,0,-0.25],[1,1,0.7,0]]] remoteExec ["glowstickEat", 0, false];
    _target removeItem "Chemlight_yellow";
};
_yellowAction = ["EatYellowGlowstick","Eat Chemlight (Yellow)","",_yellowStatement,_yellowCondition] call ace_interact_menu_fnc_createAction;
["B_Survivor_F", 1, ["ACE_SelfActions","ACE_Equipment"], _yellowAction] call ace_interact_menu_fnc_addActionToClass;


//"ACE_Chemlight_HiGreen" or "Chemlight_green" itemsWithMagazines player
