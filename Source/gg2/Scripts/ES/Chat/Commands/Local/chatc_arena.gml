chat_addCommandLocal("arena", "
if string(input[1])=='' exit;
newArena=real(input[1])-1
if newArena<0 exit;
if newArena>5 exit;

write_ubyte(global.serverSocket, MGE_CHANGE_ARENA)
write_byte(global.serverSocket, newArena)
socket_send(global.serverSocket)
", "
console_print('Syntax: arena')
console_print('Select an arena for MGE mode. 0 for no arena.')
")
