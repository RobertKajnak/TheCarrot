///checks if x and y are inside rect, where rectX and rectY represent the middle of the rectangle
public boolean insideRect(int x, int y, int rectX, int rectY, int rectW, int rectH){
   if (x>rectX-rectW/2 && x<rectX + rectW/2 && y > rectY-rectH && y< rectY+rectH)
     return true;
   else
     return false;
  
}


void showHelpScreen(){
  image(assets.get("help"),width/2,height/2);
}
