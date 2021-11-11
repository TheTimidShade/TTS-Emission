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
	private _emissionType = _module getVariable ["EmissionType", 0];
	private _playerEffect = _module getVariable ["PlayerEffect", 0];
	private _aiEffect = _module getVariable ["AIEffect", 1];
	private _aircraftEffect = _module getVariable ["AircraftEffect", 0];
	private _sirenType = _module getVariable ["SirenType", 0];
	private _useSirenObject = _module getVariable ["UsePhysicalSiren", false];
	private _protectionEquipment = (_module getVariable ["ProtectionEquipment", ""]) splitString ",";
	private _shelterTypes = (_module getVariable ["ShelterTypes", ""]) splitString ",";
	private _immuneUnits = (_module getVariable ["ImmuneUnits", ""]) splitString ",";
	private _waveSpeed = _module getVariable ["WaveSpeed", 125];
	private _showEmissionOnMap = _module getVariable ["ShowEmissionOnMap", false];
	private _disableRain = _module getVariable ["DisableRain", false];

	tts_emission_emissionType = _emissionType;
	tts_emission_playerEffect = _playerEffect;
	tts_emission_aiEffect = _aiEffect;
	tts_emission_aircraftEffect = _aircraftEffect;
	tts_emission_useSirenObject = _useSirenObject;
	tts_emission_sirenType = _sirenType;
	tts_emission_protectionEquipment = _protectionEquipment;
	tts_emission_shelterTypes = _shelterTypes;
	tts_emission_immuneUnits = _immuneUnits;
	tts_emission_waveSpeed = _waveSpeed;
	tts_emission_showEmissionOnMap = _showEmissionOnMap;
	tts_emission_disableRain = _disableRain;

	{publicVariable _x} forEach [
		"tts_emission_emissionType",
		"tts_emission_playerEffect",
		"tts_emission_aiEffect",
		"tts_emission_aircraftEffect",
		"tts_emission_useSirenObject",
		"tts_emission_sirenType",
		"tts_emission_protectionEquipment",
		"tts_emission_shelterTypes",
		"tts_emission_immuneUnits",
		"tts_emission_waveSpeed",
		"tts_emission_showEmissionOnMap",
		"tts_emission_disableRain"
	];
};
