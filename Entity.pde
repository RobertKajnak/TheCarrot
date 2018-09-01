abstract class Entity{

  public int x;
  public int y; 
  public String name;

  public Entity(String name, int x, int y){
    this.name = name;
    this.x = x;
    this.y = y;
  }
  
  abstract void update();
  
  abstract void render();
  
  int worldCoordToScreenCoord(int s, int cameraPos, int zoomLevel) {
    return (s - cameraPos)/zoomLevel;
  }
  
  boolean isVisible(int x, int y, int width, int height) {
  return cameraMinX < x + width && cameraMaxX > x - width && 
         cameraMinY < y + height && cameraMaxY > y - height;
  }
  
  void renderImage(){
     PImage img = assets.get(name + "_z" + zoomLevel);
     if (img==null) img = imagePlaceholder;
          
     if (isVisible(x, y, img.width, img.height))
       image (
         img, 
         worldCoordToScreenCoord(x, cameraX, zoomLevel), 
         worldCoordToScreenCoord(y, cameraY, zoomLevel)
       );
  }
}