abstract class InterfaceItem{
  int interfaceOX, interfaceOY,X,Y;
 protected String label;
 protected PImage img, imgHover;
 protected Runnable function;
 
 public InterfaceItem(int interfaceOX, int interfaceOY,int X,int Y,String label){
   this.X = X + interfaceOX;
   this.Y = Y + interfaceOY;
   this.interfaceOX = interfaceOX;
   this.interfaceOY = interfaceOY;
   this.label = label;
   
   img = assets.get("placeholder");
   imgHover = assets.get("placeholder");
 }
 
 public InterfaceItem(int interfaceOX, int interfaceOY,int X,int Y,String label,Runnable function){
  this(interfaceOX,interfaceOY,X,Y,label);
  this.function = function;
 }
  
  
  ///checks if the Hovering version is required to be displayed based on mouse coordinates
  public void render(){
    if (insideRect(mouseX,mouseY, X, Y, img.width,img.height)){
      image(imgHover, X, Y);
      fill(0, 250, 255);
      text(label, X,Y);
    }
    else{
       image(img, X, Y); 
       fill(0, 50, 65);
       text(label, X,Y);
    }
  }
  
  public void click(){
    if (function!=null)
       function.run();
    
  }
  
}
