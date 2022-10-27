//ATRAIN_Track_Debug_Enabled = true;

railMap2 = [
  ["rail_tracke_40nolc_f.p3d", "ATS_Tracks_A2_Elev_Straight_40"],
  ["rail_tracke_r25_5_f.p3d", "ATS_Tracks_A2_Elev_Curve_Right_3"],
  ["rail_tracke_l25_10_f.p3d", "ATS_Tracks_A2_Elev_Curve_Left_2"],
  ["rail_tracke_l25_5_f.p3d", "ATS_Tracks_A2_Elev_Curve_Left_3"],
  ["rail_tracke_25nolc_f.p3d", "ATS_Tracks_A2_Elev_Straight_25"],
  ["rail_tracke_r25_10_f.p3d", "ATS_Tracks_A2_Elev_Curve_Right_2"],
  ["rail_track_down_40_f.p3d", "ATS_Tracks_A2_Elev_Incline_Down_40"],
  ["rail_track_25_f.p3d", "ATS_Tracks_A2_Elev_Straight_25"],
  ["rail_track_sp_f.p3d", "ATS_Tracks_A2_Straight_25"],
  ["rail_track_up_40_f.p3d", "ATS_Tracks_A2_Elev_Incline_Up_40"],
  ["rail_tracke_8_f.p3d", "ATS_Tracks_A2_Elev_Straight_25"], // FUCK! "ATS_Tracks_A3_Straight_10"
  ["rail_tracke_l30_20_f.p3d", "ATS_Tracks_A2_Elev_Curve_Left_1"],
  ["rail_tracke_r30_20_f.p3d", "ATS_Tracks_A2_Elev_Curve_Right_1"],
  ["rail_track_le_rb_f.p3d", "ATS_Tracks_A2_Elev_Straight_25"], //S-bend?
  ["rail_tracke_40_f.p3d", "ATS_Tracks_A2_Elev_Straight_40"],
  ["rail_track_down_25_f.p3d", "ATS_Tracks_A2_Elev_Incline_Down_25"],
  ["rail_tracke_4_f.p3d", "ATS_Tracks_A3_Straight_3"], // FUCK! "ATS_Tracks_A3_Straight_3"
  ["rail_tracke_turnoutl_f.p3d", "ATS_Tracks_A2_Elev_Split_Left"], //DOUBLE FUCK "ATS_Tracks_A2_Elev_Split_Left"
  ["rail_track_lb_re_f.p3d", "ATS_Tracks_A2_Elev_Straight_25"], //S-bend?
  ["rail_track_turnoutr_f.p3d", "ATS_Tracks_A2_Elev_Split_Right"],
  ["rail_track_l25_10_f.p3d", "ATS_Tracks_A2_Elev_Curve_Left_2"],
  ["rail_tracke_2_f.p3d", "ATS_Tracks_A3_Straight_3"], // FUCK! "ATS_Tracks_A3_Straight_3"
  ["rail_track_lb1_re_f.p3d", "ATS_Tracks_A2_Elev_Straight_25"], //S-bend?
  ["rail_tracke_25_f.p3d", "ATS_Tracks_A2_Straight_25"],
  ["rail_track_le1_rb_f.p3d", "ATS_Tracks_A2_Elev_Straight_25"], //s-bend?
  ["rail_track_r25_10_f.p3d", "ATS_Tracks_A2_Elev_Curve_Right_2"],
  ["rail_tracke_turnoutr_f.p3d", "ATS_Tracks_A2_Elev_Split_Right"],
  ["rail_track_up_25_f.p3d", "ATS_Tracks_A2_Elev_Incline_Up_25"],
  ["rail_tracke_8nolc_f.p3d", "ATS_Tracks_A3_Straight_10"] // FUCK! "ATS_Tracks_A3_Straight_10"
];



/*
Holds data as: [position, vector up, vector dir, string]
holyCombos is a debug object placed off-map
*/
getMapRail = {
_worldObjects = [];
  {
    _worldObjects pushBack [getPosASL _x, vectorUp _x, vectorDir _x, (getModelInfo _x) select 0];
  } forEach nearestTerrainObjects [holyCombos,["RAILWAY"],7000,false];
  _worldObjects
};

//JIP - ALLRAILSOBJECTS will be declared before this moment on JIP players
if (isNil "ALLRAILSOBJECTS") then {
  ALLRAILSOBJECTS = [];
};

hideRails = {
  {hideObject _x} forEach ALLRAILSOBJECTS;
  for "_i" from 1 to 74 step 1 do {
    _rail = missionNamespace getVariable ("rail" + str _i);
    hideObject _rail;
  };
};

if (isServer) then {

  prize1 enableSimulation false;
  prize2 enableSimulation false;
  prize3 enableSimulation false;
  prize4 enableSimulation false;

  railHashMap = createHashMapFromArray railMap2;

  GLOBAL_VAR_ALLRAILS = [] call getMapRail;

  {
    //"|marker_"+ str _forEachIndex +"|"+str(_x select 0)+"|mil_pickup|ICON|[1,1]|0|Solid|Default|1|Placed_Rail"+str(_forEachIndex) call BIS_fnc_stringToMarker;
    _tempNewRail = (railHashMap get (_x select 3)) createVehicle (_x select 0);
    _tempNewRail setPosASL (_x select 0);
    _tempNewRail setVectorDirAndUp [_x select 2, _x select 1];
    ALLRAILSOBJECTS pushBack _tempNewRail;
  } forEach GLOBAL_VAR_ALLRAILS;

  publicVariable "ALLRAILSOBJECTS";

  waitUntil {time > 10};

  prize1 enableSimulation true;
  prize2 enableSimulation true;
  prize3 enableSimulation true;
  prize4 enableSimulation true;

};


//DEBUG FUNCTION
getMapRailNamesUnique = {
  _worldObjects = [];
    {
      _worldObjects pushBackUnique [str _x];
    } forEach nearestTerrainObjects [holyCombos,["RAILWAY"],worldSize*2,false];
    _worldObjects
};
