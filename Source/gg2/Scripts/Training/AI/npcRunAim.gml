if (forceAim) {
    if (aimObject != noone) {
        if (instance_exists(aimObject)) {
            aimDirection = point_direction(object.x, object.y, aimObject.x, aimObject.y);
            exit;
        }
    }
}

var bestTarget, enemyDist;
bestTarget = noone;
enemyDist = seeRange;
    
aimModifier += abs(sin(degtorad(180 - (current_time mod 360)))) * maxModifier;
aimModifier = aimModifier mod maxModifier;

if(task == NPC_TASK_IDLE) {
    var isLeft;
    if(global.myself.object != -1) {
        isLeft = (global.myself.object.x < object.x);
    } else {
        isLeft = true;
    }
    if(isLeft) aimDirection = 180;
    else       aimDirection = 0;
    exit;
}
if(task == NPC_TASK_SPYCHECK) {
    if(dir == 1) aimDirection = 0;
    else        aimDirection = 1;
    
    LMB = 1;
    exit;
}

aimDirection = 9001;

if(class == CLASS_MEDIC) {
    var allyDist, allyHpRate;
    allyDist = 9001;
    allyHpRate = 1;
    
    with(Character) {
        if(id != other.object)
        if(team == other.team) {
            if(collision_line(x,y, other.object.x, other.object.y, Obstacle, true, false) <= 0) {
                var dist, hpRate;
                dist = sqrt(sqr(x - other.object.x) + sqr(y - other.object.y));
                hpRate = hp / maxHp;
                if(dist * hpRate < allyDist * allyHpRate) {
                    allyDist = dist;
                    allyHpRate = hpRate;
                    bestTarget = id;
                }
            }
        }
    }
    
    LMB = 1;
    if(bestTarget != noone)
    if(bestTarget.player != object.currentWeapon.healTarget and object.currentWeapon.healTarget != noone) {
        LMB = 0;
    }
    if(bestTarget != noone) {
        if(instance_exists(bestTarget)) {
            aimDirection = point_direction(object.x, object.y, bestTarget.x, bestTarget.y);
            if (object.currentWeapon.uberReady) {
                if (bestTarget.hp < 50) {
                    LMB = 1;
                    RMB = 1;
                }
            }
        }
    }
    
    if (object.currentWeapon.uberReady) {
        if (object.hp < 40) {
            LMB = 1;
            RMB = 1;
        }
    }
    
}
if(aimDirection == 9001) {
    
    with(Character) {
        if(team != other.team) {
            var justUncloaked;
            justUncloaked = (uncloakTime < other.spyReactTime);
    
            if(not justUncloaked) {
                if(collision_line(x,y, other.object.x, other.object.y, Obstacle, true, false) <= 0) {
                    var dist;
                    dist = distance_to_object(other.object);
                    if(dist < enemyDist) {
                        enemyDist = dist;
                        bestTarget = id;
                    }
                }
            }
        }
    }
    
    with(Sentry) {
        if(team != other.team) {
            if(collision_line(x,y, other.object.x, other.object.y, Obstacle, true, false) <= 0) {
                var dist;
                dist = distance_to_object(other.object);
                if(dist < enemyDist) {
                    enemyDist = dist;
                    bestTarget = id;
                }
            }
        }
    }
    
    if(bestTarget == noone) {
        if(class == CLASS_MEDIC)
            RMB = 0;
        else
            LMB = 0;
        if(defaultDir == -1) {
            aimDirection = (current_time / 1000 * 360) mod 360; // gunspin
        } else {
            aimDirection = defaultDir;
        }
    } else {
        if(class == CLASS_MEDIC)
            RMB = 1;
        else
            LMB = 1;
        aimDirection = point_direction(object.x, object.y, bestTarget.x, bestTarget.y);
        if(bestTarget == global.myself.object) {
            event_user(1); // fire event
            alreadySeen = true;
            justSeen = 30;
        } else {
            justSeen = max(0, justSeen - 1);
        }
    }
}

aimDirection += aimModifier - (maxModifier / 2); // if ang = 240 & mod = 30, go from 225 to 255

if(bestTarget != noone) {
    // to curved projectiles: aim a little higher
    var xshift, modifier;
    xshift = abs(bestTarget.x - object.x);
    modifier = 0;
    switch(class) {
        case CLASS_SCOUT:
        case CLASS_ENGINEER:
        case CLASS_HEAVY:
        case CLASS_DEMOMAN:
            modifier = 2 * sqrt(xshift / 8);
            break;
        case CLASS_SPY:
            modifier = sqrt(xshift / 8);
            break;
        case CLASS_SOLDIER:
        case CLASS_SNIPER:
        case CLASS_MEDIC:
        case CLASS_PYRO:
        case CLASS_QUOTE:
            modifier = 0;
            break;
    }
    // if aiming left, aimDirection must be decreased
    if(90 < aimDirection and aimDirection < 270) {
        aimDirection -= modifier;
    }
    // if aiming right, aimDirection must be increased
    else {
        aimDirection += modifier;
    }
}

// save ammo if needed
if(reloadCounter > 0) {
    if(class == CLASS_MEDIC) {
        RMB = 0;
    } else {
        LMB = 0;
    }
    reloadCounter -= 1 * global.delta_factor;
    if(variable_local_exists("ammoCount")) {
        if(ammoCount >= maxAmmo) {
            reloadCounter = 0;
        }
    }
} else {

    with(object.currentWeapon) {
        if(variable_local_exists("ammoCount") and object_index != Rifle) {
            if(ammoCount <= 0) {
                if(variable_local_exists("reloadTime")) {
                    other.reloadCounter = 3 * reloadTime;
                }
                if(variable_local_exists("reloadBuffer")) {
                    other.reloadCounter += reloadBuffer;
                }
            } else if(object_index == Minigun or object_index == Flamethrower) {
                if(ammoCount < 5) {
                    other.reloadCounter = 4 * reloadBuffer;
                }
            }
        }
    }
}
