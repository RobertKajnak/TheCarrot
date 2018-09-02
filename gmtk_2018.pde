
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

/// --- camera values relative to the display window
/// margin at which the camera is moved relative to the map and the cursor is changed
int margin = 30;
/// --- HUD
///Starting point of the interface
List<HUD> HUDs;
Wood dispwood; Food dispfood; Iron dispiron; Nuclear dispnuclear; Fervour dispfervour;
int R=80,G=230,B=80;

PImage[] cursorImgs;

Map<String,PImage> assets;
World world;

void setup() {
  size(1280,720);
  
  mapXMin = -10000;
  mapXMax = 100000;
  mapYMin = -10000;
  mapYMax = 100000;
  
  
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
  
  buildHUD();
  
} 

void buildHUD(){
  String [] reqAssets = {"tree","rock","meat","nuclear","fervour"};
  for (String ass : reqAssets) {
      assets.put(ass,loadImage(resdir + ass + ".png"));
      assets.put(ass+"_highlight",loadImage(resdir + ass + "_highlight.png"));
  }
  HUDs = new ArrayList<HUD>();
  HUD mainHUD = new HUD(null,width/2,height - height /5/2,width*2/4,height/5);
  
  dispfood = new Food(0);
  mainHUD.add(new InterfaceText(mainHUD,100,105,new Food(30),color(255,0,0)));
  mainHUD.add(new InterfaceText(mainHUD,100,30,dispfood,0));
  mainHUD.add(new Button(mainHUD,100,70,"meat",new Runnable(){public void run(){R=255-R;G=255-G;B=255-B;};}));
  
  dispwood = new Wood(0);
  mainHUD.add(new InterfaceText(mainHUD,200,105,new Wood(50),color(255,0,0)));
  mainHUD.add(new InterfaceText(mainHUD,200,30,dispwood,0));
  mainHUD.add(new Button(mainHUD,200,70,"tree",new Runnable(){public void run(){R=255-R;G=255-G;B=255-B;};}));
  
  dispiron = new  Iron(0);
  mainHUD.add(new InterfaceText(mainHUD,300,105,new Iron(90),color(255,0,0)));
  mainHUD.add(new InterfaceText(mainHUD,300,30,dispiron,0));
  mainHUD.add(new Button(mainHUD,300,70,"rock",new Runnable(){public void run(){R=255-R;G=255-G;B=255-B;};}));
  
  dispnuclear = new  Nuclear(0);
  mainHUD.add(new InterfaceText(mainHUD,400,105,new Nuclear(500),color(255,0,0)));
  mainHUD.add(new InterfaceText(mainHUD,400,30,dispnuclear,0));
  mainHUD.add(new Button(mainHUD,400,70,"nuclear",new Runnable(){public void run(){R=255-R;G=255-G;B=255-B;};}));
  
  dispfervour = new  Fervour(0);
  mainHUD.add(new InterfaceText(mainHUD,500,30,dispfervour,0));
  mainHUD.add(new Button(mainHUD,500,70,"fervour",new Runnable(){public void run(){R=255-R;G=255-G;B=255-B;};}));
  HUDs.add(mainHUD);
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
  dispfervour.amount ++;
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
  cameraX = min(mapXMax,cameraX);
  cameraY = max(mapYMin,cameraY);
  cameraY = min(mapYMax,cameraY);
    
  int w = (int)(zoomLevel*widthForZoomLevel);
  int h = (int)(zoomLevel*heightForZoomLevel);
  cameraMinX = cameraX;
  cameraMaxX = cameraX + w;
  cameraMinY = cameraY;
  cameraMaxY = cameraY + h;
  
  ///A time based update would be better
  world.update();
  world.render();
  
  for (HUD hud : HUDs){
    hud.render();
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

void mousePressed() {
  world.resources.add(
    new Stash(
      screenCoordToWorldCoord(mouseX, cameraX), 
      screenCoordToWorldCoord(mouseY, cameraY), 
      "bush", 
      new Food(5)
    )
  );
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

void mouseClicked(){
   for (HUD hud : HUDs){
     hud.click();
   }
}
