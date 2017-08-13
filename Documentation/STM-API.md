Solo Training Mod : Things you might want to know about scenarios
=====================

A scenario is defined by a npc file, which is just gml code. The npc file should have the same name as the map it is designed for (ie. arena_lumberyard.npc for arena_lumberyard.png)

## A quick example of NPC file


```GML
setPlayerTeam(TEAM_BLUE);
with(npcNext(120*6, 200*6)) {
    npcCreateObject(id, TEAM_RED, CLASS_SCOUT);
    npcSetTask(NPC_TASK_CHASE);
    
    npcEventAdd(NPC_EVENT_DEATH, '
        addDialogForce("I died", face, subFace, c_blue);
        gameOver();
    ');
}
```
The code above will put the player in the blue team, and create a red runner bot, at position 720;1200 in game (120;200 on the png file).
It will chase after the closest enemy, and when it dies, it will create a blue dialog box with its sprite, saying "I died", and trigger the Game Over animation. 

## Importing resources

Before executing the npc file for a given map, the mod will import resources from `\Maps\stm\(map name)\sprites\` and `\Maps\stm\(map name)\sounds\`.
These two folders should contain respectively gif files, and wav or mp3 files.

To access the automatically imported resources, use the ScenarioContext.sprites and ScenarioContext.sounds maps, using the filename as the map key:
```
// if your sprite filename is 'example.gif'
sprite = ds_map_find_value(ScenarioContext.sprites, 'example.gif');

// if your sound filename is 'music.wav'
music = ds_map_find_value(ScenarioContext.sounds, 'music.wav');
```

If you want to import png files to build your sprites, you will need to import them manually. Use the following:

```my_sprite = sprite_add(working_directory + "\Maps\stm\(map_name)\(sprite_filename).png", (nb of frames), (transparency), 0, (sprite width), (sprite_height));```

Note that the offset of the sprite defaults to the bottom middle of the image. If you want to change the offset, remember to use sprite_set_offset.
```
var sprite;
sprite = ds_map_find_value(ScenarioContext.sprites, "sprite.gif");
sprite_set_offset(sprite, sprite_get_width(sprite)/2, sprite_get_height(sprite)/2); // sets offset to the middle of the sprite
```


## More specifics


There are mostly two objects you want to care about: `NPC` and `EventManager`.


### The NPC object

NPC inherits Player. It represents a bot Player. Just like a Player, it has an object (Character), but also specific attributes that are used by its AI, such as seeRange, forcePath and maxModifier. See the NPC create event.

#### Tasks

A NPC has a task, which defines its behaviour. Tasks are the following:

- NPC_TASK_IDLE : do nothing, not even gunspin, never move.
- NPC_TASk_SPYCHECK : NOT IMPLEMENTED YET.
- NPC_TASK_CHASE: run after the closest enemy, even if not in sight (excluding invisible spies).
- NPC_TASK_CAMP: reach the closest NPCSniperSpot instance, and if class is Sniper, zoom in.
- NPC_TASK_PET: run after the closest ally, even if not in sight (excluding invisible spies). Will still fire at enemies.
- NPC_TASK_SENTRY: reach the closest NPCSentrySpot instance, and if class is Engineer, build a sentry there.
- NPC_TASK_STAY: do not move, but still fire at enemies.
- NPC_TASK_GOAL_OFFENSIVE: go for the objective (capture the enemy intel, capture the enemy point, attack the generator)
- NPC_TASK_GOAL_DEFENSIVE: defend the objective (defend the intel, the point, the generator)


#### Aim and movement

Movement is independant from aim. A bot may sometimes run after an enemy, but decide to shoot another.
Note that it is possible to force the bots to go to/aim for a specific instance.

`forceAim` will make the bot aim for a given instance (`aimObject`); but **it will not fire at it**.

`forcePath` will make the bot go to a given instance (`pathPoint`).

You can personalize NPC behaviour by adding events to their `step_begin` and `step_end` events. These events are erased after the map ends, so they're guaranteed to be clean and ready to use for a new scenario.
Since all npc input is handled in the GameServerBeginStep script, you can force all input to be whatever you want in the step_end event of the NPC.

#### NPC Events

NPC can have custom events for specific events, like intel grabbing, contact with player, or death. The list of NPC events is as follows:

- NPC_EVENT_DEATH : when the bot object dies
- NPC_EVENT_PLAYER_SEEN : when the player comes into view of the bot object
- NPC_EVENT_SENTRY_DOWN : when the sentry of the NPC is destroyed
- NPC_EVENT_KILL : when the bot object kills another Character, be it the player or another NPC
- NPC_EVENT_MEET : when the bot object gets in contact with the player's object
- NPC_EVENT_INTEL_GRAB : when the bot grabs the intel

To implement one of these, use npcEventAdd, like this:
```GML
with(npcNext(x, y)) {
    ...
    npcEventAdd(NPC_EVENT_DEATH, '
        yourScriptHere
    ');
}
```

#### Dialogs

The GameServer calls runDialogs() every step, which handles DialogBox creation, using a list of DialogBoxMsg: global.dialogList.
The list is used more like a queue.

To add dialogs, three functions are available:

- addDialog: to be called in a with(NPC) block. Adds the dialog if the NPC hasn't talked in the last 5 seconds (if(not justTalked)) 
- addDialogQueue: adds the dialog to the bottom of the dialogList
- addDialogForce: clears the dialogList and removes all previous dialogs before adding the given dialog

### The EventManager

Like NPCs, the EventManager has custom events, but it's mostly for the player. These events are:

- PLAYER_EVENT_INTEL_GRAB
- PLAYER_EVENT_INTEL_SCORE
- PLAYER_EVENT_DEATH

In addition to these player events, three custom events are available, to be triggered at will: 

- EVENT_CUSTOM_1
- EVENT_CUSTOM_2
- EVENT_CUSTOM_3

To trigger these, call `fireCustomEvent(1)`, `fireCustomEvent(2)` or `fireCustomEvent(3)`

#### Game Over

Just call `gameOver()` anywhere.


### Other Controllers

`CheatController` 

`NPCManager` counts how many NPC objects (not instances) have been created, both for the current map and in total.
When the npcNext script is called, the NPCManager checks if there is an already allocated NPC object available. If there isn't, it creates a new object.

This is useful for reusing objects instead of creating new ones every time a new NPC is needed. Which is why the NPC objects have to be cleaned.



