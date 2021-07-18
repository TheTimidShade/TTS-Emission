/*
	Author: TheTimidShade

	Description:
		Checks if the unit is safe from the emission

	Parameters:
		0: OBJECT - Unit to check status for
		
	Returns:
		BOOL - Whether or not unit is safe from emission (deep enough underwater or has a roof within 5m above their head)
*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {false};
if (((getPosASL _unit)#2) <= -2) exitWith {true}; // if unit is more than 2m underwater, they are safe
if ((typeOf _unit) in tts_emission_immuneUnits || (vehicleVarName _unit) in tts_emission_immuneUnits) exitWith {true};

private _isSafe = false;
if (isPlayer _unit) then {
	private _eyePos = eyePos _unit;
	private _endPos = [_eyePos#0, _eyePos#1, _eyePos#2+5];

	private _intersectObjects = lineIntersectsWith [_eyePos, _endPos, _unit, objNull, true]; // check if there are any objects above player's head for 5m

	{
		if (_x call tts_emission_fnc_isSafeType) exitWith {_isSafe = true;}; // check if there is an object which is considered shelter above player
	} forEach _intersectObjects;
} else {
	private _nearbyBuildings = _unit nearObjects ["Building", 20]; // any AI within 20m of a building are considered safe
	_isSafe = if ({!(typeOf _x == "GroundWeaponHolder")} count _nearbyBuildings > 0) then {true} else {false};
};
_isSafe