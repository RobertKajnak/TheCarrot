class AI {
  
  Civilization civ;
  World world;
  
  float buffer = 0;
  int fervour = 0;
  int decision = -1;
  
  public AI(Civilization civ, World world) {
    this.world = world;
    this.civ = civ;
  }
  
  void update() {
    updateFervour();
    
    if (decision == -1) {
      decision = randomBetweenBounds(0, 5);
    }
    
    switch (decision) {
      case 1: 
        if (fervour >  30) {
          int index = randomBetweenBounds(0, civ.buildings.size());
          
          if (civ.buildings.size() > 0) {
            Building building = civ.buildings.get(index);
          
            int x = around(building.x);
            int y = around(building.y);
          
            world.resources.add(new Stash(x, y, "bush", new Food(50)));
            fervour -= 30;
            decision = -1;
          }
        }
        break;
        
      case 2:
        if (fervour >  50) {
          int index = randomBetweenBounds(0, civ.buildings.size());
          
          if (civ.buildings.size() > 0) {
            Building building = civ.buildings.get(index);
          
            int x = around(building.x);
            int y = around(building.y);
          
            world.resources.add(new Stash(x, y, "wood_1", new Wood(50)));
            fervour -= 50;
            decision = -1;
          }
        }
        break;
        
      case 3:
        if (fervour >  90) {
          int index = randomBetweenBounds(0, civ.buildings.size());
          
          if (civ.buildings.size() > 0) {
            Building building = civ.buildings.get(index);
          
            int x = around(building.x);
            int y = around(building.y);
          
            world.resources.add(new Stash(x, y, "iron", new Iron(50)));
            fervour -= 90;
            decision = -1;
          }
        }
        break;
        
      default:
        decision = -1;
        break;
    }
  }
  
  int around(int x) {
    return randomBetweenBounds(x - 400, x + 400);
  }

  void updateFervour() {
    buffer += 1;
      if (buffer >= 10) {
        buffer = 0;
        fervour++;
      }
  }
}
