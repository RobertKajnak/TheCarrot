import java.util.List;

public class Civilization{
  String name;
  List<Unit> units = new ArrayList<Unit>();
  List<Building> buildings = new ArrayList<Building>();
  List<BuildingUnderConstruction> underConstruction = new ArrayList<BuildingUnderConstruction>();
  Inventory inventory = new Inventory();
  Techtree tech = new Techtree();

  public Civilization() {}
  
  public void add(Unit unit){
   units.add(unit); 
  }
  
  public void add(BuildingUnderConstruction building){
    underConstruction.add(building);
  }
  
  
  void update(){
     for (Unit unit : units)
       unit.update();
     
     for (Building building : buildings)
        building.update(); 
     
     for (BuildingUnderConstruction building : underConstruction)
       building.update();
     
     finalizeFinishedBuildings();
  }
  
  void finalizeFinishedBuildings() {
    List<BuildingUnderConstruction> finalized = new ArrayList<BuildingUnderConstruction>();
    List<BuildingUnderConstruction> notFinalized = new ArrayList<BuildingUnderConstruction>();
    
    for (BuildingUnderConstruction building : underConstruction)
      if (building.finishedPercent >= 100)
        finalized.add(building);
      else 
        notFinalized.add(building);
        
    for (BuildingUnderConstruction building : finalized)
      buildings.add(new Building(building.x, building.y, building.name, world, this));
      
    underConstruction = notFinalized;
  }
 
  
  void render() {
    for (Building building : buildings)
      building.render();
      
    for (Unit unit : units)
      unit.render();
      
    for (BuildingUnderConstruction building : underConstruction)
      building.render();
  }
  
  
}