/*
Part of Universal Weapon Tilter by generic name guy.
You can download a copy of the source code or contribute to the project on GitHub at https://github.com/generic-name-guy/universal-weapon-tilt-gz/
This is code licensed under Unlicense, so do whatever you want with it, i don't care.
*/

class WeaponTilterInventory : Inventory
{
	double currentRoll, crABS, aVelocity, playerVel, adjustedCrABS;
	float rResistance, rVelocity, rLimit;
	vector2 direction, velocityUnit;
  int currentTickCount;
  bool debug, limit, offset;
  
  default
  {
    Inventory.MaxAmount 1;
  }
  
  override void DoEffect()
  {
    super.DoEffect(); //not sure what this does
    
    currentTickCount++; //count tick
    
    // do nothing if the owner is null or not a player:
    if(!owner || !owner.player)
      return;
      
    let weaponsprite = owner.player.FindPSprite(PSP_WEAPON);
    
    if(!(owner.player.weaponstate & wf_weaponbobbing))
      return;

    if(weaponsprite)
    {
      //to do: optimize further with the gearbox cvar system
      
      //get cvars, optimized with tick count
      if (currentTickCount % 35 == 0)
      {
        rResistance = cvar.getcvar("wt_rollresistance", owner.player).getfloat();
        rVelocity = cvar.getcvar("wt_rollvelocity", owner.player).getfloat();
        rLimit = cvar.getcvar("wt_rollcap", owner.player).getfloat();
        
        debug = cvar.getcvar("wt_debug", owner.player).getbool();
        limit = cvar.getcvar("wt_cap", owner.player).getbool();
        offset = cvar.getcvar("wt_offset", owner.player).getbool();
      }
  		
  		//calculate tilt and shit idk
  		aVelocity = atan2(owner.vel.y, owner.vel.x);
  		direction = (sin(-owner.angle), cos(-owner.angle));
  		velocityUnit = owner.vel.xy;
  		currentRoll += (velocityUnit dot direction) * rVelocity;
  		currentRoll *= rResistance;
  		crABS = abs(currentRoll);
  		
      if(offset)
      {
        adjustedCrABS = weaponsprite.y + crABS;
        weaponsprite.y = adjustedCrABS;
      }
  		
      //roll cap
      if(limit)
      {
        if(currentRoll > rLimit)
        {
          currentRoll = rLimit;
        }
      }
      
      //to do: figure out how to make this additive to avoid issues with mods that use sprite rotation for animations
      //apply tilt
      weaponsprite.rotation = currentRoll;
      
      //debug
		  if(debug)
		  {
		    console.printf("roll: %f", currentRoll);
		  }
    }
  }
}
