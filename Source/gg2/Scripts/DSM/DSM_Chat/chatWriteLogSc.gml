if global.dsmWriteChatLog==0 exit;

var chatLogFile,datetime;
datetime=string(date_datetime_string(date_current_datetime()))
{
    datetime=string_replace_all(datetime,"<","_");datetime=string_replace_all(datetime,">","_");
    datetime=string_replace_all(datetime,":","_");datetime=string_replace_all(datetime,'"',"_");
    datetime=string_replace_all(datetime,"/","_");datetime=string_replace_all(datetime,"\","_");
    datetime=string_replace_all(datetime,"|","_");datetime=string_replace_all(datetime,"?","_");
    datetime=string_replace_all(datetime,"*","_")
}
chatLogFile=file_text_open_write(working_directory+"\ChatLogs\Chat Log "+datetime+".txt")

for(i=0; i<ds_list_size(global.chatLog); i+=1){
    file_text_write_string(chatLogFile,ds_list_find_value(global.chatLog,i))
    file_text_writeln(chatLogFile)
}

file_text_close(chatLogFile)
