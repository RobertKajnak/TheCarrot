class Resource extends Entity {
   
  int amount = 200;
   
   public Resource(int x, int y, int amount) {
     super("Food", x, y);
     this.amount = amount;
   }
   
   void extract(int nr) {
     amount -= nr;
   }
   
   void update(){
     
   }
   
   void render() {
     fill(100, 0, 100);
     ellipse(x, y, 50, 50);
     
     fill(255);
     text(name + ": " + amount, x, y);
   }
}