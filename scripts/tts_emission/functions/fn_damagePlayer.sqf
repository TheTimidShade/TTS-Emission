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
if (!alive player) exitWith {};
if (missionNamespace getVariable ["tts_emission_damagePlayerRunning", false]) exitWith {}; // make sure the script cannot run more than once at a time
if (tts_emission_playerEffect == 4) exitWith {}; // do nothing since player emission damage is disabled

private _ace_enabled = isClass(configFile >> "CfgPatches" >> "ace_main");
private _zombiesEnabled = isClass (configFile >> "CfgPatches" >> "rvg_zeds") || isClass (configFile >> "CfgPatches" >> "Ryanzombies");

tts_emission_damagePlayerRunning = true;
_vehicle = vehicle player;
if (_vehicle isKindOf "AIR" && (getPosATL _vehicle)#2 > 15 && tts_emission_aircraftEffect != 2) then { // if player is in air vehicle strike them out of the sky
	private _playerCrew = [];
	{
		if (isPlayer _x) then {_playerCrew pushBackUnique _x;};
	} forEach crew (vehicle player); 
	
	if (_playerCrew#0 == player) then { // only disable vehicle if player is the first in the crew to prevent duplicate
		if (tts_emission_aircraftEffect == 0) then {
			[_vehicle, nil, true] call BIS_fnc_moduleLightning; // vehicle gets blown out the sky
		} else {
			[_vehicle, ["hitEngine", 1]] remoteExec ["setHitPointDamage", _vehicle, false];
		};
	};
} else { // if the player is not in an air vehicle
	if ((!(player call tts_emission_fnc_isSafe) || tts_emission_playerEffect in [2,3]) && isDamageAllowed player) then { // check if they are safe from the emission
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
};

sleep 10; // wait 10 seconds before player can be affected by emission wave again

tts_emission_damagePlayerRunning = false;