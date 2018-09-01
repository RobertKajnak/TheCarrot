class Stash extends Entity {
   
  Resource type;
   
   public Stash(int x, int y, String name, Resource type) {
     super(name, x, y);
     this.type = type;
   }
   
   Resource extract(int nr) {
     type.amount -= nr;
     return type.withAmount(nr);
   }
   
   void update(){
     
   }
   
   void render() {
     fill(100, 0, 100);
     ellipse(x, y, 50, 50);
     
     fill(255);
     text(type.getName() + ": " + type.amount, x, y);
   }
}