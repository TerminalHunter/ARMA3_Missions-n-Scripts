blackoutLoadingScreen = {
	//	waitUntil {time > 0};
	//	_jip_enable	= 200;
	//	[[_jip_enable],"time_srv.sqf"] remoteExec ["execVM"];
	//	waitUntil {!isNil "curr_time"};
	//	if ((!curr_time) or (_jip_enable<0)) then {
		for "_i" from 15 to 0 step -1 do{
			titleText ["<img size='20' image='logo.paa'/><br/>Mission Initializing - Intel says the mission will start in " + str _i + " (ish) seconds, you drunk fuck.", "BLACK FADED",0.12,true,true];
			sleep 1;
		};
	//};
};