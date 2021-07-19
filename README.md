# Real Time Weather
 Real Time Weather for Arma 3

IMPORTANT!!!!!

there are a few conditions that you may need to set up inside the config file.

life_timeVar // if you want for the weather app to also update the time ingame to the real time

life_fogvar // if you want the weather app to also update the humidity and fog value in the game

important to note, inside the nightlights file at the bottom you will find the sleep command that decides the delay between each meteor spawn.

the two url fetch DLL's need to be placed in your arma 3 download directory (this is only needed for the server, as all these scripts are server sided)

you will require an API key, you can get one from https://weatherstack.com/ A free account should suffice.

make sure you open the configuration file located inside the config folder and set the api key to the variable "life_WeatherKeyAPI" 

please note that this is likely not 100% bug free, i've been testing Multiplayer code in a Singleplayer condition. if you happen to find some bugs, report them!
