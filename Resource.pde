abstract class Resource {
  abstract String getName();
  int amount = 0;
  abstract Resource withAmount(int amount);
}

class Food extends Resource { 
  String getName() { return "Food"; } 
  public Food(int amount) { this.amount = amount; }
  Resource withAmount(int amount) { return new Food(amount); }
}

class Wood extends Resource { 
  String getName() { return "Wood"; }
  public Wood(int amount) { this.amount = amount; }
  Resource withAmount(int amount) { return new Wood(amount); }
}

class Iron extends Resource { 
  String getName() { return "Iron"; }
  public Iron(int amount) { this.amount = amount; }
  Resource withAmount(int amount) { return new Iron(amount); }
}

class Nuclear extends Resource { 
  String getName() { return "Nuclear"; }
  public Nuclear(int amount) { this.amount = amount; }
  Resource withAmount(int amount) { return new Nuclear(amount); }
}

class Fervour extends Resource { 
  String getName() { return "Fervour"; }
  public Fervour(int amount) { this.amount = amount; }
  Resource withAmount(int amount) { return new Fervour(amount); }
}
