import java.util.Random;

class Unit extends Entity {
  
  World world;
  Civilization civ;
  
  int speed = 1;
  int range = 500;
  int extractingAmount = 10;
  Inventory inventory = new Inventory();
  
  
  Coord target = null;
  
  String state = "Gathering";
  
  public Unit(String name, int x, int y, World world, Civilization civ) {
    super(name,x,y);
    this.world = world;
    this.civ = civ;
  }
  
  void update() {
    switch (state) {
      case "Gathering":
        if (hasNoTarget() || !isStashAtTarget(world.resources)) {
          target = selectNewStash(world.resources);
        }
        else {
          if (distance(target, this) < range)
            moveTowardsTarget();
          
          if (distance(target, this) < 10) {
            Stash stash = getTargetStash(world.resources);
            Resource extracted = stash.extract(extractingAmount);
            inventory.add(extracted);
          }
          
          if (inventory.nonEmpty()) {
            target = noTarget();
            state = "Collecting";
          }
        }
        break;
        
      case "Collecting":
        if (canNotSeeBuildings(civ.buildings)) {
          state = "Wandering";
        }
        else {
          for (Building building : civ.buildings) {
          
            if (distance(building, this) < range) {
              x = stepTowards(x, building.x, speed);
              y = stepTowards(y, building.y, speed);
            }
          
            if (distance(building, this) < 10) {
              building.inventory.add(inventory);
              inventory = new Inventory();
            }
          
            if (inventory.empty()) {
              state = "Gathering";
            }
          }
        }
        break;
        
      case "Wandering":
        if (canNotSeeBuildings(civ.buildings)) {
          if (hasNoTarget() || distance(target, this) < 5)
            target = selectRandomTarget(x, y);
          else moveTowardsTarget();
        }
        else {
          target = noTarget();
          state = "Collecting";
        }
        break;
        
      default:
        println("UNRECOGNIZED STTE: " + state);
        break;
    }
  }
  
  Coord selectRandomTarget(int x, int y) {
    int nx = randomBetweenBounds(x - 200, x + 200);
    int ny = randomBetweenBounds(y - 200, y + 200);
    return new Coord(nx, ny);
  }
  
  Coord selectNewStash(List<Stash> resources) {
    for (Stash resource : resources) 
      if (distance(resource, this) < range) 
        return new Coord(resource.x, resource.y);
    return null;
  }
  
  void moveTowardsTarget() {
    x = stepTowards(x, target.x, speed);
    y = stepTowards(y, target.y, speed);
  }
  
  Coord noTarget() {
    return null;
  }
  
  boolean canNotSeeBuildings(List<Building> buildings) {
    for (Building b : buildings) 
      if (distance(this, b) < range) 
        return false;
    return true;
  }
  
  boolean isStashAtTarget(List<Stash> stashes) {
    for (Stash s : stashes) 
      if (new Coord(s.x, s.y).equals(target)) 
        return true;
    return false;
  }
  
  boolean hasNoTarget() {
    return target == null;
  }
  
  int stepTowards(int s, int d, int speed) {
    return 
      (s < d)? s + speed :
      (s > d)? s - speed : s;
  }
  
  Stash getTargetStash(List<Stash> stashes) {
    for (Stash s : stashes) 
      if (new Coord(s.x, s.y).equals(target))
        return s;
    println("You should never see this message from getTargetStash!");
    return null;
  }
 
  void render() {
    renderImage();
  
    if (isVisible(x, y, 20, 20)) {
      
      int nx = worldCoordToScreenCoord(x, cameraX);
      int ny = worldCoordToScreenCoord(y, cameraY);
      
      fill(255, 255, 0, 0.5);
      ellipse(nx, ny, range * 2 / zoomLevel, range * 2 / zoomLevel);
      
      fill(255, 0, 0);
      ellipse(nx, ny, 20, 20);
   
      fill(255);
      text(state + " - " + target, nx, ny);
    }
  }
}