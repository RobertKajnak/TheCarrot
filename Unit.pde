import java.util.Random;

class Unit extends Entity{
  public Unit(PImage im, int x, int y){
    super(im,x,y);
    
  }
 void update(){
   this.X += RNG.nextInt()%10 + (5 *Math.signum(mouseX-X))* Math.abs(RNG.nextDouble());
   this.Y += RNG.nextInt()%10 + (5* Math.signum(mouseY-Y))* Math.abs(RNG.nextDouble());
   this.paint();
   
 }
}
