waitUntil {!isNull (findDisplay 46)};

player switchCamera "External";
enableSaving [false, false];
player enableFatigue false;
player allowDamage false;
enableTeamSwitch false;

// Setup configuration
call life_fnc_configuration;

[] spawn life_fnc_setWeather;
systemChat "Starting preprocess";