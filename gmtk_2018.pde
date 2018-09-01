
final String resdir = "assets/";
PImage imagePlaceholder;
Random RNG;

/// --- Camera values relative to the global map
int cameraX,cameraY; //top left corner
int cameraMinX, cameraMaxX, cameraMinY, cameraMaxY;
int zoomLevel = 1, zoomLimit = 16;
double widthForZoomLevel,heightForZoomLevel;

/// --- camera values relative to the display window
/// margin at which the camera is moved relative to the map and the cursor is changed
int margin = 30;

PImage[] cursorImgs;

Map<String,PImage> assets;
World world;

void setup() {
  size(1280,720);
  
  loadCursorImages();
  
  RNG = new Random();
  assets = new HashMap<String,PImage>();
  world = new World("start");

  zoomLevel = 1;
  widthForZoomLevel = width ;
  heightForZoomLevel = height;
} 

void loadCursorImages() {
  cursorImgs =new PImage[9];
  for (int i=0;i<9;i++){
   cursorImgs[i] = loadImage(resdir + "arrowHead"+i+".png"); 
  }
  imagePlaceholder = loadImage(resdir + "placeholder.png");
}


int dirPrev = 0;
int offX = 0;
int offY = 0;
int dir = 0;

void draw () {
  background(80,230,80);
  
    
  int w = (int)(zoomLevel*widthForZoomLevel/2);
  int h = (int)(zoomLevel*heightForZoomLevel/2);
  cameraMinX = cameraX+width/2 - w;
  cameraMaxX = cameraX+width/2 + w;
  cameraMinY = cameraY+height/2 - h;
  cameraMaxY = cameraY+height/2 + h;
  
  ///A time based update would be better
  world.update();
  world.render();
  
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
    cursor(cursorImgs[dir],0,0);
    dirPrev = dir;     
  }
}

void mouseWheel (MouseEvent event){
 //float c = event.getCount();
 //println(c);
 if (event.getCount()>0){
   ///scroll up
     if (zoomLevel<zoomLimit) {}
       //zoomLevel *= 2;
   }
   else{
      ///scroll down 
     if (zoomLevel>1) {}
       //zoomLevel /= 2;
   }
}