{
    ini_open("dsm.ini")
    global.intelArrows=ini_read_real("Settings","IntelArrows",1)
    global.randomRotation=ini_read_real("Settings","RandomiseRotation",0)
    global.hpbartext=ini_read_real("Settings","ShowHpText",1)
    global.ammoBar=ini_read_real("Settings","AmmoBar",1)

    ini_write_real("Settings","IntelArrows",global.intelArrows)
    ini_write_real("Settings","RandomiseRotation",global.randomRotation)
    ini_write_real("Settings","ShowHpText",global.hpbartext)
    ini_write_real("Settings","AmmoBar",global.ammoBar)
    ini_close()
}
