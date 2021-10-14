/*
	Author: TheTimidShade

	Description:
		Initialises custom modules for ZEN if enabled

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (isClass(configFile >> "CfgPatches" >> "tts_effects_aio") && {missionNamespace getVariable ["tts_effects_aio_disable_emission", false]}) exitWith {};

[] spawn {

waitUntil {sleep 1; player == player && !isNull getAssignedCuratorLogic player};

[] call tts_emission_fnc_module_changeSettings;
[] call tts_emission_fnc_module_startEmission;

};