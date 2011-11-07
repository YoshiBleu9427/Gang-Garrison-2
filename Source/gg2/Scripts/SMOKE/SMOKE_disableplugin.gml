// argument0 - plugin id

if (ds_list_find_index(global.SMOKE_enabledpluginlist, argument0) != -1) {
    ds_list_delete(global.SMOKE_enabledpluginlist,
        ds_list_find_index(global.SMOKE_enabledpluginlist, argument0));
    SMOKE_saveconfig();
}
