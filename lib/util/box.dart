part of util;

class Box {
  double _x, _y, _w, _h;
  
  Box(num x, num y, num w, num h) {
    _x = x.toDouble();
    _y = y.toDouble();
    _w = w.toDouble();
    _h = h.toDouble();
  }
  
  Box.fromVector(Vector2 v, num w, num h) {
    _w = w.toDouble();
    _h = h.toDouble();
    center = v;
  }
  
  double get x => _x;
  set x(num n) => _x = n.toDouble();
  double get y => _y;
  set y(num n) => _y = n.toDouble();
  double get w => _w;
  set w(num n) => _w = n.toDouble();  
  double get h => _h;
  set h(num n) => _h = n.toDouble();
  
  Vector2 get center => new Vector2(_x+_w/2, _y+_h/2);
  set center(Vector2 v) {
    _x = v.x - _w/2;
    _y = v.y - _h/2;
  }
  Vector2 get topLeft => new Vector2(_x, _y);
  set topLeft(Vector2 v) {
    _x = v.x;
    _y = v.y;
  }
  double get left => _x;
  set left(num n) => _x = n.toDouble();
  double get right => _x+_w;
  set right(num n) => _x = n.toDouble()-_w;
  double get top => _y;
  set top(num n) => _y = n.toDouble();
  double get bottom => _y+_h;
  set bottom(num n) => _y = n.toDouble()-_h;
  
  double get area => _w * _h;
  
  intersects(Box b) {
    if (_x >= b._x+b._w) {
      return false;
    }
    if (_x+_w <= b._x) {
      return false;
    }
    if (_y >= b._y+b._h) {
      return false;
    }
    if (_y+_h <= b._y) {
      return false;
    }
    return true;
  }
}