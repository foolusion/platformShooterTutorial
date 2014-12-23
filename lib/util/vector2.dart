part of util;

class Vector2 {
  double _x, _y;
  
  Vector2(num x, num y) {
    this._x = x.toDouble();
    this._y = y.toDouble();
  }
  
  double get x => _x;
  set x(num n) => _x = n.toDouble();
  double get y => _y;
  set y(num n) => _y = n.toDouble();
  
  Vector2 operator +(Vector2 v) => new Vector2(_x+v._x, _y+v._y);
  Vector2 operator -(Vector2 v) => new Vector2(_x-v._x, _y-v._y);
  Vector2 operator *(num n) => new Vector2(_x*n, _y*n);
  Vector2 operator /(num n) => new Vector2(_x/n, _y/n);

  double length() {
    return math.sqrt(_x*_x + _y*_y);
  }
    
  Vector2 normalize() {
    double l = this.length();
    if (l != 0) {
      return this / l;
    }
    return this;
  }
}