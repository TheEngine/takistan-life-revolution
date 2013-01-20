if (not(isNil "list_functions_defined")) exitWith {};

//Call examples:
//Add to list:
// [player, "pmc_whitelist", "add"] call list_update;
//Remove from list:
// [player, "pmc_whitelist", "remove"] call list_update;
//Get state (is player in the list?)
// _state = [player, "pmc_whitelist"] call list_contains;
//Clear list
// ["pmc_whitelist"] call list_wipe;

// Used Listnames: (atm none, just how i would name them. After we used it switching is possible by renaming it in the server stats on restart)
//
// Faction		 	 Whitelist			Blacklist
// PMC				 pmc_whitelist		pmc_blacklist
// Blufor			 cop_whitelist		cop_blacklist
// Admin			 adm_list			-
// Donator			 don_list_a			-
// Silver Donator	 don_list_b			-
// Gold Donator		 don_list_c			-
// Platinium Donator don_list_d			-
// Bugfinder		 bug_list			-

list_update = {
	private["_player", "_list", "_mode", "_playerUID", "_oldList"];
	_player = _this select 0;
	_list = _this select 1;
	_mode = _this select 2;
	_playerUID = getPlayerUID _player;
	//Modes: 0 - toggle, 1 - add, 2 - remove
	// You can use "toggle", "add" or "remove" too as mode (case insensitive)
	
	
	if (isNil "_player") exitWith {false};
	if (isNil "_list") exitWith {false};
	if (isNil "_mode") exitWith {false};
	
	if (typeName _player != "OBJECT") exitWith {false};
	if (typeName _list != "STRING") exitWith {false};
	
	
	if (typeName _mode == "STRING") then {
		_mode = toLower(_mode);
		switch (_mode) do {
			case "toggle": { _mode = 0; };
			case "add": { _mode = 1; };
			case "remove": { _mode = 2; };
		};
	};
	
	if (typeName _mode != "SCALAR") exitWith {false};
	_oldList = [_list] call list_get;
	sleep 0.5;
	
	if (_mode == 0) then {
		if (_playerUID in _oldList) then {
			_mode = 2;
		} else {
			_mode = 1;
		};
	};
	
	switch (_mode) do {
		case 1: {
			[_player, _list] call list_add;
		};
		case 2: {
			[_player, _list] call list_remove;
		};
	};
	true
};

list_get = {
	private["_list", "_return"];
	_list = _this select 0;
	
	if (isNil "_list") exitWith {};
	if (typeName _list != "STRING") exitWith {};
	
	_return = server getVariable _list;
	sleep 0.1;
	if (isNil "_return") then {
		_return = [];
	};
	
	_return
};

list_add = {
	private["_player", "_list", "_playerUID", "_oldList"];
	_player = _this select 0;
	_list = _this select 1;
	_playerUID = getPlayerUID _player;
	
	if (isNil "_player") exitWith {false};
	if (isNil "_list") exitWith {false};
	
	if (typeName _player != "OBJECT") exitWith {false};
	if (typeName _list != "STRING") exitWith {false};
	
	_oldList = [_list] call list_get;
	if (_playerUID in _oldList) exitWith {true};
	_oldList set [(count _oldList), _playerUID];
	
	server setVariable [_list, _oldList, true];
	[_list, _oldList] call stats_server_save;
	true
};

list_remove = {
	private["_player", "_list", "_playerUID", "_oldList"];
	_player = _this select 0;
	_list = _this select 1;
	_playerUID = getPlayerUID _player;
	
	if (isNil "_player") exitWith {false};
	if (isNil "_list") exitWith {false};
	
	if (typeName _player != "OBJECT") exitWith {false};
	if (typeName _list != "STRING") exitWith {false};
	
	_oldList = [_list] call list_get;
	if (not(_playerUID in _oldList)) exitWith {true};
	_oldList = _oldList - _playerUID;
	
	server setVariable [_list, _oldList, true];
	[_list, _oldList] call stats_server_save;
	true
};

list_contains = {
	private["_player", "_list", "_playerUID", "_oldList", "_return"];
	_player = _this select 0;
	_list = _this select 1;
	_playerUID = getPlayerUID _player;
	
	if (isNil "_player") exitWith {false};
	if (isNil "_list") exitWith {false};
	
	if (typeName _player != "OBJECT") exitWith {false};
	if (typeName _list != "STRING") exitWith {false};
	
	_oldList = [_list] call list_get;
	if (_playerUID in _oldList) then {
		_return = true;
	} else {
		_return = false;
	};
	
	_return
};

list_wipe = {
	private["_list"];
	_list = _this select 0;
	
	if (isNil "_list") exitWith {false};
	if (typeName _list != "STRING") exitWith {false};
	
	server setVariable [_list, [], true];
	[_list, []] call stats_server_save;
	true	
};

list_functions_defined = true;
