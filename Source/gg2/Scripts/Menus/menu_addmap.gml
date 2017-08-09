var mapName, completed, shownName;
mapName = argument0;
completed = argument1;

if (completed) {
    shownName = "[X] " + mapName
} else {
    shownName = "[ ] " + mapName
}
menu_addlink(shownName, '
    global.currentMap = "' + mapName + '";
    global.gameServer = instance_create(0,0,GameServer);
');

