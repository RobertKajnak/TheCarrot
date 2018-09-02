class Worker extends Unit {
  
  int extractingAmount = 10;
  Inventory inventory = new Inventory();
  
  public Worker(int x, int y, World world, Civilization civ) {
    super(x, y, civ.unitName, world, civ);
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
    Coord best = null;
    float bestDistance = 9999999;
    
    for (Building building : buildings) { 
      float dist = distance(building, this);
      if (dist < range && dist < bestDistance) {
        bestDistance = dist;
        best = new Coord(building.x, building.y);
      }
    }
    return best;
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
    Coord best = null;
    float bestDistance = 9999999;
    
    for (Stash resource : resources) { 
      float dist = distance(resource, this);
      if (dist < range && dist < bestDistance) {
        bestDistance = dist;
        best = new Coord(resource.x, resource.y);
      }
    }
    return best;
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