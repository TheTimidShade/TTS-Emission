/*
	Author: TheTimidShade

	Description:
		Checks if the object is considered shelter from the emission

	Parameters:
		0: OBJECT - Object to check
		
	Returns:
		BOOL - True if object is considered safe
*/

params [
	["_obj", objNull, [objNull]]
];

if (isNull _obj) exitWith {};

private _safe = false;
{
	if (_obj isKindOf _x) exitWith {_safe = true;};
} forEach tts_emission_shelterTypes;
_safe