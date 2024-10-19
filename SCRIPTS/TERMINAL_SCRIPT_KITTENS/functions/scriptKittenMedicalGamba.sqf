/*

SCRIPT KITTEN THAT GIVES RANDOM MEDICAL ITEMS INSTEAD OF THE STANDARD ACE SET

*/

randomMedicalKit = {
	_numBandages = (floor random 4) + 1;
	_numStandardItems = floor random 4;
	_numRareItems = floor random 2;
	_itemList = [];
	for "_i" from 1 to _numBandages do {
		_itemList pushBack selectRandom["ACE_fieldDressing","ACE_packingBandage","ACE_elasticBandage","ACE_quikclot"];
	};
	for "_j" from 1 to _numStandardItems do {
		_itemList pushBack selectRandom["ACE_morphine","ACE_tourniquet","ACE_epinephrine","ACE_plasmaIV_500","ACE_splint","ACE_painkillers"];
	};
	for "_k" from 1 to _numRareItems do {
		_itemList pushBack selectRandom["ACE_plasmaIV", "ACE_surgicalKit","Dermal_Repair_Matrix", "White_Goo", "Combat_Stim_A", "Combat_Stim_X", "Space_Painkiller"];
	};
	_itemList
};

player addEventHandler ["Take", {
	params ["_unit", "_container", "_item"];
	if (_item == "FirstAidKit") then {
		player removeItem "FirstAidKit";
		_spill = "GroundWeaponHolder" createVehicle position player;
		_spill setPos (getPos player vectorAdd [0.5,0.5,0]);
		{
			if (player canAdd _x) then {
				player addItem _x;
				deleteVehicle _spill;
			} else {
				_spill addItemCargoGlobal [_x,1]; //maybe have this check for nearby piles and add to it
			};
		} forEach ([] call randomMedicalKit);
	};
}];