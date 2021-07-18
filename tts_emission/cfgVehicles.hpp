class CfgVehicles {
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;
			class Combo;
			class Checkbox;
			class CheckboxNumber;
			class ModuleDescription;
			class Units;
		};
		class ModuleDescription;
	};
	
	class tts_emission_module : Module_F {
		author = "TheTimidShade";
		scope = 1;
		scopeCurator = 1;
		is3DEN = 0;
		displayName = "TheTimidShade's Module";
		vehicleClass = "Modules";
		category = "tts_emission_modules";
	};
	
	class tts_emission_moduleEmissionSettings : tts_emission_module {
		scope = 2;
		scopeCurator = 0; // module is not available in Zeus
		isDisposable = 1; // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isGlobal = 0; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;
		displayName = "Emission Settings";
		icon = "tts_emission\icons\tts_settings.paa";
		category = "tts_emission_modules";
		function = "tts_emission_fnc_editor_moduleEmissionSettings";
		
		class Attributes : AttributesBase {
			class EmissionType : Combo {
				property = "tts_emission_moduleEmissionSettings_EmissionType";
				displayName = "Emission type";
				tooltip = "Which wave type to use for the emission.\nMap Sweep - Wave passes over entire map from the North, the wave will hit areas at the top of the map earlier\nFixed Distance - Wave is always a fixed distance from players but will hit all units on the map at the same time (good for infantry only/PVP/RP missions)";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class MapSweep {name = "Map Sweep"; value = 0;}; // Listbox item
					class FixedDistance {name = "Fixed Distance"; value = 1;};
				};
			};
			class PlayerEffect : Combo {
				property = "tts_emission_moduleEmissionSettings_PlayerEffect";
				displayName = "Player effect";
				tooltip = "How does the emission affect player units";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class KillUnsheltered {name = "Kill unsheltered"; value = 0;}; // Listbox item
					class KnockoutUnsheltered {name = "Knockout unsheltered"; value = 1;};
					class KillAll {name = "Kill all"; value = 2;};
					class KnockoutAll {name = "Knockout all"; value = 3;};
					class NoEffect {name = "No effect"; value = 4;};
				};
			};
			class AIEffect : Combo {
				property = "tts_emission_moduleEmissionSettings_AIEffect";
				displayName = "AI effect";
				tooltip = "How does the emission affect non-player units";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class KillUnsheltered {name = "Kill unsheltered"; value = 0;}; // Listbox item
					class KnockoutUnsheltered {name = "Knockout unsheltered"; value = 1;};
					class KillAll {name = "Kill all"; value = 2;};
					class KnockoutAll {name = "Knockout all"; value = 3;};
					class NoEffect {name = "No effect"; value = 4;};
				};
			};
			class AircraftEffect : Combo {
				property = "tts_emission_moduleEmissionSettings_AircraftEffect";
				displayName = "Aircraft effect";
				tooltip = "How does the emission affect flying aircraft (altitude > 15m)";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class LightningBolt {name = "Lightning bolt"; value = 0;}; // Listbox item
					class EngineFailure {name = "Engine failure"; value = 1;};
					class NoEffect {name = "No effect"; value = 2;};
				};
			};
			class SirenType : Combo {
				property = "tts_emission_moduleEmissionSettings_SirenType";
				displayName = "Siren type";
				tooltip = "What type of siren should play to warn of the emission";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class Classic {name = "Classic"; value = 0;}; // Listbox item
					class Dramatic {name = "Dramatic"; value = 1;};
					class None {name = "None"; value = 2;};
				};
			};
			class UsePhysicalSiren : Checkbox {
				property = "tts_emission_moduleEmissionSettings_UsePhysicalSiren";
				displayName = "Use physical siren";
				tooltip = "If checked, siren will play from the object with varname 'tts_emission_sirenObj' if found (can only be one per mission)";
				defaultValue = "0";
			};
			class ProtectionEquipment : Edit {
				property = "tts_emission_moduleEmissionSettings_ProtectionEquipment";
				displayName = "Protection equipment";
				tooltip = "Comma seperated classnames of headgear, facewear, NVGs, uniforms, vests or bags that units can wear to survive emissions outside of shelter";
				typeName = "STRING";
				defaultValue = """""";
			};
			class ImmuneUnits : Edit {
				property = "tts_emission_moduleEmissionSettings_ImmuneUnits";
				displayName = "Immune units";
				tooltip = "Comma seperated classnames or variable names of units that are not affected by emissions";
				typeName = "STRING";
				defaultValue = """""";
			};
			class WaveSpeed : Edit {
				property = "tts_emission_moduleEmissionSettings_WaveSpeed";
				displayName = "Wave speed";
				tooltip = "Speed in m/s wave travels (only applies to map sweep emission)";
				typeName = "NUMBER";
				defaultValue = "125";
			};
			class ShowEmissionOnMap : Checkbox {
				property = "tts_emission_moduleEmissionSettings_ShowEmissionOnMap";
				displayName = "Show emission on map";
				tooltip = "If checked, the emission's position will be displayed on the map";
				defaultValue = "0";
			};
			class DisableRain : Checkbox {
				property = "tts_emission_moduleEmissionSettings_DisableRain";
				displayName = "Disable rain effects";
				tooltip = "If checked, rain after the emission finishes will be disabled (tick this if using weather scripts)";
				defaultValue = "0";
			};
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Configures settings for TTS Emission script."; // Short description, will be formatted as structured text
		};
	};

	class tts_emission_moduleStartEmission : tts_emission_module {
		scope = 2;
		scopeCurator = 0; // module is not available in Zeus
		isDisposable = 1; // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isGlobal = 0; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 1;
		displayName = "Start Emission";
		icon = "tts_emission\icons\tts_emission.paa"
		category = "tts_emission_modules";
		function = "tts_emission_fnc_editor_moduleStartEmission";
		
		class Attributes : AttributesBase {
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Starts an emission when all synced triggers are activated."; // Short description, will be formatted as structured text
		};
	};

}