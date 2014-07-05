if(not instance_exists(GameOverController)) {
    var text;
    text = argument0;

    instance_create(0,0,GameOverController);
    if(is_string(text)) {
        GameOverController.text = text;
    }
}
