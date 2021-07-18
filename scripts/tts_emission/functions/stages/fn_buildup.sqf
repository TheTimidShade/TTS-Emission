/*
	Author: TheTimidShade

	Description:
		Handles buildup to emission impact

	Parameters:
		NONE
		
	Returns:
		NONE
*/

#define EMISSION_PULSE selectRandom ["blowout_boom_01", "blowout_boom_02", "blowout_boom_03"]

if (!hasInterface) exitWith {}; // don't run sounds or particles on dedi or HC

while {tts_emission_progressState < 4} do {
	sleep ((random 5) + 7);
	[EMISSION_PULSE] spawn tts_emission_fnc_soundAbovePlayer;
};