import java.util.Random;

class Unit extends Entity {
  
  World world;
  Civilization civ;
  
  int speed = 1;
  int range = 500;
  Inventory inventory = new Inventory();
  
  String state = "Gathering";
  
  public Unit(String name, int x, int y, World world, Civilization civ) {
    super(name,x,y);
    this.world = world;
    this.civ = civ;
  }
  
  void update() {
    switch (state) {
      case "Gathering":
        for (Resource resource : world.resources) {
          
          if (distance(resource, this) < range) {
            x = stepTowards(x, resource.x, speed);
            y = stepTowards(y, resource.y, speed);
          }
          
          if (distance(resource, this) < 10) {
            resource.extract(10);
            inventory.add(resource.name, 10);
          }
          
          if (inventory.nonEmpty()) {
            state = "Collecting";
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
   
   //this.x += RNG.nextInt()%20 + (10 *Math.signum(mouseX-x/zoomLevel))* Math.abs(RNG.nextDouble());
   //this.y += RNG.nextInt()%20 + (10* Math.signum(mouseY-y/zoomLevel))* Math.abs(RNG.nextDouble());
  }
  
  int stepTowards(int s, int d, int speed) {
    return 
      (s < d)? s + speed :
      (s > d)? s - speed : s;
  }
 
 void render() {
  renderImage();
  
   fill(255, 0, 0);
   ellipse(x, y, 20, 20);
   
   fill(255);
   text(state, x, y);
 }
}
