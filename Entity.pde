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

 
 abstract void update();
 
 void draw(){
   if (cameraMinX < X && cameraMaxX >X && cameraMinY < Y && cameraMaxY > Y){
     //img = ;
   }
 }
  
}
