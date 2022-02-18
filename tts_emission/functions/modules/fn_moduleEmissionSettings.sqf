/*
	Author: TheTimidShade

	Description:
		Module function for Emission Settings module.

	Parameters:
		0: OBJECT - Placed module.
		1: ARRAY - Objects that can be affected by the module.
		2: BOOL - Whether module is activated (synced triggers are active)
		
	Returns:
		NONE
*/

params [
	["_module", objNull, [objNull]],
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!isServer) exitWith {};

if (_activated) then {
	//tts_emission_emissionType = _module getVariable ["EmissionType", 0];
	tts_emission_playerEffect = _module getVariable ["PlayerEffect", 0];
	tts_emission_aiEffect = _module getVariable ["AIEffect", 1];
	tts_emission_vehicleEffect = _module getVariable ["VehicleEffect", 3];
	tts_emission_aircraftEffect = _module getVariable ["AircraftEffect", 0];
	tts_emission_useSirenObject = _module getVariable ["UsePhysicalSiren", false];
	tts_emission_sirenType = _module getVariable ["SirenType", 0];
	tts_emission_protectionEquipment = (_module getVariable ["ProtectionEquipment", ""]) splitString ",";
	tts_emission_shelterTypes = (_module getVariable ["ShelterTypes", ""]) splitString ",";
	tts_emission_immuneUnits = (_module getVariable ["ImmuneUnits", ""]) splitString ",";
	tts_emission_waveSpeed = _module getVariable ["WaveSpeed", 125];
	tts_emission_approachDirection = _module getVariable ["ApproachDirection", "N"];
	tts_emission_showEmissionOnMap = _module getVariable ["ShowEmissionOnMap", false];
	tts_emission_disableRain = _module getVariable ["DisableRain", false];

	{publicVariable _x} forEach [
		//"tts_emission_emissionType",
		"tts_emission_playerEffect",
		"tts_emission_aiEffect",
		"tts_emission_vehicleEffect",
		"tts_emission_aircraftEffect",
		"tts_emission_useSirenObject",
		"tts_emission_sirenType",
		"tts_emission_protectionEquipment",
		"tts_emission_shelterTypes",
		"tts_emission_immuneUnits",
		"tts_emission_waveSpeed",
		"tts_emission_approachDirection",
		"tts_emission_showEmissionOnMap",
		"tts_emission_disableRain"
	];
};
