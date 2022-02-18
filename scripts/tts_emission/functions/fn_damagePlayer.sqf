/*
	Author: TheTimidShade

	Description:
		Handles the effect of the emission wave on the player when it reaches them

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (!hasInterface) exitWith {};
if (!alive player || !isDamageAllowed player) exitWith {};
if (missionNamespace getVariable ["tts_emission_damagePlayerRunning", false]) exitWith {}; // make sure the script cannot run more than once at a time

private _ace_enabled = isClass(configFile >> "CfgPatches" >> "ace_main");

// helper function to determine whether or not the effect should be run on this player
private _fnc_isFirstCrew = {
	params ["_vehicle"];

	private _playerCrew = [];
	{
		if (isPlayer _x) then {_playerCrew pushBackUnique _x;};
	} forEach crew (vehicle player);

	(_playerCrew#0 == player)
};

tts_emission_damagePlayerRunning = true;

// check player status
if (!(player call tts_emission_fnc_isSafe) && tts_emission_playerEffect != 4) then { // check if they are safe from the emission
	if ((tts_emission_playerEffect == 0 && player call tts_emission_fnc_hasProtection) || tts_emission_playerEffect in [1,3]) then { // if they have protection, knock them out if ACE is enabled, or knock them over if not
		if (_ace_enabled) then {
			[player, true, 10, true] call ace_medical_fnc_setUnconscious; // force wakeup after 15 seconds if vitals are stable
			[] spawn {sleep 10; [] spawn tts_emission_fnc_psyEffect;}; // sleep so can still see ppfx
		} else {
			player setUnconscious true;
			[] spawn tts_emission_fnc_psyEffect;
			[] spawn {sleep 15; player setUnconscious false;};
		};
	} else { // if they don't have protection instantly kill them
		player setDamage 1;
	};
};

// check player vehicle status
_vehicle = vehicle player;
if (_vehicle != player && [player, _vehicle] call _fnc_isFirstCrew && {!(_vehicle isKindOf "StaticWeapon")}) then {
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

sleep 10; // wait 10 seconds before player can be affected by emission wave again

tts_emission_damagePlayerRunning = false;