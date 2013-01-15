
If (isServer) Then
{
	If (isNil "RE") Then
	{
		nul= [] execVM "\ca\Modules\MP\data\scripts\MPframework.sqf";
	};

	_wdm = _this select 0;

	private "_dist";
	If (!(isNil {_wdm getVariable "CLAY_DogAttackDistance"})) Then
	{
		_dist = _wdm getVariable "CLAY_DogAttackDistance";
	}
	Else
	{
		_dist = 150;
	};

	private "_count";
	If (!(isNil {_wdm getVariable "CLAY_DogCount"})) Then
	{
		_count = _wdm getVariable "CLAY_DogCount";
	}
	Else
	{
		_count = 5;
	};


	If (isNil "CLAY_fnc_findNearEnemy") Then
	{
		CLAY_fnc_findNearEnemy = compile preprocessFile "\Awesome\CLAY_Dogs\fn_findNearEnemy.sqf";
	};
	publicVariable "CLAY_fnc_findNearEnemy";


	_search = 
	{
		_dog = _this select 0;
		_dist = _this select 1;

		while {alive _dog} do
		{
			_nearUnits = nearestObjects [_dog, ["Man"], _dist];
			If (count _nearUnits > 0) Then
			{
				_nearEnemys = [];
				{
					If ((alive _x) && !(_x isKindOf "CLAY_Dog")) Then
					{
						_nearEnemys set [count _nearEnemys, _x];
					};
				} forEach _nearUnits;

				If (count _nearEnemys > 0) Then
				{
					_target = _nearEnemys select 0;
					sleep 1;
					_attacking = [_dog, _target] execVM "\Awesome\CLAY_Dogs\scripts\attack.sqf";
					waitUntil {scriptDone _attacking};
				};
			};
			sleep 1;
		};
	};

	_c = (_count - 1) + (floor (random 3));
	If (_c < 1) Then {_c = 1};

	for "_i" from 1 to _c do
	{
		private "_type";
		If (random 10 > 5) Then
		{
			_type = "CLAY_Dog";
		}
		Else
		{
			_type = "CLAY_Dog2";
		};

		createCenter CIVILIAN;
		_grp = createGroup CIVILIAN;
		_dog = _grp createUnit [_type, [(getPos _wdm select 0) + (10 - (random 20)), (getPos _wdm select 1) + (10 - (random 20)), 0], [], 0, "NONE"];
		_dog setDir (random 360);
		_dog addRating -2500;

		nul = [_dog, _dist] spawn _search;
	};
};
