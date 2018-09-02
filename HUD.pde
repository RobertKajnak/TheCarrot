class HUD{
  
  int interfaceOX;
  int interfaceOY;
  List <Button> buttons;
  List <InterfaceText> texts;
  PImage backgroundImg;
  
  public HUD(PImage background, int x, int y,int w, int h){
    interfaceOX = x;
    interfaceOY = y;
    
    if (background == null){
       background = createImage(w, h, ARGB);
       for (int i = 0; i < background.pixels.length; i++) {
          background.pixels[i] = color(170,170, 30,0); 
        }
    }
    
    backgroundImg = background; 
    
    
    buttons = new ArrayList<Button>();
    texts = new ArrayList<InterfaceText>();
    }
  
  public void add(Button button){
    buttons.add(button);  
  }
  
  public void add(InterfaceText text){
     texts.add(text); 
  }
  
  public void render(){
    image(backgroundImg,interfaceOX,interfaceOY);
    for (Button button : buttons){
       button.render(); 
    }
    for (InterfaceText it : texts){
      it.render();
    }
  }
  
  public boolean click(){
    boolean anyclicked = false;
    for (Button button : buttons){
       anyclicked |= button.click(); 
    }
    return anyclicked;
  }
}
