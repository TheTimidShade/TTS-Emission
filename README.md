## Changelog
Read below for complete changelog history.

### 19/11/2021
- Added Korean translation by Taru.

### 13/11/2021
Applied changes from script version:
- Added a new function `fn_startRandomEmissions` which can be used to create emissions at random intervals. (Suggested by Apocalypsis)
- Added a new ZEN module 'Start Random Emissions' which can be used to start and stop the new random emissions function.

Mod version specific changes:
- Added 'Start Random Emissions' editor module.

### 12/11/2021
Applied changes from script version:
- Added a new setting 'Approach direction' which determines the direction the map sweep emission will approach from. You can now choose 'North', 'South', 'East' or 'West'. (Suggested by cpt_bassbeard)

### 11/11/2021
Applied changes from script version:
- Cleaned up ZEN functions to be consistent with other TTS scripts.
- Doubled the width of the emission wave particle effect.
- Tweaked the emission particle creation to be tied to the camera's distance to the wave rather than the player character's distance to the wave. This should allow the emission wave to be visible from Zeus and Spectator.

Mod version specific changes:
- Redid support for TTS Effects AIO.

### 07/11/2021
- Fixed default settings for modules having incorrect types. Modules should not cause errors when using default settings anymore.

### 22/10/2021
Applied changes from script version:
- Added a new setting `tts_emission_shelterTypes` that controls the classes that provide shelter from the emission.
- Improved setting `tts_emission_immuneUnits`, it can now contain parent classes the same as `tts_emission_shelterTypes`.

### 21/10/2021
Applied changes from script version:
- Fixed a typo in `fn_startEmission` that was resetting siren type 'None' back to 'Classic'.

### 18/10/2021
Applied changes from script version:
- Added stringtable support to allow the script to be translated. If you are willing to help translate the script into another language, contact me in my Discord!

### 09/10/2021
- Added compatibility for upcoming AIO mod.

### 25/07/2021
Applied changes from script version:
- Increased shelter check distance from 10m to 30m.

### 25/07/2021
Applied changes from script version:
- AI units can now be protected by whitelisted protection equipment the same as players.

### 20/07/2021
Applied changes from script version:
- Fixed some sounds playing at incorrect height when player is on buildings.
- Adjusted length of lightning flashes.
- Increased distance above head for roof check from 5m to 10m.

### 19/07/2021
Applied changes from script version:
- Adjusted update rate of emission lighting.
- Fixed dodgy loop code causing crash.
- Fixed bug where updating settings via ZEN module would break the map sweep wave.

### 18/07/2021
- Created mod version.
