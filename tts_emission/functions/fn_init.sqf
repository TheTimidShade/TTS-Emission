/*
	Author: TheTimidShade
	Description:
		Initialises TTS Emission. Terminates if TTS Effects AIO is enabled so that the main mod can manage initialisation.
	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (isClass(configFile >> "CfgPatches" >> "tts_effects_aio")) exitWith {};

[] call tts_emission_fnc_initCustomModules;