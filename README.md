# TTS Emission (Blowout)
This is an emission script I made for a STALKER themed mission. In STALKER, an emission is a devastating release of excess noosphere energy from the centre of the Chernobyl Exclusion Zone, which will kill/zombify anything not sheltered from it when it passes over. This script will allow you to recreate this event in Arma 3, by having an emission sweep over the map in the direction of your choice.

You can see the script in action in this [demo video](https://www.youtube.com/watch?v=45dQugEdcTo) or if you'd like to test the script for yourself, you can try out the [demo mission](https://steamcommunity.com/sharedfiles/filedetails/?id=2552184110).

This is the script version, a [mod version](https://github.com/TheTimidShade/Timid-Emission) is also available on the Steam Workshop.

### **Features:**
- Configurable settings so you can use the script how you like
- Emissions can be triggered on demand via script or Zeus
- AI can be affected by the emission
- Zombies from Ryan's Zombies and Ravage are immune to the emission
- Designed for multiplayer and tested on dedicated server
- Compatible with ACE
- Useable from Zeus via [Zeus Enhanced](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631)
- Editor modules to simplify usage (*Mod version only!*)

**ZEN Modules**:
- Change Settings
- Start Emission
- Start Random Emissions

**Editor Modules (MOD VERSION ONLY):**
- Change Settings
- Start Emission
- Start Random Emissions

**For help with troubleshooting, questions or feedback, join my [Discord](https://discord.gg/8Y2ENWQMpK)**
___

To shelter yourself from the emission, you must have a structure or vehicle considered to be shelter above your head within 30m. By default, objects considered shelter are anything that inherits from the classes 'Building', 'Car', 'Tank', 'Air' or 'Ship'. These classes can be adjusted in the settings if desired.

___

### **More information:**
- [Script version install instructions](https://github.com/TheTimidShade/TTS-Emission/wiki/Script-version-install-instructions)
- [Available settings](https://github.com/TheTimidShade/TTS-Emission/wiki/Available-settings)
- [Function documentation](https://github.com/TheTimidShade/TTS-Emission/wiki/Function-documentation)

### **License:**
This script is licensed under [Arma Public License No Derivatives (APL-ND)](https://www.bohemia.net/community/licenses/arma-public-license-nd). You can freely use the script in your missions, private or uploaded to the Steam Workshop but you must not use any parts of the script in another mod without my permission.

### **Supported Languages:**
- English
- Korean (Translation by Taru)  
If you'd like to translate the script into a different language, contact me via my Discord or create a pull request.

### **Credits:**
- Players of the [Task Force Dingo](taskforcedingo.com) community who helped bulk test the script during a weekly mission night.

___


### **Examples:**  
Trigger an emission:
```sqf
// put in a script or trigger 'On Activation' box
[] spawn tts_emission_fnc_startEmission;
```
*NOTE:* `tts_emission_fnc_startEmission` needs to be executed on the server and will not do anything if it isn't. If you're using a trigger you probably don't need to worry about this.

Start random emissions every 30-45 minutes with wave speed between 125-300m/s:
```sqf
// put in a script or trigger 'On Activation' box or init.sqf
// last parameter will randomise approach direction when true
[30, 45, 125, 300, true] spawn tts_emission_fnc_startRandomEmissions;
```

___

## Changelog
Read below for complete changelog history.

### 18/02/2022
- Fixed distance emission is no longer supported.
- Camera shake is now tied to the camera's distance to the emission wave rather than the player's and sounds are now played relative to the camera.
- Increased audible distance for emission pulse sounds and create them further away so that they are still audible when moving rapidly.
- Adjusted light source attenuation so the sky light isn't concentrated around the player.
- The player is no longer affected by the emission wave if they have damage disabled.
- AI now use the same shelter check as players.
- Added a parameter to select what effect the emission has on non-flying vehicles (ground vehicles/ships/landed aircraft).
- Cleaned up damage related functions so there should be no clash between player/AI effect and aircraft/vehicle effect parameters.
- Fixed an issue where lightning bolts would not appear correctly in multiplayer.
- Static weapons are not affected by the emission.
- Updated default settings for 'Start Random Emissions' ZEN module (defaults were still in seconds rather than minutes).

### 19/11/2021
- Added Korean translation by Taru.
- Updated GitHub README to be more consistent with Steam Workshop page.
- Shifted a lot of information from the README to GitHub's wiki pages.

### 12/11/2021
- Added a new function `fn_startRandomEmissions` which can be used to create emissions at random intervals. (Suggested by Apocalypsis)
- Added a new ZEN module 'Start Random Emissions' which can be used to start and stop the new random emissions function.

### 12/11/2021
- Added a new setting 'Approach direction' which determines the direction the map sweep emission will approach from. You can now choose 'North', 'South', 'East' or 'West'. (Suggested by cpt_bassbeard)
- Cleaned up default settings in `init.sqf`.

### 11/11/2021
- Cleaned up ZEN functions to be consistent with other TTS scripts.
- Doubled the width of the emission wave particle effect.
- Tweaked the emission particle creation to be tied to the camera's distance to the wave rather than the player character's distance to the wave. This should allow the emission wave to be visible from Zeus and Spectator.

### 22/10/2021
- Added a new setting `tts_emission_shelterTypes` that controls the classes that provide shelter from the emission.
- Improved setting `tts_emission_immuneUnits`, it can now contain parent classes the same as `tts_emission_shelterTypes`.

### 21/10/2021
- Fixed a typo in `fn_startEmission` that was resetting siren type 'None' back to 'Classic'.

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
