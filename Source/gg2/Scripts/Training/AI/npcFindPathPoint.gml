/**
 *  To be called in context of NPC
 *  Sets pathPoint
 */

switch(task) {
    case NPC_TASK_SPYCHECK:
        var boundLeft, boundRight, boundLeftFound, boundRightFound, groundY;
        boundLeft = x;
        boundRight = x;
        groundY = y;
        while(collision_point(x, groundY, Obstacle, false, false) <= 0) {
            groundY += 6;
        }
        while((boundLeft > x-80) and (not boundLeftFound)) {
            boundLeft -= 6;
            if (collision_point(boundLeft, groundY, Obstacle, false, false) > 0) {
                boundLeftFound = true;
            }
        }
        while((boundRight < x+80) and (not boundRightFound)) {
            boundRight += 6;
            if (collision_point(boundRight, groundY, Obstacle, false, false) > 0) {
                boundRightFound = true;
            }
        }
        if(pathPoint == noone) {
            pathPoint = instance_create(boundLeft, groundY, Point);
        } else {
            if((object.x + 18 < boundLeft) or (object.x - 18 > boundRight)) {
                if(pathPoint.x < x) {
                    pathPoint = instance_create(boundLeft, groundY, Point);
                } else {
                    pathPoint = instance_create(boundRight, groundY, Point);
                }
            }
        }
        break;
        
    case NPC_TASK_CHASE:
        var closest, closestDist;
        closestDist = 9001;
        closest = object;
        with(Character) {
            if(team != other.team) {
                var justUncloaked;
                justUncloaked = (uncloakTime < other.spyReactTime);
    
                if(not justUncloaked) {
                    var dist;
                    dist = sqrt(sqr(x - other.object.x) + sqr(y - other.object.y));
                    if(dist < closestDist) {
                        closestDist = dist;
                        closest = id;
                    }
                }
            }
        }
        pathPoint = closest;
        break;
        
    case NPC_TASK_CAMP:
        var closest;
        closest = instance_nearest(object.x, object.y, NPCSniperSpot);
        if(closest == noone || closest <= 0) {
            closest = object;
        }
        pathPoint = closest;
        break;
        
    case NPC_TASK_PET:
        var closest, closestDist;
        closestDist = 9001;
        closest = object;
        with(Character) {
            if(not cloak)
            if(id != other.object)
            if(team == other.team) {
                var dist;
                dist = sqrt(sqr(x - other.object.x) + sqr(y - other.object.y));
                if(dist < closestDist) {
                    closestDist = dist;
                    closest = id;
                }
            }
        }
        pathPoint = closest;
        break;
        
    case NPC_TASK_SENTRY:
        var closest;
        closest = instance_nearest(object.x, object.y, NPCSentrySpot);
        if(closest == noone || closest <= 0) {
            closest = object;
        }
        pathPoint = closest;
        break;
        
    case NPC_TASK_GOAL_OFFENSIVE :
        pathPoint = npcGetObjective(false);
        break;
        
    case NPC_TASK_GOAL_DEFENSIVE :
        pathPoint = npcGetObjective(true);
        break;
        
    case NPC_TASK_STAY:
    case NPC_TASK_IDLE:
        pathPoint = object;
        break;
}

// don't know where to go? Stay here.
if(pathPoint == noone) {
    pathPoint = object;
}