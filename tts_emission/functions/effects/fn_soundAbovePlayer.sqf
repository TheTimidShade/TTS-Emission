/*
	Author: TheTimidShade

	Description:
		Creates sound source object near and above local player and plays given sound

	Parameters:
		0: STRING - Name of sound to play on source
		
	Returns:
		NONE
*/

if (!hasInterface) exitWith {}; // don't run sounds or particles on dedi or HC

params ["_sound"];

private _source = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
_source hideObject true;
private _direction = round random 360;
private _sourcePos = player getRelPos [5 + (random 10), _direction];
_source setPosATL [_sourcePos#0, _sourcePos#1, 10];

_source say3D [_sound, 100, 1, false];

sleep 30;

deleteVehicle _source;