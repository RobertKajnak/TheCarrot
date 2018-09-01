class Inventory {
  
  int food = 0;
  int wood = 0;
  int iron = 0;
  
  void add(String name, int nr) {
    food += nr;
  }
  
  void add(Inventory inventory) {
    food += inventory.food;
    wood += inventory.wood;
    iron += inventory.iron;
  }
  
  boolean empty() {
    return (food == 0) && (wood == 0) && (iron == 0);
  }
  
  boolean nonEmpty() {
    return !empty();
  }
  
  String toString() {
    return String.format("Food: %d\nWood: %d\nIron: %d", food, wood, iron);
  }
}