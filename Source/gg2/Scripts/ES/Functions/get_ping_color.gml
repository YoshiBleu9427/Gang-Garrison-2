//argument0 = ping
var pingNumber, pingcol;
pingNumber=real(argument0)

pingcol=c_gray
if pingNumber<240 pingcol=c_yellow
if pingNumber<135 pingcol=c_green
if pingNumber<75 pingcol=c_aqua
if pingNumber>=240 pingcol=c_red
if pingNumber==-1 pingcol=c_gray

return(pingcol)
