abstract class Entity{

  public int x;
  public int y; 
  public String name;
  
  int hitPoints = 100;
  int damage = 10;

  public Entity(String name, int x, int y){
    this.name = name;
    this.x = x;
    this.y = y;
  }
  
  abstract void update();
  
  abstract void render();
  
  void renderImage(){
    renderImage("");
  }
  
  void renderImage(String suffix){
    PImage img = assets.get(name +suffix+ "_z" + zoomLevel);
     if (img==null) img = imagePlaceholder;
                
     if (isVisible(x, y, img.width, img.height)) {
       
       int nx = worldCoordToScreenCoord(x, cameraX); 
       int ny = worldCoordToScreenCoord(y, cameraY);
       
       image(img, nx, ny);
       
       int start = nx - 30;
       int end = nx + 30; 
       int length = end - start;
    
       if (hitPoints < 100) {
         strokeWeight(4);
         stroke(255, 0, 0);
         line(start, ny - 50, end, ny - 50);
    
         stroke(0, 255, 0);
         float hp = map(hitPoints, 0, 100, 0, length);
         line(start, ny - 50, start + hp, ny - 50);
         strokeWeight(1);
    }
     }
  }
  
  int buffer = 0;
  
  void damage(int dmg) {
    buffer++;
    if (buffer > 15) {
      buffer = 0;
      hitPoints -= dmg;
    }
  }
}