#include "dumbShit.sqf"
#include "hyperboreaArsenal.sqf"
#include "autodoc.sqf"
#include "hyperboreaSaveSystem.sqf"
#include "saveLoadout.sqf"

enableSaving [false, false];

if (isServer) then {
	[junkTruck1] call giveRandomLicense;
	[junkTruck2] call giveRandomLicense;

	[west, 25, [["FlagSmall_F", 1]]] call acex_fortify_fnc_registerObjects;

	pileJoke addItemCargoGlobal ["AM_potatocrisps", 1];

	bcrate1 addItemCargoGlobal ["ACE_Banana", 1000];
	bcrate2 addItemCargoGlobal ["ACE_Banana", 1000];
	bcrate3 addItemCargoGlobal ["ACE_Banana", 917];
};

drugVase attachTo [drugBase];
[drugVase] call makeDrugOracle;

[jackShack1] call makeHyperboreaArsenal;
[jackShack2] call makeHyperboreaArsenal;

jackShackRespawn1 attachTo [jackShack1];
jackShackRespawn2 attachTo [jackShack2];

//fuel check quick script
_fuelAction = ["CheckFuel", "Check Fuel", "", {hint format ["Fuel: %1%2", str((fuel _target) * 100), "%"]}, {true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _fuelAction, true] call ace_interact_menu_fnc_addActionToClass;

//Code specific to this mission
storyText = {
  params ["_text"];
  titleText [_text,"PLAIN DOWN",2.5,true,true];
};

shorterHint = {
	params ["_text"];
	hint _text;
	sleep 4;
	hint "";
};

//Query Telecontrol Uplink Location
missionQuery = {
	params ["_player"];
	_heading = (getPos _player) getDir (getPos endLocation);
	_longString = "<t color='#aaaa22' size='1'>" + str(_heading) + "</t>";
	[_longString] call storyText;
};

secretRadio01 addAction ["SECRET RADIO #13",{
	playSound3D ["Hyperborea_Music\NotSafe.ogg", secretRadio01, false, getPosASL secretRadio01, 2];
  removeAllActions secretRadio01;
},[],1.5,true,true,"","true"];

secretRadio02 addAction ["SECRET RADIO #14",{
	playSound3D ["Hyperborea_Music\Coma.ogg", secretRadio02, false, getPosASL secretRadio02, 2];
  removeAllActions secretRadio02;
},[],1.5,true,true,"","true"];

droneTerminal attachTo [endLocation];

droneTerminal addAction ["Automated Drone Delivery System Login",{
	_longString = "<t color='#22aa22' size='1'>ACCESS DENIED - INSUFFICIENT CREDENTIALS</t>";
	[_longString] call storyText;
},[],1.5,true,true,"","true"];

droneTerminal addAction ["Loading Bay Door Control",{
	_longString = "<t color='#22aa22' size='1'>DOOR STUCK - MAINTENANCE REQUEST LOGGED</t>";
	[_longString] call storyText;
},[],1.5,true,true,"","true"];

droneTerminal addAction ["Emergency Manual Override",{
	_longString = "<t color='#22aa22' size='1'>ACTION REQUIRES CONFIRMATION. Base self destruct sequence will be armed. Delivery Drone will require human pilot for evacuation. This action has been logged.</t>";
	[_longString] call storyText;
	[] call confirmAction;
},[],1.5,true,true,"","true"];

confirmAction = {
	droneTerminal addAction ["CONFIRM ACTION",{
		_longString = "<t color='#22aa22' size='1'>Virus Bomb Armed. All hands EVACUATE IMMEDIATELY. This action has been logged.</t>";
		[_longString] call storyText;
		[] call selfDestructAlarmStart;
	},[],1.5,true,true,"","true"];
};

selfDestructAlarmStart = {
	publicVariableServer "selfDestructStart";
};

blinkingLight = {
	params ["_lightLoc"];
	_light = "#lightpoint" createVehicleLocal (getPos _lightLoc);
	_light setLightBrightness 1.0;
	_light setLightAmbient [0.9, 0, 0];
	_light setLightColor [0.9, 0, 0];
	[_light,_lightLoc] spawn {
		params[ "_light","_lightLoc" ];

		while { !isNull _light } do {
			_light setLightAmbient [0, 0, 0];
			_light setLightColor [0, 0, 0];
			uiSleep 0.5;
			_light setLightAmbient [0.9, 0, 0];
			_light setLightColor [0.9, 0, 0];
			playSound3D [getMissionPath "AlarmLoop.ogg", _lightLoc, true];
			uiSleep 0.5;
		};
	};
};

if (isServer) then{

	"selfDestructStart" addPublicVariableEventHandler{
		//["SELF DESTRUCT INITIATED"] remoteExec ["hint",0,false];
		[alarm01] remoteExec ["blinkingLight",0,true];
		[alarm02] remoteExec ["blinkingLight",0,true];
		[alarm03] remoteExec ["blinkingLight",0,true];
		[alarm04] remoteExec ["blinkingLight",0,true];
		[droneTerminal] remoteExec ["removeAllActions",0,true];
		escapeChopper setFuel 0.4;
		_longString = "<t color='#22aa22' size='1'>Virus Bomb Armed. All hands EVACUATE IMMEDIATELY. This action has been logged.</t>";
		[_longString] remoteExec ["storyText",0,false];
	};

};

intelTerm addAction ["DATAFILE",{
	_longString = "<t color='#22aa22' size='1'>||data corrupted|| ot my definition of a 'low key' transfer. The work is laughably easy but how do you expect people to surv</t>";
	[_longString] call storyText;
},[],1.5,true,true,"","true"];

intelTerm addAction ["DATAFILE",{
	_longString = "<t color='#22aa22' size='1'>||data corrupted|| longi;floatx2,y;constfloatthreehalfs=1.5F;x2=number*0.5F;y=number;i=*(long*)&y;/*evil floating point bit level hacking*/i=0x5f3759df-(i>>1);/*what the fuck?*/y=*(float*)&i;y=y*(threehalfs-(x2*y*y));return y;</t>";
	[_longString] call storyText;
},[],1.5,true,true,"","true"];

intelTerm addAction ["DATAFILE",{
	_longString = "<t color='#22aa22' size='1'>||data corrupted|| ay concern, the wizards in the DoW have managed to make otherwise fine looking meatballs taste like mothbal</t>";
	[_longString] call storyText;
},[],1.5,true,true,"","true"];

intelTerm addAction ["DATAFILE",{
	_longString = "<t color='#22aa22' size='1'>||data corrupted|| ps to repeat: 1) make an API call to the central requisition network for any item with the character 'a' in the number to requisition field 2) central network will send a reply code that seems to imply 3 tons of bana</t>";
	[_longString] call storyText;
},[],1.5,true,true,"","true"];

intelTerm addAction ["DATAFILE",{
	_longString = "<t color='#22aa22' size='1'>||data corrupted|| e else hear something going on in the pipeline tunnel? Had no reason to undo the magne</t>";
	[_longString] call storyText;
},[],1.5,true,true,"","true"];
