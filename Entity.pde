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
}