/*
	Author: TheTimidShade

	Description:
		Creates bright flash/lightning effect

	Parameters:
		0: NUMBER - Light brightness to use for flash
		1: NUMBER - Delay used before deleting light source
		
	Returns:
		NONE
*/

params ["_brightness", "_delay"];

private _flash = "#lightpoint" createVehicleLocal (getPos player);
private _flashPos = (positionCameraToWorld [0,0,0]) getPos [random 4000, random 360];
_flashPos set [2, 1400];
_flash setPosASL _flashPos;
_flash setLightBrightness _brightness;
_flash setLightAmbient [1,1,1];
_flash setLightColor [1,1,1];
sleep _delay;
deleteVehicle _flash;