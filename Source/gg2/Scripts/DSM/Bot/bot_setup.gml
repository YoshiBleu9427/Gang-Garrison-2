pressed = 0
target = -1
aimModifier = 0
isHealing = 0
patient = -1
cloaking = 0

if variable_local_exists("directionList"){
    ds_list_clear(directionList)
}else{
    directionList = ds_list_create()
}

wasFighting = 0
dir = 1
stuckTimer = 0
oldX = 0
oldY = 0
reloadCounter = 0

// tasks possible: default, doesn't have any special properties, it just accounts for everything.
task = "default"
