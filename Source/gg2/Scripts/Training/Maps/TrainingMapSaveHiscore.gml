var map, time, class, prevScore;
map = global.currentMap;
time = GameServer.frame;
class = classname(global.myself.class);

prevScore = TrainingMapGetHiscore(map, global.myself.class);
if (prevScore == noone) {
    prevScore = time + 1;
}
if (time < prevScore) {
    // do save
    ini_open('stm_scores.ini');
    ini_write_real(map, class, time);
    ini_close();
}
