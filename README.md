# TTS Emission (Blowout) Script
Emission script for Arma 3 I created for one of my missions which can be used to trigger an 'emission' or 'blowout' weather event from the STALKER games. Any units not in shelter or not wearing protection when the wave passes will be killed or knocked unconscious depending on the settings you choose.

A [mod version](https://steamcommunity.com/sharedfiles/filedetails/?id=2552187881) is also available on the Steam Workshop.

### **FEATURES:**
- Configurable settings so you can use the script how you like
- Emissions can be triggered on demand via script or Zeus
- AI can be affected by the emission
- ACE compatibility
- Designed for multiplayer and tested on dedicated server
- Compatible with Zeus Enhanced
- Zombies from Ryan's Zombies and Ravage are immune to the emission
- Editor modules to simplify usage (*Mod version only!*)

[Zeus Enhanced](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631) is required to use the module from Zeus.

You can see the script in action in this [demo video](https://www.youtube.com/watch?v=45dQugEdcTo) or try out the [demo mission](https://steamcommunity.com/sharedfiles/filedetails/?id=2552184110) yourself.

___

There are two types of emissions to choose from:

**Map Sweep** - The emission will sweep the map from North to South, so the time at which units are hit by the wave is dynamic depending on their position on the map. The 'Wave Speed' and 'Show Emission on Map' parameters only apply to this emission type.

**Fixed Distance** - The emission will start at a fixed distance away from players so all players and units on the map are hit at the same time. Since the emission is fixed to the player, no matter how fast you fly away from the wave it will still hit you, so this can look weird from aircraft. Mainly suited towards player only/infantry/RP missions. (This was v1 before I designed the map sweep version)

To shelter yourself from the emission, you must have a structure or vehicle considered to be shelter above your head within 30m. Objects considered shelter are anything that inherits from the classes 'Building', 'Car', 'Tank', 'Air' or 'Ship'. If you notice instances where you think you should have been protected but weren't, feel free to report them to me in my via my [Discord](https://discord.com/invite/8Y2ENWQMpK) and I will look into adjusting these classes if necessary.

___

### **INTALLATION INSTRUCTIONS:**
1. Download the script files via the green 'Code' button in the top right. Extract the ZIP file somewhere easily accessible.
2. Open your mission folder. You can do this from the 3den Editor using (Scenario > Open Scenario Folder).
3. Copy the 'scripts' folder into your mission folder.
4. If you do not already have an `init.sqf` file in your mission, copy it into your mission folder. If you already have one, copy the contents of my `init.sqf` into yours.
5. If you do not already have a `description.ext` file in your mission, copy it into your mission folder. If you already have one, copy the contents of my `description.ext` into yours. Any 'CfgSomething' classes need to be merged together into one.
e.g.
```cpp
// from TTS Cloak
class CfgFunctions
{
    #include "scripts\tts_cloak\cfgFunctions.hpp"
}
```
and
```cpp
// from TTS Beam Laser
class CfgFunctions
{
    #include "scripts\tts_beam\cfgFunctions.hpp"
}
```
should become
```cpp
// what CfgFunctions should look like when using both
class CfgFunctions
{
    #include "scripts\tts_cloak\cfgFunctions.hpp"
    #include "scripts\tts_beam\cfgFunctions.hpp"
}
```
6. Set up the settings in your `init.sqf` file how you would like (more info on individual settings below)
7. Done! You can now trigger an emission using 
```sqf
[] spawn tts_emission_fnc_startEmission;
```
Alternatively, if you are using Zeus Enhanced you can do this via Zeus modules.

*IMPORTANT*: `tts_emission_fnc_startEmission` should be executed on the server. If you don't know how to do this, see below for some examples you can copy paste!

___

### **SETTINGS:**
Default settings:
```sqf
tts_emission_emissionType = 0; // 'Map Sweep' emission
tts_emission_playerEffect = 0; // Kill unsheltered
tts_emission_aiEffect = 1; // Knockout unsheltered
tts_emission_aircraftEffect = 0; // Lightning bolt
tts_emission_sirenType = 0; // Classic
tts_emission_useSirenObject = false;
tts_emission_protectionEquipment = []; // Nothing can protect you outside of shelter
tts_emission_immuneUnits = []; // No units are immune to the emission
tts_emission_waveSpeed = 125;
tts_emission_showEmissionOnMap = false;
tts_emission_disableRain = false;
```
**tts_emission_emissionType**  
Must be 0 or 1. 0 means use the 'Map Sweep' emission type, 1 means use the 'Fixed Distance' emission type. Default value is 0.

**tts_emission_playerEffect/tts_emission_aiEffect**  
Can be any number 0-4. Default value is 0 for player and 1 for AI.  
0 = Kill unsheltered  
1 = Knockout unsheltered  
2 = Kill all  
3 = Knockout all  
4 = No effect  

A player unit is considered 'unsheltered' if they do not have a valid roof within 30m above their head and do not have any protection equipment equipped. AI units are considered 'unsheltered' if they are more than 20m from any safe shelter types and do not have protection equipment equipped.

Units outside during a 'Kill unsheltered' emission will be knocked out instead if they are wearing protection equipment. 'Kill all' and 'Knockout all' will ALWAYS kill/knockout units when the wave passes, regardless of whether or not they are wearing protection equipment.

**tts_emission_aircraftEffect**  
Can be any number 0-2. Default value is 0.  
0 = Lightning bolt  
1 = Disable engine  
2 = No effect  

Aircraft will be affected if they are more than 15m above terrain level. 'Lightning bolt' setting will use a Zeus lightning strike to strike aircraft out of the sky when the wave passes them, 'Disable Engine' will deliver critical damage to the engine of the aircraft.

**tts_emission_sirenType**  
Can be any number 0-2. Default value is 0.  
0 = Classic  
1 = Dramatic  
2 = None  
There are two types of siren sound effects that can be played, the original sound effect from the STALKER games and a newer more modern sounding siren.

**tts_emission_useSirenObject**  
If this is true, the script will try to find an object in the mission with the variable name `tts_emission_sirenObj` and will play the siren sound in 3D space from that object instead of just playing the sound. If the object cannot be found, the behaviour is the same as if this setting is set to false. Default value is false.

**tts_emission_protectionEquipment**  
An array of equipment classnames that player and AI units can equip to protect themselves from the emission outside of shelter. The unit only needs to be wearing one of the items in the array to be considered protected. Valid equipment can be headgear, facewear, NVGs, uniforms, vests or backpacks. Default value is an empty array.

**tts_emission_immuneUnits**  
Similar to `tts_emission_protectionEquipment`, this is an array containing unit types and variable names that are immune to the emission. 'Unit types' means exact classnames, if you put 'Man' in the array it will not make all child types immune.  
e.g.  
```sqf
// NATO riflemen and the unit with variable name 'immune_1' will be immune
tts_emission_immuneUnits = ["B_Soldier_F", "immune_1"];
```

**tts_emission_waveSpeed**  
The speed the wave moves at in m/s. This setting only applies when using the 'Map Sweep' emission type. Must be > 0. The kill trigger for the map sweep wave is 80m wide and updates every 0.1 seconds, so setting this higher than 800m/s may cause units to be missed by the trigger. Default value is 125.

**tts_emission_showEmissionOnMap**  
If this is true, the emission's progress across the map will be shown via map markers. This setting only applies to the 'Map Sweep' emission type. Default value is false.

**tts_emission_disableRain**  
If this is true, the rain effects following the emission wave will be disabled. This can be disabled to prevent interference if you are running some kind of weather script in your mission. Default value is false.

___

### **EXAMPLES:**  
Trigger an emission:
```sqf
// put in a script or trigger 'On Activation' box
[] spawn tts_emission_fnc_startEmission;
```
*NOTE:* `tts_emission_fnc_startEmission` needs to be executed on the server and will not do anything if it isn't. If you're using a trigger that isn't 'Server Only', you don't need to worry about this.

___

### **OTHER FUNCTIONS:**  
*NOTE:* Be careful when using these functions, incorrect use may cause strange behaviour! These are used internally by the scripts/modules but you can use them yourself if you want to.

**tts_emission_fnc_hasProtection**  
Used to check if the given unit is wearing protection equipment defined in `tts_emission_protectionEquipment`.
```
Parameters:  
  0: OBJECT - Unit to check for protection equipment 
Returns:  
  BOOL - True if unit is wearing protection, false if not
```
Example:
```sqf
[_unit] call tts_emission_fnc_hasProtection;
```

<br/>**tts_emission_fnc_isSafe**  
Tests if the given unit is 'sheltered' from the emission. 'Safe shelter objects' are considered to be anything that inherits from the classes 'Building', 'Car', 'Tank', 'Air' or 'Ship'.  
Players are considered 'sheltered' if one or more of the following conditions are met:
- There is a safe shelter object over their head within 30m.
- They are more than 2m underwater.
- Their variable name or unit type is in `tts_emission_immuneUnits`.  

AI are considered 'sheltered' if one or more of the following conditions are met:
- They are within 20m of safe shelter.
- They are more than 2m underwater.
- Their variable name or unit type is in `tts_emission_immuneUnits`. 
```
Parameters:  
  0: OBJECT - Unit to check
Returns:  
  BOOL - True if unit is safe from the emission, false if not
```
Example:
```sqf
private _isSafe = [_unit] call tts_emission_fnc_isSafe;
```

<br/>**tts_emission_fnc_isZombie**  
Tests if the given unit is a zombie from Ryan's Zombies or Ravage. This function checks to see if the unit inherits from the classes 'zombie' (Ravage), 'RyanZombieCivilian_F' (Civilian Zombies) or 'RyanZombieB_Soldier_base_F' (Military Zombies).
```
Parameters:  
  0: OBJECT - Unit to check
Returns:  
  BOOL - True if unit is a zombie, false if not
```
Example:
```sqf
private _isZombie = [_unit] call tts_emission_fnc_isZombie;
```

<br/>**tts_emission_fnc_psyEffect**  
Typo in the function name that I may fix in the future. Plays a 'psi' style effect on the player's screen. This can be quite nauseating since the effect is quite intense, use in moderation. Used internally when a player is knocked out by the emission. Must be executed locally on the player's machine you want the effect to play on.
```
Parameters:  
  NONE
Returns:  
  NOTHING
```
Example:
```sqf
// remoteExec used to execute where '_playerUnit' is local
[] remoteExec ["tts_emission_fnc_psyEffect", _playerUnit, false];
```

___

## Changelog
Read below for complete changelog history.

### 18/10/2021
- Added stringtable support to allow the script to be translated. If you are willing to help translate the script into another language, contact me in my Discord!

### 06/10/2021
- Increased shelter check distance from 10m to 30m.

### 25/07/2021
- AI units can now be protected by whitelisted protection equipment the same as players.

### 20/07/2021
- Fixed some sounds playing at incorrect height when player is on buildings.
- Adjusted length of lightning flashes.
- Increased distance above head for roof check from 5m to 10m.

### 19/07/2021
- Adjusted update rate of emission lighting.
- Fixed dodgy loop code causing crash.
- Fixed bug where updating settings via ZEN module would break the map sweep wave.

### 18/07/2021
- Created repository.
