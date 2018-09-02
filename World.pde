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
        reqAssets.add("peon_left");
        reqAssets.add("peon_walk");
        reqAssets.add("peon_walk_left");
        reqAssets.add("soldier");
        reqAssets.add("soldier_left");
        reqAssets.add("soldier_walk");
        reqAssets.add("soldier_walk_left");
        reqAssets.add("bush");
        reqAssets.add("wood");
        reqAssets.add("iron");
        reqAssets.add("building");
        reqAssets.add("construction_0");
        reqAssets.add("construction_1");
      
        for (String ass : reqAssets) {
          PImage assIm = loadImage(resdir + ass + ".png");
        
          for (int i=1;i<=zoomLimit;i*=2){
            PImage assImResized = assIm.copy();
            assImResized.resize(assIm.width/i,assIm.height/i);
            assets.put(ass + "_z" + i, assImResized);
          }
        }
        
        
        // Initializations
        Civilization moustache = new Civilization("Moustache", color(255, 0, 0));
        civs.add(moustache);
        moustache.add(new Worker(width/2,height/2, this, moustache));
        moustache.add(new Worker(0,0, this, moustache));
        moustache.add(new BuildingUnderConstruction(200, 200, moustache));
        moustache.add(new Soldier(500, 500, this, moustache));
        
        Civilization randors = new Civilization("Randors", color(0, 0, 255));
        civs.add(randors);
        randors.add(new Worker(width, height, this, randors));
        randors.add(new BuildingUnderConstruction(width, height, randors));
        randors.add(new Soldier(700, 500, this, randors));
         ai = new AI(randors, this);
        
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