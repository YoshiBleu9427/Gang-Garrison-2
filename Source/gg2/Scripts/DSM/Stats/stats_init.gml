ini_open("stats.gg2")
    global.statsTime=ini_read_real("Stats","Time",0)
    ini_write_real("Stats","Time",global.statsTime)
    
    global.statsGames=ini_read_real("Stats","Games",0)
    ini_write_real("Stats","Games",global.statsGames)
    
    global.statsWins=ini_read_real("Stats","Wins",0)
    ini_write_real("Stats","Wins",global.statsWins)
    
    global.statsLosses=ini_read_real("Stats","Losses",0)
    ini_write_real("Stats","Losses",global.statsLosses)
    
    global.statsPoints=ini_read_real("Stats","Points",0)
    ini_write_real("Stats","Points",global.statsPoints)
    
    global.statsKills=ini_read_real("Stats","Kills",0)
    ini_write_real("Stats","Kills",global.statsKills)
    
    global.statsDeaths=ini_read_real("Stats","Deaths",0)
    ini_write_real("Stats","Deaths",global.statsDeaths)
    
    global.statsAssists=ini_read_real("Stats","Assists",0)
    ini_write_real("Stats","Assists",global.statsAssists)
    
    global.statsDestruction=ini_read_real("Stats","Destruction",0)
    ini_write_real("Stats","Destruction",global.statsDestruction)
    
    global.statsCaps=ini_read_real("Stats","Caps",0)
    ini_write_real("Stats","Caps",global.statsCaps)
    
    global.statsDefences=ini_read_real("Stats","Defences",0)
    ini_write_real("Stats","Defences",global.statsDefences)
    
    global.statsInvulns=ini_read_real("Stats","Invulns",0)
    ini_write_real("Stats","Invulns",global.statsInvulns)
    
    global.statsHealing=ini_read_real("Stats","Healing",0)
    ini_write_real("Stats","Healing",global.statsHealing)
    
    global.statsStabs=ini_read_real("Stats","Stabs",0)
    ini_write_real("Stats","Stabs",global.statsStabs)
ini_close()

global.kdr=0
global.wlr=0
global.dsmInGameTime=0 //Recorded in minutes
global.displayTime=""
global.ratio=0
