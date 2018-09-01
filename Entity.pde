public abstract class Entity{

 int X,Y;
 
 String name;
 //PImage img;
 //PImage avatar;
 
 public Entity(){
 }
 
 /*public Entity(PImage img){
  ///for simplicity, for now:
  this.img = img;
  avatar = this.img;
 }

public Entity(PImage img, int x, int y){
  this.X = x;
  this.Y = y;
  this.img = img;
  avatar = this.img;
  
}*/
public Entity(String name, int x, int y){
  this.name = name;
  this.X = x;
  this.Y = y;
}
 
 abstract void update();
 
 void paint(){
   PImage img = assets.get(name + "_z" + zoomLevel);
    if (img==null)
        img = imagePlaceholder;
        
   if (cameraMinX < X + img.width && cameraMaxX > X - img.width && 
       cameraMinY < Y + img.height && cameraMaxY > Y - img.height){
         image (img,X/zoomLevel - cameraX, Y/zoomLevel - cameraY);
   }
 }
  
}
