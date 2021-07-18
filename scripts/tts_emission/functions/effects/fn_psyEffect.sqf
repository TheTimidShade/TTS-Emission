/*
	Author: TheTimidShade

	Description:
		Plays post process effects on player when they are knocked out by emission wave

	Parameters:
		NONE
		
	Returns:
		NONE
*/

cutText ["", "WHITE OUT", 1];
titleCut ["", "WHITE IN", 1];

playSound "psy_voices_01";

_radialBlur = ppEffectCreate ["RadialBlur", 199];
_radialBlur ppEffectEnable true;
_radialBlur ppEffectAdjust [0.05, 0.05, 0.01, 0.01];
_radialBlur ppEffectCommit 0.5;

_wetDistortion = ppEffectCreate ["WetDistortion", 198];
_wetDistortion ppEffectEnable true;
_wetDistortion ppEffectAdjust [
	1,
	1, 1,
	4.10, 3.70, 2.50, 1.85,
	0.0054, 0.0041, 0.0090, 0.0070,
	0.5, 0.3, 10.0, 6.0
];
_wetDistortion ppEffectCommit 0.5;

_chromAbber = ppEffectCreate ["ChromAberration", 201];
_chromAbber ppEffectEnable true;
_chromAbber ppEffectAdjust [0.1, 0.1, true];
_chromAbber ppEffectCommit 0.5;

_filmGrain = ppEffectCreate ["FilmGrain", 197];
_filmGrain ppEffectEnable true;
_filmGrain ppEffectAdjust [0.5];
_filmGrain ppEffectCommit 0.5;

sleep 15;

_radialBlur ppEffectAdjust [0.05, 0.05, 1, 1];
_wetDistortion ppEffectAdjust [
	0,
	0, 0,
	4.10, 3.70, 2.50, 1.85,
	0.0054, 0.0041, 0.0090, 0.0070,
	0.5, 0.3, 10.0, 6.0
];
_chromAbber ppEffectAdjust [0, 0, true];
_filmGrain ppEffectAdjust [0];

{_x ppEffectCommit 20} forEach [_radialBlur, _wetDistortion, _chromAbber, _filmGrain];

sleep 20;

{ppEffectDestroy _x} forEach [_radialBlur, _wetDistortion, _chromAbber, _filmGrain];