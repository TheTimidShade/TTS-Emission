/*
	Author: TheTimidShade

	Description:
		Starts emission/blowout process

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (!isServer) exitWith {}; // only run on server or host client
if (isNil "tts_emission_emissionIsActive") then {tts_emission_emissionIsActive = false; publicVariable "tts_emission_emissionIsActive";};
if (tts_emission_emissionIsActive) exitWith {}; // if there is already an emission happening, exit

// configure settings if they are not defined or invalid
/*
	tts_emission_emissionType - 0 = map sweeper, wave sweeps map from top to bottom, 1 = fixed distance, wave hits at same time for everyone on the map
	tts_emission_playerEffect - 0 = kill unsheltered units, 1 = knockout unsheltered units, 2 = kill all, 3 = knockout all, 4 = no effect
	tts_emission_aiEffect - 0 = kill unsheltered units, 1 = knockout unsheltered units, 2 = kill all, 3 = knockout all, 4 = no effect
	tts_emission_aircraftEffect - 0 = strike aircraft, 1 = disable aircraft, 2 = no effect
	tts_emission_sirenType - 0 = classic, 1 = dramatic, 2 = none
	tts_emission_useSirenObject - true = Siren warning will be emitted from object instead of played in player's ears
	tts_emission_protectionEquipment - array of equipment classnames which are considered protection from emissions
	tts_emission_immuneUnits - array of unit classnames that are no affected by emissions
	tts_emission_waveSpeed - speed in m/s wave sweeps map (only applies to map sweep emission)
	tts_emission_showEmissionOnMap - should the emissions position be shown on the map
	tts_emission_disableRain - true to disable rain transition after emission (enable this if using other weather scripts)
*/

// if not defined, set to default
if (isNil "tts_emission_emissionType") then {tts_emission_emissionType = 0;};
if (isNil "tts_emission_playerEffect") then {tts_emission_playerEffect = 0;};
if (isNil "tts_emission_aiEffect") then {tts_emission_aiEffect = 1;};
if (isNil "tts_emission_aircraftEffect") then {tts_emission_aircraftEffect = 0;};
if (isNil "tts_emission_sirenType") then {tts_emission_sirenType = 0;};
if (isNil "tts_emission_useSirenObject") then {tts_emission_useSirenObject = false;};
if (isNil "tts_emission_protectionEquipment") then {tts_emission_protectionEquipment = [];};
if (isNil "tts_emission_immuneUnits") then {tts_emission_immuneUnits = [];};
if (isNil "tts_emission_waveSpeed") then {tts_emission_waveSpeed = 125;};
if (isNil "tts_emission_showEmissionOnMap") then {tts_emission_showEmissionOnMap = false;};
if (isNil "tts_emission_disableRain") then {tts_emission_disableRain = false;};

// if defined value is invalid, update
if (!(tts_emission_emissionType in [0,1])) then {tts_emission_emissionType = 0;};
if (!(tts_emission_playerEffect in [0,1,2,3,4])) then {tts_emission_playerEffect = 0;};
if (!(tts_emission_aiEffect in [0,1,2,3,4])) then {tts_emission_aiEffect = 1;};
if (!(tts_emission_aircraftEffect in [0,1,2])) then {tts_emission_aircraftEffect = 0;};
if (!(tts_emission_sirenType in [0,1])) then {tts_emission_sirenType = 0;};
if (!(tts_emission_useSirenObject in [true,false])) then {tts_emission_useSirenObject = false;};
if (tts_emission_waveSpeed <= 0) then {tts_emission_waveSpeed = 125;};
if (!(tts_emission_showEmissionOnMap in [true,false])) then {tts_emission_showEmissionOnMap = false;};
if (!(tts_emission_disableRain in [true,false])) then {tts_emission_disableRain = false;};

// make sure clients have the same settings as the server
{publicVariable _x} forEach [
	"tts_emission_emissionType",
	"tts_emission_playerEffect",
	"tts_emission_aiEffect",
	"tts_emission_aircraftEffect",
	"tts_emission_sirenType",
	"tts_emission_useSirenObject",
	"tts_emission_protectionEquipment",
	"tts_emission_immuneUnits",
	"tts_emission_waveSpeed",
	"tts_emission_showEmissionOnMap",
	"tts_emission_disableRain"
];

// define sound effect groups
#define EMISSION_PULSE selectRandom ["blowout_boom_01", "blowout_boom_02", "blowout_boom_03"]
#define EMISSION_BEGIN selectRandom ["blowout_begin_01", "blowout_begin_02"]

tts_emission_emissionIsActive = true; publicVariable "tts_emission_emissionIsActive";
tts_emission_progressState = 0; publicVariable "tts_emission_progressState"; // 0:buildup, 1:impact, 2:wave 1, 3:wave 2, 4:ending, 5:finished

// pulse and siren
[EMISSION_PULSE] remoteExec ["tts_emission_fnc_soundAbovePlayer", 0, false];
[EMISSION_BEGIN] remoteExec ["playSound", 0, false];

// handle siren
if (tts_emission_sirenType != 2) then {
	[] spawn { 
		private _sirenSound = ["blowout_siren", "blowout_siren_2"]#tts_emission_sirenType;
		sleep 5;
		if (!tts_emission_useSirenObject || isNil "tts_emission_sirenObj") then {
			[_sirenSound] remoteExec ["playSound", 0, false];
		} else {
			[tts_emission_sirenObj, [_sirenSound, 30000]] remoteExec ["say3D", 0, false];
		};
	};
};

[] remoteExec ["tts_emission_fnc_buildup", 0, false]; // start buildup pulses

sleep 10; // small sleep to let blowout intro blend

tts_emission_playRumble = true; publicVariable "tts_emission_playRumble";
[] remoteExec ["tts_emission_fnc_rumble", 0, false]; // start bass rumble

sleep 35;

["blowout_impact"] remoteExec ["playSound", 0, false];

sleep 3; // small delay before blowout impact actually hits

// impact
tts_emission_progressState = 1; publicVariable "tts_emission_progressState"; 
[750, 1] remoteExec ["tts_emission_fnc_flash", 0, false];
{[] remoteExec [_x, 0, false];} forEach ["tts_emission_fnc_impact", "tts_emission_fnc_handleLighting", "tts_emission_fnc_handlePPeffects"];

sleep 60;

if (tts_emission_emissionType == 1) then { // classic emission
	// wave 1 begins
	tts_emission_progressState = 2; publicVariable "tts_emission_progressState";
	["blowout_wave_01"] remoteExec ["playSound", 0, false];
	[] spawn tts_emission_fnc_wave;

	sleep 32;
	[(allUnits - allPlayers)] spawn tts_emission_fnc_damageNonPlayer; // handle non-player emission effects
	sleep 36;

	// wave 2 begins
	tts_emission_progressState = 3; publicVariable "tts_emission_progressState";
	["blowout_wave_02"] remoteExec ["playSound", 0, false];

	sleep 25;

	[] spawn tts_emission_fnc_wave;

	sleep 32;
	[(allUnits - allPlayers)] spawn tts_emission_fnc_damageNonPlayer; // handle non-player emission effects
	sleep 36;
} else {
	tts_emission_progressState = 3; publicVariable "tts_emission_progressState";
	[] spawn tts_emission_fnc_waveMapSweeper;
	waitUntil {sleep 10; tts_emission_wave_finished};
};

// start outro
tts_emission_progressState = 4; publicVariable "tts_emission_progressState";
tts_emission_playRumble = false; publicVariable "tts_emission_playRumble";
["blowout_outro"] remoteExec ["playSound", 0, false];

if (!tts_emission_disableRain) then {
	private _currentRain = rain;
	60 setRain 1;

	sleep 60;
	tts_emission_progressState = 5; publicVariable "tts_emission_progressState";
	sleep 120;

	120 setRain _currentRain;
	sleep 120;
};
tts_emission_progressState = 5; publicVariable "tts_emission_progressState";

tts_emission_emissionIsActive = false; publicVariable "tts_emission_emissionIsActive";