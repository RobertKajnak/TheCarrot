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
  
  public void update() {
    
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

float buffer = 0.0;

void updateFervour() {
  buffer += 0.1;
    if (buffer >= 1) {
      buffer = 0;
      dispfervour.amount ++;
    }
}

void buildHUD(){
  String [] reqAssets = {"tree","rock","meat","nuclear","fervour"};
  for (String ass : reqAssets) {
      assets.put(ass,loadImage(resdir + ass + ".png"));
      assets.put(ass+"_highlight",loadImage(resdir + ass + "_highlight.png"));
  }
  HUDs = new ArrayList<HUD>();
  HUD mainHUD = new HUD(null,width/2,height - height /5/2,width*2/4,height/5);
  
  dispfood = new Food(0);
  mainHUD.add(new InterfaceText(mainHUD,100,105,new Food(30),color(255,0,0)));
  mainHUD.add(new InterfaceText(mainHUD,100,30,dispfood,0));
  mainHUD.add(new Button(mainHUD,100,70,"meat",new Runnable(){public void run(){activeBushType = "bush";};}));
  
  dispwood = new Wood(0);
  mainHUD.add(new InterfaceText(mainHUD,200,105,new Wood(50),color(255,0,0)));
  mainHUD.add(new InterfaceText(mainHUD,200,30,dispwood,0));
  mainHUD.add(new Button(mainHUD,200,70,"tree",new Runnable(){public void run(){
    int x = randomBetweenBounds(1, 4);
    
    activeBushType = "wood_" + x;
  };}));
  
  dispiron = new  Iron(0);
  mainHUD.add(new InterfaceText(mainHUD,300,105,new Iron(90),color(255,0,0)));
  mainHUD.add(new InterfaceText(mainHUD,300,30,dispiron,0));
  mainHUD.add(new Button(mainHUD,300,70,"rock",new Runnable(){public void run(){activeBushType = "iron";};}));
  
  dispnuclear = new  Nuclear(0);
  mainHUD.add(new InterfaceText(mainHUD,400,105,new Nuclear(500),color(255,0,0)));
  mainHUD.add(new InterfaceText(mainHUD,400,30,dispnuclear,0));
  mainHUD.add(new Button(mainHUD,400,70,"nuclear",new Runnable(){public void run(){
    if (dispfervour.amount < 500) return; 
    SS.Upgrade();
    for (Civilization civ : world.civs) {
      if (civ.name == "Moustache") {
        for (Unit unit : civ.units) {
           unit.damage += 1;
        }
    }
    }
    dispfervour.amount -= 500;
};}));
  
  dispfervour = new  Fervour(500);
  mainHUD.add(new InterfaceText(mainHUD,500,30,dispfervour,0));
  mainHUD.add(new Button(mainHUD,500,70,"fervour",new Runnable(){public void run(){activeBushType = "";};}));
  HUDs.add(mainHUD);
}