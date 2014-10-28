var stat1,stat2;
stat1=argument0
stat2=argument1

if (stat1!=0) and (stat2!=0){
    global.ratio=string(round(stat1/max(1,stat2)*100)/100)
}
show_message(string(global.ratio))
