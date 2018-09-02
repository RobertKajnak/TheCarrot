abstract class InterfaceItem{
  int interfaceOX, interfaceOY,X,Y;
 protected String label;
 protected PImage img, imgHover;
 protected Runnable function;
 protected boolean isImg;
 protected boolean isImgHighlight;
 
 public InterfaceItem(int interfaceOX, int interfaceOY,int X,int Y,String label){
   this.X = X + interfaceOX;
   this.Y = Y + interfaceOY;
   this.interfaceOX = interfaceOX;
   this.interfaceOY = interfaceOY;
   this.label = label;
   
   img = assets.get(label);
   isImg = img != null;
   if ( !isImg){
         this.img = createImage(100, 30, ARGB);
         for (int i = 0; i < this.img.pixels.length; i++) {
            this.img.pixels[i] = color(250, 250, 50); 
          }
   }
   
   imgHover = assets.get(label+"_highlight");
   isImgHighlight = imgHover != null;

   if (!isImgHighlight){
         this.imgHover = createImage(100, 30, ARGB);
         for (int i = 0; i < this.imgHover.pixels.length; i++) {
            this.imgHover.pixels[i] = color(50, 50, 50); 
          }
   }
 }
 
 public InterfaceItem(int interfaceOX, int interfaceOY,int X,int Y,String label,Runnable function){
  this(interfaceOX,interfaceOY,X,Y,label);
  this.function = function;
 }

  ///checks if the Hovering version is required to be displayed based on mouse coordinates
  public void render(){
    if (insideRect(mouseX,mouseY, X, Y, img.width,img.height)){
      image(imgHover, X, Y);
      if (!isImgHighlight){
        fill(0, 250, 255);
        text(label, X,Y);
      }
    }
    else{
       image(img, X, Y); 
       if (!isImg){
         fill(0, 50, 65);
         text(label, X,Y);
       }
       
    }
  }
  
  public void click(){
    if (function!=null && insideRect(mouseX,mouseY, X, Y, img.width,img.height))
       function.run();
    
  }
  
}
