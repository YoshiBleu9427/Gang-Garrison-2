/**
 *  arg0 - map name
 *
 *  returns string the class name of the best hiscore
 */
 
var i, map, class, value, thisvalue, bestclass;
map = argument0;
ini_open('stm_scores.ini');

for (i = 0; i < 10; i+=1) {
    class = classname(i);
    thisvalue = ini_read_real(map, class, noone);
    if (thisvalue != noone) {
        if (value == noone) {
            value = thisvalue
            bestclass = class
        } else if (thisvalue < value) {
            value = thisvalue
            bestclass = class
        }
    }
}
ini_close();

return bestclass;
