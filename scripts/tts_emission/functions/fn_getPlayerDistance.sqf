/*
	Author: TheTimidShade

	Description:
		Returns player's distance from emission wave (only used for map sweeper emission)

	Parameters:
		NONE
		
	Returns:
		NUMBER - Distance between player and emission wave
*/

abs (tts_emission_wave_yPos - (getPos player)#1)