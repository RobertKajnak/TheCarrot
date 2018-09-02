
final String resdir = "assets/";
PImage imagePlaceholder;
Random RNG;

/// --- Camera values relative to the global map
int cameraX,cameraY; //top left corner
int cameraMinX, cameraMaxX, cameraMinY, cameraMaxY;
int zoomLevel = 1, zoomLimit = 16;
double widthForZoomLevel,heightForZoomLevel;
double cameraMoveSpeed = 10;
int mapXMin, mapXMax, mapYMin,mapYMax;

/// --- Minimap
Minimap minimap;

/// --- camera values relative to the display window
/// margin at which the camera is moved relative to the map and the cursor is changed
int margin = 30;
/// --- HUD
///Starting point of the interface
List<HUD> HUDs;
Wood dispwood; 
Food dispfood; 
Iron dispiron; 
Nuclear dispnuclear; 
Fervour dispfervour;

int R=80,G=230,B=80;

PImage[] cursorImgs;

Map<String,PImage> assets;
World world;
String activeBushType = "";

boolean debugView = false;

void setup() {
  size(1280,720);
  
  mapXMin = -1000;
  mapXMax = 5000;
  mapYMin = -1000;
  mapYMax = 5000;
  
  
  imagePlaceholder = loadImage(resdir + "placeholder.png");
  loadCursorImages();
  cursor(cursorImgs[0],0,0);
  
  RNG = new Random();
  assets = new HashMap<String,PImage>();
  world = new World("start");

  zoomLevel = 1;
  widthForZoomLevel = width ;
  heightForZoomLevel = height;
  imageMode(CENTER);
  textAlign(CENTER,CENTER);
  textSize(16);
  
  
  minimap = new Minimap(width-300,height-200,180,180,world);
  buildHUD();
  
} 

void loadCursorImages() {
  cursorImgs =new PImage[9];
  for (int i=0;i<9;i++){
   cursorImgs[i] = loadImage(resdir + "arrowHead"+i+".png"); 
  }
}


int dirPrev = 0;
int offX = 0;
int offY = 0;
int dir = 0;

void draw () {
  background(R,G,B);
  
  dir = 
  (offX == 7 && offY == 1)? 8 :
  (offX != 0 && offY != 0)? (offX+offY)/2 : offX+offY;
    
  if (dir != dirPrev){
    cursor(cursorImgs[dir],0,0);
    dirPrev = dir;     
  }
  
  cameraX += cameraMoveSpeed * (1+zoomLevel/2) * new int[]{0,0,1,1,1,0,-1,-1,-1}[dir];
  cameraY += cameraMoveSpeed * (1+zoomLevel/2) * new int[]{0,-1,-1,0,1,1,1,0,-1}[dir];
  cameraX = max(mapXMin,cameraX);
  cameraX = min(mapXMax - (int)(zoomLevel*widthForZoomLevel),cameraX);
  cameraY = max(mapYMin,cameraY);
  cameraY = min(mapYMax - (int)(zoomLevel*heightForZoomLevel),cameraY);
    
  int w = (int)(zoomLevel*widthForZoomLevel);
  int h = (int)(zoomLevel*heightForZoomLevel);
  cameraMinX = cameraX;
  cameraMaxX = cameraX + w;
  cameraMinY = cameraY;
  cameraMaxY = cameraY + h;
  
  ///A time based update would be better
  world.update();
  world.render();
  
  updateFervour();
  
  for (HUD hud : HUDs){
    hud.render();
  }
  
  minimap.render();
}

void keyPressed() {
  if (key == '`') {
    println("Debug View");
    debugView = !debugView;
  }
}

void mouseMoved() {
  /// --- camera related Assets
  //       1
  //    8     2
  // 7     0     3
  //    6     4
  //       5
  /// --- Determine camera to map movement direction and cursor graphic 
  
  offX = 
    (mouseX<margin)? 7 :
    (mouseX>width-margin)? 3 : 0;
    
  offY = 
    (mouseY<margin)? 1 : 
    (mouseY>height - margin)? 5 : 0;
    
    
  dir = 
    (offX == 7 && offY == 1)? 8 :
    (offX != 0 && offY != 0)? (offX+offY)/2 : offX+offY;
    
  if (dir != dirPrev){
    cursor(cursorImgs[dir],new int[]{3,15,31,31,31,15,0,0,0}[dir],new int[]{2,0,0,15,31,31,31,15,0}[dir]);
    dirPrev = dir;     
  }
}

void mouseWheel (MouseEvent event){
 //float c = event.getCount();
 //println(c);
 if (event.getCount()>0){
   ///scroll up
     if (zoomLevel<zoomLimit) {
       cameraX -= zoomLevel * widthForZoomLevel /2 ;
       cameraY -= zoomLevel * heightForZoomLevel /2;
       
       zoomLevel *= 2; 
     }
   }
   else{
      ///scroll down 
     if (zoomLevel>1){
       zoomLevel /= 2;
       
       cameraX += zoomLevel* widthForZoomLevel /2 + zoomLevel * widthForZoomLevel*(mouseX-width/2)/width;
       cameraY += zoomLevel* heightForZoomLevel /2 + zoomLevel * widthForZoomLevel*(mouseY-height/2)/height;
     }
   }
   //println(cameraMaxX);
   //println(zoomLevel * widthForZoomLevel);
   //println(cameraX);
   //println(cameraX + zoomLevel* widthForZoomLevel/2);
}

void mouseReleased(){
  boolean anyclicked = false;
   for (HUD hud : HUDs){
     anyclicked |= hud.click();
   }
   PVector minimapV = minimap.click();
   if (minimapV!=null){
     anyclicked = true;
     cameraX = (int)minimapV.x;
     cameraY = (int)minimapV.y;
   }
   if (
     !anyclicked && 
     insideRect(
       screenCoordToWorldCoord(mouseX, cameraX),
       screenCoordToWorldCoord(mouseY, cameraY), 
       mapXMin, 
       mapYMin, 
       (mapXMax-mapXMin)*2,
       (mapYMax-mapYMin)*2 
     )
   ) {
     Resource resToAdd;
     switch (activeBushType){
       case "bush":
         resToAdd = spendOnResource(new Food(50), 30);
         break;
       case "wood":
         resToAdd = spendOnResource(new Wood(50), 50);
         break;
       case "iron":
         resToAdd = spendOnResource(new Iron(50), 90);
         break;
       case "nuclear":
         resToAdd = spendOnResource(new Nuclear(50), 500);
         break;
       default:
         resToAdd = null;
         break;
     }
     
     if (resToAdd!=null){
         world.resources.add(
          new Stash(
            screenCoordToWorldCoord(mouseX, cameraX), 
            screenCoordToWorldCoord(mouseY, cameraY), 
            activeBushType, 
            resToAdd
          )
        );
     }
   }
}

Resource spendOnResource(Resource resource, int cost) {
  if (dispfervour.amount > cost) {
    dispfervour.amount -= cost;
    return resource;
  }
  return resource.withAmount(0);
}