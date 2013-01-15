If (isServer) Then
{
	If (isNil "bis_fnc_init") Then
	{
        private ["_logGrp","_logFnc"];
		createCenter sideLogic;
		_logGrp = createGroup sideLogic;
		_logFnc = _logGrp createUnit ["FunctionsManager", [0,0,0], [], 0, "NONE"];
	};
	If (isNil "RE") Then
	{
		nul= [] execVM "\ca\Modules\MP\data\scripts\MPframework.sqf";
	};
	If (isNil "CLAY_fnc_findNearEnemy") Then
	{
		CLAY_fnc_findNearEnemy = compile preprocessFile "Awesome\CLAY_Dogs\fn_findNearEnemy.sqf";
	};
	publicVariable "CLAY_fnc_findNearEnemy";



	publicVariable "CLAY_DogEODs";	
	publicVariable "CLAY_DogVehicles";	
	publicVariable "CLAY_DogSearchDistanceMan";	
	publicVariable "CLAY_DogSearchDistanceEOD";
	if(isnil "CLAY_DogEODs") exitwith{player groupchat "entrou";};
};


If ((isMultiplayer && !isServer) || !isMultiplayer) Then
{
	
	waitUntil {!isNull player};	
	
    private ["_synO","_dhm"];
	_dhm = this;
	_synO = synchronizedObjects _dhm;
	
	If (count _synO == 0) exitWith {};
	If (player in _synO && (vehicle player != player)) exitWith {player groupchat "Dog Handler unit is not of type 'Man'!"};
	If (!(player in _synO)) exitWith {player groupchat "Dog Handler unit must be player-controled!"};
	
	
	 if(!isNil "roffy") then 
	  {
		deletevehicle roffy;
	  };
	
    "Pastor" createUnit [[(getPos player select 0) + (1 * sin (getDir player)), (getPos player select 1) + (0.3 * cos (getDir player)), 0],group player,'roffy=this;this setSpeedMode "full";this allowFleeing 0;this setBehaviour "aware";this setskill 1;',1,'PRIVATE'];
    roffy setIdentity "k9unit";   
    if (leader player == player) then {
        [roffy] joinsilent player;
    } else {
        roffy dofollow player;
    };

	//enableRadio false;  
	roffy setVariable ["_sound1", "dog_01"];
	roffy setVariable ["_sound2", "dog_02"];
	//publicVariable "roffy";
	player setVariable ["CLAY_DogUnit", roffy];
	player setVariable ["CLAY_DogStatus", "Waiting"];
	_dog switchMove "Dog_sit1";
	If (isNil "BIS_MENU_GroupCommunication") Then
		{
			BIS_MENU_GroupCommunication = [[localize "STR_SOM_COMMUNICATIONS", false]];
		};

		DOGCTRL_MENU =
		[
			["Dog Control", true],
			["Follow", [2], "", -5, [["expression", "nul = [1] execVM 'Awesome\CLAY_Dogs\handler\dogMove.sqf'"]], "1", "1", "\ca\ui\data\cursor_tactical_ca.paa"],
			["Wait", [3], "", -5, [["expression", "nul = [2] execVM 'Awesome\CLAY_Dogs\handler\dogMove.sqf'"]], "1", "0"],
			//["Move To Pos", [4], "", -5, [["expression", "nul = [3,cursorTarget] execVM 'Awesome\CLAY_Dogs\handler\dogMove.sqf'"]], "1", "1", "\ca\ui\data\cursor_tactical_ca.paa"],
			["", [], "", -1, [], "0", "0"],
			["Attack Target", [4], "", -5, [["expression", "nul = [cursorTarget] execVM 'Awesome\CLAY_Dogs\handler\dogAttack.sqf'"]], "1", "1", "\ca\ui\data\cursor_attack_ca.paa"],
			["Drug Search", [5], "", -5, [["expression", "nul = [1] execVM 'Awesome\CLAY_Dogs\handler\dogsearch.sqf'"]], "1", "1", "\ca\ui\data\cursor_attack_ca.paa"],
			//["Drug Search", [6], "", -5, [["expression", "nul = [cursorTarget] execVM 'dogSearch.sqf'"]], "1", "1", "\ca\ui\data\cursor_igui_scroll_ca.paa"],
			["Search EOD", [6], "", -5, [["expression", "nul = [2] execVM 'Awesome\CLAY_Dogs\handler\dogSearch.sqf'"]], "1", "1", "\ca\ui\data\cursor_igui_scroll_ca.paa"],["", [], "", -1, [], "0", "0"],
			["Board Car", [7], "", -5, [["expression", "nul = [1, cursorTarget] execVM 'Awesome\CLAY_Dogs\handler\dogVehicle.sqf'"]], "1", "CursorOnEmptyVehicle", "\ca\ui\data\cursor_getin_ca.paa"],
			["Dismount", [8], "", -5, [["expression", "nul = [2] execVM 'Awesome\CLAY_Dogs\handler\dogVehicle.sqf'"]], "1", "0", "\ca\ui\data\icon_board_out_ca.paa"],
			["Bark", [9], "", -5, [["expression", "Hint 'Wuff!'"]], "1", "1"]
		];
		BIS_MENU_GroupCommunication set [1, ["Dog Control", [0], "#USER:DOGCTRL_MENU", -5, [["expression", ""]], "1", "1", "\ca\ui\data\cursor_tactical_ca.paa"]];
		_nic = [objNull, roffy, rSAY, "dog_01"] call RE;	
  		
};
