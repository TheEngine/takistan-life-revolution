
If (isServer) Then
{
	If (isNil "RE") Then
	{
		nul= [] execVM "\ca\Modules\MP\data\scripts\MPframework.sqf";
	};

	_d = _this select 0;

	private "_dist";
	If (!(isNil {_d getVariable "CLAY_DogAttackDistance"})) Then
	{
		_dist = _d getVariable "CLAY_DogAttackDistance";
	}
	Else
	{
		_dist = 150;
	};

	private "_type";
	If (!(isNil {_d getVariable "CLAY_DogType"})) Then
	{
		_type = _d getVariable "CLAY_DogType";
	}
	Else
	{
		_type = "CLAY_Dog";
	};

	_pos = getPos _d;
	_dir = getDir _d;
	_grp = createGroup (side _d);
	_name = format ["CLAY_tmpDog%1", round (random 1000)];
	call compile format ["_type createUnit [getPos _d, _grp, '%1 = this']", _name];
	_dog = call compile format ["%1", _name];
	_dog setDir getDir player;
	deleteVehicle _d;


	If (isNil "CLAY_fnc_findNearEnemy") Then
	{
		CLAY_fnc_findNearEnemy = compile preprocessFile "\Awesome\CLAY_Dogs\fn_findNearEnemy.sqf";
	};
	publicVariable "CLAY_fnc_findNearEnemy";

	while {alive _dog} do
	{
		_nearEnemys = [_dog, _dist] call CLAY_fnc_findNearEnemy;
		If (count _nearEnemys > 0) Then
		{
			_target = _nearEnemys select 0;
			sleep 1;
			_attacking = [_dog, _target] execVM "\Awesome\CLAY_Dogs\scripts\attack.sqf";
			waitUntil {scriptDone _attacking};
		};
		sleep 1;
	};
};
