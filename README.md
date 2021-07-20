# Emission/Blowout Script
## Overview:
Designed for Arma 3, this script allows mission makers and Zeuses to trigger an emission/blowout event based on the weather event of the same name from the STALKER games. It has a number of settings that can be customised to suit a wide range of scenarios.

There are two types of emissions to choose from:  

**Map Sweep** - The emission will sweep the map from North to South, so the time at which units are hit by the wave is dynamic depending on their position on the map. The 'Wave Speed' and 'Show Emission on Map' parameters only apply to this emission type.  

**Fixed Distance** - The emission will start at a fixed distance away from players so all players and units on the map are hit at the same time. Since the emission is fixed to the player, no matter how fast you fly away from the wave it will still hit you, so this can look weird from aircraft. Mainly suited towards player only/infantry/RP missions. (This was v1 before I designed the map sweep version)

You will not be able to use this script from Zeus unless Zeus Enhanced is loaded.

Demo Video: N/A  
Steam Workshop page: N/A  
Zeus Enhanced: https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631  

## Features:
- Emissions can be triggered on demand via script or Zeus
- Customisable settings to adjust the lethality of the emission
- AI can be affected by the emission
- Works in MP (Tested on dedicated server)
- Compatible with Zeus Enhanced.

## Setup/Use:
1. Download files from repository.
2. Excluding `README.md`, move files into your mission folder and merge `description.ext` and `init.sqf` with your existing files (if you have them).
3. Configure settings in `init.sqf`.
4. Trigger emission via script using `[] spawn tts_emission_fnc_startEmission;` or using Zeus Modules (requires Zeus Enhanced).

### Settings  
Below is a list of settings that can be changed to suit the way you want to use the script. Place the lines you wish to change in `init.sqf`.  

```sqf
tts_emission_emissionType = 0;          // 0 = Map Sweep, 1 = Fixed Distance
tts_emission_playerEffect = 0;          // 0 - 4, see below
tts_emission_aiEffect = 1;              // 0 - 4, see below
tts_emission_aircraftEffect = 0;        // 0 = Lightning Bolt, 1 = Disable Engine, 2 = No Effect
tts_emission_sirenType = 0;             // 0 = Classic, 1 = Dramatic, 2 = None
tts_emission_useSirenObject = false;    // If true, uses object with name 'tts_emission_sirenObj' as sound source for siren
tts_emission_protectionEquipment = [];  // Equipment* classnames that protect unsheltered players
tts_emission_immuneUnits = [];          // Unit classnames or variable names that are immune to the emission
tts_emission_waveSpeed = 125;           // Speed of map sweep wave in m/s **
tts_emission_showEmissionOnMap = false; // If true, progress of map sweep wave will be shown on map
tts_emission_disableRain = false;       // If true, rain effects will be disabled ***
```
Player and AI effect parameters can be these values:  
0 = Kill Unsheltered, 1 = Knockout Unsheltered, 2 = Kill All, 3 = Knockout All, 4 = No Effect  

\*  Valid equipment can be headgear, facewear, NVGs, uniforms, vests or bags  
\** Increasing this can lead to units being 'skipped over' by the kill trigger for the emission so proceed with caution.  
\*** Disable rain effects if using weather scripts as it may interfere




## Changelog
Read below for complete changelog history.

### 20/07/2021
- Fixed some sounds playing at incorrect height when player is on buildings.
- Adjusted length of lightning flashes.

### 19/07/2021
- Adjusted update rate of emission lighting.
- Fixed dodgy loop code causing crash.
- Fixed bug where updating settings via ZEN module would break the map sweep wave.

### 18/07/2021
- Created repository.
