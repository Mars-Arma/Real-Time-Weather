
// File: fn_nightLights.sqf
// Author: Infamous
// Description: during the night, creates shooting stars and meteors of 2 different speeds and 4 different colors to fly over.
// makes sure this is ran on the server.
if (!isServer) exitWith {systemChat "this only runs on the server"};

meteor = {	
	// params	
	params ["_RedCo", "_GreenCo", "_BlueCo"];
	_color = [0.254,0.225,0.227];
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
	_lightVehicle = "Land_PenBlack_F" createVehicle selectRandom _positions;
	_speed = selectRandom [150, 300];
	_lightpoint = "#lightpoint" createVehicle [0,0,0];
	_lightpoint setLightColor _color;//[0.252, 0.212, 0.64];
	_lightpoint setLightAmbient _color;//[0.252, 0.212, 0.64];
	_lightpoint setLightUseFlare true;
	_lightpoint setLightFlareSize 50;
	_lightpoint setLightFlareMaxDistance 25000;
	_lightpoint setLightBrightness 50;
	_lightpoint setLightDayLight true;
	_lightVehicle setVelocity [0,0,1250];
	sleep 1;
	_lightpoint attachTo [_lightVehicle, [0, 0, 1.5]];
	_lightVehicle setVelocity selectRandom _speedSettings;
	_lightpoint setLightAttenuation [2, 4, 4, 0, 1, 2];
	
	// adding an aspect of realism AKA the light gets brighter and bigger the closer it gets to the ground.
	_lightSize = 50;
	_lightBright = 50;

	for "_i" from 1 to 75 do { 

		// changes the brightness and size of the light

		_lightpoint setLightFlareSize _lightSize;
		_lightpoint setLightBrightness _lightBright;
		sleep 0.1;
		_lightSize = _lightSize + 2;
		_lightBright = _lightBright + 2;
		_lightpoint setLightColor _color;
		_lightpoint setLightAmbient _color;

		// stores the color values
		_red = _color select 0;
		_green = _color select 1;
		_blue = _color select 2;

		// changes the color
		_red = _red + _Redco;
		_green = _green + _GreenCo;
		_blue = _blue + _BlueCo;
		_color = [];
		_color pushback _red;
		_color pushback _green;
		_color pushback _blue;
	};
	
	for "_i" from 1 to 200 do { 

		// changes the brightness and size of the light
		_lightpoint setLightFlareSize _lightSize;
		_lightpoint setLightBrightness _lightBright;
		sleep 0.1;
		_lightSize = _lightSize - 2;
		_lightBright = _lightBright - 2;
		_lightpoint setLightColor _color;
		_lightpoint setLightAmbient _color;

	};

	// makes sure the lightVehicle is not moving anymore and slowly dims it out
	_lightVehicle setVelocity [0,0,0];

	deleteVehicle _lightpoint;
	deleteVehicle _lightVehicle;

};

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

	// select randomly what color the light should be
	switch (_colorSelect) do
	{
		case 0: {	[0.003, 0.0177, 0.0252] remoteExec ["meteor"];}; // Blue
		case 1: { 	[0.252, 0.032, 0.03] remoteExec ["meteor"];}; // red
		case 2: { 	[0.252, 0.032, 0.3] remoteExec ["meteor"];}; // purple 
		case 3: { 	[0.3, 0.252, 0.235] remoteExec ["meteor"];}; // Cyan
		default { 	[0.3, 0.252, 0.235] remoteExec ["meteor"];}; // default which is Cyan
	};

	// add a delay in the loop. CHANGE THIS TO CHANGE THE DELAY FOR EACH METEOR TO BE CREATED
	sleep 300;
};


