// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Emission", "Start Emission",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNil "tts_emission_emissionIsActive") then {tts_emission_emissionIsActive = false;};

		if (tts_emission_emissionIsActive) then {
			["Emission already in progress!"] call zen_common_fnc_showMessage;
		} else {
			["Confirm Emission", "Are you sure you want to start an emission?<br/><br/>Once started the emission cannot be stopped until it is complete.", {
				[] remoteExec ["tts_emission_fnc_startEmission", 2, false];
				["An emission is approaching!"] call zen_common_fnc_showMessage;
				false
			}] call zen_common_fnc_messageBox;
		};
	}, "scripts\tts_emission\icons\tts_emission.paa"] call zen_custom_modules_fnc_register;
};