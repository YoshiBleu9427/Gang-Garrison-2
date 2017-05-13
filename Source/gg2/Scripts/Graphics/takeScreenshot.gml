{
    var currentDate, timestamp, serverMap, uniqueSuffix, nextUniqueSuffixNr, filename, serverName;
    currentDate = date_current_datetime();
    timestamp = string(date_get_year(currentDate)) + "-";
    if (date_get_month(currentDate) < 10) { timestamp = timestamp + "0"; }
    timestamp += string(date_get_month(currentDate)) + "-";
    if (date_get_day(currentDate) < 10) { timestamp = timestamp + "0"; }
    timestamp += string(date_get_day(currentDate)) + " ";
    if (date_get_hour(currentDate) < 10) { timestamp = timestamp + "0"; }
    timestamp += string(date_get_hour(currentDate)) + "-";
    if (date_get_minute(currentDate) < 10) { timestamp = timestamp + "0"; }
    timestamp += string(date_get_minute(currentDate)) + "-";
    if (date_get_second(currentDate) < 10) { timestamp = timestamp + "0"; }
    timestamp += string(date_get_second(currentDate));
    
    serverName=global.joinedServerName
    //Characters reserved for file paths (http://msdn.microsoft.com/en-us/library/aa365247%28VS.85%29.aspx)
    {
        serverName=string_replace_all(serverName,"<","_");serverName=string_replace_all(serverName,">","_");
        serverName=string_replace_all(serverName,":","_");serverName=string_replace_all(serverName,'"',"_");
        serverName=string_replace_all(serverName,"/","_");serverName=string_replace_all(serverName,"\","_");
        serverName=string_replace_all(serverName,"|","_");serverName=string_replace_all(serverName,"?","_");
        serverName=string_replace_all(serverName,"*","_")
    }
    
    if instance_exists(PlayerControl)
        serverMap = " " + serverName + " " + global.currentMap;
    else
        serverMap = "";
    
    uniqueSuffix = "";
    nextUniqueSuffixNr = 2;
    
    do
    {
        filename = "Screenshots/" + timestamp + serverMap + uniqueSuffix + ".png";
        uniqueSuffix = " ("+string(nextUniqueSuffixNr)+")";
        nextUniqueSuffixNr += 1;
    }
    until(!file_exists(filename));
    
    screen_save(filename);
}
