var player;
player = argument0;

if(player.class == CLASS_ENGINEER
    and collision_circle(player.object.x, player.object.y, 50, Sentry, false, true) < 0
    and player.object.nutsNBolts == 100
    and (collision_point(player.object.x,player.object.y,SpawnRoom,0,0) < 0)
    and !player.sentry
    and !player.object.onCabinet)
{
    buildSentry(player, player.object.x, player.object.y, player.object.image_xscale);
}

