
If (player getVariable "CLAY_DogStatus" == "Attacking") exitWith {};
private ["_dog","_target","_oldpos","_sound"];
_oldpos=[0,0,0];
_target = _this select 0;

_dog = player getVariable "CLAY_DogUnit";

player setVariable ["CLAY_DogStatus", "Attacking"];
(DOGCTRL_MENU select 1) set [6, "1"];
(DOGCTRL_MENU select 2) set [6, "1"];
(DOGCTRL_MENU select 3) set [6, "1"];
_sound = createSoundSource ["Sound_Dog", getpos _dog, [], 0];
_sound attachTo [_dog];

while {(alive _dog) && (alive _target) && ((player getVariable "CLAY_DogStatus") == "Attacking")} do
{
    if( _dog distance _target > 2 ) then 
	{
  
		//_sound = [objNull, _dog, rSAY, "dog_01"] call RE;
		 _dog switchMove "Dog_Bark";
		if( _dog distance _target > 30 ) then 
		 {
			_vel = velocity _dog;
			_dir = direction _dog;		
			_speed = 2; 
            _dog setVelocity [(_vel select 0)+((sin _dir)*_speed),(_vel select 1)+ ((cos _dir)*_speed),(_vel select 2)];
		};
		if(([_oldpos ,getPos _dog] call BIS_fnc_areEqual) && (_dog distance _target < 5) ) then 
		 {
		   _dog switchMove "Dog_Run";
		   _dog lookAt _target;	
		   _pos = [((getPos _target select 0)+(getPos _dog select 0))/2 + 1.5*(sin(getDir _dog)),((getPos _target select 1)+(getPos _dog select 1))/2 +  1.5*(cos (getDir _dog)), 0];		   
		   _dog doMove _pos;  
		 } 
		else 
		 {
		   _pos = [(getPos _target select 0) + ( sin (getDir _target)), (getPos _target select 1) + (0.3 * cos (getDir _target)), 0];
		   _dog lookAt _target;
		   _dog doMove _pos;				
		   	 
		};
		_oldpos= getPos _dog;	   
	    //sleep 2;
	 } 
	else 
	 {
	    _dog doTarget _target;
		_dog lookAt _target;		
		_dog switchMove "Dog_Attack";
		sleep 0.35; 
		_dog setVelocity [0, 0, 1.5];			
		_target setHit ["legs", 1];		
		_target playMove "AmovPpneMstpSrasWrflDnon";		
		_target setHit ["hands", 1];
		_target setDamage (damage _target + 0.4);	
		player groupchat "The dog has neutralized his target";
		StunActiveTime = StunActiveTime + 5;
		[_target] spawn stun_effects_full;	        
		player setVariable ["CLAY_DogStatus", "Waiting"];
		_dog playMove "Dog_Sit1";
	 };
	   
sleep 3.45;
};


deleteVehicle _sound;


