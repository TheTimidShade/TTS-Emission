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

params [
	["_unitArray", [], [[]]]
];

if (count _unitArray < 1) exitWith {};

private _ace_enabled = isClass(configFile >> "CfgPatches" >> "ace_main");

// helper function to determine whether or not the effects apply to specific units
private _fnc_isFirstCrew = {
	params ["_unit", "_vehicle"];

	private _playerInCrew = false;
	{if (isPlayer _x) exitWith {_playerInCrew = true;};} forEach (crew _vehicle);
	
	((crew _vehicle)#0 == _unit && !_playerInCrew)
};

private _disabledUnits = [];
{
	private _unit = _x;
	if (_unit call tts_emission_fnc_isZombie) then { continue }; // skip units that are zombies
	if (_unit getVariable ["tts_emission_affectedByWave", false]) then { continue }; // skip units that have already been affected by the wave in the last 10s
	
	// check unit
	if (!(_unit call tts_emission_fnc_isSafe) && tts_emission_aiEffect != 4) then { // check if they are safe from the emission
		if (tts_emission_aiEffect in [0,2] && !(_unit call tts_emission_fnc_hasProtection)) then { // if emission is lethal to ai
			_unit setDamage 1;
			_unit setVariable ["tts_emission_affectedByWave", true, true];
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
				_unit setVariable ["tts_emission_affectedByWave", true, true];
			};

			//_unit setUnconscious true;
			//_unit spawn {sleep 15; _this setUnconscious false;};
		};
	};

	// check unit's vehicle
	_vehicle = vehicle _unit;
	if (_vehicle != _unit && [_unit, _vehicle] call _fnc_isFirstCrew && {!(_vehicle isKindOf "StaticWeapon")}) then {
		private _isFlying = (surfaceIsWater getPos _vehicle && (getPosASL _vehicle)#2 > 10) || (!surfaceIsWater getPos _vehicle && (getPosASL _vehicle)#2 > 10 && !isTouchingGround _vehicle);
		
		if (_isFlying) then { // for flying vehicles, apply aircraft effect
			switch (tts_emission_aircraftEffect) do {
				case 0: {
					private _target = createSimpleObject ["Land_HelipadEmpty_F", getPosATL _vehicle];
					_target attachTo [_vehicle, [0,0,0]];
					[_target, nil, true] remoteExec ["BIS_fnc_moduleLightning", 0, false]; // lightning bolt
				};
				case 1: {
					[_vehicle, ["HitEngine", 1]] remoteExec ["setHitPointDamage", _vehicle, false]; // engine is disabled
				};
				case 2: {
					continue
				};
			};
		} else { // for other vehicles apply standard vehicle effect
			switch (tts_emission_vehicleEffect) do {
				case 0: {
					private _target = createSimpleObject ["Land_HelipadEmpty_F", getPosATL _vehicle];
					_target attachTo [_vehicle, [0,0,0]];
					[_target, nil, true] remoteExec ["BIS_fnc_moduleLightning", 0, false]; // lightning bolt
				};
				case 1: {
					[_vehicle, ["HitEngine", 1]] remoteExec ["setHitPointDamage", _vehicle, false]; // engine is disabled
				};
				case 2: {
					if (isEngineOn _vehicle) then { // vehicle gets lightning bolted if engine is on
						private _target = createSimpleObject ["Land_HelipadEmpty_F", getPosATL _vehicle];
						_target attachTo [_vehicle, [0,0,0]];
						[_target, nil, true] remoteExec ["BIS_fnc_moduleLightning", 0, false]; // lightning bolt
					}; 
				};
				case 3: {
					if (isEngineOn _vehicle) then {[_vehicle, ["HitEngine", 1]] remoteExec ["setHitPointDamage", _vehicle, false];}; // engine is disabled if engine is on
				};
				case 4: {
					continue
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
	[_unit, "AmovPpneMstpSnonWnonDnon"] remoteExec ["switchMove", _unit, false];
	
	_unit setVariable ["tts_emission_ai_isUnconscious", false, true];
} forEach _disabledUnits;