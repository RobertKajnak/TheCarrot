
final String resdir = "assets/";
PImage imagePlaceholder;
Random RNG;

/// --- Camera values relative to the global map
int cameraX,cameraY; //top left corner
int cameraMinX, cameraMaxX, cameraMinY, cameraMaxY;
int zoomLevel = 1;
double widthForZoomLevel,heightForZoomLevel;

/// --- camera values relative to the display window
/// margin at which the camera is moved relative to the map and the cursor is changed
int margin = 30;

/// --- camera related Assets
//      1
//   8     2
//7     0     3
//   6     4
//      5
PImage[] cursorImgs;


Map<String,PImage> assets;
World world;

void setup() {
  size(1280,720);
  cursorImgs =new PImage[9];
  for (int i=0;i<9;i++){
   cursorImgs[i] = loadImage(resdir + "arrowHead"+i+".png"); 
  }
  imagePlaceholder = loadImage(resdir + "placeholder.png");
  
  RNG = new Random();
  assets = new HashMap<String,PImage>();
  world = new World("start");

  zoomLevel = 1;
  widthForZoomLevel = width ;
  heightForZoomLevel = height;
} 


int dirPrev=0;
void draw () {
  /// --- Determine camera to map movement direction and cursor graphic 
  int offX=0, offY=0, dir;
  if (mouseX<margin)
    offX = 7;
  if (mouseX>width-margin)
    offX = 3;
  if (mouseY<margin)
    offY = 1;
  if (mouseY>height - margin)
    offY = 5;
  if (offX == 7 && offY == 1)
    dir = 8;
  else if (offX != 0 && offY != 0)
    dir = (offX+offY)/2;
  else
    dir = offX+offY;
  if (dir!=dirPrev){
    cursor(cursorImgs[dir],0,0);
    dirPrev = dir;     
  }
    
  int w = (int)(zoomLevel*widthForZoomLevel/2);
  int h = (int)(zoomLevel*heightForZoomLevel/2);
  cameraMinX = cameraX+width/2 - w;
  cameraMaxX = cameraX+width/2 + w;
  cameraMinY = cameraY+height/2 - h;
  cameraMaxY = cameraY+height/2 + h;
  ///A time based update would be better
  world.update();
  
}
