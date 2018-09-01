import java.util.List;
import java.util.Map;

class World {
  List <Civilization> civs;
  List <Resource> ress;


  List<String> reqAssets;
  public World(String level) {
    civs = new ArrayList<Civilization>();
    ress = new ArrayList<Resource>();
    reqAssets = new ArrayList<String>();
    //civ1 = new Civilization();

    switch (level) {
    case "start":
      reqAssets.add("grass");
      reqAssets.add("peon");
      civs.add(new Civilization());
      for (String ass : reqAssets) {
        assets.put(ass, loadImage(resdir + ass + ".png"));
      }

      PImage im = assets.get("peon1");
      if (im==null)
        im = imagePlaceholder;
      civs.get(0).add(new Unit(im,100,100));
      //PImage peon2 = loadImage(resdir + "peon_p2.png");

      break;
    }
  }

  public void update() {
    for (Civilization civ : civs) {
      civ.update();
    }
  }
}
