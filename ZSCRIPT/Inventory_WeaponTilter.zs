class WeaponTilterInventory : Inventory
{
	double currentRoll, aVelocity; 
	float rResistance, rVelocity;
	vector2 direction, velocityUnit;
  int currentTickCount;
  bool debug, offset;
  
  default
  {
    Inventory.MaxAmount 1;
  }
  
  override void DoEffect()
  {
    currentTickCount++; //count tick
    
    super.DoEffect();
    
    // do nothing if the owner is null or not a player:
    if(!owner || !owner.player)
      return;
  
    let weaponsprite = owner.player.FindPSprite(PSP_WEAPON);
    if(weaponsprite)
    {
      //get cvars, optimized with tick count
      if (currentTickCount % 35 == 0)
      {
        rResistance = cvar.getcvar("wt_rollresistance", owner.player).getfloat();
        rVelocity = cvar.getcvar("wt_rollvelocity", owner.player).getfloat();
        debug = cvar.getcvar("wt_debug", owner.player).getbool();
        offset = cvar.getcvar("wt_offset", owner.player).getbool();
      }
  		
  		//calculate tilt and shit idk
  		aVelocity = atan2(owner.vel.y, owner.player.vel.x);
  		direction = (sin(-owner.angle), cos(-owner.angle));
  		velocityUnit = owner.vel.xy;
  		currentRoll += (velocityUnit dot direction) * rVelocity;
  		currentRoll *= rResistance;
  
      //apply tilt
      weaponsprite.rotation = currentRoll;
      
      if(offset)
      {
        weaponsprite.y += (+currentRoll);
      }
      
      //debug
		  if(debug)
		  {
		    console.printf("roll: %f", currentRoll);
		  }
    }
  }
}