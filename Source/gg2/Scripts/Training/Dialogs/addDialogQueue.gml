// Adds the dialog even if the npc has just talked. Useful for briefings, etc
    var text, face, subFace, color, nextMsg;
    text = argument0;
    face = argument1;
    subFace = argument2;
    color = argument3;

    nextMsg = instance_create(0,0,DialogBoxMsg);
    nextMsg.text = text;
    nextMsg.face = face;
    nextMsg.subFace = subFace;
    nextMsg.color = color;

    ds_list_add(global.dialogList, nextMsg);

    justTalked = true;
    alarm[1] = 120 / global.delta_factor;
