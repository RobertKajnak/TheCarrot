import java.util.List;
import java.util.Map;

class World {
  List <Civilization> civs = new ArrayList<Civilization>();;
  public List<Stash> resources = new ArrayList<Stash>();

  List<String> reqAssets = new ArrayList<String>();
  
  public World(String level) {

    switch (level) {
      case "start":
        reqAssets.add("grass");
        reqAssets.add("peon");
        reqAssets.add("bush");
      
        civs.add(new Civilization());
      
        for (String ass : reqAssets) {
          PImage assIm = loadImage(resdir + ass + ".png");
        
          for (int i=1;i<=zoomLimit;i*=2){
            PImage assImResized = assIm.copy();
            assImResized.resize(assIm.width/i,assIm.height/i);
            assets.put(ass + "_z" + i, assImResized);
          }
        }

        // Initializations
        civs.get(0).add(new Unit("peon",width/2,height/2, this, civs.get(0)));
        civs.get(0).add(new Unit("peon",100,100, this, civs.get(0)));
        civs.get(0).add(new Building(200, 200, "Building"));
        
        resources.add(new Stash(500, 300, "bush", new Food(10000)));

        break;
    }
  }

  public void update() {
    for (Civilization civ : civs)
      civ.update();
      
    removeDepletedResources();
  }
  
  private void removeDepletedResources() {
    List<Stash> tempRes = resources;
    resources = new ArrayList<Stash>();
    
    for (Stash res : tempRes)
      if (res.type.amount > 0) {
        resources.add(res);
      }
  }
  
  public void render() {
    for (Stash resource : resources)
      resource.render();
  
    for (Civilization civ : civs)
      civ.render();
  }
}