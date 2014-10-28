//£ signs are used instead of spaces because they don't show up in the font, so this avoids problems with using " and '
var endString;
endString='£has£been£temporarily£banned£from£the£server.'
global.playerNameC=string_replace_all(global.playerNameC,' ','£')
console_parseInput('broadcast '+global.playerNameC+endString)
