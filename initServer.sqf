
// Setup configuration
call life_fnc_configuration;

// we wanna make sure these two are only spawned on the server!
[] spawn life_fnc_setWeather;
sleep 5;
[] spawn life_fnc_initNightLights;

