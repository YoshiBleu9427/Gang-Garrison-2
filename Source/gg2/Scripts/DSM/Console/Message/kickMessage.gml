//£ signs are used instead of spaces because they don't show up in the font, so this avoids problems with using " and '
//argument0 is the type of kick; id or name
var kickType;
kickType=argument0

if kickType==0{
    console_parseInput("broadcast "+player.name+"£has£been£kicked£from£the£server.")
}else{
    console_parseInput("broadcast "+name+"£has£been£kicked£from£the£server.")
}
