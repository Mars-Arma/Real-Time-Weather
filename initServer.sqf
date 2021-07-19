waitUntil {!isNull (findDisplay 46)};

player switchCamera "External";
enableSaving [false, false];
player enableFatigue false;
player allowDamage false;
enableTeamSwitch false;

// Setup configuration
call life_fnc_configuration;

// we wanna make sure these two are only spawned on the server!
[] spawn life_fnc_setWeather;
sleep 5;
[] spawn life_fnc_nightLights;

