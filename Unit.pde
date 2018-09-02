import java.util.Random;

abstract class Unit extends Entity {
  
  int speed = 1;
  int range = 500;
  
  World world;
  Civilization civ;
  
  int framesShown = 0, frameSwitch = 30, frameIndex = 0;
  int prevX = x; 
  int prevY = y;
  
  String state = "Idle";
  Coord target = null;
  
  public Unit(int x, int y, String name, World world, Civilization civ) {
    super(name, x, y);
    this.world = world;
    this.civ = civ;
  }
  
  boolean hasNoTarget() {
    return target == null;
  }
  
  int stepTowards(int s, int d, int speed) {
    return 
      (s < d)? s + speed :
      (s > d)? s - speed : s;
  }
  
  boolean isInRange(Entity a) {
    return distance(this, a) < range;
  }
  
  Coord selectRandomTarget(int x, int y) {
    int nx = randomBetweenBounds(x - 200, x + 200);
    int ny = randomBetweenBounds(y - 200, y + 200);
    return new Coord(nx, ny);
  }
  
  void moveTowardsTarget() {
    x = stepTowards(x, target.x, speed);
    y = stepTowards(y, target.y, speed);
  }
  
  Coord noTarget() {
    return null;
  }
  
  void render() {
    framesShown ++;
    if (framesShown > frameSwitch){
        framesShown = 0;
        if (x!=prevX || y!=prevY){
          frameIndex = frameIndex == 1?0:1;
        }
        else{
          frameIndex = 0; 
        }
     }
     
    prevX = x;
    prevY = y;
    
     if (frameIndex ==0){
        renderImage();
      }
      else{
        renderImage("_walk");
      }
    
    int nx = worldCoordToScreenCoord(x, cameraX);
    int ny = worldCoordToScreenCoord(y, cameraY);
    
    noStroke();
    fill(255, 255, 255, 50);
    ellipse(nx, ny, range * 2 / zoomLevel, range * 2 / zoomLevel);
    stroke(0);
  
    if (isVisible(x, y, 20, 20) && debugView) {
      
      fill(255, 255, 0, 0.5);
      ellipse(nx, ny, range * 2 / zoomLevel, range * 2 / zoomLevel);
      
      fill(civ.colour);
      ellipse(nx, ny, 20, 20);
   
      fill(255);
      text(state, nx, ny);
    }
  }
}

class Soldier extends Unit {
  
  public Soldier(int x, int y, World world, Civilization civ) {
    super(x, y, "soldier", world, civ);
  }
  
  void update() {
    switch(state) {
      case "Idle":
        state = "Wandering";
      
        break;
        
      case "Wandering":
        if (hasNoTarget() || distance(target, this) < 5)
            target = selectRandomTarget(x, y);
        else moveTowardsTarget();
        break;
        
      default:
        state = "Idle";
        break;
    }
  }
}

class Worker extends Unit {
  
  int extractingAmount = 10;
  Inventory inventory = new Inventory();
  
  public Worker(int x, int y, World world, Civilization civ) {
    super(x, y, "peon", world, civ);
    this.world = world;
    this.civ = civ;
  }
  
  void update() {
    switch (state) {
      case "Idle": 
        if (seeBuildingUnderConstruction()) {
          state = "Constructing";
          return;
        }
        
        if (canSeeStash()) {
          state = "Gathering";
          return;
        }
        
        if (canNotSeeBuildings(civ.buildings)) {
          state = "Wandering";
          return;
        }
        
        break;
      
      case "Gathering":
        if (seeBuildingUnderConstruction()) {
          target = noTarget();
          state = "Constructing";
          return;
        }
      
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
          target = noTarget();
          state = "Wandering";
        }
        else {
          if (hasNoTarget()) {
            target = selectBuilding(civ.buildings);
          }
          else {
          
            moveTowardsTarget();
          
            if (distance(target, this) < 10) {
              Building building = getTargetBuilding(civ.buildings);
              building.inventory.add(inventory);
              inventory = new Inventory();
            }
          
            if (inventory.empty()) {
              target = noTarget();
              state = "Idle";
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
          if (seeBuildingUnderConstruction()) {
            target = noTarget();
            state = "Constructing";
          } else {
            target = noTarget();
            state = "Collecting";
          }
        }
        break;
        
      case "Constructing":
        if (!seeBuildingUnderConstruction()) {
          state = "Idle";
          return;
        }
        else {
          if (hasNoTarget()) {
            target = serlectNewUnderConstruction(civ.underConstruction);
          }
          else {
            if (distance(target, this) < 20) {
              BuildingUnderConstruction building = findBuildingAtTarget(civ.underConstruction);
              if (building != null) {
                building.build();
              }
            }
            else {
              moveTowardsTarget();
            }
          }
          
        }
        
        break;
        
      default:
        println("UNRECOGNIZED STATE: " + state);
        target = noTarget();
        state = "Idle";
        break;
    }
  }
  
  Building getTargetBuilding(List<Building> buildings) {
    for (Building b : buildings)
      if (new Coord(b.x, b.y).equals(target))
        return b;
    return null;
  }
  
  boolean canSeeStash() {
    for (Stash s : world.resources)
      if (isInRange(s))
        return true;
    return false;
  }
  
  boolean seeBuildingUnderConstruction() {
    for (BuildingUnderConstruction b : civ.underConstruction)
      if (isInRange(b))
        return true;
    return false;
  }
  
  Coord selectBuilding(List<Building> buildings) {
    for (Building building : buildings)
      if (isInRange(building))
        return new Coord(building.x, building.y);
    return null;
  }
  
  BuildingUnderConstruction findBuildingAtTarget(List<BuildingUnderConstruction> buildings) {
    for (BuildingUnderConstruction b : buildings)
      if (target.equals(new Coord(b.x, b.y)))
        return b;
    return null;
  }
  
  Coord serlectNewUnderConstruction(List<BuildingUnderConstruction> buildings) {
    for (BuildingUnderConstruction building : buildings)
      if (isInRange(building))
        return new Coord(building.x, building.y);
    return null;
  }
  
  Coord selectNewStash(List<Stash> resources) {
    for (Stash resource : resources) 
      if (distance(resource, this) < range) 
        return new Coord(resource.x, resource.y);
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
  
  Stash getTargetStash(List<Stash> stashes) {
    for (Stash s : stashes) 
      if (new Coord(s.x, s.y).equals(target))
        return s;
    println("You should never see this message from getTargetStash!");
    return null;
  }
}