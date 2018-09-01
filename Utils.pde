class Coord {
  int x;
  int y;
  
  public Coord(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  boolean equals(Coord that) {
    return this.x == that.x && this.y == that.y;
  }
  
  String toString() {
    return "(" + x + ", " + y + ")";
  }
}

int randomBetweenBounds(float lower, float upper) {
  return (int)random(min(upper, lower), max(upper, lower));
}

float distance(Entity a, Entity b) {
  return dist(a.x, a.y, b.x, b.y);
}

float distance(Coord a, Entity b) {
  return dist(a.x, a.y, b.x, b.y);
}

int worldCoordToScreenCoord(int s, int cameraPos) {
  return (s - cameraPos)/zoomLevel;
}

int screenCoordToWorldCoord(int s, int cameraPos) {
  return (s * zoomLevel) + cameraPos;
}

boolean isVisible(int x, int y, int width, int height) {
  return cameraMinX < x + width && cameraMaxX > x - width && 
         cameraMinY < y + height && cameraMaxY > y - height;
}