
private ["_dog", "_dist", "_nearUnits", "_nearEnemys"];
_dog = _this select 0;
_dist = _this select 1;

_nearUnits = nearestObjects [_dog, ["Man"], _dist];
_nearEnemys = [];
{
	If ((alive _x) && ((side _x) getFriend (side _dog) < 0.6) && (_x != _dog)) Then
	{
		_nearEnemys set [count _nearEnemys, _x];
	};
} foreach _nearUnits;

_nearEnemys
