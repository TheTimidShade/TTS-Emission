/*
	Author: TheTimidShade

	Description:
		Handles post process effects

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (!hasInterface) exitWith {};

private _colourCorrection = ppEffectCreate ["colorCorrections", 1550];
_colourCorrection ppEffectEnable true;
_colourCorrection ppEffectAdjust [1, 1, 0, [0.3, 0, 0, 0.15], [1, 1, 1, 1], [0.299, 0.587, 0.114, 0]];
_colourCorrection ppEffectCommit 60;

private _filmGrain = ppEffectCreate ["FilmGrain", 2050];
_filmGrain ppEffectEnable true;
_filmGrain ppEffectAdjust [0.1, 1.25, 2.01, 0.75, 1.0, true];
_filmGrain ppEffectCommit 60;

if (sunOrMoon < 0.5) then {
	_colourCorrection ppEffectEnable false; // disable colour correction if it is night time
};

waitUntil {sleep 1; tts_emission_progressState > 3};

_colourCorrection ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0.299, 0.587, 0.114, 0]];
_colourCorrection ppEffectCommit 60;
_filmGrain ppEffectAdjust [0, 1.25, 2.01, 0.75, 1.0, true];
_filmGrain ppEffectCommit 60;

sleep 60;

ppEffectDestroy _colourCorrection;
ppEffectDestroy _filmGrain;