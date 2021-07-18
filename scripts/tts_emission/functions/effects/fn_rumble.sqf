/*
	Author: TheTimidShade

	Description:
		Handles ambient rumbling throughout emission

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (!hasInterface) exitWith {}; // don't run sounds or particles on dedi or HC

#define EMISSION_AMBIENT_RUMBLE selectRandom ["blowout_ambient_rumble_01", "blowout_ambient_rumble_02"]

[] spawn { // once the emission has set in a bit, start bass rumble
	while {tts_emission_playRumble} do {
		playSound "blowout_rumble";
		sleep 14;
	};
};

sleep 10;

[] spawn { // add extra layers to increase rumble intensity
	while {tts_emission_playRumble} do {
		playSound EMISSION_AMBIENT_RUMBLE;
		sleep (8 + (random 3));
	};
}