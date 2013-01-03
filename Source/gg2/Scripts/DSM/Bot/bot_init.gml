{
    global.botNameCounter = 1
    
    ini_open("bot.ini")
    
    global.botNumber = ini_read_real("Bots","Number",0)
    global.botClass[CLASS_SCOUT] = ini_read_real("Bots","RunnersOn",1)
    global.botClass[CLASS_PYRO] = ini_read_real("Bots","FirebugsOn",1)
    global.botClass[CLASS_SOLDIER] = ini_read_real("Bots","RocketmenOn",1)
    global.botClass[CLASS_HEAVY] = ini_read_real("Bots","OverweightsOn",1)
    global.botClass[CLASS_DEMOMAN] = ini_read_real("Bots","DemomenOn",1)
    global.botClass[CLASS_MEDIC] = ini_read_real("Bots","HealersOn",1)
    global.botClass[CLASS_ENGINEER] = ini_read_real("Bots","ConstructorsOn",1)
    global.botClass[CLASS_SPY] = ini_read_real("Bots","SpiesOn",1)
    global.botClass[CLASS_SNIPER] = ini_read_real("Bots","RiflemenOn",1)
    global.botClass[CLASS_QUOTE] = ini_read_real("Bots","QuotesOn",1)
    global.botNamePrefix = ini_read_string("Bots","NamePrefix","")
    
    ini_write_real("Bots","Number",global.botNumber)
    ini_write_real("Bots","RunnersOn",global.botClass[CLASS_SCOUT])
    ini_write_real("Bots","FirebugsOn",global.botClass[CLASS_PYRO])
    ini_write_real("Bots","RocketmenOn",global.botClass[CLASS_SOLDIER])
    ini_write_real("Bots","OverweightsOn",global.botClass[CLASS_HEAVY])
    ini_write_real("Bots","DemomenOn",global.botClass[CLASS_DEMOMAN])
    ini_write_real("Bots","HealersOn",global.botClass[CLASS_MEDIC])
    ini_write_real("Bots","ConstructorsOn",global.botClass[CLASS_ENGINEER])
    ini_write_real("Bots","SpiesOn",global.botClass[CLASS_SPY])
    ini_write_real("Bots","RiflemenOn",global.botClass[CLASS_SNIPER])
    ini_write_real("Bots","QuotesOn",global.botClass[CLASS_QUOTE])
    ini_write_string("Bots","NamePrefix",global.botNamePrefix)
    ini_close()
}
