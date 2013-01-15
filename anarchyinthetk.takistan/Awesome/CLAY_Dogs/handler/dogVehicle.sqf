private ["_dog","_vehicle","_pos","_dir","_cnt"];
_dog = player getVariable "CLAY_DogUnit";
_cnt=0;
switch (_this select 0) do
{
	case 1:
	{
		player setVariable ["CLAY_DogStatus", "Boarding"];
		_vehicle = _this select 1;
		//_index = [CLAY_DogVehicles, typeOf _vehicle] call BIS_fnc_findNestedElement;
		{
			if((_x select 0)==(typeOf _vehicle)) then {_cnt=_forEachIndex;};
		} foreach (player getVariable "CLAY_DogVehicles");
		If (_cnt > 0) Then
		 { 
			_pos = (CLAY_DogVehicles select _cnt) select 1;
			_dir = (CLAY_DogVehicles select _cnt) select 2;
		 } 
		else 
		 {
			_pos = [0,-1.8,-.5];
			_dir = 0;
		 };
		if (alive _dog && ((_dog distance _vehicle) > 5) && player getVariable "CLAY_DogStatus" == "Boarding") then
			{
			  _dog doMove getPos _vehicle;
			  waituntil{(_dog distance _vehicle) <= 5};
			 };
			If (alive _dog && (player getVariable "CLAY_DogStatus") == "Boarding") Then
			 {
				_dog attachTo [_vehicle,_pos];
				_dog setDir _dir;
				_dog switchMove "Dog_sit1";
				sleep 1;
				_dog disableAI "ANIM";				
				player setVariable ["CLAY_DogStatus", "InVehicle"];
				_dog setVariable ["CLAY_DogVehicle", _vehicle];
				(DOGCTRL_MENU select 1) set [6, "0"];
				(DOGCTRL_MENU select 2) set [6, "0"];
				(DOGCTRL_MENU select 3) set [6, "0"];
				(DOGCTRL_MENU select 4) set [6, "0"];
				(DOGCTRL_MENU select 5) set [6, "0"];
				(DOGCTRL_MENU select 6) set [6, "0"];
				(DOGCTRL_MENU select 7) set [6, "0"];
				(DOGCTRL_MENU select 8) set [6, "0"];
				(DOGCTRL_MENU select 9) set [6, "1"];				
			};		
	};
	case 2:
	{
		_vehicle = _dog getVariable "CLAY_DogVehicle";
		detach _dog;
		_dog setPos [(getPos _vehicle select 0) + (-5 * sin (getDir _vehicle)), (getPos _vehicle select 1) + (-5 * cos (getDir _vehicle)),0];
		_dog setDir (getDir _vehicle + 180);
		_dog enableAI "ANIM";
		_dog playMove "Dog_Run";		
		player setVariable ["CLAY_DogStatus", "Waiting"];
		(DOGCTRL_MENU select 1) set [6, "1"];
		(DOGCTRL_MENU select 3) set [6, "0"];
		(DOGCTRL_MENU select 4) set [6, "1"];
		(DOGCTRL_MENU select 5) set [6, "1"];
		(DOGCTRL_MENU select 6) set [6, "1"];
		(DOGCTRL_MENU select 7) set [6, "0"];
		(DOGCTRL_MENU select 8) set [6, "CursorOnEmptyVehicle"];
		(DOGCTRL_MENU select 9) set [6, "0"];
		
	};
};
