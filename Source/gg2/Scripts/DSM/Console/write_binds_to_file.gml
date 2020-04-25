var file,bindListSize,index;
if (file_exists("Binds.txt")){
    file_delete("Binds.txt")
}

file=file_text_open_write("Binds.txt")

file_text_write_string(file,"{BINDS}") //Header
bindListSize=ds_list_size(global.dsmBinds)
index=0
while(index<bindListSize){
    file_text_write_string(file,string(ds_list_find_value(global.dsmBinds,index))+"#")
    index+=1
}

file_text_write_string(file,"{COMMANDS}") //Header
index=0
while(index<bindListSize){
    file_text_write_string(file,string(ds_list_find_value(global.dsmBindCommands,index))+"#")
    index+=1
}

file_text_close(file)