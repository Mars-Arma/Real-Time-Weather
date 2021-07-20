
// File: fn_SetWeather.sqf
// Author: Infamous
// Description: Gets data and sends it to be sorted, then sets the weather on the server.


// makes sure this is only ran on the server
if (isServer) then {
	

	private ["_weatherData","_message"];
	life_error = false;
	life_realWeatherStats = [];
	life_dataReady = false;
	life_timeOut = false;
	_diagtime = diag_tickTime; 
	

	// set locations and names of the place the API will search for
	Weather_worldVar = "Greece";
	Weather_cityVar = "Limnos";
	WorldLat = "39.5329";
	WorldLong = "25.0122";
	Bracket = "/";

	// checks to see if the Config file includes a API key
	if (Life_WeatherKeyAPI == "") exitWith
	{

	};

	if (Life_WeatherKeyAPI != "" && life_realWeatherStats isEqualTo []) then 
	{
		
		life_dataReady = false;
		life_timeOut = false;
	
		if (parseNumber Weather_worldVar == 0) then {Bracket = "/";} else {Bracket = ",";};
		
		//http://api.weatherstack.com/forecast?access_key=%1&query=%2,%3
		
		_weatherData = format ["http://api.weatherstack.com/current?access_key=%3&query=%1,%2",Weather_worldVar, Weather_cityVar, Life_WeatherKeyAPI, Bracket] call life_fnc_grabData;
		waitUntil {life_dataReady OR life_timeOut};
		life_realWeatherStats = (_weatherData select 0) call life_fnc_sortData;

	};
	
	
	if (life_timeOut) then  {life_error = true};
	if (life_error) exitWith {systemChat "An error has happened, this is likely because of the live weather tracker"};
	
	
	//[_temp_f,_temp_c,_wind_mph,_wind_gust_mph,_wind_kph,_wind_gust_kph,_wind_degrees,_relative_humidity,_pressureIn,_totalrain,_rainchance,_date,_cloudcover];
	_SERVERTEMPF = life_realWeatherStats select 0;
	_SERVERTEMPC = life_realWeatherStats select 1;
	_SERVERWINDSPEEDMph = life_realWeatherStats select 2;
	_SERVERWINDSPEEDMphGust = life_realWeatherStats select 3;
	_SERVERWINDSPEEDKph = life_realWeatherStats select 4;
	_SERVERWINDSPEEDKphGust = life_realWeatherStats select 5;
	_SERVERWINDDIR = life_realWeatherStats select 6;
	_SERVERHUMID = life_realWeatherStats select 7;
	_SERVERPRESSUREIN = life_realWeatherStats select 8;
	_SERVERTOTALRAIN = life_realWeatherStats select 9;
	_SERVERRAINCHANCE = life_realWeatherStats select 10;
	_SERVERDATE = life_realWeatherStats select 11;
	_SERVERCLOUDCOVER = life_realWeatherStats select 12;
	_rainlevel = life_realWeatherStats select 13;


	private ["_year","_month","_day","_hour","_minute"];
	enableEnvironment true;
	_year = _SERVERDATE select 0;
	_month = _SERVERDATE select 1;
	_day = _SERVERDATE select 2;
	_hour = _SERVERDATE select 3;
	_minute = _SERVERDATE select 4;

	if (life_timeVar) then 
	{
		
		[_year, _month, _day, _hour, _minute] spawn
		{
		[[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4)]] remoteExec ["setDate"];
		};
	};

	if (life_rainVar) then 
	{
		_rainchance2 = (_SERVERRAINCHANCE * 0.1) min 0.5;
		[((_SERVERCLOUDCOVER*0.75)+ (_rainlevel * 0.5))] remoteExec ["setOvercast"];
		15 setRain (_rainlevel+_rainchance2);
	};

	if (life_fogvar) then
	{
	0 setFog (_SERVERHUMID * 0.00025);
	};

	//1 mph = 0.447040 meters per second
	//1km = 0.277778 meters per second
	if (life_windVar) then 
	{
		private _value = (_SERVERWINDSPEEDKph / 3.6);
		setWind [_value, _value, false];
		15 setWindDir _SERVERWINDDIR;
		[15, (_SERVERWINDSPEEDKph*0.01)] remoteExec ["setGusts"];
	};
	forceWeatherChange;

	//[_temp_f,_temp_c,_wind_mph,_wind_gust_mph,_wind_kph,_wind_gust_kph,_wind_degrees,_relative_humidity,_pressureIn,_totalrain,_rainchance,_date,_cloudcover];
	systemChat format ["The Temperature in F is currently %1, in C, it is %2. The wind is currently %3mph, with gusts of %4. In Kph the wind is %5 with gusts of %6,
	The wind is currently blowing at bering %7. The humidity is currenlty %8, and the pressure is %9. The total current rain is %10 with a chance of %11 to rain. The current time
	is %12, %13, %14, %15, %16. With a cloudcover of %17.
	
	", _SERVERTEMPF, _SERVERTEMPC, _SERVERWINDSPEEDMph, _SERVERWINDSPEEDMphGust, _SERVERWINDSPEEDKph, _SERVERWINDSPEEDKphGust, _SERVERWINDDIR, _SERVERHUMID,
	_SERVERPRESSUREIN, _SERVERTOTALRAIN, _SERVERRAINCHANCE, _SERVERDATE, _SERVERCLOUDCOVER, _rainlevel];

};
	