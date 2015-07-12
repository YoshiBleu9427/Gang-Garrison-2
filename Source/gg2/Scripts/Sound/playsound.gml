{
    var vol;
    vol = calculateVolume(argument0, argument1);
    if(vol==0) exit;
    
    // Prevent crashes on Win8 (NT Kernel 6.2)
    if (global.NTKernelVersion >= 6.2)
        sound_stop(argument2);
    
    sound_volume(argument2, vol);
    if global.dsmStereoSound==1{
        sound_pan(argument2, calculatePan(argument0));
    }
    
    //if global.enablePrimeNo==1{
    //    sound_play(PrimeNoSnd)
    //}else{
    sound_play(argument2);
    //}
}
