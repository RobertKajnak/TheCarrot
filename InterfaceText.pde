class InterfaceText{
  ///I am aware that this is not the best desigm, but no time to rewirte atm
  Resource res;
  int interfaceOX, interfaceOY,X,Y;
  int colour;
  
  public InterfaceText(int interfaceOX, int interfaceOY,int X,int Y,Resource res){
    this.X = X + interfaceOX;
    this.Y = Y + interfaceOY;
    this.interfaceOX = interfaceOX;
    this.interfaceOY = interfaceOY;
    this.res = res;
    this.colour = color(255,192,203);
  }
  
  public InterfaceText(HUD hud,int X,int Y,Resource res){
     this(hud.interfaceOX - hud.backgroundImg.width/2,hud.interfaceOY - hud.backgroundImg.height/2,X,Y,res);
  }
  
  public InterfaceText(int interfaceOX, int interfaceOY,int X,int Y,Resource res,int colour){
    this(interfaceOX, interfaceOY, X,Y,res);
    this.colour = colour;
    
  }
  public InterfaceText(HUD hud,int x, int y,Resource res,int colour){
     this(hud.interfaceOX - hud.backgroundImg.width/2,hud.interfaceOY - hud.backgroundImg.height/2,x,y,res,colour);
  }

  public void render(){
      fill(colour);
      textSize(25);
      text(res.amount, X,Y);
  }
}
