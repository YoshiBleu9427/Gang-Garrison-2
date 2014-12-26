console_addCommand("execute", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

execute_string(input[1]);
console_print('/:/'+COLOR_GREEN+'Executed code: '+input[1])
", "
console_print('Syntax: execute '<code>');
console_print('Use: Executes the given code immediately.');
console_print('Warning: Can cause crashes, use at own responsibility!');
");
