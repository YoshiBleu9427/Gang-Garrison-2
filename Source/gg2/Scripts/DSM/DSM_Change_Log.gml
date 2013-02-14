/*
-Rockets are more brightly coloured to their team.
    Changed: RocketS, RedRocketS, BlueRocketS.
-Bullets are team coloured.
    Changed: ShotS, Shot (Draw).
-Bubbles are team coloured, so if the pop.
    Changed: BubbleS, PopS, Bubble (Draw), Pop (Draw).
-Flames (And flares) are team coloured.
    Changed: Flame (Draw), Flare (Draw).
    Added: FlameBlueS, FlareBlueS.
-Needles are team coloured.
    Changed: NeedleS, Needle (Draw).
-Blades are team coloured.
    Changed: BladeB (Draw).
    Added: BladeProjectileRedS, BladeProjectileBlueS.
-Stats are tracked, and visible to user on the scoreboard.
    Changed: ScoreTableController (Create).
    Added: StatsBoardS, StatsBoard.
-MedAlert bubbles don't have white background.
    Changed: MedAlert.
-Sniper charge bar made into one bar.
    Changed: ChargeS.
-Timer sprite changed; amber "warning level" added.
    -Changed: TimerS.
-Main menu says "DSM"
    Changed: MenuBackgroundVersionS.
-Default welcome message for DSM added.
    Changed: game_init.
-Addded version checking for new versions of DSM.
    Changed: Constants
-Added new init for DSM options.
    Added: DSM_init
-Added randomise rotation option
    Changed: DSM_init, GameServerCreate.
    Added: randomiseRotation.
-Changed lobby information.
    Changed: sendLobbyRegistration.
-Added ini writer script for DSM.ini.
    Added: DSM_write_ini.
-Update amount shown in percentage.
    Changed: Updater (Create).
-Scoreboard opens/fades quicker.
    Changed: ScoreTableController (Create, Step).
-Added option to disable intel arrows.
    Changed: DSM_init, ScorePanel (Draw).
-Added capping percentage on CP based gamemodes.
    Changed: ControlPointHUD (Draw), ArenaHUD (Draw), KothHUD (Draw), DKothHUD (Draw).
-Generator health and shield values shown on HUD.
    Changed: GeneratorHUD (Draw).
-Heavy ammo count shown on HUD.
    Changed: AmmoCounter (Draw).
-Heavy ammo count does not go over 200.
    Changed: Minigun (Begin Step).
-Airblast does not disappear when it collides with an obstacle.
    Changed: AirBlastO (Collision with Obstacle).
-Aqua coloured ping is shown in lobby for pings less then 75.
    Changed: LobbyController (Draw).
-Added text to show current health number on health bar.
    Changed: Character (Draw).
-Added ammo "HP" bar.
    Changed: Character (Draw).
-Added ability to use Uber bubble.
    Changed: game_init, PlayerControl (Begin Step).
-Added DSM options menu.
    Changed: OptionsController (Create).
    Added: DSMOptionsController.
-Made generator be unable to be stabbed by Spies (toggle).
    Changed: StabMask (Collision with generator), DSM_init.
-Added Stats Tracker.
    Changed: GameServerBeginStep, WinBanner (Create), MenuController (Step, Draw).
    Added: statsTracker, addStats, writeStats, StatsDisplayController, menu_addtext.
*/
