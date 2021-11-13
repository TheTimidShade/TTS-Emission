/*
	Author: TheTimidShade

	Description:
		Starts emissions at random intervals using the provided settings.

	Parameters:
		0: NUMBER (OPTIONAL) - Minimum number of minutes between one emission ending and the next one starting. Default is 30 minutes.
		1: NUMBER (OPTIONAL) - Maximum number of minutes between one emission ending and the next one starting. Default is 45 minutes.
		2: NUMBER (OPTIONAL) - Minimum speed in m/s of random emissions. Default is 125 m/s.
		3: NUMBER (OPTIONAL) - Maximum speed in m/s of random emissions. Default is 125 m/s.
		4: BOOL (OPTIONAL) - If true, a random approach direction will be selected for each emission. Default is false.
		
	Returns:
		NONE
*/

params [
	["_minDelay", 30, [0]],
	["_maxDelay", 45, [0]],
	["_minSpeed", 125, [0]],
	["_maxSpeed", 125, [0]],
	["_randomiseDirection", false, [false]]
];

_minDelay = _minDelay*60;
_maxDelay = _maxDelay*60;

if (!isServer) exitWith {};
if (missionNamespace getVariable ["tts_emission_randomEmissions", false]) exitWith {};

private _speedBeforeStart = missionNamespace getVariable ["tts_emission_waveSpeed", 125];
private _directionBeforeStart = missionNamespace getVariable ["tts_emission_approachDirection", "N"];

if (isNil "tts_emission_emissionIsActive") then {
	tts_emission_emissionIsActive = false;
	publicVariable "tts_emission_emissionIsActive";
};

tts_emission_randomEmissions = true;
while {tts_emission_randomEmissions} do
{
	waitUntil {sleep 5; !tts_emission_emissionIsActive};
	sleep (_minDelay + floor random (_maxDelay - _minDelay));
	
	tts_emission_waveSpeed = _minSpeed + floor random (_maxSpeed - _minSpeed);
	publicVariable "tts_emission_waveSpeed";

	if (_randomiseDirection) then
	{
		tts_emission_approachDirection = selectRandom ["N", "E", "S", "W"];
		publicVariable "tts_emission_approachDirection";
	};

	if (tts_emission_randomEmissions) then {[] spawn tts_emission_fnc_startEmission;}; // start emission
};

// restore original speed & direction after ambient emissions stop
tts_emission_waveSpeed = _speedBeforeStart; publicVariable "tts_emission_waveSpeed";
tts_emission_approachDirection = _directionBeforeStart; publicVariable "tts_emission_approachDirection";