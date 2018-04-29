// arg0 should be an object
with(argument0) {
    if(hasClassReward(player, 'Grey_Accessories_') and player.class != CLASS_QUOTE)
    {
        ds_list_add(stillOverlays, global.SilverAttireOverlay[player.class]);
        ds_list_add(leanROverlays, global.SilverAttireLeanROverlay[player.class]);
        ds_list_add(leanLOverlays, global.SilverAttireLeanLOverlay[player.class]);
        ds_list_add(jumpOverlays, global.SilverAttireJumpOverlay[player.class]);
        ds_list_add(runOverlays, global.SilverAttireRunOverlay[player.class]);
        ds_list_add(tauntOverlays, global.SilverAttireTaunt[player.class]);
        if (player.class == CLASS_HEAVY)
        {
            ds_list_add(omnomnomnomOverlays, global.SilverSandwichOverlay[player.class]);
            ds_list_add(walkOverlays, global.SilverAttireOverlay[player.class]);
        }
        if (player.class == CLASS_SNIPER)
            ds_list_add(crouchOverlays, global.SilverAttireOverlay[player.class]);
    }
    else if(hasClassReward(player, 'Gold_Accessories_') and player.class != CLASS_QUOTE)
    {
        ds_list_add(stillOverlays, global.GoldenAttireOverlay[player.class]);
        ds_list_add(leanROverlays, global.GoldenAttireLeanROverlay[player.class]);
        ds_list_add(leanLOverlays, global.GoldenAttireLeanLOverlay[player.class]);
        ds_list_add(jumpOverlays, global.GoldenAttireJumpOverlay[player.class]);
        ds_list_add(runOverlays, global.GoldenAttireRunOverlay[player.class]);
        ds_list_add(tauntOverlays, global.GoldenAttireTaunt[player.class]);
        if (player.class == CLASS_HEAVY)
        {
            ds_list_add(omnomnomnomOverlays, global.GoldenSandwichOverlay[player.class]);
            ds_list_add(walkOverlays, global.GoldenAttireOverlay[player.class]);
        }
        if (player.class == CLASS_SNIPER)
            ds_list_add(crouchOverlays, global.GoldenAttireOverlay[player.class]);
    }
    // You cannot wear more than one hat at once you dingdong
    // 'BH' reward - *B*obble *H*ead - not available for quote
    if(hasClassReward(player, 'BH') and player.class != CLASS_QUOTE)
    {
        // hats use the same sprite for most animations
        ds_list_add(stillOverlays, global.HatBobbleClassOverlay[player.class]);
        ds_list_add(leanROverlays, global.HatBobbleClassOverlay[player.class]);
        ds_list_add(leanLOverlays, global.HatBobbleClassOverlay[player.class]);
        ds_list_add(jumpOverlays, global.HatBobbleClassOverlay[player.class]);
        ds_list_add(runOverlays, global.HatBobbleClassOverlay[player.class]);
        if (player.class == CLASS_HEAVY)
        {
            ds_list_add(walkOverlays, global.HatBobbleClassOverlay[player.class]);
            ds_list_add(omnomnomnomOverlays, global.HatBobbleSandwich[player.class]);
        }
        if (player.class == CLASS_SNIPER)
            ds_list_add(crouchOverlays, global.HatBobbleClassOverlay[player.class]);
        if (player.class == CLASS_SPY and player.team == TEAM_BLUE)
        {
            ds_list_add(tauntOverlays, HatBobbleSpyBlueTauntS);
        }
        else
        {
            ds_list_add(tauntOverlays, global.HatBobbleClassTaunt[player.class]);
        }
    }
    else if(hasClassReward(player, 'TopHatMonocle_'))
    {
        ds_list_add(stillOverlays, global.TopHatMonocleOverlay[player.class]);
        ds_list_add(leanROverlays, global.TopHatMonocleOverlay[player.class]);
        ds_list_add(leanLOverlays, global.TopHatMonocleOverlay[player.class]);
        ds_list_add(jumpOverlays, global.TopHatMonocleOverlay[player.class]);
        ds_list_add(runOverlays, global.TopHatMonocleOverlay[player.class]);
        if (player.class == CLASS_HEAVY)
        {
            ds_list_add(walkOverlays, global.TopHatMonocleOverlay[player.class]);
            ds_list_add(omnomnomnomOverlays, global.TopHatMonocleSandwich[player.class]);
        }
        if (player.class == CLASS_SNIPER)
            ds_list_add(crouchOverlays, global.TopHatMonocleOverlay[player.class]);
        if (player.class == CLASS_QUOTE and player.team == TEAM_BLUE)
        {
            ds_list_add(tauntOverlays, QuerlyBlueMonocleHatTauntS);
        }
        else
        {
            ds_list_add(tauntOverlays, global.TopHatMonocleTaunt[player.class]);
        }
    }
    else if(hasClassReward(player, 'TopHat_'))
    {
        ds_list_add(stillOverlays, global.TopHatOverlay[player.class]);
        ds_list_add(leanROverlays, global.TopHatOverlay[player.class]);
        ds_list_add(leanLOverlays, global.TopHatOverlay[player.class]);
        ds_list_add(jumpOverlays, global.TopHatOverlay[player.class]);
        ds_list_add(runOverlays, global.TopHatOverlay[player.class]);
        if (player.class == CLASS_HEAVY)
        {
            ds_list_add(walkOverlays, global.TopHatOverlay[player.class]);
            ds_list_add(omnomnomnomOverlays, global.TopHatSandwich[player.class]);
        }
        if (player.class == CLASS_SNIPER)
            ds_list_add(crouchOverlays, global.TopHatOverlay[player.class]);
        if (player.class == CLASS_QUOTE and player.team == TEAM_BLUE)
        {
            ds_list_add(tauntOverlays, QuerlyBlueTopHatTauntS);
        }
        else
        {
            ds_list_add(tauntOverlays, global.TopHatTaunt[player.class]);
        }
    }
    else if (hasReward(player, 'Crown'))
    {
        ds_list_add(gearList, GEAR_CROWN);
        has_crown = true;
    }
    else if (hasReward(player, 'Navigator'))
    {
        ds_list_add(gearList, GEAR_NAVIGATORHAT);
        has_navigatorhat = true;
    }
    else if (global.gg_birthday)
    {
        ds_list_add(gearList, GEAR_PARTY_HAT);
        has_partyhat = true;
    }
    if (hasReward(player, 'WillOWisp'))
    {
        demon = WillOWispS;
    }
    if (hasClassReward(player, 'HaxxyCape_'))
    {
        ds_list_add(gearList, GEAR_HAXXY_CAPE);
    }
    else if (hasClassReward(player, 'RaybannCape_'))
    {
        ds_list_add(gearList, GEAR_RAYBANN_CAPE);
    }
    if(hasClassReward(player, 'GW'))
    {
        // 'GW' reward - *G*olden *W*eapon
        // Prepend to the start of the overlay list, so that it gets drawn first (it's a full sprite replacement)
        switch(player.class)
        {
            case CLASS_SCOUT:
            case CLASS_SOLDIER:
            case CLASS_SNIPER:
            case CLASS_DEMOMAN:
            case CLASS_HEAVY:
            case CLASS_PYRO:
            case CLASS_MEDIC:
                ds_list_insert(tauntOverlays, 0, getCharacterSpriteId(player.class, player.team, "GoldWeaponTaunt"));
                break;
        }
        if(player.class == CLASS_HEAVY)
        {
            ds_list_insert(omnomnomnomOverlays, 0, getCharacterSpriteId(player.class, player.team, "OmnomnomnomGoldWeapon"));
        }
    }
}
