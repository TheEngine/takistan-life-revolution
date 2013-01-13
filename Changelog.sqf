/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

init.sqf
- Removed add event handlers
- new define "ExecSQF(FILE)" to simplify running a script that needs to be compeleted

awesome\init.sqf
- new define "ExecSQF(FILE)" to simplify running a script that needs to be compeleted
- moved pmc skin list from here to c_shop

Some file inits were moved around between the inits, like debug/white_black_list due to some errors

onKeyPress.sqf
- added inAgony check

nametags.sqf
- added agony check
- added mico changes

variables.sqf
- removed unused variables

awesome\FA
- all first aid stuff
- sets event handlers

awesome my stats
- player_continuity edited for first Aid
- load and set damage edited for FA

awesome\EH
- added init file
- event handlers defined/added in first aid

Awesome\Functions\player_functions.sqf
- added a line onto respawn event handler

awesome\functions\debug.sqf
- new file
- debug functions

awesome\clothes\clothes actions.sqf
- switch up some stuff for first aid support

awesome\clothes\c_shop.sqf
- removed un-needed comments 
- added pmc skin list

awesome\servers\server_loop.sqf
- localized A_DEBUG

awesome\scripts\communications.sqf
- commented out show communications menu on load

awesome\retributions\functions.sqf
- get_near_vehicle_driver & compute_death_parameters 
	changed up isNil and isNull issue, _driver = objNull now

client_loop function
- new functions, check_rating, check_reveal
- check_rating: checks rating of player, if below 0 it sets it to 1000
- check_reveal: checks nearby units to player, checks if in screen area then reveals (issue with cursorTarget)
	
gfx.sqf
- decreased default view distance to 1k (from 2k)
- set default terrain detail to lowest possible
- todo: dynamic settings
	
First Aid
- all new stuff
- Event handlers handled here

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////