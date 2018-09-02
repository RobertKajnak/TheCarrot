abstract class Entity{

  public int x;
  public int y; 
  public String name;
  
  int hitPoints = 100;

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
          
     if (isVisible(x, y, img.width, img.height))
       image (
         img, 
         worldCoordToScreenCoord(x, cameraX), 
         worldCoordToScreenCoord(y, cameraY)
       );
  }
  
  int buffer = 0;
  
  void damage() {
    buffer++;
    if (buffer > 15) {
      buffer = 0;
      hitPoints -= 10;
    }
  }
}