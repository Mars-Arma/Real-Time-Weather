# Real Time Weather
 Real Time Weather for Arma 3

IMPORTANT!!!!!

there are a few conditions that you may need to set up inside the config file.

life_timeVar // if you want for the weather to also update the time ingame to the real time

life_fogVar // if you want the weather to also update the humidity and fog value in the game

life_windVar // if you want the weather to sync the wind value 

life_rainVar // if you want the weather to sync the rain value

important to note, inside the initNightLights file at the bottom you will find the sleep command that decides the delay between each meteor spawn. (currently set to 150 seconds // 2:30 min)

the two url fetch DLL's need to be placed in your arma 3 download directory (this is only needed for the server, as all these scripts are server sided)

both the scripts are called from the initServer.sqf file. (initNightLights and setWeather) these both run on the server, however createNightLights is remotely executed from the server onto all clients as #lightpoints are all local.

you will require an API key, you can get one from https://weatherstack.com/ A free account should suffice.

make sure you open the configuration file located inside the config folder and set the api key to the variable "life_WeatherKeyAPI" 

if you wish to only use one part of this mission, please by all means do so.


