var defending;
defending = argument0;

if(instance_exists(ArenaControlPoint)) {
    return instance_nearest(object.x, object.y, ArenaControlPoint);
}

if(instance_exists(IntelligenceBase)) {
    var intelObj;
    intelObj = noone;
    if((team == TEAM_RED and defending) or (team == TEAM_BLUE and !defending)) {
        intelObj = instance_nearest(object.x, object.y, IntelligenceRed);
        // if the intel is carried
        if(intelObj == noone || intelObj == -1) {
            with(Character) {
                if(intel) {
                    if(defending) {
                        if(team != other.team) {
                            intelObj = id;
                        }
                    } else {
                        if(team == other.team) {
                            intelObj = id;
                        }
                    }
                }
            }
        }
        // if the intel was not dropped somewhere
        if(intelObj == noone || intelObj == -1) {
            intelObj = instance_nearest(object.x, object.y, IntelligenceBaseRed);
        }
    }
    if((team == TEAM_BLUE and defending) or (team == TEAM_RED and !defending)) {
        intelObj = instance_nearest(object.x, object.y, IntelligenceBlue);
        // if the intel is carried
        if(intelObj == noone || intelObj == -1) {
            with(Character) {
                if(intel) {
                    if(defending) {
                        if(team != other.team) {
                            intelObj = id;
                        }
                    } else {
                        if(team == other.team) {
                            intelObj = id;
                        }
                    }
                }
            }
        }
        // if the intel was not dropped somewhere
        if(intelObj == noone || intelObj == -1) {
            intelObj = instance_nearest(object.x, object.y, IntelligenceBaseBlue);
        }
    }
    // if I have the intel, I have to carry it back to my base
    if(object.intel) {
        if(team = TEAM_RED) {
            intelObj = instance_nearest(object.x, object.y, IntelligenceBaseRed);
        }
        if(team = TEAM_BLUE) {
            intelObj = instance_nearest(object.x, object.y, IntelligenceBaseBlue);
        }
    }
    return intelObj;
}


if(instance_exists(Generator)) {
    if((team == TEAM_RED and defending) or (team == TEAM_BLUE and !defending)) {
        return instance_nearest(object.x, object.y, GeneratorRed);
    }
    if((team == TEAM_BLUE and defending) or (team == TEAM_RED and !defending)) {
        return instance_nearest(object.x, object.y, GeneratorBlue);
    }
}


if(instance_exists(ControlPoint)) {
    var chosenCp;
    chosenCp = noone;
    // check first all cps that are yours
    // so that if none of them is, you don't stand still, but attack another point
    if(defending) {
        with(ControlPoint) {
            if(not locked) {
                if(team == other.team) {
                    chosenCp = id;
                }
            }
        }
    }
    if(chosenCp == noone) {
        with(ControlPoint) {
            if(not locked) {
                if(team != other.team) {
                    chosenCp = id;
                }
            }
        }
    }
    return chosenCp;
}
