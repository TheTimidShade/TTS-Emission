/*
	Author: TheTimidShade

	Description:
		Module function for Start Random Emissions module.

	Parameters:
		0: OBJECT - Placed module.
		1: ARRAY - Objects that can be affected by the module.
		2: BOOL - Whether module is activated (synced triggers are active)
		
	Returns:
		NONE
*/

params [
	["_module", objNull, [objNull]],
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!isServer) exitWith {};

if (_activated) then {
	private _minDelay = _module getVariable ["MinDelay", 30];
	private _maxDelay = _module getVariable ["MaxDelay", 45];
	private _minSpeed = _module getVariable ["MinSpeed", 125];
	private _maxSpeed = _module getVariable ["MaxSpeed", 125];
	private _randomiseDirection = _module getVariable ["RandomiseDirection", false];

	[_minDelay, _maxDelay, _minSpeed, _maxSpeed, _randomiseDirection] spawn tts_emission_fnc_startRandomEmissions;
};
