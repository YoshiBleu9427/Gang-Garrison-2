// argument0 - host e.g. "smoke.ajf.me"
// argument1 - resource e.g. "/api/test"
// argument2 - filename e.g. "test.html"

var sock, file, buf, crlf;
crlf = chr(13)+chr(10);
sock = tcp_connect(argument0, 80);
//sock = tcp_connect("localhost", 5000);

if (socket_connecting(sock) == false) {
    return false;
}

write_string(sock, "GET http://" + argument0 + argument1 + crlf + crlf);
//write_string(sock, "GET " + argument1 + crlf + crlf);
socket_send(sock);

buf = buffer_create()
while (!tcp_eof(sock)) {
    //tcp_receive(sock,1);
    tcp_receive_available(sock);
    write_buffer(buf,sock);
}
write_buffer_to_file(buf, argument2);

return true;
