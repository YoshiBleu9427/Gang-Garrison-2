var classList;

classList = ds_list_create()

if global.botClass[CLASS_SCOUT]{
    ds_list_add(classList, CLASS_SCOUT)
}
if global.botClass[CLASS_PYRO]{
    ds_list_add(classList, CLASS_PYRO)
}
if global.botClass[CLASS_SOLDIER]{
    ds_list_add(classList, CLASS_SOLDIER)
}
if global.botClass[CLASS_HEAVY]{
    ds_list_add(classList, CLASS_HEAVY)
}
if global.botClass[CLASS_DEMOMAN]{
    ds_list_add(classList, CLASS_DEMOMAN)
}
if global.botClass[CLASS_MEDIC]{
    ds_list_add(classList, CLASS_MEDIC)
}
if global.botClass[CLASS_ENGINEER]{
    ds_list_add(classList, CLASS_ENGINEER)
}
if global.botClass[CLASS_SPY]{
    ds_list_add(classList, CLASS_SPY)
}
if global.botClass[CLASS_SNIPER]{
    ds_list_add(classList, CLASS_SNIPER)
}
if global.botClass[CLASS_QUOTE]{
    ds_list_add(classList, CLASS_QUOTE)
}

if ds_list_empty(classList){
    argument0.class = CLASS_QUOTE
    show_message("No avaliable classes.#Quote selected.")
    return 1
}

argument0.class = ds_list_find_value(classList, random_range(0, ds_list_size(classList)))

return argument0.class
