class WeaponTilterEventHandler : EventHandler
{
	override void PlayerEntered(PlayerEvent e)
	{
		players[e.PlayerNumber].mo.A_GiveInventory("WeaponTilterInventory", 1);
	}
}