#include "jackAnimations.sqf"

activatedAutodoc = "";

activateAutodoc = {
	params ["_autodocRequestingActivation"];
	activatedAutodoc = _autodocRequestingActivation;
	publicVariableServer "activatedAutodoc";
	publicVariableServer "startAutodoc";
};

serverRunAutodoc = {
  params ["_autodoc"];
  _detectedEnemies = [];
  _detectedEntities = _autodoc nearEntities 250;
  {
    if (side _x == east) then {
			if (!(_x getVariable ["ACE_isUnconscious" , false])) then {
      	_detectedEnemies append [_x];
			};
    };
  } forEach _detectedEntities;
  if (count _detectedEnemies == 0) then {
    //do some healing
    [_autodoc] spawn {
      params ["_machine"];
      ["Administering Medical Aid in 10 seconds.\nEnsure all patients are within 5 meters.\nRemove all patients from vehicles."] remoteExec ["hint",0,false];
      _helperCircle = "VR_Area_01_circle_4_yellow_F" createVehicle (getPos _machine);
      _helperCircle setPosASL ((getPosASL _machine) vectorAdd [0,0,0.44]); //ASL?
      [_helperCircle] remoteExec ["speenAnimation",0,false];
      sleep 10;
      _potentialHealingTargets = _machine nearEntities 5;
      {
        if (isPlayer _x) then {
          [_machine, _x] call ace_medical_treatment_fnc_fullHeal;
          _x addItem "immersion_pops_poppack";
        };
      } forEach _potentialHealingTargets;
      deleteVehicle _helperCircle;
      ["Medical Aid (and lollipops) Administered"] remoteExec ["hintSilent",0,false];
			if (floor(random 10) == 1) then {
				{
					_x addItem "murshun_cigs_cigpack";
				} forEach _potentialHealingTargets;
				["Doc says your respiration could be better.\nHave a pack of Chesterfields!"] remoteExec ["hintSilent",0,false];
			};
    };
  } else {
    //warn players of nearby enemy
    _firstdetectedEnemy = _detectedEnemies select 0;
    _typeOfEnemy = typeOf _firstdetectedEnemy;
    _enemyHeading = (getPos _autodoc) getDir (getPos _firstdetectedEnemy);
    _warningMessage = "We got incoming at " + (str (floor _enemyHeading)) + "!\nWe can't insta-patch people up until they're gone!";
    [_warningMessage] remoteExec ["hint",0,false];
  };
};

//server init
if (isServer) then {
    "startAutodoc" addPublicVariableEventHandler {
	     [activatedAutodoc] call serverRunAutodoc;
  };
};

/*
[] spawn {
_helperCircle = "VR_Area_01_circle_4_yellow_F" createVehicle (getPos cursorObject);
_helperCircle setPos (getPos cursorObject);
sleep 10;
deleteVehicle _helperCircle;
};
*/
