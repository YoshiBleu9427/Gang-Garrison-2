// This script describes the behavior during fighting in close to medium combat.
// Charge at everything except Pyros, Heavies and Quotes.
if (ds_list_empty(directionList) or task != 'default') and target_in_sight{
    if nearestEnemy.object_index == Character{
        if nearestEnemy.player.class != CLASS_PYRO and nearestEnemy.player.class != CLASS_HEAVY and nearestEnemy.player.class != CLASS_QUOTE{
            dir = sign(predictedEnemy_x-object.x)
        }
    }else{
        dir = sign(predictedEnemy_x-object.x)
    }
}

if dir == 0{
    dir = 1
}

if(collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,Obstacle,true,true)<0
    and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,TeamGate,true,true)<0
    and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,ControlPointSetupGate,true,true)<0
    and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,IntelGate,true,true)<0
    and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,BulletWall,true,true)<0)
{
    LMB = 1
}
