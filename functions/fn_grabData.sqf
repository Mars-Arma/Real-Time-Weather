
// all credits here go to killzonekid! 
private ["_result","_results","_ticks"];
	_results = ["",""];
	_result = "";
	_ticks = round diag_tickTime;
	life_timeOut = false;
	life_dataReady = false;
	
	systemChat "Grabbing Data";
	waitUntil 
	{
		_cond = false;
		_status = "urlExtension" callExtension format ["%1", _this];
        if ((_status == "OK") OR (_status != "BUSY"))then {_cond = true;};
		if (diag_tickTime > (_ticks + 15)) then {_cond = true;life_timeOut = true;life_error = true;};
        _cond
    };
	_ticks = round diag_tickTime;
    waitUntil 
	{
		_cond = false;
        _result = "urlExtension" callExtension "OK";
        if (_result != "WAIT") then {_cond = true;};
		if (diag_tickTime > (_ticks + 15)) then {_cond = true;life_timeOut = true;life_error = true;_result = "ERROR";};
        _cond
    };
    if (_result == "ERROR") then 
	{
       

    };

	life_dataReady = true;
	_results = [_result, "DONE"];
	_results