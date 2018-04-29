var bestTarget, enemyDist;
bestTarget = noone;
enemyDist = seeRange;

aimDirection = 9001;

if (forceAim) {
    if (aimObject != noone) {
        if (instance_exists(aimObject)) {
            bestTarget = aimObject;
            aimDirection = point_direction(object.x, object.y, bestTarget.x, bestTarget.y);
            aimDistance = point_distance(object.x, object.y, bestTarget.x, bestTarget.y);
        } else {
            aimObject = noone;
            forceAim = false;
        }
    } else {
        forceAim = false;
    }
}

if(task == NPC_TASK_IDLE) {
    if (forceAim) exit;
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
    LMB = 1;
    if (forceAim) exit;
    
    if(dir == 1) aimDirection = 0;
    else        aimDirection = 1;
    exit;
}

// compute aimModifier based on time following a sine wave (modifierIntensity = a*sin(b*time))
timeRatio = current_time mod 1000;
timeToDeg = timeRatio / 1000 * 360;
positiveTimeModifier = (1 + sin(degtorad(timeToDeg))) / 2;
aimModifier += positiveTimeModifier * maxModifier;
aimModifier = aimModifier mod maxModifier;

// find a target to heal
if (class == CLASS_MEDIC) {
    var allyDist, allyHpRate;
    allyDist = 9001;
    allyHpRate = 1;
    
    // if your target hasn't been previously forced,
    // find the best ally to heal around you
    if (bestTarget == noone) {
        with(Character) {
            if(id != other.object)
            if(team == other.team) {
                if(collision_line(x,y, other.object.x, other.object.y, Obstacle, true, false) <= 0) {
                    var dist, hpRate;
                    dist = sqrt(sqr(x - other.object.x) + sqr(y - other.object.y));
                    hpRate = hp / maxHp;
                    if((dist/1000) + hpRate*2 < (allyDist/1000) + allyHpRate*2) {
                        allyDist = dist;
                        allyHpRate = hpRate;
                        bestTarget = id;
                    }
                }
            }
        }
    }
    
    // always healing
    LMB = 1;
    if(bestTarget != noone)
    if(bestTarget.player != object.currentWeapon.healTarget and object.currentWeapon.healTarget != noone) {
        // unless you're healing the wrong person
        LMB = 0;
    }
    
    // set direction
    // trigger uber if target needs it
    if(bestTarget != noone) {
        if(instance_exists(bestTarget)) {
            aimDirection = point_direction(object.x, object.y, bestTarget.x, bestTarget.y);
            aimDistance = point_distance(object.x, object.y, bestTarget.x, bestTarget.y);
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
            // UBER NOW
            LMB = 1;
            RMB = 1;
            exit;
        }
    }
    
    if(bestTarget != noone) {
        // got it all figured out already
        exit;
    }
}

// if you still don't have a target, aim for an enemy
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
    
}

// got nothing to shoot? Don't fire
if(bestTarget == noone) {
    RMB = 0;
    LMB = 0;
    if(defaultDir == -1) {
        aimDirection = (current_time / 1000 * 360) mod 360; // gunspin
    } else {
        aimDirection = defaultDir;
    }
// got your target? Good! Now press your mouse buttons to fire
} else {
    if(class == CLASS_MEDIC) {
        RMB = 1;
        LMB = 0;
    } else {
        LMB = 1;
    }
    aimDirection = point_direction(object.x, object.y, bestTarget.x, bestTarget.y);
    aimDistance = point_distance(object.x, object.y, bestTarget.x, bestTarget.y);
    if(bestTarget == global.myself.object) {
        event_user(1); // fire event
        alreadySeen = true;
        justSeen = 30;
    } else {
        justSeen = max(0, justSeen - 1);
    }
}

// aim randomizer
aimDirection += aimModifier - (maxModifier / 2); // if ang = 240 & mod = 30, go from 225 to 255


// aim compensation for curved projectiles
if (bestTarget != noone) {
    var xshift, compensationModifier;
    xshift = abs(bestTarget.x - object.x);
    compensationModifier = 0;
    switch(class) {
        case CLASS_SCOUT:
        case CLASS_ENGINEER:
        case CLASS_HEAVY:
        case CLASS_DEMOMAN:
        case CLASS_MEDIC:
            compensationModifier = 2 * sqrt(xshift / 8);
            break;
        case CLASS_SPY:
            compensationModifier = 0.8 * sqrt(xshift / 8);
            break;
        case CLASS_SOLDIER:
        case CLASS_SNIPER:
        case CLASS_PYRO:
        case CLASS_QUOTE:
            compensationModifier = 0;
            break;
    }
    // if aiming left, aimDirection must be decreased
    if(90 < aimDirection and aimDirection < 270) {
        aimDirection -= compensationModifier;
    }
    // if aiming right, aimDirection must be increased
    else {
        aimDirection += compensationModifier;
    }

    // if you're a rocketman about to shoot, and you're too close to your target to hit it, jump just before firing
    // and move slightly to the side, to make sure to increase the distance between the two of you
    if (class == CLASS_SOLDIER)
    if ((reloadCounter < 5) and (object.currentWeapon.alarm[0] < (5 / global.delta_factor)))
    if (LMB and (enemyDist < 30)) {
        jump = 1;
        if(object.x > bestTarget.x) {
            dir = -1;
        } else {
            dir = 1;
        }
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
    with(object.currentWeapon) {
        if(variable_local_exists("ammoCount")) {
            if(ammoCount >= maxAmmo) {
                reloadCounter = 0;
            }
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
            } else if(object_index == Flamethrower) {
                if(ammoCount < 5) {
                    other.reloadCounter = 4 * reloadBuffer;
                }
            } else if(object_index == Minigun) {
                if(ammoCount < 5) {
                    other.reloadCounter = 6 * reloadBuffer;
                }
            }
        }
    }
}
