/*
	Author: TheTimidShade

	Description:
		Initialises custom modules for ZEN if enabled

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (!isClass (configFile >> "CfgPatches" >> "zen_main")) exitWith {};

[] call tts_emission_fnc_zen_moduleChangeSettings;
[] call tts_emission_fnc_zen_moduleStartEmission;
[] call tts_emission_fnc_zen_moduleStartRandomEmissions;