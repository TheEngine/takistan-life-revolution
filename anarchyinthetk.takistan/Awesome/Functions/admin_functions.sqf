if (not(isNil "admin_functions_defined")) exitWith {};


///////////////NOT TESTED!///////////////
admin_create_poll = {
	private["_question", "_polltime", "_poll"];
	_question = format["%1",_this select 0];
	_polltime = round(time + 60);
	
	if (_question == "") exitWith {player groupChat "You have to enter a question to start a poll";};
	_poll = server getVariable "admin_poll";
	if (not(isNil "_poll")) exitWith {player groupChat "There is already another poll running. Wait for it to complete before starting a new poll";};
	
	//Broadcast that there is a new poll
	[_polltime] spawn admin_set_results_poll;
	format["[""%1"",%2] call admin_vote_poll", _question, _polltime] call broadcast;
	
};

admin_vote_poll = {
	private["_question", "_pollID", "_polltime", "_votes"];
	if (isServer) exitWith {};
	
	//player groupChat format["%1", _this];
	_question = _this select 0;
	_polltime = _this select 1;
	[_question, _polltime] spawn admin_see_poll_results;
	//player groupChat format["%1", typeName _question];
	player setVariable ["admin_poll", nil, true];
	
	response = false;
	if (!(createDialog "ja_nein")) exitWith {hint "Dialog Error!"};
	ctrlSetText [1, _question];
	waitUntil{(not(ctrlVisible 1023))};

	if (time > _polltime) exitWith{player groupChat "Sorry you voted to late, your vote could not be counted";};
	if(not(response)) then {
		player setVariable ["admin_poll", "No", true];
	} else {
		player setVariable ["admin_poll", "Yes", true];
	};
	
};

admin_see_poll_results = {
	private["_question", "_polltime", "_votes"];
	_question = _this select 0;
	_polltime = _this select 1;
	
	while{time <= _polltime} do {
		_votes = server getVariable "admin_poll";
		if (typeName (_votes select 0) != "SCALAR") then {
			_votes = [0,0,0];
		};
		hint format["Actual standings on the question: %1\nYes: %2\nNo: %3\nNot voted: %4\nPoll ends in %5 seconds", _question, _votes select 0, _votes select 1, _votes select 2, round(_polltime - time)];
		sleep 1;
	};
	
	//Poll is over
	_votes = server getVariable "admin_poll";
	
	hint format["Result of the poll %1:\nVotes for yes: %2\nVotes for no: %3\nNot voted: %4", _question, _votes select 0, _votes select 1, _votes select 2];
	sleep 10;
	hint "";
};

admin_set_results_poll = {
	private["_polltime", "_player", "_vote", "_votes"];
	_polltime = (_this select 0) + 10;
	_votes = [0,0,0];
	
	while {_polltime >= time} do {
		{
			_vote = _x getVariable "admin_poll";
		
			switch (_vote) do {
				case "No": {
					_votes set [1, ((votes select 1) + 1);
					_votes set [2, ((votes select 2) - 1);
					_x setVariable ["admin_poll", "Counted", true];
				};
				
				case "Yes": {
					_votes set [0, ((votes select 0) + 0);
					_votes set [2, ((votes select 2) - 1);
					_x setVariable ["admin_poll", "Counted", true];
				};
				
				case "Counted": {
				};
				
				case nil: {
					_votes set [2, ((votes select 2) + 1);
					_x setVariable ["admin_poll", "Counted", true];
				};
			
			};
		} foreach playableUnits;
		
		if ((_votes select 2) < 0) then {
			_votes set [2,0];
		};
		
		server setVariable ["admin_poll", _votes, true];
		sleep 1;
	};
	
	//Reset votes
	{
		_x setVariable ["admin_poll", nil, true];
	} foreach playableUnits;
	server setVariable ["admin_poll", nil, true];
};
///////////////!NOT TESTED!///////////////

admin_functions_defined = true;