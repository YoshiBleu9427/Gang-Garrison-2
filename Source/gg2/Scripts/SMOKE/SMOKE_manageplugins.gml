clipboard_set_text("do_nothing");

splash_set_main(false);
splash_set_border(false);
splash_set_interrupt(false);
splash_set_close_button(false);
//splash_show_web("http://localhost:5000/pluginlist?inmod&"
splash_show_web("http://"+global.SMOKE_domain+"/pluginlist?inmod&"
+ "installed="+SMOKE_parselist(global.SMOKE_pluginlist)+"&enabled="+SMOKE_parselist(global.SMOKE_enabledpluginlist), 0);

instance_create(0, 0, SMOKE_ClippyChecker);
