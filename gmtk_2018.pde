
final String resdir = "assets/";
PImage imagePlaceholder;
Random RNG;

/// --- Camera values relative to the global map
int cameraX,cameraY; //top left corner
int cameraMinX, cameraMaxX, cameraMinY, cameraMaxY;
int zoomLevel = 1, zoomLimit = 16;
double widthForZoomLevel,heightForZoomLevel;
double cameraMoveSpeed = 10;

/// --- camera values relative to the display window
/// margin at which the camera is moved relative to the map and the cursor is changed
int margin = 30;

PImage[] cursorImgs;

Map<String,PImage> assets;
World world;

void setup() {
  size(1280,720);
  
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
  background(80,230,80);
  
  dir = 
  (offX == 7 && offY == 1)? 8 :
  (offX != 0 && offY != 0)? (offX+offY)/2 : offX+offY;
    
  if (dir != dirPrev){
    cursor(cursorImgs[dir],0,0);
    dirPrev = dir;     
  }
  cameraX += cameraMoveSpeed * (1+zoomLevel/2) * ((dir<=8 && dir>=6)?-1:(dir>=2 && dir<=4)?1:0);
  cameraY += cameraMoveSpeed * (1+zoomLevel/2) * ((dir%8<=2 && dir !=0)?-1:(dir>=4 && dir<=6)?1:0);
    
  int w = (int)(zoomLevel*widthForZoomLevel);
  int h = (int)(zoomLevel*heightForZoomLevel);
  cameraMinX = cameraX;
  cameraMaxX = cameraX + w;
  cameraMinY = cameraY;
  cameraMaxY = cameraY + h;
  
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
     if (zoomLevel<zoomLimit) {
       cameraX -= zoomLevel * widthForZoomLevel /2;
       cameraY -= zoomLevel * heightForZoomLevel /2;
       
       zoomLevel *= 2; 
     }
   }
   else{
      ///scroll down 
     if (zoomLevel>1){
       zoomLevel /= 2;
       
       cameraX += zoomLevel* widthForZoomLevel /2;
       cameraY += zoomLevel* heightForZoomLevel /2;
     }
   }
   println(cameraMaxX);
   //println(zoomLevel);
   //println(cameraX);
   //println(cameraX + zoomLevel* widthForZoomLevel/2);
}
