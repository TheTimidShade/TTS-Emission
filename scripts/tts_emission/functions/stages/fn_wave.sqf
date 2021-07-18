/*
	Author: TheTimidShade

	Description:
		Handles blowout wave on server side

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (!isServer) exitWith {}; // only run on server

private _distance = 1400;
private _moveStep = 4;

tts_emission_wave_finished = false; publicVariable "tts_emission_wave_finished";
tts_emission_wave_distance = _distance; publicVariable "tts_emission_wave_distance";

[] remoteExec ["tts_emission_fnc_waveEffect", 0, false];

// start wave
for [{private _wvDist = _distance}, {_wvDist > -_distance}, {_wvDist = _wvDist - _moveStep}] do {
	tts_emission_wave_distance = _wvDist;
	publicVariable "tts_emission_wave_distance";
	sleep 0.1;
};

tts_emission_wave_finished = true; publicVariable "tts_emission_wave_finished";