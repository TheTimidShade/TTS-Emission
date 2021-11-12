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
if (isNil "tts_emission_approachDirection" || !(tts_emission_approachDirection in ["N", "E", "S", "W"])) then {tts_emission_approachDirection = "N"; publicVariable "tts_emission_approachDirection";};

private _startPos = -1;
private _useYcoord = true;
private _emissionStartPos = [0,0];
private _emissionApproachDirection = tts_emission_approachDirection;

switch (_emissionApproachDirection) do {
	case "N": {
		_startPos = worldSize + 2000;
		_useYcoord = true;
		_emissionStartPos = [worldSize/2, _startPos];
	};
	case "E": {
		_startPos = worldSize + 2000;
		_useYcoord = false;
		_emissionStartPos = [_startPos, worldSize/2];
	};
	case "S": {
		_startPos = -2000;
		_useYcoord = true;
		_emissionStartPos = [worldSize/2, _startPos];
	};
	case "W": {
		_startPos = -2000;
		_useYcoord = false;
		_emissionStartPos = [_startPos, worldSize/2];
	};
	default { // same values as "N"
		_startPos = worldSize + 2000;
		_useYcoord = true;
		_emissionStartPos = [worldSize/2, _startPos];
	};
};

tts_emission_wave_finished = false; publicVariable "tts_emission_wave_finished";
tts_emission_wave_pos = _startPos; publicVariable "tts_emission_wave_pos";

[] remoteExec ["tts_emission_fnc_waveEffectMapSweeper", 0, false];

private _waveKillTrigger = createTrigger ["EmptyDetector", _emissionStartPos];
_waveKillTrigger setTriggerArea [(worldsize + 4000)/2, 40, 0, true];

private _waveMarker = createMarker ["tts_emission_wave_debug", _waveKillTrigger];
_waveMarker setMarkerShape "RECTANGLE";
_waveMarker setMarkerSize [worldSize/2 + 2000, 40];
_waveMarker setMarkerColor "ColorRed";

private _waveMarker2 = createMarker ["tts_emission_wave_warning", _waveKillTrigger];
_waveMarker2 setMarkerType "mil_warning";
_waveMarker2 setMarkerColor "ColorRed";

// if W/E approach rotate trigger and marker 90 degrees
if (!_useYcoord) then {
	_waveKillTrigger setDir 90;
	_waveKillTrigger setPos (getPos _waveKillTrigger);
	"tts_emission_wave_debug" setMarkerDir 90;
};

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

private _moveStep = tts_emission_waveSpeed/10; // default speed = 125m/s

switch (_emissionApproachDirection) do {
	case "N": {
		for [{private _wvPos = _startPos}, {_wvPos > -2000}, {_wvPos = _wvPos - _moveStep}] do 
		{
			_waveKillTrigger setPos [worldsize/2, _wvPos];
			tts_emission_wave_pos = _wvPos; publicVariable "tts_emission_wave_pos";
			sleep 0.1;
		};
	};
	case "E": {
		for [{private _wvPos = _startPos}, {_wvPos > -2000}, {_wvPos = _wvPos - _moveStep}] do 
		{
			_waveKillTrigger setPos [_wvPos, worldsize/2];
			tts_emission_wave_pos = _wvPos; publicVariable "tts_emission_wave_pos";
			sleep 0.1;
		};
	};
	case "S": {
		for [{private _wvPos = _startPos}, {_wvPos < worldSize + 2000}, {_wvPos = _wvPos + _moveStep}] do 
		{
			_waveKillTrigger setPos [worldsize/2, _wvPos];
			tts_emission_wave_pos = _wvPos; publicVariable "tts_emission_wave_pos";
			sleep 0.1;
		};
	};
	case "W": {
		for [{private _wvPos = _startPos}, {_wvPos < worldSize + 2000}, {_wvPos = _wvPos + _moveStep}] do 
		{
			_waveKillTrigger setPos [_wvPos, worldsize/2];;
			tts_emission_wave_pos = _wvPos; publicVariable "tts_emission_wave_pos";
			sleep 0.1;
		};
	};
};

// cleanup
deleteVehicle _waveKillTrigger;
deleteMarker _waveMarker; deleteMarker _waveMarker2;
tts_emission_wave_finished = true; publicVariable "tts_emission_wave_finished";