
class Building extends Entity {
 
  Inventory inventory = new Inventory();
  
  public Building(int x, int y, String name) {
    super(name, x,y);
  }

  void update (){
    
  }
  
  void render() {
    fill(255, 0, 0);
    rect(x, y, 50, 50);
    
    fill(255);
    text(inventory.toString(), x, y);
  }
}