playerArsenal = ["rangerhat_white","armor_ncr_trooper_helm_winter","NCR_Black_beret","NCRbrownBeret","NCRBlackBeret","NCRWhiteBeret","combat_ranger_winter_uniform","armor_ncr_trooper_01_winter_uniform","armornvncrtrooper_plain_winter_uniform","Backpack_02","BackpackNUKA_02","BackpackNUKA","FRXA_tf_rt1523g_Black","FRXA_tf_rt1523g_UCP","FRXA_tf_rt1523g_big_Black","FRXA_tf_rt1523g_big_UCP","AM_AvBagInvis","trouper_mask_winter","SAN_Headlamp_v2","ItemCompass","ItemMap","TFAR_microdagr","TFAR_rf7800str","armor_ncr_trooper_clothes_winter_medic_uniform","Bobbleheads_Strength_02","AM_BigBagInvis"];

//INITS

//color correction init - to make things look colder and blue
"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.75],[0.5,0.3,1.0,-0.1]];
"colorCorrections" ppEffectCommit 0;

if (isNil {profileNamespace getVariable "bluePref"}) then {
	profileNamespace setVariable ["bluePref", true];
};

//autosave toggle option init
if (isNil {profileNamespace getVariable "arseAutosavePref"}) then {
	profileNamespace setVariable ["arseAutosavePref", true];
};

//color correction toggle option init
if (profileNamespace getVariable "bluePref") then {
	//nothing because we already set it.
} else {
	call removeBlue;
};

//Event Handler that auto-saves the loadout when the ace arsenal is closed
if (!isServer) then {
	["ace_arsenal_displayOpened",{
		player setVariable["arsenalCheatCheck",getUnitLoadout player];
	}] call CBA_fnc_addEventHandler;

	["ace_arsenal_displayClosed",{
		if (profileNamespace getVariable "arseAutosavePref") then {
			[] spawn saveHyperboreaLoadout;
		};
		[player] spawn arsenalAntiCheat;
	}] call CBA_fnc_addEventHandler;
};

//FUNCTIONS

makeHyperboreaArsenal = {
  params ["_jackShack"];

  [_jackShack, playerArsenal] call ace_arsenal_fnc_initBox;

  _jackShack addAction ["Jack Shack Arsenal", {[(_this select 0), player] call ace_arsenal_fnc_openBox;},[],1.5,true,true,"","true",10,false,"",""];
  _jackShack addAction["Save Current Loadout as Respawn Loadout","saveLoadout.sqf",[],1.5,true,true,"","true",10,false,"",""];
  //_jackShack setVariable ["ACE_Name","Jack Shack Autodoc #1"]; doesn't work?

  _jackShack addAction["Toggle Loadout Autosave",toggleLoadoutAutosave,[],1.5,true,true,"","true",10,false,"",""];
  _jackShack addAction["Toggle Blue Filter",toggleBlue,[],1.5,true,true,"","true",10,false,"",""];

  //TODO : SAVE GAME
  _jackShack addAction["Save Game",campaignStartSave,[],1.5,true,true,"","true",10,false,"",""];

  //TODO : AUTODOC
  _jackShack addAction["Activate AutoDoc",{[(_this select 0)] spawn activateAutodoc},[],1.5,true,true,"","true",10,false,"",""];

  [_jackShack,1] call ace_cargo_fnc_setSize;
  [_jackShack,true,[-0.5,0.75,0]] call ace_dragging_fnc_setDraggable;

};

toggleLoadoutAutosave = {
	if (profileNamespace getVariable ["arseAutosavePref", true]) then {
		profileNamespace setVariable ["arseAutosavePref", false];
		hintSilent "Loadout Autosave OFF";
	}else{
		profileNamespace setVariable ["arseAutosavePref", true];
		hintSilent "Loadout Autosave ON";
	};
};

removeBlue = {
	"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.0, 0.0, 0.0, 0.0],[1.0, 1.00, 1.0, 1.00],[0.299, 0.587, 0.114, 0]];
	"colorCorrections" ppEffectCommit 0;
};

readdBlue = {
	"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.60],[0.5,0.3,1.0,-0.1]];
	"colorCorrections" ppEffectCommit 0;
};

toggleBlue = {
	if (profileNamespace getVariable ["bluePref", true]) then {
		profileNamespace setVariable ["bluePref", false];
		call removeBlue;
		hintSilent "Extra Cold Blue Filter OFF";
	}else{
		profileNamespace setVariable ["bluePref", true];
		call readdBlue;
		hintSilent "Extra Cold Blue Filter ON";
	};
};
