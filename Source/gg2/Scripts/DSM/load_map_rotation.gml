	ds_list_clear(global.map_rotation);

    // if the user defined a valid map rotation file, then load from there

    if(global.mapRotationFile != "" && file_exists(global.mapRotationFile) && global.launchMap == "") {
        var fileHandle, i, mapname;
        fileHandle = file_text_open_read(global.mapRotationFile);
        for(i = 1; !file_text_eof(fileHandle); i += 1) {
            mapname = trim(file_text_read_string(fileHandle));
            if(mapname != "" and string_char_at(mapname, 0) != "#") { // if it's not blank and it's not a comment (starting with #)
                ds_list_add(global.map_rotation, mapname);
            }
            file_text_readln(fileHandle);
        }
        file_text_close(fileHandle);
    }
    
     else if (global.launchMap != "") && (global.dedicatedMode == 1)
        {  
        ds_list_add(global.map_rotation, global.launchMap);
        }
    
     else { // else load from the ini file Maps section
		ds_list_copy(global.map_rotation, global.ini_map_rotation);
    }
    
    var map, i;
    if (global.shuffleRotation) {
        if (global.shuffleRotation==3){
            randomiseRotation()
        }else{
            ds_list_shuffle(global.map_rotation);
            map = ds_list_find_value(global.map_rotation, 0);
            // "Shuffle, don't make arena map first" chosen
            if (global.shuffleRotation == 1) {
                // if first map is arena
                if (string_copy(map, 0, 6) == 'arena_') {
                    // try to find something else
                    for (i = 0; i < ds_list_size(global.map_rotation); i += 1) {
                        map = ds_list_find_value(global.map_rotation, i);
                        // swap with first map
                        if (string_copy(map, 0, 6) != 'arena_') {
                            ds_list_replace(global.map_rotation, i, ds_list_find_value(global.map_rotation, 0));
                            ds_list_replace(global.map_rotation, 0, map);
                        }
                    }
                }
            }
        }
    }
