#define ExecSQF(FILE) [] call compile preprocessFileLineNumbers FILE

enableSaving [false, false];

isClient = !isServer || (isServer && !isDedicated);

sleep 0.5;

ExecSQF("Awesome\Functions\debug.sqf");
ExecSQF("Awesome\Scripts\white_black_list.sqf");

ExecSQF("Awesome\Functions\encodingfunctions.sqf");

if (isServer) then {
	ExecSQF("Awesome\MyStats\persist.sqf");
};

ExecSQF("Awesome\Functions\time_functions.sqf");
ExecSQF("Awesome\MyStats\functions.sqf");

WEST setFriend [EAST, 0];
WEST setFriend [RESISTANCE, 0];
EAST setFriend [WEST, 0];
EAST setFriend [RESISTANCE, 0];
RESISTANCE setFriend [EAST, 0];
RESISTANCE setFriend [WEST, 0];
CIVILIAN setFriend [WEST, 0];
CIVILIAN setFriend [EAST, 0];
CIVILIAN setFriend [RESISTANCE, 0];

ExecSQF("Awesome\Scripts\optimize_1.sqf");

debug  = false;

["init"] execVM "bombs.sqf";

if (isServer) then {
	["server"] execVM "bombs.sqf";
};


ExecSQF("Awesome\Functions\interaction.sqf");
ExecSQF("triggers.sqf");


if (isClient) then {
	[] execVM "briefing.sqf";
};

if(isServer) then {
	execVM "targets.sqf";
};

ExecSQF("broadcast.sqf");
ExecSQF("customfunctions.sqf");
ExecSQF("strfuncs.sqf");
ExecSQF("1007210.sqf");
ExecSQF("4422894.sqf");
ExecSQF("miscfunctions.sqf");
ExecSQF("Awesome\Functions\quicksort.sqf");
ExecSQF("INVvars.sqf");
ExecSQF("Awesome\Shops\functions.sqf");
ExecSQF("Awesome\Functions\bankfunctions.sqf");
ExecSQF("bankexec.sqf");
ExecSQF("execlotto.sqf");
ExecSQF("initWPmissions.sqf");
ExecSQF("gfx.sqf");
ExecSQF("animList.sqf");
ExecSQF("variables.sqf");
ExecSQF("Awesome\Functions\money_functions.sqf");
ExecSQF("Awesome\Functions\gangfunctions.sqf");
ExecSQF("Awesome\init.sqf");
ExecSQF("setPitchBank.sqf");

publicvariable "station1robbed";
publicvariable "station2robbed";
publicvariable "station3robbed";
publicvariable "station4robbed";
publicvariable "station5robbed";
publicvariable "station6robbed";
publicvariable "station7robbed";
publicvariable "station8robbed";
publicvariable "station9robbed";


if(isClient) then {
	server globalChat "Loading - Please Wait";
	[] execVM "Awesome\Functions\holster.sqf";
	[] execVM "clientloop.sqf";
	[0,0,0,["clientloop"]] execVM "gangs.sqf";
	[] execVM "respawn.sqf";
	[] execVM "petrolactions.sqf";
	[] execVM "nametags.sqf";
	server globalChat "Loading - Complete";
	[] execVM "Awesome\Functions\markers.sqf";
	[] execVM "Awesome\Functions\salary.sqf";
	[] execVM "motd.sqf";
	[] ExecVM "Awesome\MountedSlots\functions.sqf";
	["client"] execVM "bombs.sqf";
	[] execVM "Awesome\Functions\factory_functions.sqf";

	[] execVM "onKeyPress.sqf";

};

if (isServer) then {
	//[60,180,true] execVM "cly_removedead.sqf";
	[0, 0, 0, ["serverloop"]] execVM "mayorserverloop.sqf";
	[0, 0, 0, ["serverloop"]] execVM "chiefserverloop.sqf";
	[] execVM "gangsserverloop.sqf";
	[] execVM "druguse.sqf";
	[] execVM "drugreplenish.sqf";
	[] execVM "robpool.sqf";
	[] execVM "Awesome\Scripts\hunting.sqf";
	[] execVM "setObjectPitches.sqf";
	[] execVM "governmentconvoy.sqf";

//=======================rob gas station init and variables================
	[] execVM "stationrobloop.sqf";
	station1money = 5000;
	publicvariable "station1money";
	station2money = 5000;
	publicvariable "station2money";
	station3money = 5000;
	publicvariable "station3money";
	station4money = 5000;
	publicvariable "station4money";
	station5money = 5000;
	publicvariable "station5money";
	station6money = 5000;
	publicvariable "station6money";
	station7money = 5000;
	publicvariable "station7money";
	station8money = 5000;
	publicvariable "station8money";
	station9money = 5000;
	publicvariable "station9money";
};


// Define Variables
gcrsrope1 = "none";
gcrsrope2 = "none";
gcrsrope3 = "none";
gcrsrope4 = "none";
gcrsrope5 = "none";
gcrsrope6 = "none";
gcrsrope7 = "none";
gcrsrope8 = "none";
gcrsrope9 = "none";
gcrsrope10 = "none";
gcrsrope11 = "none";
gcrsrope12 = "none";
gcrsrope13 = "none";
gcrsrope14 = "none";
gcrsrope15 = "none";
gcrsrepelvehicle = "none";
gcrsropedeployed = "false";
gcrsdeployropeactionid = 0;
gcrsdropropeactionid = 0;
gcrsplayerrepelactionid = 0;
gcrsplayerveh = "none";
gcrspilotvehicle = "none";
gcrsrapelvehiclearray = ["MH6J_EP1", "UH1H_TK_GUE_EP1", "UH60M_EP1", "BAF_Merlin_HC3_D", "CH_47F_EP1", "Mi17_UN_CDF_EP1", "Ka60_PMC"];
gcrsrapelheloarray = [];
gcrsplayerveharray = [];

//// Start the Drop Cargo Script
execVM "BTK\Cargo Drop\Start.sqf";







