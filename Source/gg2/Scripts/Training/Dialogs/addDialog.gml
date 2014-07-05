if(not justTalked) {
    var text, face, subFace, nextMsg;
    text = argument0;
    face = argument1;
    subFace = argument2;

    nextMsg = instance_create(0,0,DialogBoxMsg);
    nextMsg.text = text;
    nextMsg.face = face;
    nextMsg.subFace = subFace;

    ds_list_add(global.dialogList, nextMsg);

    justTalked = true;
    alarm[1] = 120;
}
