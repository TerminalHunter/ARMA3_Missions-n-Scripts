createSupplyDrop = {
	params ["_dataArray"];
	_poorSchmuck = selectRandom allPlayers;
	//_newLootBox = "C_IDAP_supplyCrate_F" createVehicle ((getPos _poorSchmuck) vectorAdd [50,50,0]);
	_newLootBox = "C_IDAP_supplyCrate_F" createVehicle [0,0,0];
	_newLootBoxParachute = "NonSteerable_Parachute_F" createVehicle [0,0,0];
	_newLootBox attachTo [_newLootBoxParachute, [0,0,0]];
	_newLootBoxParachute setPosASL ((getPosASL _poorSchmuck) vectorAdd [0,0,100]);
	//TODO: make new supply drop box - make it like purple or something and give it a new config so it doesn't overlap with game modes that also use these boxen
		//TODO: and maybe also retexture the parachute lol
	//_newLootBox setPosASL ((getPosASL _poorSchmuck) vectorAdd [0,0,100]);
	clearItemCargoGlobal _newLootBox;
	clearWeaponCargoGlobal _newLootBox;
	clearMagazineCargoGlobal _newLootBox;
	clearItemCargoGlobal _newLootBox;
	clearBackpackCargoGlobal _newLootBox;

	if ((_dataArray select 2) == "") then {
		_newLootBox call createLootBox;
	} else {
		_parsedWords = false;
		_words = (_dataArray select 2) splitString " ";
		{
			switch (_x) do {
				case "live":{
					[_newLootBox] spawn makeFullOfLiveGrenades;
					_parsedWords = true;
				};
				case "grenades":{
					[_newLootBox] spawn makeFullOfLiveGrenades;
					_parsedWords = true;
				};
				case "medical":{
					_newLootBox addItemCargoGlobal ["ACE_plasmaIV", 20];
					_newLootBox addItemCargoGlobal ["ACE_packingBandage", 25];
					_newLootBox addItemCargoGlobal ["ACE_elasticBandage", 25];
					_newLootBox addItemCargoGlobal ["ACE_quikclot", 25];
					_newLootBox addItemCargoGlobal ["ACE_epinephrine", 10];
					_newLootBox addItemCargoGlobal ["ACE_morphine", 10];
					_newLootBox addItemCargoGlobal ["ACE_splint", 10];
					_newLootBox addItemCargoGlobal ["ACE_tourniquet", 10];
					_newLootBox addItemCargoGlobal ["ACE_surgicalKit", 2];
					_parsedWords = true;
				};
				case "ammo":{
					[_newLootBox] spawn giveUsefulAmmoToAll;
					_parsedWords = true;
				};
				case "lollipops":{
					_newLootBox addItemCargoGlobal ["immersion_pops_poppack", 100];
					_parsedWords = true;
				};
				case "toolkits":{
					_newLootBox addItemCargoGlobal ["ToolKit", 10];
					_parsedWords = true;
				};
				case "smokes":{
					_newLootBox addItemCargoGlobal ["murshun_cigs_cigpack", 10];
					_newLootBox addItemCargoGlobal ["Smokeshell", 10];
					_newLootBox addItemCargoGlobal ["murshun_cigs_lighter", 2];
					_parsedWords = true;
				};
				case "snacks":{
					_newLootBox addItemCargoGlobal ["ACE_Chemlight_HiBlue", 10];
					_newLootBox addItemCargoGlobal ["ACE_Chemlight_HiGreen", 10];
					_newLootBox addItemCargoGlobal ["ACE_Chemlight_HiRed", 10];
					_newLootBox addItemCargoGlobal ["ACE_Chemlight_HiWhite", 10];
					_newLootBox addItemCargoGlobal ["ACE_Chemlight_HiYellow", 10];
					_parsedWords = true;
				};
				case "unsafely":{
					detach _newLootBox;
					_newLootbox setPosASL (getPosASL _newLootBoxParachute);
				};
				//TODO: gyas
				default {
					//[_newLootBox, _x] call checkIfPlayer; //what's this? the proper reuse of code?! an extra large helping of BEES ought to help that!
					_squishVictim = [_x] call getSpecificPlayer;
					if(!isNull _squishVictim) then {
						_newLootBoxParachute setPosASL ((getPosASL _squishVictim) vectorAdd [0,0,100]);
					};
				};
			};
		} forEach _words;
		if (!_parsedWords) then {
			_newLootBox call createLootBox;
		};
		//["Twitch Chat: Supply Drop Inbound!"] remoteExec ["systemChat",0,false];
	};
};

createLootbox = {
	params["_box"];
	switch (floor(random(10))) do {
		case 0:{
			[_box] spawn makeFullOfLiveGrenades;
		};
		case 1:{
			_box addItemCargoGlobal ["ACE_plasmaIV", 10];
			_box addItemCargoGlobal ["ACE_packingBandage", 25];
			_box addItemCargoGlobal ["ACE_elasticBandage", 25];
			_box addItemCargoGlobal ["ACE_quikclot", 25];
			_box addItemCargoGlobal ["ACE_epinephrine", 10];
			_box addItemCargoGlobal ["ACE_morphine", 10];
			_box addItemCargoGlobal ["ACE_splint", 10];
			_box addItemCargoGlobal ["ACE_tourniquet", 10];
			_box addItemCargoGlobal ["ACE_surgicalKit", 2];
		};
		case 2:{
			[_box] spawn giveUsefulAmmoToAll;
		};
		case 3:{
			_box addItemCargoGlobal ["immersion_pops_poppack", 100];
		};
		case 4:{
			_box addItemCargoGlobal ["ToolKit", 10];
		};
		case 5:{
			_box addItemCargoGlobal ["murshun_cigs_cigpack", 10];
			_box addItemCargoGlobal ["Smokeshell", 10];
			_box addItemCargoGlobal ["murshun_cigs_lighter", 2];
		};
		case 6:{
			_box addItemCargoGlobal ["ACE_Chemlight_HiBlue", 10];
			_box addItemCargoGlobal ["ACE_Chemlight_HiGreen", 10];
			_box addItemCargoGlobal ["ACE_Chemlight_HiRed", 10];
			_box addItemCargoGlobal ["ACE_Chemlight_HiWhite", 10];
			_box addItemCargoGlobal ["ACE_Chemlight_HiYellow", 10];
		};
		case 7:{
			[_box] spawn giveUsefulAmmoToAll;
		};
		case 8:{
			[_box] spawn giveUsefulAmmoToAll;
		};
		case 9:{
			[_box] spawn giveUsefulAmmoToAll;
		};
	};
};

makeFullOfLiveGrenades = {
	params["_badBox"];
	if (isNull (attachedTo _badBox)) then {
		waitUntil {getPos _badBox select 2 < 3};
		_dumb1 = "GrenadeHand" createVehicle (getPos _badBox);
		_dumb1 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
		_dumb2 = "GrenadeHand" createVehicle (getPos _badBox);
		_dumb2 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
		_dumb3 = "GrenadeHand" createVehicle (getPos _badBox);
		_dumb3 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
		_dumb4 = "GrenadeHand" createVehicle (getPos _badBox);
		_dumb4 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
		_dumb5 = "GrenadeHand" createVehicle (getPos _badBox);
		_dumb5 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
	} else {
		private _badChute = attachedTo _badBox;
		waitUntil {getPos _badChute select 2 < 3};
		_dumb1 = "GrenadeHand" createVehicle (getPos _badChute);
		_dumb1 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
		_dumb2 = "GrenadeHand" createVehicle (getPos _badChute);
		_dumb2 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
		_dumb3 = "GrenadeHand" createVehicle (getPos _badChute);
		_dumb3 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
		_dumb4 = "GrenadeHand" createVehicle (getPos _badChute);
		_dumb4 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
		_dumb5 = "GrenadeHand" createVehicle (getPos _badChute);
		_dumb5 setVelocity [(random 10) - 5,(random 10) - 5, random 12];
		//you could probably just [_badChute] spawn makeFullofLiveGrenades but fuck it I'm tired.
	};

};

giveUsefulAmmo = {
	params["_goodBox"];
	_randomSchmuck = selectRandom allPlayers;
	_gunTheSchmuckHas = primaryWeapon _randomSchmuck;
	if (_gunTheSchmuckHas == "") then {
		[_goodBox] spawn giveUsefulAmmo;
	} else {
		_ammo1 = selectRandom compatibleMagazines _gunTheSchmuckHas;
		_ammo2 = selectRandom compatibleMagazines _gunTheSchmuckHas;
		_ammo3 = selectRandom compatibleMagazines _gunTheSchmuckHas;
		_ammo4 = selectRandom compatibleMagazines _gunTheSchmuckHas;
		{
			_goodBox addItemCargoGlobal [_x, 10];
		} forEach [_ammo1,_ammo2,_ammo3,_ammo4]
	};
};

giveUsefulAmmoToAll = {
	params["_gooderBox"];
	{
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines primaryWeapon _x, 12];
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines primaryWeapon _x, 12];
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines primaryWeapon _x, 12];
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines handgunWeapon _x, 10];
		_gooderBox addItemCargoGlobal [selectRandom compatibleMagazines secondaryWeapon _x, 10];
	} forEach allPlayers;
};

checkIfPlayer = {
	params ["_box", "_stringToCheck"];
	{
		/*
		_nameArray = (toLower(name _x)) splitString " ";
		if(toLower(_stringToCheck) in _nameArray) then {
			_box setPosASL ((getPosASL _x) vectorAdd [0,0,100]);
		};
		*/

		if (name _x == _stringToCheck) then {
			_box setPosASL ((getPosASL _x) vectorAdd [0,0,100]);
		};
	} forEach allPlayers;
};