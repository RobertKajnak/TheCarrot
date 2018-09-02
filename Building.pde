class BuildingUnderConstruction extends Entity {
  
  int finishedPercent = 0;
  float buffer = 0.0;
  
  public BuildingUnderConstruction(int x, int y, String name) {
    super(name, x, y);
  }
  
  void build() {
    buffer += 0.1;
    if (buffer > 1) {
      buffer = 0;
      finishedPercent++;
      
      if (finishedPercent >= 50) 
        name = "construction_1";
      if (finishedPercent >= 100)
        name = "building";
    }
  }
  
  void update() {}
  
  void render() {
    renderImage();
    
    if (isVisible(x, y, 20, 20) && debugView) {
      
      int nx = worldCoordToScreenCoord(x, cameraX);
      int ny = worldCoordToScreenCoord(y, cameraY);
     
      fill(255, 0, 0);
      rect(nx, ny, 50, 50);
    
      fill(255);
      text("Finished " + finishedPercent + "%", nx, ny);
    }
  }
}

class Building extends Entity {
 
  Inventory inventory = new Inventory();
  World world;
  Civilization civ;
  
  public Building(int x, int y, String name, World world, Civilization civilization) {
    super(name, x,y);
    this.world = world;
    civ = civilization;
  }

  void update () {
    if (inventory.food.amount >= 50) {
      spawnUnit();
      inventory.food.amount -= 50;
    }
    
    if (inventory.wood.amount >= 200) {
      Coord goodPlace = findPotentialPlace();
      if (goodPlace != null) {
        spawnBuilding(goodPlace);
        inventory.wood.amount -= 200;
      }
    }
  }
  
  void spawnUnit() {
    int nx = randomBetweenBounds(x - 20, x + 20);
    int ny = randomBetweenBounds(y - 20, y + 20);
    
    civ.add(new Worker("peon", nx, ny, world, civ));
  }
  
  void spawnBuilding(Coord goodPlace) {
    civ.add(new BuildingUnderConstruction(goodPlace.x, goodPlace.y, "construction_0"));
  }
  
  Coord findPotentialPlace() {
    for (Stash stash : world.resources)
      if (distance(stash, this) < 1000) {
        int nx = randomBetweenBounds(stash.x - 200, stash.x + 200);
        int ny = randomBetweenBounds(stash.y - 200, stash.y + 200);
        Coord potentialPlace = new Coord(nx, ny);
        
        if (distance(potentialPlace, this) > 400)
          return potentialPlace;
      }
    return null;
  }
  
  void render() {
    renderImage();
    
    if (isVisible(x, y, 20, 20) && debugView) {
      
      int nx = worldCoordToScreenCoord(x, cameraX);
      int ny = worldCoordToScreenCoord(y, cameraY);
     
      fill(255, 0, 0);
      rect(nx, ny, 50, 50);
    
      fill(255);
      text(inventory.toString(), nx, ny);
    }
  }
}