var xoffset, yoffset, xsize, ysize, countdown, mode;
xoffset = argument0;
yoffset = argument1;
xsize = argument2;
ysize = argument3;
countdown = argument4;
teamoffset = argument5;
mode = argument6; // 0: normal, large; 1: normal, small; 2: outlined, small

if global.dsmHUDs==1{
    timerSprite=DSM_TimerS
}else{
    timerSprite=TimerS
}

draw_set_alpha(global.dsmHudOpacityReal)

if (mode == 0)
{
    if (overtime)
    {
        draw_set_halign(fa_center);
        draw_sprite_ext(TimerHudS,2+teamoffset,xoffset+xsize/2,yoffset+30,3,3,0,c_white,global.dsmHudOpacityReal);
        draw_text((xoffset+xsize/2)+xshift,yoffset+30+yshift,"OVERTIME");
    }
    else
    {
        draw_sprite_ext(TimerHudS,teamoffset,xoffset+xsize/2,yoffset+30,3,3,0,c_white,global.dsmHudOpacityReal);
        draw_set_halign(fa_right);
        draw_set_font(global.timerFont);
        
        if(global.setupTimer > 0 and instance_exists(ControlPointSetupGate))
        {
            draw_sprite_ext(timerSprite,floor(global.setupTimer/1800*12),xoffset+xsize/2+39,yoffset+30,3,3,0,c_white,global.dsmHudOpacityReal);
            var seconds, secstring;
            seconds = ceil(global.setupTimer/30);
            if (seconds >= 10)
                secstring = string(seconds);
            else
                secstring = "0" + string(seconds);
            draw_text_transformed(xoffset+xsize/2+20,yoffset+27,"0:" + secstring,1,1,0);
            draw_set_font(global.gg2Font);
            draw_set_halign(fa_center);
            draw_text_transformed(xoffset+xsize/2-3, yoffset+40,"Setup",         1,1,0);
        }
        else
        {
            draw_sprite_ext(timerSprite,floor(countdown/timeLimit*12),xoffset+xsize/2+39,yoffset+30,3,3,0,c_white,global.dsmHudOpacityReal);
            var time, minutes, secondcounter, seconds, secstring;
            secondcounter = ceil(countdown/30);
            minutes = secondcounter div 60;
            seconds = secondcounter mod 60;
            
            if (seconds >= 10)
                secstring = string(seconds);
            else
                secstring = "0" + string(seconds);
                
            draw_text_transformed(xoffset+xsize/2+20,yoffset+32,string(minutes) + ":" + secstring,1,1,0);
        }
        draw_set_font(global.gg2Font);
    }
}
else
{
    if (mode == 2)
        draw_sprite_ext(TimerOutlineS, 0, xoffset+xsize/2, yoffset, 2, 2, 0, c_white, global.dsmHudOpacityReal);
    draw_sprite_ext(TimerHudS, 2+teamoffset, xoffset+xsize/2+xshift, yoffset, 2,2,0,c_white,global.dsmHudOpacityReal);
    if (countdown <= 0)
    {
        draw_set_halign(fa_center);
        draw_text(xoffset+xsize/2+xshift,yoffset+2,"OVERTIME");
    }
    else
    {
        draw_set_halign(fa_right);
        var time, minutes, secondcounter, seconds, secstring;
        secondcounter = ceil(countdown/30);
        minutes = secondcounter div 60;
        seconds = secondcounter mod 60;
        draw_set_font(global.timerFont);
        
        if (seconds >= 10)
            secstring = string(seconds);
        else
            secstring = "0" + string(seconds);
            
        draw_text_transformed(xoffset+xsize/2+24, yoffset+2, string(minutes) + ":" + secstring, 1, 1, 0);
        draw_set_font(global.gg2Font);
    }
    
}
