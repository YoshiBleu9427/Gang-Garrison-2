if (global.statsKills!=0) and (global.statsDeaths!=0){
    var k, d;
    k=(global.statsKills+global.myself.stats[KILLS])
    d=(global.statsDeaths+global.myself.stats[DEATHS])
    global.kdr=string(round(k/max(1,d)*100)/100)
}
