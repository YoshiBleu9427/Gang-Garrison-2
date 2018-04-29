if(task == NPC_TASK_IDLE) {
    exit;
}

if (forcePath) {
    if (pathPoint != noone) {
        if (instance_exists(pathPoint)) {
            // TODO remove (and reorganise)
            // setting aim here doesnt make sense anymore
            // and these few lines can be made a lot more simple
            aimDirection = point_direction(object.x, object.y, pathPoint.x, pathPoint.y);
            aimDistance = point_distance(object.x, object.y, pathPoint.x, pathPoint.y);
        } else {
            pathPoint = noone;
            forcePath = false;
        }
    } else {
        forcePath = false;
    }
}

// failsafes
if(not instance_exists(pathPoint)) {
    pathPoint = noone;
} else {
    with(pathPoint) {
        // yeah, this happened. Don't ask me why or how
        if(not variable_local_exists("x")) {
            other.pathPoint = noone;
        }
    }
}

if(!forcePath) {
    // this sets the pathPoint
    npcFindPathPoint();
}

// additional task logic
switch(task) {
    case NPC_TASK_SPYCHECK:
    case NPC_TASK_CHASE:
    case NPC_TASK_PET:
    case NPC_TASK_GOAL_OFFENSIVE:
    case NPC_TASK_GOAL_DEFENSIVE:
    case NPC_TASK_STAY:
    case NPC_TASK_IDLE:
        // nothing
        break;
        
        
    case NPC_TASK_CAMP:
        if (class == CLASS_SNIPER) {
            with(object) {
                if(distance_to_object(other.pathPoint) < 40) {
                    if(not zoomed) {
                        toggleZoom(id);
                    }
                }
            }
        }
        break;
        
    case NPC_TASK_SENTRY:
        if (class == CLASS_ENGINEER) {
            with(object) {
                if(distance_to_object(other.pathPoint) < 40) {
                    if(player.sentry == noone) {
                        doEventBuildSentry(player);
                    }
                }
            }
        }
        break;
}


if(pathPoint != noone) {
    if(object.x - 18 > pathPoint.x) {
        reachedDestination = false;
        dir = -1;
    } else if(object.x + 18 < pathPoint.x) {
        reachedDestination = false;
        dir = 1;
    } else {
        if (not reachedDestination) {
            event_user(7); // NPC_EVENT_REACH_DEST
        }
        reachedDestination = true;
        dir = 0;
    }
}
    
npcAvoidObstacle();

oldX = object.x;
oldY = object.y;

//intel
if (object.intel) {
    if(task != NPC_TASK_GOAL_OFFENSIVE) {
        doEventDropIntel(id);
    }
}

