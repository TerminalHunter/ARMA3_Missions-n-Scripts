speenAnimation = {
  params ["_spinner"];
  _spinnerDir = getDir _spinner;
  while {alive _spinner} do {
    sleep 0.02;
    _spinnerDir = _spinnerDir + 0.15;
    _spinner setDir _spinnerDir;
  };
};
