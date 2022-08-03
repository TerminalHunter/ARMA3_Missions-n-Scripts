serverRunAutodoc = {
  params ["_autodoc"];
  _detectedEnemies = [];
  _detectedEntities = _autodoc nearEntities 250;
  {
    if (side _x == east) then {
      _detectedEnemies append [_x];
    };
  } forEach _detectedEntities;
  if (count _detectedEnemies == 0) then {
    //do some healing
    [_autodoc] spawn {
      params ["_machine"];
      ["Administering Medical Aid in 10 seconds.\nEnsure all patients are within 5 meters.\nRemove all patients from vehicles."] remoteExec ["hint",0,false];
      _helperCircle = "VR_Area_01_circle_4_yellow_F" createVehicle (getPos _machine);
      _helperCircle setPos ((getPos _helperCircle) vectorAdd [0,0,0.44]);
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
      ["Administration Complete.\nDispensing Good {NULL} and/or Good Girl Lollipop."] remoteExec ["shorterHint",0,false];
    };
  } else {
    //warn players of nearby enemy
    _firstdetectedEnemy = _detectedEnemies select 0;
    _typeOfEnemy = typeOf _firstdetectedEnemy;
    _enemyHeading = (getPos _autodoc) getDir (getPos _firstdetectedEnemy);
    _warningMessage = _typeOfEnemy + " detected at heading " + (str (floor _enemyHeading)) + "\nSelf Preservation Protocol Engaged\nShutting Down\nkUser: Please Clear Area";
    [_warningMessage] remoteExec ["hint",0,false];
  };
};

speenAnimation = {
  params ["_spinner"];
  _spinnerDir = getDir _spinner;
  while {alive _spinner} do {
    sleep 0.02;
    _spinnerDir = _spinnerDir + 0.15;
    _spinner setDir _spinnerDir;
  };
};
