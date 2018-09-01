class Button extends InterfaceItem{
   
  public Button(int offsetX, int offsetY, int x, int y, String label,Runnable function){
     super(offsetX,offsetY,x,y,label);
     
     this.img = loadImage("buttonBacground.png");
     this.imgHover = loadImage("buttonBackgroundHighlight.png");
     if (this.img == null){
       this.img = createImage(100, 30, ARGB);
       for (int i = 0; i < this.img.pixels.length; i++) {
          this.img.pixels[i] = color(250, 250, 50); 
        }
        
       this.imgHover = createImage(100, 30, ARGB);
       for (int i = 0; i < this.imgHover.pixels.length; i++) {
          this.imgHover.pixels[i] = color(50, 50, 50); 
        }
    }
      this.function = function;
  }
  
  public Button(HUD hud, int x, int y, String label,Runnable function){
     this(hud.interfaceOX,hud.interfaceOY,x,y,label,function);
     
  }
  
  public Button(int offsetX, int offsetY,int x, int y, String label,PImage image,Runnable function){
     super(offsetX,offsetY,x,y,label, function);
     
     this.img = image;
  }
  
  public Button(HUD hud,int x, int y, String label,PImage image,Runnable function){
     this(hud.interfaceOX,hud.interfaceOY,x,y,label,image,function);
     
  }
  
  
}
