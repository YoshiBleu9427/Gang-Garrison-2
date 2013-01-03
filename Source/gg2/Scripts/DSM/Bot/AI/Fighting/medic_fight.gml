//This describes the medic's behaviour; ubering, healing and fighting.
//Check the current healing target
//Out of sight or meet obstacle in the healing beam
if patient != -1{
    if point_distance(object.x, object.y, patient.x, patient.y)>300
    or collision_line(object.x, object.y, patient.x, patient.y, Obstacle, true, true) > 0
    or patient.cloak
    {
        patient = -1;
    }
}

if patient != object.currentWeapon.healTarget and isHealing{
    isHealing = 0
}

//target is dead
if patient == -1 and isHealing{
    isHealing=0;
}else if patient != -1 and !isHealing{
    // You've just chosen a new target
    isHealing = 1
}

//FINDING BEST TARGET//

with Character{
    if team == other.team and id!=other.object
    and distance_to_object(other.object) <= 300 //in range of healing
    and !cloak
    and (player.class != CLASS_MEDIC)
    and (!ubered or healer == other.id)
    and healer == -1 //Target is not healed
    {
        if other.patient == -1{ //No target yet, pick one
            other.patient = id;
            other.isHealing=0;
        }else{
            if ((hp/maxHp)*1.5 < (other.patient.hp/other.patient.maxHp) //I am more hurt (*1.5 to prevent switching target every step)
            or (other.patient.hp/other.patient.maxHp == 1 and hp < maxHp)) //They is fully healed
            and collision_line(other.object.currentWeapon.x, other.object.currentWeapon.y, x, y, Obstacle, true, true) <= 0
            {
                other.patient = id;
                other.isHealing=0;
                exit;
            }
        }
    }
}

if patient != -1{
    if isHealing{ // I'm supposed to heal
        aimDirection = point_direction(object.x,object.y,patient.x,patient.y);
        LMB = 1;
    }
}

//Moving
//I am not healing
if !isHealing{
    //There are no targets
    if patient == -1{
        //Enemies:
        if nearestEnemy!=-1 and !object.currentWeapon.ubering{
            if (point_distance(object.x,object.y,nearestEnemy.x,nearestEnemy.y)<350 or object.hp<=30)
            and !collision_line(object.x,object.y,nearestEnemy.x,nearestEnemy.y,Obstacle,true,true) //I can see them
            {
                if task != 'default'{
                    //Run away
                    if object.x > nearestEnemy.x
                        dir = 1;
                    if object.x < nearestEnemy.x
                        dir =- 1;
                }
                //Shooting
                if point_distance(object.x,object.y,nearestEnemy.x,nearestEnemy.y)<300
                and (collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,Obstacle,true,true)<0
                and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,TeamGate,true,true)<0
                and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,ControlPointSetupGate,true,true)<0
                and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,IntelGate,true,true)<0
                and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,BulletWall,true,true)<0)
                and !nearestEnemy.ubered
                {
                    RMB=1;
                }
            }
        }
    }
}

//Following the heal target
if patient != -1 and isHealing{
    if point_distance(object.x, object.y, patient.x, patient.y) < 150{ // 150 is random, it may need to be changed if it causes problems
        if task != 'default'{
            //Follow them
            if object.x > patient.x
                dir=-1;
            if object.x < patient.x
                dir=1;
        }
    }
    //An enemy is nearer
    if nearestEnemy != -1 and !object.currentWeapon.ubering{
        if point_distance(object.x,object.y,nearestEnemy.x,nearestEnemy.y)<=point_distance(object.x,object.y,patient.x,patient.y)+50{
            if task != 'default'{
                //Run away!
                if object.x > nearestEnemy.x
                    dir = 1;
                if object.x < nearestEnemy.x
                    dir =- 1;
            }

            if point_distance(object.x,object.y,nearestEnemy.x,nearestEnemy.y)<200
            and patient.hp >= 50
            and point_distance(object.x,object.y,nearestEnemy.x,nearestEnemy.y)<300
            and (collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,Obstacle,true,true)<0
            and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,TeamGate,true,true)<0
            and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,ControlPointSetupGate,true,true)<0
            and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,IntelGate,true,true)<0
            and collision_line(object.x,object.y,predictedEnemy_x,predictedEnemy_y,BulletWall,true,true)<0)
            and !nearestEnemy.ubered
            {
                RMB=1;
            }
        }
    }
}

//Ubering
//I am healing, and not ubering, and my ubercharge is ready, and not being ubering
if !object.currentWeapon.ubering and object.currentWeapon.uberReady and !object.ubered{
    //I am healing someone
    if isHealing{
        if patient.hp <= patient.maxHp/4 //My patient is going to die
        or object.hp <= object.maxHp/3 //Or me
        {
            LMB=1;
            RMB=1;
        }
    }
}
