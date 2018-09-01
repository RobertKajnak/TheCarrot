import java.util.List;

public class Civilization{
  String name;
  List <Unit> units = new ArrayList<Unit>();
  List <Building> buildings = new ArrayList<Building>();
  Inventory inventory = new Inventory();
  Techtree tech = new Techtree();

  public Civilization() {}
  
  public void add(Unit unit){
   units.add(unit); 
  }
  public void add(Building building){
    buildings.add(building);
  }
  
  
  void update(){
     for (Unit unit : units){
       unit.update();
     }
     
     for (Building building : buildings){
        building.update(); 
     }
  }
  
  void render() {
    for (Building building : buildings)
      building.render();
      
    for (Unit unit : units)
      unit.render();
  }
  
  
}