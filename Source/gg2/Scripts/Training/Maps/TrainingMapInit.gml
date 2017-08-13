/**
 *  argument0 : path to npc file
 */

with(instance_create(0,0,ScenarioContext)) {
    TrainingMapImportResources();
    execute_file(argument0);
}
