class tts_emission
{
	class emission {
		file = "tts_emission\functions";
		class startEmission {};
		class isSafe {};
		class damagePlayer {};
		class damageNonPlayer {};
		class hasProtection {};
		class isZombie {};
		class isSafeType {};
		class getPlayerDistance {};
	};
	class stages {
		file = "tts_emission\functions\stages";
		class buildup {};
		class impact {};
		class wave {};
		class waveMapSweeper {};
	};
	class effects {
		file = "tts_emission\functions\effects";
		class soundAbovePlayer {};
		class rumble {};
		class waveEffect {};
		class waveEffectMapSweeper {};
		class flash {};
		class handleLighting {};
		class handlePPeffects {};
		class psyEffect {};
	};
	class zen {
		file = "tts_emission\functions\zen";
		class initCustomModules {preInit = 1;};
		class module_changeSettings {};
		class module_startEmission {};
	}
	class modules {
		file = "tts_emission\functions\modules";
		class editor_moduleEmissionSettings {};
		class editor_moduleStartEmission {};
	}
};