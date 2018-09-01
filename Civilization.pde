import java.util.List;

public class Civilization{
  String name;
  List <Unit> units;
  List <Building> buildings;
  Inventory inv;
  Techtree tech;
  
  public Civilization(){
   units = new ArrayList<Unit>();
   buildings = new ArrayList<Building>(); 
  }
  
  void update(){
     for (Unit unit : units){
       unit.update();
     }
     
     for (Building building : buildings){
        building.update(); 
     }
  }
  
}
