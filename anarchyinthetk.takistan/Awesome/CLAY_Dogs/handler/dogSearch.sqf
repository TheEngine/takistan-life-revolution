private ["_dog","_target","_dist","_nearEnemys"];
_dog = player getVariable "CLAY_DogUnit";
player setVariable ["CLAY_DogStatus", "Searching"];
(DOGCTRL_MENU select 6) set [6, "0"];
(DOGCTRL_MENU select 7) set [6, "0"];

switch (_this select 0) do
{
	case 1:
	{
		_dist = CLAY_DogSearchDistanceMan;
		_nearEnemys = [_dog, _dist] execvm "Awesome\CLAY_Dogs\fn_findNearEnemy.sqf";
		If (count _nearEnemys > 0) Then
		{
			_target = _nearEnemys select 0;
			sleep 1;
			nul = [_target] execVM "\Awesome\CLAY_Dogs\handler\dogAttack.sqf";
		}
		Else
		{
			_startPos = getPos _dog;
			while {alive _dog && player getVariable "CLAY_DogStatus" == "Searching"} do
			{
				_pos = [(_startPos select 0) + ((random (2 * _dist))), (_startPos select 1) + ((random (2 * _dist))), 0];
				while {alive _dog && _dog distance _pos > 10 && player getVariable "CLAY_DogStatus" == "Searching"} do
				{
					_dog doMove _pos;
					sleep 2;
				};
				If (alive _dog && player getVariable "CLAY_DogStatus" == "Searching") Then
				{
					_nearEnemys = [_dog, _dist] execvm "Awesome\CLAY_Dogs\fn_findNearEnemy.sqf";
					If (count _nearEnemys > 0) Then
					{
						_target = _nearEnemys select 0;
						nul = [_target] execVM "\Awesome\CLAY_Dogs\handler\dogAttack.sqf";
					};
				};
				sleep 1;
			};
		};
	};
	case 2:
	{
		_startPos = getPos _dog;
		_dist = CLAY_DogSearchDistanceEOD;
		while {alive _dog && player getVariable "CLAY_DogStatus" == "Searching"} do
		{
			//_eodObjs = nearestObjects [_dog, CLAY_DogEODs, _dist];
			_eodObjs = [];
			{
				_o = _dog nearObjects [_x, _dist];
				_eodObjs = _eodObjs + _o;
			} forEach CLAY_DogEODs;

			If (count _eodObjs > 0) Then
			{
				_obj = _eodObjs select 0;
				while {alive _dog && _dog distance _obj > 10 && player getVariable "CLAY_DogStatus" == "Searching"} do
				{
					_dog doMove getPos _obj;
					sleep 2;
				};
				player setVariable ["CLAY_DogStatus", "Waiting"];
				_dog playMove "Dog_Sit1";
			}
			Else
			{
				_pos = [(_startPos select 0) + random  _dist, (_startPos select 1) + random (_dist), 0];
				while {alive _dog && _dog distance _pos > 10 && player getVariable "CLAY_DogStatus" == "Searching"} do
				{
					_dog doMove _pos;
					sleep 2;
				};
			};
			sleep 1;
		};
	};
};

(DOGCTRL_MENU select 6) set [6, "1"];
(DOGCTRL_MENU select 7) set [6, "1"];
