// argument0 - plugin id

var file;

file_find_first(global.SMOKE_plugindirpath+argument0+"\*", 0);
while (1) {
    file = file_find_next();
    if (file != "") {
        file_delete(file);
    }
}
if (ds_list_find_index(global.SMOKE_pluginlist, argument0) != -1) {
    ds_list_delete(global.SMOKE_pluginlist,
        ds_list_find_index(global.SMOKE_pluginlist, argument0));
    SMOKE_saveconfig();
}
