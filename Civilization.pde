import java.util.List;

public class Civilization {
  
  String name;
  int colour;
  String buildingName;
  String constructionName1;
  String constructionName2;
  String unitName;
  String soldierName;
  
  List<Unit> units = new ArrayList<Unit>();
  List<Building> buildings = new ArrayList<Building>();
  List<BuildingUnderConstruction> underConstruction = new ArrayList<BuildingUnderConstruction>();
  Inventory inventory = new Inventory();
  Techtree tech = new Techtree();

  public Civilization(String name, int colour, String buildName, String constrName1, String constrName2, String unitName, String soldierName) {
    this.name = name;
    this.colour = colour;
    buildingName = buildName;
    constructionName1 = constrName1;
    constructionName2 = constrName2;
    this.unitName = unitName;
    this.soldierName = soldierName;
  }
  
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
     removeDeadUnits();
     removeDeadBuildings();
     removeDeadBUC();
     
     if (underConstruction.size() == 0 && buildings.size() == 0) {
       if (name == "Moustache") gameState = -1;
       else gameState = 1;
     }
  }
  
  void removeDeadUnits() {
    ArrayList<Unit> alive = new ArrayList<Unit>();
    
    for (Unit entity : units)
      if (entity.hitPoints > 0)
        alive.add(entity);
        
    units = alive;
  }
  
  void removeDeadBuildings() {
    ArrayList<Building> alive = new ArrayList<Building>();
    
    for (Building entity : buildings)
      if (entity.hitPoints > 0)
        alive.add(entity);
        
    buildings = alive;
  }
  
  void removeDeadBUC() {
    ArrayList<BuildingUnderConstruction> alive = new ArrayList<BuildingUnderConstruction>();
    
    for (BuildingUnderConstruction entity : underConstruction)
      if (entity.hitPoints > 0)
        alive.add(entity);
        
    underConstruction = alive;
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
      
    for (BuildingUnderConstruction building : underConstruction)
      building.render();
      
    for (Unit unit : units)
      unit.render();
  }
}