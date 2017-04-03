//if instance_exists(WinBanner)
//    exit;
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
if global.boxHUD==0{
    //red timer HUD
    draw_generictimer(xoffset-coffset+xshift, yoffset+36,        xsize, ysize, redTimer,  0, 1+(KothBlueControlPoint.team == TEAM_RED) );
    //blue timer HUD    
    draw_generictimer(xoffset+coffset+xshift, yoffset+36+yshift, xsize, ysize, blueTimer, 1, 1+(KothRedControlPoint.team == TEAM_BLUE));
}else{
    //red timer HUD
    draw_boxGenericTimer(xoffset-coffset+xshift, yoffset+yshift,        xsize, ysize, redTimer,  0, 1+(KothBlueControlPoint.team == TEAM_RED) );
    //blue timer HUD    
    draw_boxGenericTimer(xoffset+coffset+xshift, yoffset+yshift, xsize, ysize, blueTimer, 1, 1+(KothRedControlPoint.team == TEAM_BLUE));
}