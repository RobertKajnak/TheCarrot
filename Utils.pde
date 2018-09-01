float distance(Entity a, Entity b) {
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