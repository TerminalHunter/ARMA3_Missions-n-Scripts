"colorCorrections" ppEffectEnable true;

/*

BLUE
"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.75],[0.5,0.3,1.0,-0.1]];

BLACK&WHITE
"colorCorrections" ppEffectAdjust [1, 0.4, 0, [0, 0, 0, 0], [1, 1, 1, 0], [1, 1, 1, 0]];

MONOCHROME REDDISH
"colorCorrections" ppEffectAdjust [
 1,
 1,
 0,
 [0.5, 0.2, 0.2, 0.5],
 [1, 1, 1, 0],
 [0.299, 0.587, 0.114, 0],
 [-1, -1, 0, 0, 0, 0, 0]
];



DEFAULT
"colorCorrections" ppEffectAdjust [
	1,
	1,
	0,
	[0, 0, 0, 0],
	[1, 1, 1, 1],
	[0.299, 0.587, 0.114, 0],
	[-1, -1, 0, 0, 0, 0, 0]
];

*/

"colorCorrections" ppEffectAdjust [
	1,
	1,
	0,
	[0, 0, 0, 0],
	[1, 1, 1, 1],
	[0.299, 0.587, 0.114, 0],
	[-1, -1, 0, 0, 0, 0, 0]
];


"colorCorrections" ppEffectCommit 0;

/*
"colorInversion" ppEffectEnable true;
"colorInversion" ppEffectAdjust [1,0,0];
"colorInversion" ppEffectCommit 0;
*/

/*
_secondColorCorrection = ppEffectCreate ["colorCorrections", 1501];
_secondColorCorrection ppEffectEnable true;
_secondColorCorrection ppEffectAdjust [
	1,
	1,
	0,
	[0, 0, 0, 0],
	[1, 1, 1, 0],
	[0.299, 0.587, 0.114, 0],
	[-1, -1, 0, 0, 0, 0, 0]
];
_secondColorCorrection ppEffectCommit 0;
*/

yaBoiCanSee = {
  //specifically for humans
  params ["_dude1", "_dude2"];
  [] isEqualTo (lineIntersectsSurfaces [eyePos _dude1, eyePos _dude2, _dude1, _dude2, true, -1]);
};

yaBoiCanSeePoint = {
	//needs 1 object and 1 AGL point, though it immediately casts it to ASL.
	params ["_yaBoi", "_seenObj", "_point"];
	[] isEqualTo (lineIntersectsSurfaces [eyePos _yaBoi, AGLToASL _point, _yaBoi, _seenObj, true, -1]);
};

/*
while {true} do {
	sleep 0.5;
	if ([mill, dude] call yaBoiCanSee) then {
		hintSilent "Ya boi can see.";
		drawLine3D [ASLToAGL eyePos mill, ASLToAGL eyePos dude, [1,0,0,1]];
	} else {
		hintSilent "Ya boi can't see.";
		drawLine3D [ASLToAGL eyePos mill, ASLToAGL eyePos dude, [0,1,0,1]];
	};
};
*/

getTheActualGoddamnPosition = {
	params ["_memPoint", "_object"];
	_object modelToWorld (_object selectionPosition _memPoint);
};

onEachFrame {
	/*
	if ([mill, dude] call yaBoiCanSee) then {
		drawLine3D [ASLToAGL eyePos mill, ASLToAGL eyePos dude, [1,0,0,1]];
		drawLine3D [ASLToAGL eyePos mill, ASLToAGL aimPos dude, [1,0,0,1]];
		drawLine3D [ASLToAGL eyePos mill, getPos dude, [1,0,0,1]];
		{
			if (!(dude selectionPosition [_x, "HitPoints"] isEqualTo [0,0,0])) then {
				_actualPoint = (dude selectionPosition _x) vectorAdd (dude modelToWorld [0,0,0]);
				drawLine3D [ASLToAGL eyePos mill, _actualPoint, [1,0,0,1]];
			};
		} forEach selectionNames dude;
	} else {
		drawLine3D [ASLToAGL eyePos mill, ASLToAGL eyePos dude, [0,1,0,1]];
		drawLine3D [ASLToAGL eyePos mill, ASLToAGL aimPos dude, [0,1,0,1]];
		drawLine3D [ASLToAGL eyePos mill, getPos dude, [0,1,0,1]];
	};
	*/
	//drawLine3D [ASLToAGL eyePos mill, dude modelToWorld (dude selectionPosition ["head", "Memory"]), [1,0,0,1]];
	//drawLine3D [ASLToAGL eyePos mill, dude modelToWorld (dude selectionPosition ["head", "FireGeometry"]), [1,0,0,1]];
	//drawLine3D [ASLToAGL eyePos mill, dude modelToWorld (dude selectionPosition ["head", "HitPoints"]), [1,0,0,1]];

	{
		if (!((dude selectionPosition _x) isEqualTo [0,0,0])) then {
			_position = [_x, dude] call getTheActualGoddamnPosition;
			if ([mill, dude, _position] call yaBoiCanSeePoint) then {
				//drawLine3D [ASLToAGL eyePos mill, ASLToAGL _position, [1,0,0,1]];
				drawLine3D [ASLToAGL eyePos mill, _position, [1,0,0,1]];
			} else {
				//drawLine3D [ASLToAGL eyePos mill, ASLToAGL _position, [0,1,0,1]];
				drawLine3D [ASLToAGL eyePos mill, _position, [0,1,0,1]];
			};
		};
	//} forEach (dude selectionNames "HitPoints");
	//} forEach (dude selectionNames "Memory");
	//} forEach selectionNames dude;
	} forEach whatIsAManButAMiserablePileOfMemoryPoints;

};

/*
["rightarm","rightforearm","leftforearm","rightarmroll","spine3","spine2","spine1","pelvis","rightupleg","rightuplegroll","rightleg","rightlegroll","rightfoot","head","leftarmroll","leftarm","leftupleg","leftuplegroll","leftlegroll","leftfoot","neck","body","legs","hands","head_hit","l_femur_hit","r_femur_hit","hand_r","leg_r","leg_l","hand_l","face_hub","arms"]
*/

whatIsAManButAMiserablePileOfMemoryPoints = [
"pelvis",
"spine",
"spine1",
"spine2",
"spine3",
"neck",
"neck1",
"head",
"neck1",
"face_hub",
"face_jawbone",
"face_jowl",
"face_jawbone",
"face_chopright",
"face_jawbone",
"face_chopleft",
"face_jawbone",
"face_liplowermiddle",
"face_jawbone",
"face_liplowerleft",
"face_jawbone",
"face_liplowerright",
"face_jawbone",
"face_chin",
"face_jawbone",
"face_tongue",
"face_jawbone",
"face_cornerright",
"face_cheeksideright",
"face_cornerright",
"face_cornerleft",
"face_cheeksideleft",
"face_cornerleft",
"face_cheekfrontright",
"face_cheekfrontleft",
"face_cheekupperright",
"face_cheekupperleft",
"face_lipuppermiddle",
"face_lipupperright",
"face_lipupperleft",
"face_nostrilright",
"face_nostrilleft",
"face_forehead",
"face_browfrontright",
"face_forehead",
"face_browfrontleft",
"face_forehead",
"face_browmiddle",
"face_forehead",
"face_browsideright",
"face_forehead",
"face_browsideleft",
"face_forehead",
"face_eyelids",
"face_eyelidupperright",
"face_eyelidupperleft",
"face_eyelidlowerright",
"face_eyelidlowerleft",
"eyeleft",
"eyeright",
"leftshoulder",
"leftarm",
"leftarmroll",
"leftforearm",
"leftforearmroll",
"leftforearm",
"lefthand",
"leftforearmroll",
"lefthandring",
"lefthandring1",
"lefthandring2",
"lefthandring3",
"lefthandpinky1",
"lefthandpinky2",
"lefthandpinky3",
"lefthandmiddle1",
"lefthandmiddle2",
"lefthandmiddle3",
"lefthandmiddle2",
"lefthandindex1",
"lefthandindex2",
"lefthandindex1",
"lefthandindex3",
"lefthandindex2",
"lefthandthumb1",
"lefthandthumb2",
"lefthandthumb1",
"lefthandthumb3",
"lefthandthumb2",
"rightshoulderspine3",
"rightarm",
"rightshoulder",
"rightarmroll",
"rightarm",
"rightforearm",
"rightarmroll",
"rightforearm",
"rollrightforearm",
"righthand",
"rightforearmroll",
"righthandring",
"righthandring1",
"righthandring2",
"righthandring1",
"righthandring3",
"righthandring2",
"righthandpinky1",
"righthandpinky2",
"righthandpinky3",
"righthandmiddle1",
"righthand",
"righthandmiddle2",
"righthandmiddle3",
"righthandindex1",
"righthand",
"righthandindex2",
"righthandindex3",
"righthandthumb1",
"righthand",
"righthandthumb2",
"righthandthumb3",
"righthandthumb2",
"weaponspine1",
"launcherspine1",
"camerapelvis",
"leftuplegpelvis",
"leftuplegroll",
"leftupleg",
"leftleg",
"leftlegroll",
"leftfoot",
"lefttoebase",
"rightuplegpelvis",
"rightuplegroll",
"rightupleg",
"rightleg",
"rightlegroll",
"rightfoot",
"righttoebase"
];
