_unit = _this select 0;
while { (alive _unit)&&(_unit inArea radzone) } do {
  _uniform = uniform _unit;
  _goggles = goggles _unit;
  if (
  (["radiationsuit", _uniform] call BIS_fnc_inString)
  ) then { } else {
  //playSound "electricity_loop";
  playSound3D [getMissionPath "RadLoop.ogg", _unit, false, getPosASL _unit, 4, 1];
  _unit setDammage (_unit getVariable "Pdamage");
  _unit setStamina (_unit getVariable "Pstamina");
  "colorCorrections" ppEffectAdjust [(_unit getVariable "Pbright"), 1.0, 0.0, [0.2, 0.2, 1.0, 0.0], [0.4, 0.75, 1.0, (_unit getVariable "Pcolor")], [0.5, 0.3, 1.0, -0.1]];
  "colorCorrections" ppEffectCommit 1;
  "colorCorrections" ppEffectEnable TRUE;
  "filmGrain" ppEffectAdjust [(_unit getVariable "Pgrain"), 1, 1, 0, 1];
  "filmGrain" ppEffectCommit 1;
  "filmGrain" ppEffectEnable TRUE;
  "DynamicBlur" ppEffectAdjust [(_unit getVariable "Pblur")];
  "DynamicBlur" ppEffectCommit 1;
  "DynamicBlur" ppEffectEnable TRUE;
  _unit setVariable ["Pcolor",(_unit getVariable "Pcolor") - 0.04];
  _unit setVariable ["Pbright",(_unit getVariable "Pbright") - 0.03];
  _unit setVariable ["Pblur",(_unit getVariable "Pblur") + 0.1];
  _unit setVariable ["Pgrain",(_unit getVariable "Pgrain") + 0.0015];
  _unit setVariable ["Pdamage",(_unit getVariable "Pdamage") + 0.03];
  _unit setVariable ["Pstamina",(_unit getVariable "Pstamina") - 2];
  };
  sleep 5;
};

//blue filter
//"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.75],[0.5,0.3,1.0,-0.1]];
