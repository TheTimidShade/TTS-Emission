class tts_emission
{
	class emission {
		file = "scripts\tts_emission\functions";
		class init { postInit = 1; };
		class startEmission {};
		class isSafe {};
		class damagePlayer {};
		class damageNonPlayer {};
		class hasProtection {};
		class isZombie {};
		class isSafeType {};
		class isImmune {};
	};
	class stages {
		file = "scripts\tts_emission\functions\stages";
		class buildup {};
		class impact {};
		class wave {};
		class waveMapSweeper {};
	};
	class effects {
		file = "scripts\tts_emission\functions\effects";
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
		file = "scripts\tts_emission\functions\zen";
		class initCustomModules {};
		class zen_moduleChangeSettings {};
		class zen_moduleStartEmission {};
	}
};