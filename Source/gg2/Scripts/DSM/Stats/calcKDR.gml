if (global.statsKills!=0) and (global.statsDeaths!=0){
    global.kdr=string(round(global.statsKills/max(1,global.statsDeaths)*100)/100)
}
