public abstract class Entity{

 int X,Y;
 PImage img;
 PImage avatar;
 
 public Entity(){
 }
 
 public Entity(PImage img){
  ///for simplicity, for now:
  this.img = img;
  avatar = this.img;
 }

public Entity(PImage img, int x, int y){
  this.X = x;
  this.Y = y;
  this.img = img;
  avatar = this.img;
  
}
 
 abstract void update();
 
 void paint(){
   if (cameraMinX < X + img.width && cameraMaxX > X - img.width && 
       cameraMinY < Y + img.height && cameraMaxY > Y - img.height){
         image (this.img,X - cameraX, Y - cameraY);
   }
 }
  
}
