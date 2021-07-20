
// File: fn_initNightLights.sqf
// Author: Infamous
// Description: during the night, creates shooting stars and meteors of 2 different speeds and 4 different colors to fly over.

// makes sure this is ran on the server.
if (!isServer) exitWith {systemChat "this only runs on the server"};

waitUntil {
	_time = false;
	_hour = date select 3;
	sleep 1; 
	if (_hour >= 20 || _hour < 6) then {_time = true };
	_time;
};

// checks to make sure to only run during the night
while {date select 3 >= 22 || date select 3 < 6} do {

	// random number for color
	_colorSelect = floor  (random 4);

	// setting up vars and creating light point and the vehicle it will attach to.
	_positions =  [[14105.4,11562.9,0.00239754], [12387,10065.9,0.00175619], [11412.4,6882.22,0.00141907],
	[3130.15,9987.29,0.000762939], [3953.95,15152.3,0.00139618], [16596.9,14975.1,0.00145674], 
	[16596.9,14975.1,0.00145674], [19016.8,9918.55,0.00144958], [19016.8,9918.55,0.00144958],
	[23719.7,16095.2,0.00143909], [18079.5,19169.3,0.0011158], [13512.8,16930.8,0.00144482], [3963.43,12895,0.00149727]
	];
	_speedSettings = [[150,0,0], [0,150,0], [150,150,0], [175,140,0], [140,175,0],
	[-150,0,0], [0,-150,0], [-150,-150,0], [-175,-140,0], [-140,-175,0],
	[300,0,0],[0,300,0], [300,300,0], [350,300,0], [300,350,0],[-300,0,0],
	[0,-300,0], [-350,-300,0], [-300,3-50,0], [-300,-300,0]
	];

	_position = selectRandom _positions;
	_speed = selectRandom _speedSettings;

	// select randomly what color the light should be
	switch (_colorSelect) do
	{
		case 0: {	[0.003, 0.0177, 0.0252,_position,_speed] remoteExec ["life_fnc_CreateNightLights"];}; // Blue
		case 1: { 	[0.252, 0.032, 0.03,_position,_speed] remoteExec ["life_fnc_CreateNightLights"];}; // red
		case 2: { 	[0.252, 0.032, 0.3,_position,_speed] remoteExec ["life_fnc_CreateNightLights"];}; // purple 
		case 3: { 	[0.3, 0.252, 0.235,_position,_speed] remoteExec ["life_fnc_CreateNightLights"];}; // Cyan
		//default: { 	[0.3, 0.252, 0.235] remoteExec ["meteor"];}; // default which is Cyan
	};

	// add a delay in the loop. CHANGE THIS TO CHANGE THE DELAY FOR EACH METEOR TO BE CREATED
	uisleep 150;
};


