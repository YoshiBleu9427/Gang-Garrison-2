// toggles the global mute on or off

if(AudioControl.allAudioMuted) {
    AudioControl.allAudioMuted = false;
    sound_global_volume(100);
    sound_global_volume(global.dsmVolume/100)
} else {
    AudioControl.allAudioMuted = true;
    sound_global_volume(0);
}
