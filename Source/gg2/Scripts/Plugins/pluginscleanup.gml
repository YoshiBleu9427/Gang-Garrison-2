// cleans up server-sent plugins
// Restart or quit GG2 so that plugins aren't kept in memory

//skipping plugin cleanup
if (show_message_ext("Clean up plugins? (Only skip when no plugins were downloaded or when going on a server using the same plugins.)","Yes","","No") == 3) exit

if (show_message_ext("Because you used this server's plugins, you will have to restart GG2 to play on another server.","Restart","","Quit") == 1)
{
    execute_program(parameter_string(0), "-restart", false);
}
game_end();
