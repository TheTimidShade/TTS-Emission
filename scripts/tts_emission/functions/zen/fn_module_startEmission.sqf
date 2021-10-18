// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Emission", "STR_tts_emission_moduleStartEmission_title",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNil "tts_emission_emissionIsActive") then {tts_emission_emissionIsActive = false;};

		if (tts_emission_emissionIsActive) then {
			["STR_tts_emission_moduleStartEmission_inProgress"] call zen_common_fnc_showMessage;
		} else {
			["STR_tts_emission_moduleStartEmission_heading", "STR_tts_emission_moduleStartEmission_warning", {
				[] remoteExec ["tts_emission_fnc_startEmission", 2, false];
				["STR_tts_emission_moduleStartEmission_emissionApproaching"] call zen_common_fnc_showMessage;
				false
			}] call zen_common_fnc_messageBox;
		};
	}, "scripts\tts_emission\icons\tts_emission.paa"] call zen_custom_modules_fnc_register;
};