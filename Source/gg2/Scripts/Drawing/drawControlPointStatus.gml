// Global "parameters":
// global.totalControlPoints
// global.cp[]

var cpUnlock, xoffset, yoffset, xsize, ysize, drawx;

cpUnlock = argument0;

xoffset = view_xview[0];
yoffset = view_yview[0];
xsize = view_wview[0];
ysize = view_hview[0];

drawx = xoffset+xsize/2 - (global.totalControlPoints - 1)/2*60;

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_alpha(1);
//DSM
draw_set_alpha(global.dsmHudOpacityReal)

for (i=1; i<= global.totalControlPoints; i+=1)
{
    var teamoffset;
    if (global.cp[i].team == TEAM_RED)
        teamoffset = 60;
    else if (global.cp[i].team == TEAM_BLUE)
        teamoffset = 90;
    if (global.cp[i].cappingTeam == TEAM_RED and global.cp[i].team == -1)
        teamoffset = 30;
    else if (global.cp[i].cappingTeam != TEAM_RED and global.cp[i].team == -1)
        teamoffset = 0;

    if (global.cp[i].capping != 0)
    {
        draw_sprite_ext(ControlPointStatusS, teamoffset+floor(global.cp[i].capping/global.cp[i].capTime*30), drawx, yoffset+ysize-40, 3, 3, 0, c_white, 1);
        if global.dsmHUDs==1{
            var cpCapPercent;
            cpCapPercent = string(floor(global.cp[i].capping/global.cp[i].capTime*100)) + "%"
            draw_set_halign(fa_center)
            draw_set_valign(fa_center)
            draw_set_color(c_black)
            draw_text_transformed(drawx, yoffset+572, cpCapPercent,1,1,0)
        }
    }
    else if (global.cp[i].capping == 0)
        draw_sprite_ext(ControlPointStatusS, teamoffset, drawx, yoffset+ysize-40, 3, 3, 0, c_white, 1);
    if (global.cp[i].locked)
    {
        if global.dsmHUDs==1{
            draw_set_halign(fa_center)
            if cpUnlock >= 1 draw_sprite_ext(ControlPointLockS, 0, drawx, yoffset+ysize-40, 3, 3, 0, c_white, global.dsmHudOpacityReal)
            draw_set_valign(fa_center)
            if cpUnlock >= 1800 {} //To prevent display problems at server join and during set-up
            else if ceil(cpUnlock/30) > 5 draw_text_transformed(drawx, yoffset+ysize-38, ceil(cpUnlock/30), 1.0, 1.0, 0);
            else if ceil(cpUnlock/30) <= 5 draw_text_transformed(drawx, yoffset+ysize-38, ceil(cpUnlock/30), 3,3, 0);
        }else{
            if (cpUnlock >= 150 or cpUnlock == 0)
                draw_sprite_ext(ControlPointLockS, 0, drawx, yoffset+ysize-40, 3, 3, 0, c_white, 1);
            else if (cpUnlock > 0)
                draw_text_transformed(drawx+2, yoffset+ysize-38, ceil(cpUnlock/30), 3, 3, 0);
        }
    }
    else if (global.cp[i].cappers > 0 and not global.cp[i].locked)
    {
        if global.dsmHUDs==1{
            draw_sprite_ext(ControlPointCappersS, 0, drawx, yoffset+ysize-45, 3, 3, 0, c_white, global.dsmHudOpacityReal);
            draw_set_halign(fa_center);
            draw_set_color(c_black);
            draw_text_transformed(drawx+13, yoffset+ysize-43, string(global.cp[i].cappers),1.5,1.5,0);
        }else{
            draw_sprite_ext(ControlPointCappersS, 0, drawx, yoffset+ysize-40, 3, 3, 0, c_white, 1);
            draw_set_color(c_black);
            draw_text_transformed(drawx+13, yoffset+ysize-38, string(global.cp[i].cappers), 1.5, 1.5, 0);
        }    
    }
    drawx += 60;
}
