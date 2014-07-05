var nbMsg;
nbMsg = ds_list_size(global.dialogList);
if(!instance_exists(DialogBox)) {
    if(nbMsg > 0) {
        var nextMsg, newBox;
        nextMsg = ds_list_find_value(global.dialogList, 0);
        ds_list_delete(global.dialogList, 0);
        newBox = instance_create(0,0,DialogBox);
        with(newBox) {
            dialogMsg = nextMsg;
        }
    }
}
