class Button extends InterfaceItem{
   
  public Button(int offsetX, int offsetY, int x, int y, String label,Runnable function){
     super(offsetX,offsetY,x,y,label);
      this.function = function;
  }
  
  public Button(HUD hud, int x, int y, String label,Runnable function){
     this(hud.interfaceOX - hud.backgroundImg.width/2,hud.interfaceOY - hud.backgroundImg.height/2,x,y,label,function);
     
  }
  
  public Button(int offsetX, int offsetY,int x, int y, String label,PImage image,Runnable function){
     super(offsetX,offsetY,x,y,label, function);
     
     this.img = image;
  }
  
  public Button(HUD hud,int x, int y, String label,PImage image,Runnable function){
     this(hud.interfaceOX - hud.backgroundImg.width/2,hud.interfaceOY - hud.backgroundImg.height/2,x,y,label,image,function);
     
  }
  
  
}
