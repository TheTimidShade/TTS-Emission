/*
	Author: TheTimidShade

	Description:
		Handles emission impact

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (!hasInterface) exitWith {}; // don't run sounds or particles on dedi or HC

#define EMISSION_LIGHTNING selectRandom ["blowout_lightning_01", "blowout_lightning_02", "blowout_lightning_03", "blowout_lightning_04"]

while {tts_emission_progressState <= 4} do {
	sleep ((random 7) + 1);
	[EMISSION_LIGHTNING] spawn tts_emission_fnc_soundAbovePlayer;

	// create bright flash for lightning effect
	if (selectRandom [true, false]) then { // one flash
		[500, 0.1 + random 0.1] spawn tts_emission_fnc_flash;
	} else { // two flashes
		[500, 0.1 + random 0.1] spawn tts_emission_fnc_flash;
		sleep 0.15;
		[500, 0.1 + random 0.1] spawn tts_emission_fnc_flash;
	};
};