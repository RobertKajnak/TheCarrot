class Soldier extends Unit {
  
  Entity enemyTarget = null;
  
  public Soldier(int x, int y, World world, Civilization civ) {
    super(x, y, civ.soldierName, world, civ);
  }
  
  void update() {
    switch(state) {
      case "Idle":
        state = "Wandering";
      
        break;
        
      case "Wandering":
        Entity enemyEntity = seeEnemyEntity();
        if (enemyEntity != null) {
          enemyTarget = enemyEntity;
          state = "Aggresive"; 
        }
      
        if (hasNoTarget() || distance(target, this) < 5)
            target = selectRandomTarget(x, y);
        else moveTowardsTarget();
        break;
        
      case "Aggresive":
        goTowardsEnemy();
        
        if (distance(this, enemyTarget) < 10) {
          enemyTarget.damage();
          if (enemyTarget.hitPoints <= 0) {
            enemyTarget = null;
            state = "Idle";
          }
        }
        
        break;
        
      default:
        state = "Idle";
        break;
    }
  }
  
  Entity seeEnemyEntity() {
    for (Civilization civ : world.civs) {
      if (civ.name == this.civ.name) continue;
      
      for (Unit unit : civ.units)
        if (isInRange(unit))
          return unit;
      
      for (Building building : civ.buildings)
        if (isInRange(building))
          return building;
          
      for (BuildingUnderConstruction buc : civ.underConstruction)
        if (isInRange(buc)) 
          return buc;
    }
    
    return null;
  }
  
  void goTowardsEnemy() {
    x = stepTowards(x, enemyTarget.x, speed);
    y = stepTowards(y, enemyTarget.y, speed);
  }
}