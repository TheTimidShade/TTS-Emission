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

if (isNil "tts_emission_waveSpeed") then {tts_emission_waveSpeed = 125; publicVariable "tts_emission_waveSpeed";};

private _startY = worldSize + 2000; // start 2km from northern world border
private _moveStep = tts_emission_waveSpeed/10; // default = 125m/s

tts_emission_wave_finished = false; publicVariable "tts_emission_wave_finished";
tts_emission_wave_yPos = _startY; publicVariable "tts_emission_wave_yPos";

[] remoteExec ["tts_emission_fnc_waveEffectMapSweeper", 0, false];

private _waveKillTrigger = createTrigger ["EmptyDetector", [worldsize/2, _startY]];
_waveKillTrigger setTriggerArea [(worldsize + 4000)/2, 40, 0, true];

private _waveMarker = createMarker ["tts_emission_wave_debug", _waveKillTrigger];
_waveMarker setMarkerShape "RECTANGLE";
_waveMarker setMarkerSize [worldSize/2 + 2000, 40];
_waveMarker setMarkerColor "ColorRed";

private _waveMarker2 = createMarker ["tts_emission_wave_warning", _waveKillTrigger];
_waveMarker2 setMarkerType "mil_warning";
_waveMarker2 setMarkerColor "ColorRed";

if (!tts_emission_showEmissionOnMap) then {_waveMarker setMarkerAlpha 0; _waveMarker2 setMarkerAlpha 0;};

[_waveKillTrigger, _waveMarker, _waveMarker2] spawn {
	params ["_waveKillTrigger", "_waveMarker", "_waveMarker2"];
	private ["_unitsInTrigger", "_disabledUnits"];
	while {alive _waveKillTrigger} do {
		_waveMarker setMarkerPos (getPos _waveKillTrigger);
		_waveMarker2 setMarkerPos (getPos _waveKillTrigger);
		_unitsInTrigger = (allUnits - allPlayers) inAreaArray _waveKillTrigger;
		[_unitsInTrigger] spawn tts_emission_fnc_damageNonPlayer; // handle non-player emission effects
		sleep 0.1;
	};
};

// start wave
for [{private _wvPos = _startY}, {_wvPos > -2000}, {_wvPos = _wvPos - _moveStep}] do {
	_waveKillTrigger setPos [worldsize/2, _wvPos];
	tts_emission_wave_yPos = _wvPos; publicVariable "tts_emission_wave_yPos";
	sleep 0.1;
};

// cleanup
deleteVehicle _waveKillTrigger;
deleteMarker _waveMarker; deleteMarker _waveMarker2;
tts_emission_wave_finished = true; publicVariable "tts_emission_wave_finished";