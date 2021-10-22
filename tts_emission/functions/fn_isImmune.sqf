/*
	Author: TheTimidShade

	Description:
		Checks if the unit is immune from the emission

	Parameters:
		0: OBJECT - Unit to check for immunity
		
	Returns:
		BOOL - Whether or not unit is immune from emission
*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {false};

// check for exact classname and varname first
if ((typeOf _unit) in tts_emission_immuneUnits || (vehicleVarName _unit) in tts_emission_immuneUnits) exitWith {true};

// if not found check for parent types
private _immune = false;
{
	if (_unit isKindOf _x) exitWith {_immune = true;};
} forEach tts_emission_immuneUnits;
_immune
