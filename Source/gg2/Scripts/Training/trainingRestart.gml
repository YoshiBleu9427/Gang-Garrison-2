// from GameServer begin step, didnt work
/*
        ServerChangeMap(global.currentMap, global.currentMapMD5, global.sendBuffer);
        serverGotoMap(global.currentMap);
        trainingCleanup();
  */
  
// from ingamemenucontroller, works      
        global.restart = true;
        GameServer.impendingMapChange = 1;
        with(GameServer) instance_destroy();
