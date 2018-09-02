class TextBox extends HUD{
 public TextBox(int x, int y){
   super(assets.get("textbox"),x,y,300,200);
   this.add(new Button(this,150,170,"OK",new Runnable(){public void run(){}}));
   
 }
  
}
