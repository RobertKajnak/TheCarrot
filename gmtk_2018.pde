
final String resdir = "assets/";

/// --- Camera values relative to the global map
int cameraX,cameraY;
int cameraMinX, cameraMaxX, cameraMinY, cameraMaxY;
int zoomLevel;
double widthForZoomLevel;

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


World world;

void setup() {
  size(1280,720);
  cursorImgs =new PImage[9];
  for (int i=0;i<9;i++){
   cursorImgs[i] = loadImage(resdir + "arrowHead"+i+".png"); 
  }
  world = new World("start");

} 



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
  cursor(cursorImgs[dir],0,0);
    
  int w = (int)(zoomLevel*widthForZoomLevel/2);
  
  cameraMinX = cameraX - w;
  cameraMaxX = cameraX + w;
  cameraMinY = cameraY - w;
  cameraMaxY = cameraY + w;
  ///A time based update would be better
  
}
