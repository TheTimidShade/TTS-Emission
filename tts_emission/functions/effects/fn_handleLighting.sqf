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

private _mainBrightness = 110;
private _delay = 60;

private _mainLight = "#lightpoint" createVehicleLocal (getPos player);
_mainLight setLightBrightness 0;
//_mainLight setLightAmbient [1,0.5,0.5]; // [0.2,0,0]
_mainLight setLightColor [1,0.5,0.5];
_mainLight lightAttachObject [player, [0,0,1000]];

for "_i" from 0 to _mainBrightness do {
	_mainLight setLightBrightness _i;
	sleep (_delay/_mainBrightness);
};

waitUntil {sleep 1; tts_emission_progressState > 4};

for "_i" from 0 to _mainBrightness do {
	_mainLight setLightBrightness _mainBrightness - _i;
	sleep (_delay/_mainBrightness);
};

deleteVehicle _mainLight;