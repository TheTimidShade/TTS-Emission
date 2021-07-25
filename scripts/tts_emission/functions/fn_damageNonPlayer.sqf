/*
	Author: TheTimidShade

	Description:
		Handles the effect of the emission wave on non-player units

	Parameters:
		0: ARRAY - Aray of units to affect (for classic this is allUnits - allPlayers, for reworked this is only units inside wave trigger)
		
	Returns:
		NONE
*/

if (!isServer) exitWith {}; // only run on server/host client
if (tts_emission_aiEffect == 4) exitWith {}; // if emission does not affect non-players, exit

params [
	["_unitArray", [], [[]]]
];

if (count _unitArray < 1) exitWith {};

private _ace_enabled = isClass(configFile >> "CfgPatches" >> "ace_main");
private _zombiesEnabled = isClass (configFile >> "CfgPatches" >> "rvg_zeds") || isClass (configFile >> "CfgPatches" >> "Ryanzombies");

private _disabledUnits = [];
{
	private _unit = _x;
	if (!(_unit call tts_emission_fnc_isZombie)) then { // if the unit is not a zombie and isn't a player
		_vehicle = vehicle _unit;
		if (_vehicle isKindOf "AIR" && (getPosATL _vehicle)#2 > 15 && tts_emission_aircraftEffect != 2) then {
			private _playerInCrew = false;
			{if (isPlayer _x) exitWith {_playerInCrew = true;};} forEach (crew _vehicle);
			
			if ((crew _vehicle)#0 == _unit && !_playerInCrew) then { // only bolt vehicle if the unit is the first in the crew and there are no players
				if (tts_emission_aircraftEffect == 0) then {
					[_vehicle, nil, true] call BIS_fnc_moduleLightning; // vehicle gets blown out the sky
				} else {
					[_vehicle, ["HitEngine", 1]] remoteExec ["setHitPointDamage", _vehicle, false];
				};
			};
		} else { // if the unit is not in an air vehicle
			if (!(_unit call tts_emission_fnc_isSafe) || tts_emission_aiEffect in [2,3]) then { // check if they are safe from the emission
				if (tts_emission_aiEffect in [0,2] && !(_unit call tts_emission_fnc_hasProtection)) then { // if emission is lethal to ai
					_unit setDamage 1;
				} else { // if emission is non-lethal disable them temporarily
					if (!(_unit getVariable ["tts_emission_ai_isUnconscious", false])) then {
						private _unitStatus = [ // preserve unit AI state to avoid conflict
							_unit checkAIFeature "MOVE",
							_unit checkAIFeature "TARGET",
							_unit checkAIFeature "AUTOTARGET",
							_unit checkAIFeature "WEAPONAIM"
						];
						{[_unit, _x] remoteExec ["disableAI", _unit, false];} forEach ["MOVE", "AUTOTARGET", "TARGET", "WEAPONAIM"];
						_disabledUnits pushBack [_unit, _unitStatus];
						[_unit, "unconscious"] remoteExec ["playMoveNow", _unit, false];
						_unit setVariable ["tts_emission_ai_isUnconscious", true, true];
					};

					//_unit setUnconscious true;
					//_unit spawn {sleep 15; _this setUnconscious false;};
				};
			};
		};
	};
	sleep 0.01; // 100 units per second
} forEach _unitArray;

sleep 15; // small sleep to simulate unconscious period

// enable disabled units
{
	_x params ["_unit", "_unitStatus"];
	{
		if (_unitStatus#_forEachIndex) then {
			[_unit, _x] remoteExec ["enableAI", _unit, false];
		};
	} forEach ["MOVE", "AUTOTARGET", "TARGET", "WEAPONAIM"];
	[_unit, "AmovPpneMstpSnonWnonDnon"] remoteExec ["playMove", _unit, false];
	_unit setVariable ["tts_emission_ai_isUnconscious", false, true];
} forEach _disabledUnits;