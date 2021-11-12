["TTS Emission", "STR_tts_emission_moduleChangeSettings_title",
{
	params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

	if (isNil "tts_emission_emissionIsActive") then {tts_emission_emissionIsActive = false;};
	if (tts_emission_emissionIsActive) then {systemChat localize "STR_tts_emission_moduleChangeSettings_warning";};

	// set up settings if they are undefined
	if (isNil "tts_emission_emissionType") then {tts_emission_emissionType = 0;};
	if (isNil "tts_emission_playerEffect") then {tts_emission_playerEffect = 0;};
	if (isNil "tts_emission_aiEffect") then {tts_emission_aiEffect = 1;};
	if (isNil "tts_emission_aircraftEffect") then {tts_emission_aircraftEffect = 0;};
	if (isNil "tts_emission_sirenType") then {tts_emission_sirenType = 0;};
	if (isNil "tts_emission_useSirenObject") then {tts_emission_useSirenObject = false;};
	if (isNil "tts_emission_protectionEquipment") then {tts_emission_protectionEquipment = [];};
	if (isNil "tts_emission_shelterTypes") then {tts_emission_shelterTypes = ["Building", "Car", "Tank", "Air", "Ship"];};
	if (isNil "tts_emission_immuneUnits") then {tts_emission_immuneUnits = [];};
	if (isNil "tts_emission_waveSpeed") then {tts_emission_waveSpeed = 125;};
	if (isNil "tts_emission_approachDirection") then {tts_emission_approachDirection = "N";};
	if (isNil "tts_emission_showEmissionOnMap") then {tts_emission_showEmissionOnMap = false;};
	if (isNil "tts_emission_disableRain") then {tts_emission_disableRain = false;};

	private ["_protectionPlaceholder", "_shelterTypesPlaceholder", "_immunePlaceholder"];
	// populate placeholders
	_protectionPlaceholder = tts_emission_protectionEquipment joinString ",";
	_immunePlaceholder = tts_emission_immuneUnits joinString ",";
	_shelterTypesPlaceholder = tts_emission_shelterTypes joinString ",";

	[
		"STR_tts_emission_moduleChangeSettings_heading", // title
		[ // array of controls for dialog
			["COMBO", ["STR_tts_emission_moduleChangeSettings_emissionType", "STR_tts_emission_moduleChangeSettings_emissionType_desc"],
				[ // control args
					[0, 1], // return values
					["STR_tts_emission_moduleChangeSettings_emissionType_mapSweep", "STR_tts_emission_moduleChangeSettings_emissionType_fixedDistance"], // labels
					tts_emission_emissionType // element 0 is default selected
				],
				true // force default
			],
			["COMBO", ["STR_tts_emission_moduleChangeSettings_playerEffect", "STR_tts_emission_moduleChangeSettings_playerEffect_desc"],
				[ // control args
					[0, 1, 2, 3, 4], // return values
					["STR_tts_emission_moduleChangeSettings_emissionEffect_killUnsheltered", "STR_tts_emission_moduleChangeSettings_emissionEffect_knockoutUnsheltered", "STR_tts_emission_moduleChangeSettings_emissionEffect_killAll", "STR_tts_emission_moduleChangeSettings_emissionEffect_knockoutAll", "STR_tts_emission_moduleChangeSettings_emissionEffect_noEffect"], // labels
					tts_emission_playerEffect // element 0 is default selected
				],
				true // force default
			],
			["COMBO", ["STR_tts_emission_moduleChangeSettings_aiEffect", "STR_tts_emission_moduleChangeSettings_aiEffect_desc"],
				[ // control args
					[0, 1, 2, 3, 4], // return values
					["STR_tts_emission_moduleChangeSettings_emissionEffect_killUnsheltered", "STR_tts_emission_moduleChangeSettings_emissionEffect_knockoutUnsheltered", "STR_tts_emission_moduleChangeSettings_emissionEffect_killAll", "STR_tts_emission_moduleChangeSettings_emissionEffect_knockoutAll", "STR_tts_emission_moduleChangeSettings_emissionEffect_noEffect"], // labels
					tts_emission_aiEffect // element 0 is default selected
				],
				true // force default
			],
			["COMBO", ["STR_tts_emission_moduleChangeSettings_aircraftEffect", "STR_tts_emission_moduleChangeSettings_aircraftEffect_desc"],
				[ // control args
					[0, 1, 2], // return values
					["STR_tts_emission_moduleChangeSettings_aircraftEffect_lightningBolt", "STR_tts_emission_moduleChangeSettings_aircraftEffect_engineFailure", "STR_tts_emission_moduleChangeSettings_emissionEffect_noEffect"], // labels
					tts_emission_aircraftEffect // element 0 is default selected
				],
				true // force default
			],
			["COMBO", ["STR_tts_emission_moduleChangeSettings_sirenType", "STR_tts_emission_moduleChangeSettings_sirenType_desc"],
				[ // control args
					[0, 1, 2], // return values
					["STR_tts_emission_moduleChangeSettings_sirenType_classic", "STR_tts_emission_moduleChangeSettings_sirenType_dramatic", "STR_tts_emission_none"], // labels
					tts_emission_sirenType // element 0 is default selected
				],
				true // force default
			],
			["CHECKBOX", ["STR_tts_emission_moduleChangeSettings_usePhysicalSiren", "STR_tts_emission_moduleChangeSettings_usePhysicalSiren_desc"],
				[ // control args
					tts_emission_useSirenObject // default state
				],
				true // force default
			],
			["EDIT", ["STR_tts_emission_moduleChangeSettings_protectionEquipment", "STR_tts_emission_moduleChangeSettings_protectionEquipment_desc"],
				[ // control args
					_protectionPlaceholder, // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				true // force default
			],
			["EDIT", ["STR_tts_emission_moduleChangeSettings_shelterTypes", "STR_tts_emission_moduleChangeSettings_shelterTypes_desc"],
				[ // control args
					_shelterTypesPlaceholder, // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				true // force default
			],
			["EDIT", ["STR_tts_emission_moduleChangeSettings_immuneUnits", "STR_tts_emission_moduleChangeSettings_immuneUnits_desc"],
				[ // control args
					_immunePlaceholder, // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				true // force default
			],
			["EDIT", ["STR_tts_emission_moduleChangeSettings_waveSpeed", "STR_tts_emission_moduleChangeSettings_waveSpeed_desc"],
				[ // control args
					str tts_emission_waveSpeed, // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				true // force default
			],
			["COMBO", ["STR_tts_emission_moduleChangeSettings_approachDirection", "STR_tts_emission_moduleChangeSettings_approachDirection_desc"],
				[ // control args
					[0, 1, 2, 3], // return values
					["STR_tts_emission_moduleChangeSettings_approachDirection_north", "STR_tts_emission_moduleChangeSettings_approachDirection_east", "STR_tts_emission_moduleChangeSettings_approachDirection_south", "STR_tts_emission_moduleChangeSettings_approachDirection_west"], // labels
					(["N", "E", "S", "W"] find tts_emission_approachDirection)
				],
				true // force default
			],
			["CHECKBOX", ["STR_tts_emission_moduleChangeSettings_showEmissionOnMap", "STR_tts_emission_moduleChangeSettings_showEmissionOnMap_desc"],
				[ // control args
					tts_emission_showEmissionOnMap // default state
				],
				true // force default
			],
			["CHECKBOX", ["STR_tts_emission_moduleChangeSettings_rainEffects", "STR_tts_emission_moduleChangeSettings_rainEffects_desc"],
				[ // control args
					tts_emission_disableRain // default state
				],
				true // force default
			]
		],
		{ // code run on dialog closed (only run if OK is clicked)
			params ["_dialogResult", "_args"];

			tts_emission_emissionType = _dialogResult#0;
			tts_emission_playerEffect = _dialogResult#1;
			tts_emission_aiEffect = _dialogResult#2;
			tts_emission_aircraftEffect = _dialogResult#3;
			tts_emission_sirenType = _dialogResult#4;
			tts_emission_useSirenObject = _dialogResult#5;
			tts_emission_protectionEquipment = (_dialogResult#6) splitString ",";
			tts_emission_shelterTypes = (_dialogResult#7) splitString ",";
			tts_emission_immuneUnits = (_dialogResult#8) splitString ",";
			tts_emission_waveSpeed = parseNumber (_dialogResult#9);
			tts_emission_approachDirection = ["N", "E", "S", "W"]#(_dialogResult#10);
			tts_emission_showEmissionOnMap = _dialogResult#11;
			tts_emission_disableRain = _dialogResult#12;

			{publicVariable _x;} forEach [ // publish settings to all clients
				"tts_emission_emissionType",
				"tts_emission_playerEffect",
				"tts_emission_aiEffect",
				"tts_emission_aircraftEffect",
				"tts_emission_sirenType",
				"tts_emission_useSirenObject",
				"tts_emission_protectionEquipment",
				"tts_emission_shelterTypes",
				"tts_emission_immuneUnits",
				"tts_emission_waveSpeed",
				"tts_emission_approachDirection",
				"tts_emission_showEmissionOnMap",
				"tts_emission_disableRain"
			];
		}, {}, [] // args
	] call zen_dialog_fnc_create;
}, "scripts\tts_emission\icons\tts_settings.paa"] call zen_custom_modules_fnc_register;