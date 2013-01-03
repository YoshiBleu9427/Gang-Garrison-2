// This script describes the behavior during fighting in close to medium combat.
// Always follow the movements of your opponent.
if (ds_list_empty(directionList) or task != 'default') and target_in_sight{
    dir = sign(nearestEnemy.hspeed)
    if dir == 0{
        dir = 1
    }
}

    if cloaking==0 RMB = 1

    if RMB == 1{
        cloaking=1
    }

    if(collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,Obstacle,true,true)<0
        and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,TeamGate,true,true)<0
        and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,ControlPointSetupGate,true,true)<0
        and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,IntelGate,true,true)<0
        and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,BulletWall,true,true)<0)
    {
        LMB = 1
    }
    if collision_circle(object.x,object.y,100,nearestEnemy,false,true) and cloaking == 1{
        LMB = 1
    }
