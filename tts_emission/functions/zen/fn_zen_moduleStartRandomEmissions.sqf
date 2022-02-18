["TTS Emission", "STR_tts_emission_moduleStartRandomEmissions_title",
{
	params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

	[
		"STR_tts_emission_moduleStartRandomEmissions_title", // title
		[ // array of controls for dialog
			["EDIT", ["STR_tts_emission_moduleStartRandomEmissions_minDelay", "STR_tts_emission_moduleStartRandomEmissions_minDelay_desc"],
				[ // control args
					"30", // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				false // force default
			],
			["EDIT", ["STR_tts_emission_moduleStartRandomEmissions_maxDelay", "STR_tts_emission_moduleStartRandomEmissions_maxDelay_desc"],
				[ // control args
					"45", // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				false // force default
			],
			["EDIT", ["STR_tts_emission_moduleStartRandomEmissions_minSpeed", "STR_tts_emission_moduleStartRandomEmissions_minSpeed_desc"],
				[ // control args
					"125", // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				false // force default
			],
			["EDIT", ["STR_tts_emission_moduleStartRandomEmissions_maxSpeed", "STR_tts_emission_moduleStartRandomEmissions_maxSpeed_desc"],
				[ // control args
					"125", // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				false // force default
			],
			["CHECKBOX", ["STR_tts_emission_moduleStartRandomEmissions_randomiseDirection", "STR_tts_emission_moduleStartRandomEmissions_randomiseDirection_desc"],
				[ // control args
					false // default state
				],
				false // force default
			],
			["CHECKBOX", ["STR_tts_emission_moduleStartRandomEmissions_stopRandomEmissions", "STR_tts_emission_moduleStartRandomEmissions_stopRandomEmissions_desc"],
				[ // control args
					false // default state
				],
				true // force default
			]
		],
		{ // code run on dialog closed (only run if OK is clicked)
			params ["_dialogResult", "_args"];
			_dialogResult params ["_minDelay", "_maxDelay", "_minSpeed", "_maxSpeed", "_randomiseDirection", "_stopRandomEmissions"];

			if (_stopRandomEmissions) exitWith
			{
				tts_emission_randomEmissions = false;
				publicVariable "tts_emission_randomEmissions";
			};

			_minDelay = parseNumber _minDelay;
			_maxDelay = parseNumber _maxDelay;
			_minSpeed = parseNumber _minSpeed;
			_maxSpeed = parseNumber _maxSpeed;

			[_minDelay, _maxDelay, _minSpeed, _maxSpeed, _randomiseDirection] remoteExec ["tts_emission_fnc_startRandomEmissions", 2, false];

		}, {}, [] // args
	] call zen_dialog_fnc_create;
}, "tts_emission\icons\random_icon.paa"] call zen_custom_modules_fnc_register;