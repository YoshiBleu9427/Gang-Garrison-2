/**
 *  arg0 - map name
 *  [arg1] - class name (if noone, checks hiscore exists for any class)
 *
 *  returns boolean (true if hiscore exists for given map; false otherwise)
 */
 
var i, map, class, value;
map = argument0;
ini_open('stm_scores.ini');

if (argument1 == noone) {
    for (i = 0; i < 10; i+=1) {
        class = classname(i);
        value = ini_read_real(map, class, noone);
        if (value != noone) {
            break;
        }
    }
} else {
    class = classname(argument1);
    value = ini_read_real(map, class, noone);
}
ini_close();

return (value != noone);
