import java.util.Random;

class Unit extends Entity{
  public Unit(String name, int x, int y){
    super(name,x,y);
    
  }
 void update(){
   println(this.X);
   this.X += RNG.nextInt()%20 + (10 *Math.signum(mouseX-X/zoomLevel))* Math.abs(RNG.nextDouble());
   this.Y += RNG.nextInt()%20 + (10* Math.signum(mouseY-Y/zoomLevel))* Math.abs(RNG.nextDouble());
   this.paint();
   
 }
}
