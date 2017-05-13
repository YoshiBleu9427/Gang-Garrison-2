if (global.statsWins!=0) and (global.statsLosses!=0){
    global.wlr=string(round(global.statsWins/max(1,global.statsLosses)*100)/100)
}
