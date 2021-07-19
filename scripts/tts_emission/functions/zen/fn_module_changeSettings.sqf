// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Emission", "Change Settings",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNil "tts_emission_emissionIsActive") then {tts_emission_emissionIsActive = false;};
		if (tts_emission_emissionIsActive) then {systemChat "WARNING: Some setting changes may not apply until after the emission is finished!";};

		// set up settings if they are undefined
		if (isNil "tts_emission_emissionType") then {tts_emission_emissionType = 0;};
		if (isNil "tts_emission_playerEffect") then {tts_emission_playerEffect = 0;};
		if (isNil "tts_emission_aiEffect") then {tts_emission_aiEffect = 1;};
		if (isNil "tts_emission_aircraftEffect") then {tts_emission_aircraftEffect = 0;};
		if (isNil "tts_emission_sirenType") then {tts_emission_sirenType = 0;};
		if (isNil "tts_emission_useSirenObject") then {tts_emission_useSirenObject = false;};
		if (isNil "tts_emission_protectionEquipment") then {tts_emission_protectionEquipment = [];};
		if (isNil "tts_emission_immuneUnits") then {tts_emission_immuneUnits = [];};
		if (isNil "tts_emission_waveSpeed") then {tts_emission_waveSpeed = 125;};
		if (isNil "tts_emission_showEmissionOnMap") then {tts_emission_showEmissionOnMap = false;};
		if (isNil "tts_emission_disableRain") then {tts_emission_disableRain = false;};

		private ["_protectionPlaceholder", "_immunePlaceholder"];
		// populate placeholders
		_protectionPlaceholder = tts_emission_protectionEquipment joinString ",";
		_immunePlaceholder = tts_emission_immuneUnits joinString ",";

		[
			"Configure Emission Settings", // title
		 	[ // array of controls for dialog
				["COMBO", ["Emission type", "Which wave type to use for the emission.\nMap Sweep - Wave passes over entire map from the North, the wave will hit areas at the top of the map earlier\nFixed Distance - Wave is always a fixed distance from players but will hit all units on the map at the same time (good for infantry only/PVP/RP missions)"],
					[ // control args
						[0, 1], // return values
						["Map Sweep", "Fixed Distance"], // labels
						tts_emission_emissionType // element 0 is default selected
					],
					true // force default
				],
				["COMBO", ["Player effect", "How does the emission affect player units"],
					[ // control args
						[0, 1, 2, 3, 4], // return values
						["Kill unsheltered", "Knockout unsheltered", "Kill all", "Knockout all", "No effect"], // labels
						tts_emission_playerEffect // element 0 is default selected
					],
					true // force default
				],
				["COMBO", ["AI effect", "How does the emission affect non-player units"],
					[ // control args
						[0, 1, 2, 3, 4], // return values
						["Kill unsheltered", "Knockout unsheltered", "Kill all", "Knockout all", "No effect"], // labels
						tts_emission_aiEffect // element 0 is default selected
					],
					true // force default
				],
				["COMBO", ["Aircraft effect", "How does the emission affect flying aircraft (altitude > 15m)"],
					[ // control args
						[0, 1, 2], // return values
						["Lightning bolt", "Engine failure", "No effect"], // labels
						tts_emission_aircraftEffect // element 0 is default selected
					],
					true // force default
				],
				["COMBO", ["Siren type", "What type of siren should play to warn of the emission"],
					[ // control args
						[0, 1, 2], // return values
						["Classic", "Dramatic", "None"], // labels
						tts_emission_sirenType // element 0 is default selected
					],
					true // force default
				],
				["CHECKBOX", ["Use physical siren", "If checked, siren will play from the object with varname 'tts_emission_sirenObj' if found (can only be one per mission)"],
					[ // control args
						tts_emission_useSirenObject // default state
					],
					true // force default
				],
				["EDIT", ["Protection equipment", "Comma seperated classnames of headgear, facewear, NVGs, uniforms, vests or bags that units can wear to survive emissions outside of shelter"],
					[ // control args
						_protectionPlaceholder, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					true // force default
				],
				["EDIT", ["Immune units", "Comma seperated classnames or variable names of units that are not affected by emissions"],
					[ // control args
						_immunePlaceholder, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					true // force default
				],
				["EDIT", ["Wave speed", "Speed in m/s wave travels (only applies to map sweep emission)"],
					[ // control args
						str tts_emission_waveSpeed, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					true // force default
				],
				["CHECKBOX", ["Show emission on map", "If checked, the emission's position will be displayed on the map"],
					[ // control args
						tts_emission_showEmissionOnMap // default state
					],
					true // force default
				],
				["CHECKBOX", ["Disable rain effects", "If checked, rain after the emission finishes will be disabled (tick this if using weather scripts)"],
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
				tts_emission_immuneUnits = (_dialogResult#7) splitString ",";
				tts_emission_waveSpeed = parseNumber (_dialogResult#8);
				tts_emission_showEmissionOnMap = _dialogResult#9;
				tts_emission_disableRain = _dialogResult#10;

				{publicVariable _x;} forEach [ // publish settings to all clients
					"tts_emission_emissionType",
					"tts_emission_playerEffect",
					"tts_emission_aiEffect",
					"tts_emission_aircraftEffect",
					"tts_emission_sirenType",
					"tts_emission_useSirenObject",
					"tts_emission_protectionEquipment",
					"tts_emission_immuneUnits",
					"tts_emission_waveSpeed",
					"tts_emission_showEmissionOnMap",
					"tts_emission_disableRain"
				];
			}, {}, [] // args
		] call zen_dialog_fnc_create;
	}, "scripts\tts_emission\icons\tts_settings.paa"] call zen_custom_modules_fnc_register;
};