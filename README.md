# Mario Kart DS Custom HUD Lua

## About and Features

This is a package of Lua scripts which can be used to draw a custom Mario Kart DS HUD using @mkdasher's [DeSmuME WiDeScreen Edition](https://github.com/mkdasher/desmume-widescreen).
The scripts support the following versions of the game:
- USA Region
- EUR Region
- JPN Region
- CTGP Nitro 1.0.0

The custom displays implemented in these scripts are:
- Boost Bar (with different colors between Mini-Turbo and PRB / Mushroom boosts)
- Unstretched Final Time / Lap Splits in Widescreen
- Input Display
- Unstretched Item Roulette in Widescreen (only supports (Triple / Double) Mushroom(s))
- Unstretched Lap Counter in Widescreen.
- Speedometer.
- Unstretched Timer in the main screen.

The custom displays can be mixed with the normal displays too.
The scripts also come with some useful Action Replay codes. They are:
- Always 100cc by Unknown (EUR, USA, JPN) and @Pikalex04 (CTGP-N)
- Always Global Map by @Garhoogin (EUR) and @Pikalex04 (USA, JPN, CTGP-N)
- Disable Music by Davidevgen (USA) and @Pikalex04 (EUR, JPN, CTGP-N)
- Force Finish Race by @Pikalex04 (all versions)
- Live Ghost by Unknown (EUR, USA) and @Pikalex04 (JPN, CTGP-N)
- No Ghost Flickering by @Pikalex04 (all versions)
- Replay Camera by Davidevgen (only for EUR)
- Unlock Everything by Unknown (all versions)
- Widescreen by Davidevgen (EUR, USA, CTGP-N) and Unknown (JPN)

A couple of further settings are also included:
- Disable or enable Input Display outside of a race
- Green-screen the touchscreen
- Display the inputs of a ghost, instead of a player
- Show decimals in the speedometer
- Show slash in kmh
- Show the "TIME" and "LAP" labels in the final time / lap splits
- Show the "TIME" label in the timer
- Ability to fade in and out the screen

All of these settings can be selected through a User-Interace menu on the touch screen.
To interact with the menu, you need to right-click on the buttons.
From the menu, you can switch between the "HUD Editing" and the "Action Replay Codes" settings, and also edit the placements of each display.
You can also save what settings you selected, so that you do not have to re-select each setting every time you want to record a run.
The menu can be hidden too, in case you need to record the touch screen. To enable it again, you can right-click on the touch screen.

## Getting Started

### Prerequisites
The scripts only work with @mkdasher's WiDeScreen Edition of DeSmuME.
So please, download it from [here](https://github.com/mkdasher/desmume-widescreen/releases).

### Setup
Make an empty folder, then move the files of the Custom HUD to that folder. Place the folder inside the "lua" folder of DeSmuME.

## Usage
Open DeSmuME and load a supported version of MKDS. Then go to Tools > Lua Scripting > New Lua Script Window and press the "Browse..." button on the newly opened Window.
Browse and find the folder you previously made and select "hud_script2.lua".
The Custom HUD Menu should now appear in the touch screen.
To record, go to File > Record AVI, and select the directory where the recordings will be saved.
For the video compression, we recommend to use the [Lagarith Lossless Video Codec](https://lags.leetcode.net/codec.html), as it is able to compress video files without losing any quality and almost any performance.

## TODO
- [ ] Add support for the KOR version of the game
- [ ] Add a display for the charge state of a Mini-Turbo, like in @Pikalex04's [Custom HUD](https://youtu.be/obHtsaGyUxM)
- [ ] Add a display for airborne state, like in @Pikalex04's [Custom HUD](https://youtu.be/obHtsaGyUxM)
- [ ] Add an option to use realspeed instead of kart-speed
- [ ] Separate Mushroom boost and PRB boost

## Contact and Links
You can contact me on Discord (Pikalex04#8877) or on Twitter (@pikalex04).
To get support, I recommend you to join [Mario Kart DS Network](https://discord.gg/pa9bea6).

## Credits
- @mkdasher, for the base HUD scripts.
- @Pikalex04, for CTGP Nitro support and the addition of several Action Replay codes.
- @Garhoogin and Davidevgen for some Action Replay codes.
