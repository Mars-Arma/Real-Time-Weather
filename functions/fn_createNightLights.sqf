// File: fn_createNightLights.sqf
// Author: Infamous
// Description: during the night, creates shooting stars and meteors of 2 different speeds and 4 different colors to fly over.

// params	
params ["_RedCo", "_GreenCo", "_BlueCo", "_position", "_speed"];
_color = [0.254,0.225,0.227];
_lightVehicle = "Land_PenBlack_F" createVehicle _position;
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
_lightVehicle setVelocity _speed;
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


