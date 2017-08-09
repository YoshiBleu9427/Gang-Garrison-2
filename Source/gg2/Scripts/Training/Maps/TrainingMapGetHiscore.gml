/**
 *  arg0 - map name
 *  [arg1] - class name (if noone, checks hiscore exists for any class)
 *
 *  returns real the value of hiscore for given map and class
 */
 
var i, map, class, value, thisvalue;
map = argument0;
ini_open('stm_scores.ini');

if (argument1 == noone) {
    for (i = 0; i < 10; i+=1) {
        class = classname(i);
        thisvalue = ini_read_real(map, class, noone);
        if (thisvalue != noone) {
            if (value == noone) {
                value = thisvalue
            } else if (thisvalue < value) {
                value = thisvalue
            }
        }
    }
} else {
    class = classname(argument1);
    value = ini_read_real(map, class, noone);
}
ini_close();

return value;
