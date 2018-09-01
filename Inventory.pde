class Inventory {
  
  Food food = new Food(0);
  Wood wood = new Wood(0);
  Iron iron = new Iron(0);
  
  void add(Resource type) {
    if (type instanceof Food) {
      food.amount += type.amount;
    }
    else if (type instanceof Wood) {
      wood.amount += type.amount;
    }
    else if (type instanceof Iron) {
      iron.amount += type.amount;
    }
  }
  
  void add(Inventory inventory) {
    food.amount += inventory.food.amount;
    wood.amount += inventory.wood.amount;
    iron.amount += inventory.iron.amount;
  }
  
  boolean empty() {
    return (food.amount == 0) && (wood.amount == 0) && (iron.amount == 0);
  }
  
  boolean nonEmpty() {
    return !empty();
  }
  
  String toString() {
    return 
      String.format(
        "Food: %d\nWood: %d\nIron: %d", 
        food.amount, 
        wood.amount, 
        iron.amount
      );
  }
}