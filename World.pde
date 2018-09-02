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
        
        reqAssets.add("peasant");
        reqAssets.add("peasant_left");
        reqAssets.add("peasant_walk");
        reqAssets.add("peasant_walk_left");
        
        
        reqAssets.add("soldier");
        reqAssets.add("soldier_left");
        reqAssets.add("soldier_walk");
        reqAssets.add("soldier_walk_left");
        
        reqAssets.add("militant");
        reqAssets.add("militant_left");
        reqAssets.add("militant_walk");
        reqAssets.add("militant_walk_left");
        
        reqAssets.add("bush");
        reqAssets.add("wood");
        reqAssets.add("iron");
        
        reqAssets.add("building");
        reqAssets.add("construction_0");
        reqAssets.add("construction_1");
        
        reqAssets.add("building_2");
        reqAssets.add("construction_2_0");
        reqAssets.add("construction_2_1");
        
      
        for (String ass : reqAssets) {
          PImage assIm = loadImage(resdir + ass + ".png");
        
          for (int i=1;i<=zoomLimit;i*=2){
            PImage assImResized = assIm.copy();
            assImResized.resize(assIm.width/i,assIm.height/i);
            assets.put(ass + "_z" + i, assImResized);
          }
        }
        
        
        // Initializations
        Civilization moustache = new Civilization("Moustache", color(255, 0, 0), "building", "construction_0", "construction_1", "peon", "soldier");
        civs.add(moustache);
        //moustache.add(new Worker(width/2,height/2, this, moustache));
        int startX = randomBetweenBounds(mapXMin, mapXMax);
        int startY = randomBetweenBounds(mapYMin, mapYMax);
        moustache.add(new Worker(startX,startY, this, moustache));
        moustache.add(new BuildingUnderConstruction(startX, startY, moustache));
        //moustache.add(new Soldier(500, 500, this, moustache));
        
        Civilization randors = new Civilization("Randors", color(0, 0, 255), "building_2", "construction_2_0", "construction_2_1", "peasant", "militant");
        civs.add(randors);
        int startX2 = randomBetweenBounds(mapXMin, mapXMax);
        int startY2 = randomBetweenBounds(mapYMin, mapYMax);
        randors.add(new Worker(startX2, startY2, this, randors));
        randors.add(new BuildingUnderConstruction(startX2, startY2, randors));
        //randors.add(new Soldier(700, 500, this, randors));
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