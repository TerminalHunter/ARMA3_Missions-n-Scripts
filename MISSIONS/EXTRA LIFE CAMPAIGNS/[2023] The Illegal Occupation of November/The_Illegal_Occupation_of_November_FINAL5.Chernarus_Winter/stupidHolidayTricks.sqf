orangePainter addAction ["Color the World Orange", {[] spawn turnTheWorldOrange},[],6,true,true,"","true",9,false,"",""];

turnTheWorldOrange = {
	["ColorCorrections", 1500, [1, 0.9, 0, [1, 0.3, 0, 0.5], [1, 1, 1, 1], [0.299, 0.587, 0.114, 0]]] spawn 
	{ 
		params ["_name", "_priority", "_effect", "_handle"]; 
		while { 
			_handle = ppEffectCreate [_name, _priority]; 
			_handle < 0 
		} do { 
			_priority = _priority + 1; 
		}; 
		_handle ppEffectEnable true; 
		_handle ppEffectAdjust _effect; 
		_handle ppEffectCommit 5; 
		waitUntil { ppEffectCommitted _handle }; 
		systemChat "Aint that nice? World's forever orange now."; 
		uiSleep 5; 
		_handle ppEffectEnable false; 
		ppEffectDestroy _handle; 
		systemChat "Nah, you're good. Thanks for indulging me. The Holiday's actually about bringing awareness to Complex Regional Pain Syndrome and Reflex Sympathetic Dystrophy."
	};
};

questionFurry addAction ['"Oh, us? The RV broke down while we were headed for Midwest FurFest (Nov. 30th)"', {},[],6,true,true,"","true",9,false,"",""];
pizzaFurry addAction ['"Hey, I got... uh... something I need help with."', {},[],6,true,true,"","true",9,false,"",""];
pizzaFurry addAction ['"Help" the furry', {
	[] call helpTheFurry;
	sleep 12;
	[["White_Goo"], 'white goo', ''] remoteExec ["addUnlocksToArsenal", 0];
},[],6,true,true,"","true",9,false,"",""];

helpTheFurry = {
	["ColorCorrections", 1500, [0, 0.9, 0, [0, 0, 0, 1], [1, 1, 1, 1], [0.299, 0.587, 0.114, 0]]] spawn 
	{ 
		params ["_name", "_priority", "_effect", "_handle"]; 
		while { 
			_handle = ppEffectCreate [_name, _priority]; 
			_handle < 0 
		} do { 
			_priority = _priority + 1; 
		}; 
		_handle ppEffectEnable true; 
		_handle ppEffectAdjust _effect; 
		_handle ppEffectCommit 5; 
		waitUntil { ppEffectCommitted _handle }; 
		systemChat 'Wait, what do you mean, "on the pizza?"'; 
		uiSleep 5; 
		_handle ppEffectEnable false; 
		ppEffectDestroy _handle;
	};
};

hunterSkele addAction ['"Hey, did you know this day is actually about people named Hunter? Go figure."', {},[],6,true,true,"","true",9,false,"",""];

rockWins = {
	[["40xtra_nade_throw_stone"], "fucking rocks", ""] call addUnlocksToArsenal;
};

offWins = {
	[["MiniGrenade"], "offensive grenades", ""] call addUnlocksToArsenal;
};

defWins = {
	[["HandGrenade"], "defensive grenades", ""] call addUnlocksToArsenal;
};

rpgGuy addAction ["OG-7V is frag. PG-7 is all HEAT. TBG is thermobaric. Is simple.", {},[],6,true,true,"","true",9,false,"",""];

rockButton addAction ["ROCK WON. WHY.", {
	[] remoteExec ["rockWins", 0];
},[],6,true,true,"","true",9,false,"",""];

offenseButton addAction ["OFFENSE WON", {
	[] remoteExec ["offWins", 0];
},[],6,true,true,"","true",9,false,"",""];

defenseButton addAction ["DEFENSE WON", {
	[] remoteExec ["defWins", 0];
},[],6,true,true,"","true",9,false,"",""];