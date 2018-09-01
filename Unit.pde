import java.util.Random;

class Unit extends Entity {
  
  World world;
  Civilization civ;
  
  int speed = 1;
  int range = 500;
  int extractingAmount = 10;
  Inventory inventory = new Inventory();
  Stash target = null;
  
  String state = "Gathering";
  
  public Unit(String name, int x, int y, World world, Civilization civ) {
    super(name,x,y);
    this.world = world;
    this.civ = civ;
  }
  
  void update() {
    switch (state) {
      case "Gathering":
        if (hasNoTarget() || !exists(target, world.resources)) {
          target = selectNewStash(world.resources);
        }
        else {
          if (exists(target, world.resources)) {
            if (distance(target, this) < range) {
              x = stepTowards(x, target.x, speed);
              y = stepTowards(y, target.y, speed);
            }
          
            if (distance(target, this) < 10) {
              Resource extracted = target.extract(extractingAmount);
              inventory.add(extracted);
            }
          
            if (inventory.nonEmpty()) {
              target = null;
              state = "Collecting";
            }
          }
        }
        break;
        
      case "Collecting": 
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
        break;
    }
  }
  
  Stash selectNewStash(List<Stash> resources) {
    for (Stash resource : resources) {
      if (distance(resource, this) < range) 
        return resource;
    }
    return null;
  }
  
  boolean exists(Stash stash, List<Stash> stashes) {
    for (Stash s : stashes)
      if (s == stash)
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
 
  void render() {
    renderImage();
  
    if (isVisible(x, y, 20, 20)) {
      
      int nx = worldCoordToScreenCoord(x, cameraX);
      int ny = worldCoordToScreenCoord(y, cameraY);
      
      fill(255, 0, 0);
      ellipse(nx, ny, 20, 20);
   
      fill(255);
      text(state + " - " + target + " | " + inventory.toString(), nx, ny);
    }
  }
}