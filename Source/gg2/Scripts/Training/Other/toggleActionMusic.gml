var activate;
activate = argument0;

activate &= (global.actionMusic != -1);

if(activate) {
    if(AudioControl.currentSong != global.actionMusic) {
        if(global.music == MUSIC_BOTH || global.music == MUSIC_INGAME_ONLY) {
            AudioControlPlaySong(global.actionMusic, true);
        }
    }
} else {
    if(AudioControl.currentSong != global.IngameMusic) {
        if(global.music == MUSIC_BOTH || global.music == MUSIC_INGAME_ONLY) {
            AudioControlPlaySong(global.IngameMusic, true);
        }
    }
}
