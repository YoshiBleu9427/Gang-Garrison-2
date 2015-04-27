{
    sound_volume(argument2, calculateVolume(argument0, argument1));
    sound_pan(argument2, calculatePan(argument0));
    
    if global.enablePrimeNo==1{
        sound_loop(PrimeNoSnd)
    }else{
        sound_loop(argument2);
    }
}
