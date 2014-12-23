part of util;

class Box {
  double x, y, w, h;
  
  Box(num x, num y, num w, num h) {
    this.x = x.toDouble();
    this.y = y.toDouble();
    this.w = w.toDouble();
    this.h = h.toDouble();
  }
  
  intersects(Box b) {
    if (x > b.x+b.w) {
      return false;
    }
    if (x+w < b.x) {
      return false;
    }
    if (y > b.y+b.w) {
      return false;
    }
    if (y+h < b.y) {
      return false;
    }
    return true;
  }
}