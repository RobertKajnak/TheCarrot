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
    
    hitPoints = 100;
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
        if (y!=prevY || x!=prevX){
          if (x-prevX<0){
            if (frameIndex/2==0)
              frameIndex+=2;
          }
          else if (x-prevX>0){
             if (frameIndex/2==1){
               frameIndex-=2;
             }
          }
          frameIndex = frameIndex %2==0? frameIndex+1:frameIndex-1;
        }
        else{
          frameIndex = 0; 
        }
     }
     
    prevX = x;
    prevY = y;
    
    switch (frameIndex){
     case 1:
       renderImage("_walk");
     break;
     case 2:
       renderImage("_left");
     break;
     case 3:
       renderImage("_walk_left");
       break;
     default:
       renderImage();
     break;
    }
    
    int nx = worldCoordToScreenCoord(x, cameraX);
    int ny = worldCoordToScreenCoord(y, cameraY);
    
    //noStroke();
    //fill(255, 255, 255, 50);
    noFill();
    stroke(47,235,230);
    ellipse(nx, ny, range * 2 / zoomLevel, range * 2 / zoomLevel);
    stroke(0);
  
    if (isVisible(x, y, 20, 20) && debugView) {
      
      fill(255, 255, 0, 0.5);
      ellipse(nx, ny, range * 2 / zoomLevel, range * 2 / zoomLevel);
      
      fill(civ.colour);
      ellipse(nx, ny, 20, 20);
   
      fill(255);
      text(state + ": " + hitPoints, nx, ny);
    }
  }
}
