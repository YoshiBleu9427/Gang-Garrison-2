ini_open("ES.ini")
    global.RCONAllowed=ini_read_real("s","RCONAllowed",0)
    ini_write_real("s","RCONAllowed",global.RCONAllowed)
    
    global.RCONPassword=ini_read_string("s","RCONPassword","")
    ini_write_string("s","RCONPassword",global.RCONPassword)
    
    global.writeConsoleLog=ini_read_real("s","WriteConsoleLog",0)
    ini_write_real("s","WriteConsoleLog",global.writeConsoleLog)
    
    global.writeChatLog=ini_read_real("s","WriteChatLog",0)
    ini_write_real("s","WriteChatLog",global.writeChatLog)
    
    global.showPing=ini_read_real("s","ShowPing",1)
    ini_write_real("s","ShowPing",global.showPing)
    
    global.showFPS=ini_read_real("s","ShowFPS",1)
    ini_write_real("s","ShowFPS",global.showFPS)
    
    global.borderless=ini_read_real("s","Borderless",0)
    if global.borderless==1{
        window_set_showborder(0)
        window_set_showicons(0)
    }else if global.borderless==0{
        window_set_showborder(1)
        window_set_showicons(1)
    }
    ini_write_real("s","Borderless",global.borderless)
    
    global.killLogItems=ini_read_real("s","KillLogItems",5)
    ini_write_real("s","KillLogItems",global.killLogItems)
    
    global.killLogTime=ini_read_real("s","KillLogTime",5)
    ini_write_real("s","KillLogTime",global.killLogTime)
    
    global.volume=ini_read_real("s","Volume",80)
    sound_global_volume(global.volume/100)
    ini_write_real("s","Volume",global.volume)
    
    global.fastBodyFade=ini_read_real("s","FastBodyFade",0)
    ini_write_real("s","FastBodyFade",global.fastBodyFade)
    
    global.healTargetArrow=ini_read_real("s","HealTargetArrow",1)
    ini_write_real("s","HealTargetArrow",global.healTargetArrow)
    
    global.hpTextPos=ini_read_real("s","HPTextPos",1)
    ini_write_real("s","HPTextPos",global.hpTextPos)
    
    global.autoStart=ini_read_real("s","AutoStart",0)
    ini_write_real("s","AutoStart",global.autoStart)
    
    global.drawHPHUD=ini_read_real("s","DrawHPHUD",1)
    ini_write_real("s","DrawHPHUD",global.drawHPHUD)
    
    global.drawAmmoHUD=ini_read_real("s","DrawAmmoHUD",1)
    ini_write_real("s","DrawAmmoHUD",global.drawAmmoHUD)
    
    global.adcpStopwatch=ini_read_real("s","ADCPStopwatch",1)
    ini_write_real("s","ADCPStopwatch",global.adcpStopwatch)
    
    global.arenaRoundsToWin=ini_read_real("s","ArenaRoundsToWin",5)
    ini_write_real("s","ArenaRoundsToWin",global.arenaRoundsToWin)
    
    global.noShells=ini_read_real("s","NoShells",0)
    ini_write_real("s","NoShells",global.noShells)
    
    global.damageIndicator=ini_read_real("s","DamageIndicator",1)
    ini_write_real("s","DamageIndicator",global.damageIndicator)
    
    global.useCustomHaxxyColor=ini_read_real("s","UseCustomHaxxyColor",0)
    ini_write_real("s","UseCustomHaxxyColor",global.useCustomHaxxyColor)
    
    global.haxxyColorSelection=ini_read_real("s","HaxxyColorSelection",0)
    ini_write_real("s","HaxxyColorSelection",global.haxxyColorSelection)
    
    global.myHaxxyColorR=ini_read_real("s","MyHaxxyColorR",255)
    ini_write_real("s","MyHaxxyColorR",global.myHaxxyColorR)
    
    global.myHaxxyColorG=ini_read_real("s","MyHaxxyColorG",255)
    ini_write_real("s","MyHaxxyColorG",global.myHaxxyColorG)
    
    global.myHaxxyColorB=ini_read_real("s","MyHaxxyColorB",255)
    ini_write_real("s","MyHaxxyColorB",global.myHaxxyColorB)
    
    global.autoCast=ini_read_real("s","AutoCast",0)
    if global.autoCast==1{
        global.isCasting=1
    }else{
        global.isCasting=0
    }
    ini_write_real("s","AutoCast",global.autoCast)
    
    global.smallTimer=ini_read_real("s","SmallTimer",0)
    ini_write_real("s","SmallTimer",global.smallTimer)
    
    global.smallSelectMenu=ini_read_real("s","SmallSelectMenu",0)
    ini_write_real("s","SmallSelectMenu",global.smallSelectMenu)
    
    global.pingGraph=ini_read_real("s","PingGraph",0)
    ini_write_real("s","PingGraph",global.pingGraph)
    
    global.yellowMineTrails=ini_read_real("s","YellowMineTrails",0)
    ini_write_real("s","YellowMineTrails",global.yellowMineTrails)
    
    global.chatDisplayLines=ini_read_real("s","ChatDisplayLines",3)
    ini_write_real("s","ChatDisplayLines",global.chatDisplayLines)
    
    global.chatBoxAlpha=ini_read_real("s","ChatBoxAlpha",80)
    ini_write_real("s","ChatBoxAlpha",global.chatBoxAlpha)
    
    global.chatTextAlpha=ini_read_real("s","ChatTextAlpha",100)
    ini_write_real("s","ChatTextAlpha",global.chatTextAlpha)
    
    global.chatPBF=ini_read_real("s","ChatPBF",-1)
    ini_write_real("s","ChatPBF",global.chatPBF)
    
    global.weaponDraw=ini_read_real("s","WeaponDraw",0)
    ini_write_real("s","WeaponDraw",global.weaponDraw)
    
    global.noSoundsDuringRUP=ini_read_real("s","NoSoundsDuringRUP",0)
    ini_write_real("s","NoSoundsDuringRUP",global.noSoundsDuringRUP)
    
    global.boxHUD=ini_read_real("s","BoxHUD",1)
    ini_write_real("s","BoxHUD",global.boxHUD)
    
    global.boxBgAlpha=ini_read_real("s","BoxBgAlpha",50)
    ini_write_real("s","BoxBgAlpha",global.boxBgAlpha)
    
    global.boxElementAlpha=ini_read_real("s","BoxElementAlpha",100)
    ini_write_real("s","BoxElementAlpha",global.boxElementAlpha)
    
    global.textSelectCol=ini_read_real("s","TextSelectCol",0)
    ini_write_real("s","TextSelectCol",global.textSelectCol)
    
    global.killLogBGAlpha=ini_read_real("s","KillLogBGAlpha",100)
    ini_write_real("s","KillLogBGAlpha",global.killLogBGAlpha)
    
    global.killLogTextAlpha=ini_read_real("s","KillLogTextAlpha",100)
    ini_write_real("s","KillLogTextAlpha",global.killLogTextAlpha)
    
    global.boxScoreboardBGAlpha=ini_read_real("s","BoxScoreboardBGAlpha",50)
    ini_write_real("s","BoxScoreboardBGAlpha",global.boxScoreboardBGAlpha)
    
    global.boxStatsScorePos=ini_read_real("s","BoxStatsScorePos",1)
    ini_write_real("s","BoxStatsScorePos",global.boxStatsScorePos)
    
    global.chatExpiryTime=ini_read_real("s","ChatExpiryTime",3)
    ini_write_real("s","ChatExpiryTime",global.chatExpiryTime)
    
    global.chatColorCodes=ini_read_real("s","ChatColorCodes",1)
    ini_write_real("s","ChatColorCodes",global.chatColorCodes)
    
    global.voteTimer=ini_read_real("s","ConfigVoteTimer",30)
    ini_write_real("s","ConfigVoteTimer",global.voteTimer)
    
    global.configVoteAllowed=ini_read_real("s","ConfigVoteAllowed",1)
    ini_write_real("s","ConfigVoteAllowed",global.configVoteAllowed)
    
    global.damageColourR=ini_read_real("s","DamageColourR","244")
    ini_write_real("s","DamageColourR",global.damageColourR)
    
    global.damageColourG=ini_read_real("s","DamageColourG","244")
    ini_write_real("s","DamageColourG",global.damageColourG)
    
    global.damageColourB=ini_read_real("s","DamageColourB","11")
    ini_write_real("s","DamageColourB",global.damageColourB)
    
    global.defaultConfig=ini_read_string("s","DefaultConfig","")
    ini_write_real("s","DefaultConfig",global.defaultConfig)
    
    global.respawnTimerPos=ini_read_real("s","RespawnTimerPos",1)
    ini_write_real("s","RespawnTimerPos",global.respawnTimerPos)
    
    global.respawnTimerAlpha=ini_read_real("s","RespawnTimerAlpha",50)
    ini_write_real("s","RespawnTimerAlpha",global.respawnTimerAlpha)
    
    global.specReadChat=ini_read_real("s","SpecReadChat",0)
    ini_write_real("s","SpecReadChat",global.specReadChat)
    
    global.bigHpNumbers=ini_read_real("s","BigHpNumbers",0)
    ini_write_real("s","BigHpNumbers",global.bigHpNumbers)
    
    global.hpColourR=ini_read_real("s","HpColourR",244)
    ini_write_real("s","HpColourR",global.hpColourR)
    
    global.hpColourG=ini_read_real("s","HpColourG",244)
    ini_write_real("s","HpColourG",global.hpColourG)
    
    global.hpColourB=ini_read_real("s","HpColourB",11)
    ini_write_real("s","HpColourB",global.hpColourB)
    
    global.serverAfkTimeout=ini_read_real("s","ServerAfkTimeout",120)
    ini_write_real("s","ServerAfkTimeout",global.serverAfkTimeout)
    
    global.medicTargeting=ini_read_real("s","MedicTargeting",0)
    ini_write_real("s","MedicTargeting",global.medicTargeting)
    
    global.jumpMapMode=ini_read_real("s","JumpMapMode",0)
    ini_write_real("s","JumpMapMode",global.jumpMapMode)
    
    global.jumpPlayerAttack=ini_read_real("s","JumpPlayerAttack",0)
    ini_write_real("s","JumpPlayerAttack",global.jumpPlayerAttack)
ini_close()

ini_open("controls.gg2")
    global.bubbleUber=ini_read_real("Controls","BubbleUber",ord("R"))
    global.bubbleSpy=ini_read_real("Controls","BubbleSpy",ord("G"))
    global.chatHideCtrl=ini_read_real("Controls","ChatHideCtrl",ord("I"))
    global.chatToggleCtrl=ini_read_real("Controls","ChatToggleCtrl",ord("T"))
    global.chatGlobalCtrl=ini_read_real("Controls","ChatGlobalCtrl",ord("Y"))
    global.chatTeamCtrl=ini_read_real("Controls","ChatTeamCtrl",ord("U"))
    global.consoleKey=ini_read_real("Controls","ConsoleKey",vk_f3)
ini_close()

global.testing=0
global.myPing=0
global.madeRupList=0
//global.isCasting=0
global.playerListExists=0
global.rupTimeMin=0
global.rupTimeSec=0
global.permIDCounter=0
global.healCabs=1
global.spawnDoors=1
global.configSuperString=""
global.jumpMode=0

//adcp stopwatch mode
global.adcpRound1Score=-1
global.adcpRound2Score=-1
global.adcpRound1Caps=-1
global.adcpRound2Caps=-1
global.currentStopwatchRound=0
global.adcpWinner=""
global.adcpRound1CapTimestamp=-1
global.adcpRound2CapTimestamp=-1
global.myAdcpTeam=""

//replays
global.replayBuffer = buffer_create();
global.isPlayingReplay = false;
global.replayTime = 0;
global.recordingReplay = false;
global.isPlayingReplay = false;
global.replayMapSplit=0

color_index()
console_init()
RUP()
chat_init()
config_init()

if(!directory_exists(working_directory+"\Logs")) directory_create(working_directory+"\Logs")

global.consoleFont=font_add_sprite(ConsoleFontS,ord("!"),false,0);
global.chatFont=font_add_sprite(ChatFontS,ord("!"),false,0);

//dmg indicator
if file_exists("Sound/DingSnd.wav"){
    global.DingSound=sound_add("Sound/DingSnd.wav",0,true)
}else{
    global.DingSound=CountDown1Snd
}
with(Character){
    lasthp=hp
}
with(Sentry){
    lasthp=hp
}
instance_create(0,0,DMG_Counter)
