private["_group_loop_i"];

_group_loop_i = 0;

while {true} do {	

	if ( (((group player) == (group server)) || ((side player) != ([player] call player_side))) && !(C_changing)  ) then {
			_side = [player] call player_side;
			_group = createGroup _side;
			if ((group player) == (group server)) then {
					[player] joinSilent _group;
				}else{
					_leader = leader player;
					_units = units (group player);
					_units joinSilent _group;
					_group selectLeader _leader;
				};
		};
		
	sleep 10;
	_group_loop_i =_group_loop_i + 1;
	if (_group_loop_i >= 5000) exitwith {[] execVM "Awesome\Client\client_loop.sqf";};
};

// player_side
// [_player] call player_side