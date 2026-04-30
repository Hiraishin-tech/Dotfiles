## For OBS-studio:
To fix screen capture not showing to these steps:
1. Add in ~/.local/bin/sway this:
#!/bin/bash
export XDG_CURRENT_DESKTOP=sway
exec /usr/bin/sway "$@"

~/.local/bin/ should be in the $PATH variable

2. Ensure you have installed those packages:
pipewire
wireplumber (or pipewire-media-session)
xdg-desktop-portal
xdg-desktop-portal-wlr

3. That's it now the screen capture (PipeWire) option should be in the sources.

### To fix the audio issue:
In the Settings -> Audio section set to Disabled everything in Global Audio
Devices and in the sources add 'Audio Output Capture (PulseAudio)'

### For the keybinds to start and stop recording:
Add to the ~/.local/bin/ the OBS websocket password. The password is in the
tools -> Websocket server settings -> Show Connect Info. Don't forget to Enable
Websocket server and Enable Authentication. 
The name of the file in ~/.local/bin/ should be obs-websocketPassword but you can change the name of the file in sway
config and in the ~/.local/bin/ if you want.

## 4. For alt-tab behaviour:
Install sway-alttab from https://github.com/autolyticus/sway-alttab
Software can be installed via cargo, it will be then located at ~/.cargo/bin/sway-alttab
