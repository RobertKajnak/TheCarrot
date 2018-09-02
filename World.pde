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
        reqAssets.add("wood");
        reqAssets.add("iron");
        reqAssets.add("building");
        reqAssets.add("construction_0");
        reqAssets.add("construction_1");
      
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
        civs.get(0).add(new Worker("peon",width/2,height/2, this, civs.get(0)));
        civs.get(0).add(new Worker("peon",0,0, this, civs.get(0)));
        civs.get(0).add(new BuildingUnderConstruction(200, 200, "construction_0"));
        
        //resources.add(new Stash(500, 300, "bush", new Food(50)));

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