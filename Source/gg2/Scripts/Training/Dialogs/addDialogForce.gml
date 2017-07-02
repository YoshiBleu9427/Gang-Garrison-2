var text, face, subFace, color, nextMsg, i;
text = argument0;
face = argument1;
subFace = argument2;
color = argument3;

ds_list_clear(global.dialogList);
with(DialogBoxMsg) instance_destroy();
with(DialogBox) instance_destroy();

nextMsg = instance_create(0,0,DialogBoxMsg);
nextMsg.text = text;
nextMsg.face = face;
nextMsg.subFace = subFace;
nextMsg.color = color;

ds_list_add(global.dialogList, nextMsg);

with(NPC) {
    alarm[1] = 1;
}
