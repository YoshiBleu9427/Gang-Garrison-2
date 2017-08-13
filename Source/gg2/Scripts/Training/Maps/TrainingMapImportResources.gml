/**
 *  Called in context of ScenarioContext, before the npc script is executed.
 *  Imports gifs, wavs and mp3s and puts them into a map.
 */

// borrowed file-search code from Port
var file, sprite, sound;
var prefix, prefixSprite, prefixSound, patternGif, patternWav, patternMp3;

// Prefix since results from file_find_* don't include path
prefix = working_directory + "\Maps\stm\" + global.currentMap;
prefixSprite = prefix + "\sprites\";
prefixSound = prefix + "\sounds\";
patternGif = prefixSprite + "*.gif";
patternWav = prefixSound + "*.wav";
patternMp3 = prefixSound + "*.mp3";

// Find files
for (file = file_find_first(patternGif, 0); file != ""; file = file_find_next())
{
    sprite = sprite_add(prefixSprite + file, 1, true, false, 0, 0);
    sprite_set_offset(sprite, sprite_get_width(sprite) / 2, sprite_get_height(sprite) - 1);
    ds_map_add(sprites, file, sprite);
}
for (file = file_find_first(patternWav, 0); file != ""; file = file_find_next())
{
    sound = sound_add(prefixSound + file, 0, 0);
    ds_map_add(sounds, file, sound);
}
for (file = file_find_first(patternMp3, 0); file != ""; file = file_find_next())
{
    sound = sound_add(prefixSound + file, 0, 0);
    ds_map_add(sounds, file, sound);
}

// need to reset these because otherwise they get free'd
sprite = noone;
sound = noone;
