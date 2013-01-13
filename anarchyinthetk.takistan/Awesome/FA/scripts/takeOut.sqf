//taking out all agonized ppl in vehicle

_vehicle = cursorTarget;

{
	if (_x getVariable "FA_inAgony") then {

			_x action ["eject", vehicle _x];

			Sleep (0.01);
			
			[nil, _x,"loc",rPLAYACTIONNOW,"healedStart"] call RE;
			[nil, _x,"loc",rPLAYACTION,"GestureNod"] call RE;      	      	    	    
		};
} forEach (crew _vehicle);
