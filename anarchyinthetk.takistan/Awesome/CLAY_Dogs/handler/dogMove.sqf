private ["_pos","_dog","_dest"];
_dog = player getVariable "CLAY_DogUnit";
switch (_this select 0) do
{
	case 1:
	{
		(DOGCTRL_MENU select 1) set [6, "0"];
		(DOGCTRL_MENU select 2) set [6, "1"];		
		player setVariable ["CLAY_DogStatus", "Following"];
		while {alive _dog && (player getVariable "CLAY_DogStatus") == "Following" } do
		{
		    if((_dog distance player)>5) then 
			 {
			   _pos = [(getPos player select 0) + (1 * sin (getDir player)), (getPos player select 1) + (0.3 * cos (getDir player)), 0];
			   _dog doMove _pos;				
			};
			sleep 2;
		};
	};
	case 2:
	{
		(DOGCTRL_MENU select 1) set [6, "1"];
		(DOGCTRL_MENU select 2) set [6, "0"];
		player setVariable ["CLAY_DogStatus", "Waiting"];
		//_dog doMove getPos _dog;
		sleep 1;
		_dog playMove "Dog_Sit1";
	};
	case 3:
	{
		(DOGCTRL_MENU select 1) set [6, "1"];
		(DOGCTRL_MENU select 2) set [6, "1"];
		hint "eae?";
		_dest=getPos (_this select 1);
		player setVariable ["CLAY_DogStatus", "Moving"];		
		_dog doMove _dest;	
		sleep 5;
		_dot domove getpos player;
		
	};
};
