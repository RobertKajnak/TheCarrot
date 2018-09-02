class Minimap{
  int x, y, w, h;
  World world;
  
  public Minimap(int x, int y, int w, int h,World world){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.world = world;
    
  }
  
public int mapx2mini(int c){
    return w * (c-mapXMin)/(mapXMax - mapXMin);
}
public int mapy2mini(int c){
    return h * (c-mapYMin)/(mapYMax - mapYMin);
}

public int minix2map(int c){
    return c * (mapXMax - mapXMin) / w + mapXMin - (int)(zoomLevel*widthForZoomLevel)/2;
}
public int miniy2map(int c){
    return c * (mapYMax - mapYMin) / h + mapYMin - (int)(zoomLevel*heightForZoomLevel)/2;
}

public PVector click(){
  if (insideRect(mouseX,mouseY, x+w/2, y+h/2, w, h)){
    return new PVector(minix2map(mouseX-x),miniy2map(mouseY-y));
  }
  return null;
  
}
public void render(){
    int r = (w+h)/60;
    fill(0,0,0,50);
    rect(x-r,y-r,w+r*2,h+r*2);
    
    noFill();
    int scrX0 = mapx2mini(cameraMinX);
    int scrY0 = mapy2mini(cameraMinY);
    int scrX1 = mapx2mini(cameraMaxX);
    int scrY1 = mapy2mini(cameraMaxY);
    println(scrX0);
    rect(x+scrX0,y+scrY0,scrX1-scrX0,scrY1-scrY0);
    
    for (Stash resource : world.resources){
      switch(resource.type.getName()){
        case "Food":
          fill(color(237,30,30));
        break;
        case "Wood":
          fill(color(185,94,0));
        break;
        case "Iron":
          fill(color(80,80,80));
        break;
        case "Nuclear":
          fill(color(92,255,0));
        break;
        default:
          fill(color(237,255,0));
        break;
      }
      ellipse(x+mapx2mini(resource.x),y+mapy2mini(resource.y),r,r);
    }
    
    for (Civilization civ : world.civs)
    {
      fill(civ.colour);
      for (Building building : civ.buildings)
        rect(x+mapx2mini(building.x),y+mapy2mini(building.y),r,r);
      
      for (BuildingUnderConstruction building : civ.underConstruction)
        rect(x+mapx2mini(building.x),y+mapy2mini(building.y),r,r);
        
      for (Unit unit : civ.units)
        ellipse(x+mapx2mini(unit.x),y+mapy2mini(unit.y),r,r);
    }
  } 
  
}