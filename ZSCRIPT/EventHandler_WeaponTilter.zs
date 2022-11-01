/*
Part of Universal Weapon Tilter by generic name guy.
You can download a copy of the source code or contribute to the project on GitHub at https://github.com/generic-name-guy/universal-weapon-tilt-gz/
This is code licensed under Unlicense, so do whatever you want with it, i don't care.
*/

class WeaponTilterEventHandler : EventHandler
{
	override void PlayerEntered(PlayerEvent e)
	{
		players[e.PlayerNumber].mo.A_GiveInventory("WeaponTilterInventory", 1);
	}
}
