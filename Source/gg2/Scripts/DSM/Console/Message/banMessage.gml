//£ signs are used instead of spaces because they don't show up in the font, so this avoids problems with using " and '
//argument0 is the type of ban; id or name
var banType;
banType=argument0

if banType==0{
    console_parseInput("broadcast "+player.name+"£has£been£banned£from£the£server.")
}else{
    console_parseInput("broadcast "+name+"£has£been£banned£from£the£server.")
}
