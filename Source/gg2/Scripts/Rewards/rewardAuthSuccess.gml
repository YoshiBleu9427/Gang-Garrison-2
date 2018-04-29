var player, rewardString, rewardArray, i, rewardValue;
player = argument0;
rewardString = argument1;
        
sendEventUpdateRewards(player, rewardString);
doEventUpdateRewards(player, rewardString);

if (player.object != -1) {
    updateRewardsLive(player.object);
}
