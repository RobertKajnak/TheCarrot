class HUD{
  
  int interfaceOX;
  int interfaceOY;
  List <Button> buttons;
  PImage backgroundImg;
  
  public HUD(PImage background, int x, int y,int w, int h){
    interfaceOX = x;
    interfaceOY = y;
    
    if (background == null){
       background = createImage(w, h, ARGB);
       for (int i = 0; i < background.pixels.length; i++) {
          background.pixels[i] = color(170,170, 30); 
        }
    }
    
    backgroundImg = background; 
    
    
    buttons = new ArrayList<Button>();
    }
  
  public void add(Button button){
    buttons.add(button);  
  }
  
  public void render(){
    image(backgroundImg,interfaceOX,interfaceOY);
    for (Button button : buttons){
       button.render(); 
    }
  }
  
  public void click(){
    for (Button button : buttons){
       button.click(); 
    }
  }
}
