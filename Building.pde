
class Building extends Entity {
 
  Inventory inventory = new Inventory();
  
  public Building(int x, int y, String name) {
    super(name, x,y);
  }

  void update (){
    
  }
  
  void render() {
    if (isVisible(x, y, 20, 20)) {
      
      int nx = worldCoordToScreenCoord(x, cameraX, zoomLevel);
      int ny = worldCoordToScreenCoord(y, cameraY, zoomLevel);
     
      fill(255, 0, 0);
      rect(nx, ny, 50, 50);
    
      fill(255);
      text(inventory.toString(), nx, ny);
    }
  }
}