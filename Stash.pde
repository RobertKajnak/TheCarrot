class Stash extends Entity {
   
  Resource type;
   
  public Stash(int x, int y, String name, Resource type) {
    super(name, x, y);
    this.type = type;
  }
   
  Resource extract(int nr) {
    int extractedNr = (nr > type.amount)? type.amount : nr;
    type.amount = (type.amount - nr >= 0)? type.amount - nr : 0;
    
    System.out.println("extracted: " + extractedNr);
    return type.withAmount(extractedNr);
  }
   
  void update() {}
   
  void render() {
    renderImage();
     
    if (isVisible(x, y, 20, 20)) {
      
      int nx = worldCoordToScreenCoord(x, cameraX);
      int ny = worldCoordToScreenCoord(y, cameraY);
     
      fill(100, 0, 100);
      ellipse(nx, ny, 50, 50);
    
      fill(255);
      text(type.getName() + ": " + type.amount, nx, ny);
    }
  }
}