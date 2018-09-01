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
  
  void renderImage(){
     PImage img = assets.get(name + "_z" + zoomLevel);
     if (img==null)
          img = imagePlaceholder;
          
     if (cameraMinX < x + img.width && cameraMaxX > x - img.width && 
         cameraMinY < y + img.height && cameraMaxY > y - img.height){
           image (img,x/zoomLevel - cameraX - img.width/2, y/zoomLevel - cameraY-img.height/2);
     }
  }
}