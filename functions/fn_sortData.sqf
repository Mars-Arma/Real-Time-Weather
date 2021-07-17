// File: fn_sortData.sqf
// Author: Infamous
// Description: Sorts the data

private ["_result","_temp_c","_temp_f","_weathercode","_rainlevel","_relative_humidity","_wind_degrees","_wind_kph","_wind_mph","_wind_gust_mph","_wind_gust_kph","_pressuretrend","_pressure","_pressureIn","_rainchance","_totalrain","_date","_day","_month","_year","_hour","_minute"];
_result = _this;
_temp_c = _result find "temperature";
_temp_c = parseNumber (_result select [(_temp_c+13),3]);
_temp_f = ((_temp_c * 9/5) + 32);
_cloudcover = _result find 'cloudcover';
_cloudcover = parseNumber (_result select [(_cloudcover+12),3]);
_cloudcover = (_cloudcover * 0.01);
_weathercode = _result find 'weather_code';
_weathercode = parseNumber (_result select [(_weathercode+14),3]);
_rainlevel = 0;
	
switch _weathercode do
{
	//Special Values
	case 374 : {_rainlevel = 0.25;};//	Light showers of ice pellets	wsymbol_0013_sleet_showers	wsymbol_0029_sleet_showers_night
	case 365 : {_rainlevel = 0.5;};//	Moderate or heavy sleet showers	wsymbol_0013_sleet_showers	wsymbol_0029_sleet_showers_night
	case 362 : {_rainlevel = 0.2;};//	Light sleet showers	wsymbol_0013_sleet_showers	wsymbol_0029_sleet_showers_night
	case 179 : {_rainlevel = 0.15;};//	Patchy snow nearby	wsymbol_0013_sleet_showers	wsymbol_0029_sleet_showers_night

	case 320 : {_rainlevel = 0.6;};//	Moderate or heavy sleet	wsymbol_0019_cloudy_with_light_snow	wsymbol_0035_cloudy_with_light_snow_night
	case 227 : {_rainlevel = 0.15;};//	Blowing snow	wsymbol_0019_cloudy_with_light_snow	wsymbol_0035_cloudy_with_light_snow_night

	case 377 : {_rainlevel = 0.65;};//	Moderate or heavy showers of ice pellets	wsymbol_0021_cloudy_with_sleet	wsymbol_0037_cloudy_with_sleet_night
	case 350 : {_rainlevel = 0.5;};//	Ice pellets	wsymbol_0021_cloudy_with_sleet	wsymbol_0037_cloudy_with_sleet_night
	case 317 : {_rainlevel = 0.1;};//	Light sleet	wsymbol_0021_cloudy_with_sleet	wsymbol_0037_cloudy_with_sleet_night
	case 314 : {_rainlevel = 0.65;};//	Moderate or Heavy freezing rain	wsymbol_0021_cloudy_with_sleet	wsymbol_0037_cloudy_with_sleet_night
	case 311 : {_rainlevel = 0.1;};//	Light freezing rain	wsymbol_0021_cloudy_with_sleet	wsymbol_0037_cloudy_with_sleet_night
	case 284 : {_rainlevel = 0.5;};//	Heavy freezing drizzle	wsymbol_0021_cloudy_with_sleet	wsymbol_0037_cloudy_with_sleet_night
	case 281 : {_rainlevel = 0.3;};//	Freezing drizzle	wsymbol_0021_cloudy_with_sleet	wsymbol_0037_cloudy_with_sleet_night
	case 185 : {_rainlevel = 0.225;};//	Patchy freezing drizzle nearby	wsymbol_0021_cloudy_with_sleet	wsymbol_0037_cloudy_with_sleet_night
	case 182 : {_rainlevel = 0.125;};//	Patchy sleet nearby	wsymbol_0021_cloudy_with_sleet	wsymbol_0037_cloudy_with_sleet_night

	case 338 : {_rainlevel = 0.65;};//	Heavy snow	wsymbol_0020_cloudy_with_heavy_snow	wsymbol_0036_cloudy_with_heavy_snow_night
	case 332 : {_rainlevel = 0.55;};//	Moderate snow	wsymbol_0020_cloudy_with_heavy_snow	wsymbol_0036_cloudy_with_heavy_snow_night
	case 329 : {_rainlevel = 0.35;};//	Patchy moderate snow	wsymbol_0020_cloudy_with_heavy_snow	wsymbol_0036_cloudy_with_heavy_snow_night
	case 230 : {_rainlevel = 1;};//	Blizzard	wsymbol_0020_cloudy_with_heavy_snow	wsymbol_0036_cloudy_with_heavy_snow_night

	case 371 : {_rainlevel = 0.65;};//	Moderate or heavy snow showers	wsymbol_0012_heavy_snow_showers	wsymbol_0028_heavy_snow_showers_night
	case 395 : {_rainlevel = 1;};//	Moderate or heavy snow in area with thunder	wsymbol_0012_heavy_snow_showers	wsymbol_0028_heavy_snow_showers_night
	case 335 : {_rainlevel = 0.5;};//	Patchy heavy snow	wsymbol_0012_heavy_snow_showers	wsymbol_0028_heavy_snow_showers_night

	case 326 : {_rainlevel = 0.03;};//	Light snow	wsymbol_0011_light_snow_showers	wsymbol_0027_light_snow_showers_night
	case 323 : {_rainlevel = 0.01;};//	Patchy light snow	wsymbol_0011_light_snow_showers	wsymbol_0027_light_snow_showers_night
	case 368 : {_rainlevel = 0.02;};//	Light snow showers	wsymbol_0011_light_snow_showers	wsymbol_0027_light_snow_showers_night

	case 260 : {_rainlevel = 0;};//	Freezing fog	wsymbol_0007_fog	wsymbol_0007_fog

	//Common Values
	case 248 : {_rainlevel = 0.001;};//	Fog	wsymbol_0007_fog	wsymbol_0007_fog

	case 389 : {_rainlevel = 1;};//	Moderate or heavy rain in area with thunder	wsymbol_0024_thunderstorms	wsymbol_0040_thunderstorms_night
	case 392 : {_rainlevel = 1;};//Patchy light snow in area with thunder	wsymbol_0016_thundery_showers	wsymbol_0032_thundery_showers_night
	case 386 : {_rainlevel = 0.75;};//	Patchy light rain in area with thunder	wsymbol_0016_thundery_showers	wsymbol_0032_thundery_showers_night
	case 200 : {_rainlevel = 0.75;};//	Thundery outbreaks in nearby	wsymbol_0016_thundery_showers	wsymbol_0032_thundery_showers_night
	
	case 359 : {_rainlevel = 0.6;};//	Torrential rain shower	wsymbol_0018_cloudy_with_heavy_rain	wsymbol_0034_cloudy_with_heavy_rain_night
	case 308 : {_rainlevel = 0.55;};//	Heavy rain	wsymbol_0018_cloudy_with_heavy_rain	wsymbol_0034_cloudy_with_heavy_rain_night
	case 302 : {_rainlevel = 0.5;};//	Moderate rain	wsymbol_0018_cloudy_with_heavy_rain	wsymbol_0034_cloudy_with_heavy_rain_night

	case 356 : {_rainlevel = 0.45;};//	Moderate or heavy rain shower	wsymbol_0010_heavy_rain_showers	wsymbol_0026_heavy_rain_showers_night
	case 305 : {_rainlevel = 0.35;};//	Heavy rain at times	wsymbol_0010_heavy_rain_showers	wsymbol_0026_heavy_rain_showers_night
	case 299 : {_rainlevel = 0.25;};//	Moderate rain at times	wsymbol_0010_heavy_rain_showers	wsymbol_0026_heavy_rain_showers_night

	case 296 : {_rainlevel = 0.2;};//	Light rain	wsymbol_0017_cloudy_with_light_rain	wsymbol_0025_light_rain_showers_night
	case 266 : {_rainlevel = 0.15;};//	Light drizzle	wsymbol_0017_cloudy_with_light_rain	wsymbol_0033_cloudy_with_light_rain_night
	case 293 : {_rainlevel = 0.125;};//	Patchy light rain	wsymbol_0017_cloudy_with_light_rain	wsymbol_0033_cloudy_with_light_rain_night

	case 353 : {_rainlevel = 0.1;};//	Light rain shower	wsymbol_0009_light_rain_showers	wsymbol_0025_light_rain_showers_night
	case 176 : {_rainlevel = 0.05;};//	Patchy rain nearby	wsymbol_0009_light_rain_showers	wsymbol_0025_light_rain_showers_night
	case 263 : {_rainlevel = 0.01;};//	Patchy light drizzle	wsymbol_0009_light_rain_showers	wsymbol_0025_light_rain_showers_night

	case 143 : {_rainlevel = 0.001;};//	Mist	wsymbol_0006_mist	wsymbol_0006_mist
	case 122 : {_rainlevel = 0.001;};//	Overcast	wsymbol_0004_black_low_cloud	wsymbol_0004_black_low_cloud
	case 119 : {_rainlevel = 0.0001;};//	Cloudy	wsymbol_0003_white_cloud	wsymbol_0004_black_low_cloud
	case 116 : {_rainlevel = 0.00001;};//	Partly Cloudy	wsymbol_0002_sunny_intervals	wsymbol_0008_clear_sky_night
	case 113 : {_rainlevel = 0;};//	Clear/Sunny	wsymbol_0001_sunny	wsymbol_0008_clear_sky_night

};
	
	
	
	_relative_humidity = _result find 'humidity';
	_relative_humidity = parseNumber (_result select [(_relative_humidity+10),3]);

	
	_wind_degrees = _result find 'wind_degree';
	_wind_degrees = parseNumber (_result select [(_wind_degrees+13),3]);

	
	_wind_kph = _result find 'wind_speed';
	_wind_kph = parseNumber (_result select [(_wind_kph+12),4]);

	_wind_mph = (_wind_kph / 1.60934);
	_wind_gust_mph = _wind_mph;
	_wind_gust_kph = _wind_kph;

	_pressuretrend = "1";
	
	_pressure = _result find 'pressure';
	_pressure = parseNumber (_result select [(_pressure+10),5]);
	_pressureIn = _pressure * 0.0295301;
	
	_rainchance = _result find 'precip';
	_rainchance = parseNumber (_result select [(_rainchance+8),4]);
	
	_totalrain = 0;
	
	_date = _result find 'localtime';
	_day = ParseNumber (_result select [(_date+20),2]);
	_month = ParseNumber (_result select [(_date+17),3]);
	_year = parseNumber (_result select [(_date+12),4]);
	_hour = parseNumber (_result select [(_date+23),2]);
	_minute = parseNumber (_result select [(_date+26),2]);
	_date = [];
	{_date pushBack _x} forEach [_year,_month,_day,_hour,_minute];
	_result = [];
	{_result PushBack _x} forEach [_temp_f,_temp_c,_wind_mph,_wind_gust_mph,_wind_kph,_wind_gust_kph,_wind_degrees,_relative_humidity,_pressureIn,_totalrain,_rainchance,_date,_cloudcover,_rainlevel];
	_result