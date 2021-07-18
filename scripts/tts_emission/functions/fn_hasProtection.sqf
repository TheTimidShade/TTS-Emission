/*
	Author: TheTimidShade

	Description:
		Checks if the given unit has protection required to survive emission

	Parameters:
		0: OBJECT - Unit to check for protection equipment
		
	Returns:
		BOOL - Whether or not unit has protection from emission, returns false if unit does not exist
*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) then {false};

if (isNil "tts_emission_protectionEquipment") then {tts_emission_protectionEquipment = [];};

private _equipment = [headgear _unit, goggles _unit, hmd _unit, uniform _unit, vest _unit, backpack _unit];

private _hasProt = false;
{
	if (_x in tts_emission_protectionEquipment) exitWith {_hasProt = true;};
} forEach _equipment;

_hasProt