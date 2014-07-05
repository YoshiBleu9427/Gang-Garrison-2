/**
 * Spawn a player at a specific location.
 * If he already has a character object, destroy it
 * and respawn.
 *
 * argument0: The player who spawned
 * argument1: The spawnpoint x
 * argument2: The spawnpoint y
 */

var spawner, spawnX, spawnY, character;
spawner = argument0;
spawnX = argument1;
spawnY = argument2;


character = getCharacterObject(spawner.team, spawner.class);
if(character == -1) {
    show_message("Spawning a player did not succeed because his class and/or team were invalid.");
    exit;
}

if(spawner.object != -1) {
    with(spawner.object) {
        instance_destroy();
    }
    spawner.object=-1;
}

global.paramPlayer = spawner;
spawner.object = instance_create(spawnX,spawnY,character);
global.paramPlayer = noone;

if (instance_exists(RespawnTimer)) {
    with(RespawnTimer) {
        done = true;
    }
}

playsound(spawnX, spawnY, RespawnSnd);

