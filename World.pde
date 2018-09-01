import java.util.List;

class World{
 List <Civilization> civils;
 List <Resource> resources;
  
  public World(String level){
    
    //civ1 = new Civilization();
    
      
    ///art assets
    switch (level){
      case "start":
        PImage grassimg = loadImage(resdir + "grass.png");
        PImage peon1 = loadImage(resdir + "peon_p1.png");
        //PImage peon2 = loadImage(resdir + "peon_p2.png");
        
      break;
    }
    
  }
  
}
