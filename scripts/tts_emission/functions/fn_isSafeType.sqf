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

private _safeTypes = ["Building", "Car", "Tank", "Air", "Ship"];
private _safe = false;
{
	if (_this isKindOf _x) exitWith {_safe = true;};
} forEach _safeTypes;
_safe