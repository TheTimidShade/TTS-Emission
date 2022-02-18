/*
	Author: TheTimidShade

	Description:
		Handles illumination for emission

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (!hasInterface) exitWith {};

private _mainBrightness = 0.4;
private _delay = 60;

private _mainLight = "#lightpoint" createVehicleLocal (getPos player);
_mainLight setLightBrightness 0;
//_mainLight setLightAmbient [1,0.5,0.5]; // [0.2,0,0]
_mainLight setLightColor [1,0.5,0.5];
_mainLight setLightAttenuation [2,4,4.31918e-005,0];
_mainLight lightAttachObject [player, [0,0,5000]];

private _step = _mainBrightness/_delay/5;

for "_i" from 0 to _mainBrightness step _step do {
	_mainLight setLightBrightness _i;
	sleep 0.2;
};

waitUntil {sleep 1; tts_emission_progressState > 4};

for "_i" from 0 to _mainBrightness step _step do {
	_mainLight setLightBrightness _mainBrightness - _i;
	sleep 0.2;
};

deleteVehicle _mainLight;