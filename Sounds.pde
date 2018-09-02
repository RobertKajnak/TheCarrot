import processing.sound.*;
import java.util.*;

class Sounds{
  
 private SoundFile BGM, Construction, Upgrade,Pickup, Death;
 private List<SoundFile> Battles;
 private int battleCount = 5;
 //private Minim SE;
 
 public Sounds(gmtk_2018 sc){
     Construction = new SoundFile(sc,resdir + "build.mp3"); 
     Upgrade = new SoundFile(sc,resdir + "weapon.mp3");
     Pickup = new SoundFile(sc, resdir + "pickup.mp3");
     Death = new SoundFile(sc, resdir + "death.mp3");
    
     Battles = new ArrayList<SoundFile>();
     for (int i=1;i<=battleCount;i++){
         Battles.add(new SoundFile(sc,resdir + "battle"+i+".mp3"));
     }
 }
 
 public void BGM(){
   BGM.loop();
 }

  public void ConstructionStart(){
   Construction.play(1,0.2);
 }
 
 public void ConstructionEnd(){
    Construction.stop(); 
 }
 
 public void battle(){
   for (int i=1; i<battleCount;i++){
     if (Battles.get(i).isPlaying()){
       return;
     }
   }
   Battles.get((Math.abs(RNG.nextInt())%battleCount)).play();
 }

 
 public void Upgrade(){
   Upgrade.play();
 }
 
 public void Pickup(){
    Pickup.play(); 
 }
 
 public void Death(){
   if (!Death.isPlaying())  
       Death.play();
 }
  
}
