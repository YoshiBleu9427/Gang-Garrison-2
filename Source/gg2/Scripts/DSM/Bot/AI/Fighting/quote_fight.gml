// Quote fighting behavior
if (ds_list_empty(directionList) or task != 'default') and target_in_sight{
    dir = sign(nearestEnemy.x-object.x)

    if abs(nearestEnemy.x-object.x) < 41{
        dir = 1
    }
}

if dir == 0{
    dir = 1
}
// Fire blades
if(collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,Obstacle,true,true)<0
    and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,TeamGate,true,true)<0
    and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,ControlPointSetupGate,true,true)<0
    and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,IntelGate,true,true)<0
    and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,BulletWall,true,true)<0
    and point_distance(object.x,object.y,predictedEnemy_x,predictedEnemy_y) < 165)
{
    RMB = 1
}

//Bubbling
if RMB == 0 or point_distance(object.x,object.y,predictedEnemy_x,predictedEnemy_y) > 165{
    LMB = 1
}
