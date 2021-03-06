part of platformShooter;

abstract class Entity {
  input();
  update(int dt);
  draw();
  Box box;
  Vector2 velocity;
}

class Static extends Entity {
  Game g;
  Vector2 position;
  final Vector2 velocity = new Vector2(0, 0);
  Box _box;

  Box get box => _box;

  Static(this.g, this.position, w, h) {
    _box = new Box(position.x, position.y, w, h);
  }

  input() {}
  update(final int dt) {}
  draw() {
    g.ctx.fillStyle = 'rgb(255,255,255)';
    g.ctx.fillRect(_box.x, _box.y, _box.w, _box.h);
  }
}

class Bouncer extends Entity {
  Game g;
  Vector2 velocity;
  Box box;
  int speed;
  String color;

  Bouncer(this.g, this.box, this.speed, velocity, this.color) {
    this.velocity = velocity.normalize();
  }

  input() {}

  update(final int dt) {
    final Vector2 pp = new Vector2(box.x, box.y) + (velocity * speed * dt / 1000);
    Box bb = new Box(pp.x, pp.y, box.w, box.h);
    if (bb.left < 0) {
      bb.left = 0;
      velocity.x = -velocity.x;
    } else if (bb.right > g.canvas.width) {
      bb.right = g.canvas.width;
      velocity.x = -velocity.x;
    }
    if (bb.top < 0) {
      bb.top = 0;
      velocity.y = -velocity.y;
    } else if (bb.bottom > g.canvas.height) {
      bb.bottom = g.canvas.height;
      velocity.y = -velocity.y;
    }
    for (Entity e in g.entities) {
      if (this == e) {
        continue;
      }
      if (bb.intersects(e.box)) {
        if (box.right <= e.box.left && bb.right > e.box.left) {
          bb.right = e.box.left;
          velocity.x = -velocity.x;
        }
        if (box.left >= e.box.right && bb.left < e.box.right) {
          bb.left = e.box.right;
          velocity.x = -velocity.x;
        }
        if (box.top >= e.box.bottom && bb.top < e.box.bottom) {
          bb.top = e.box.bottom;
          velocity.y = -velocity.y;
        }
        if (box.bottom <= e.box.top && bb.bottom > e.box.top) {
          bb.bottom = e.box.top;
          velocity.y = -velocity.y;
        }
      }
    }
    box = bb;
  }

  draw() {
    g.ctx.fillStyle = color;
    g.ctx.fillRect(box.x, box.y, box.w, box.h);
  }
}

class Player extends Entity {
  Game g;
  Input i;
  Vector2 velocity;
  Box box;
  String state = 'flying';

  final double acc = 0.046875;
  final double dec = -.5;
  final double frc = 0.046875;
  final double top = 6.0;


  Player(this.g, this.box) {
    i = new PlayerInput();
    velocity = new Vector2(0, 0);
  }


  input() {
    if (i.action('left') == true) {
      if (velocity.x > 0) {
        velocity.x = dec;
      } else if (velocity.x > -top) {
        velocity.x -= acc;
      } else {
        velocity.x = -top;
      }
    } else if (i.action('right') == true) {
      if (velocity.x < 0) {
        velocity.x = -dec;
      } else if (velocity.x < top) {
        velocity.x += acc;
      } else {
        velocity.x = top;
      }
    } else {
      velocity.x -= math.min(velocity.x.abs(), frc) * velocity.x.sign;
    }
    if (i.action('jump') == true && state != 'flying') {
      velocity.y -= 6;
      state = 'flying';
    } else if (i.action('jump') == false && state == 'flying') {
      if (velocity.y < -4) {
        velocity.y = -4;
      }
    }
  }

  update(final int dt) {

    velocity.y += 0.21875;
    if (velocity.y > 16) {
      velocity.y = 16;

    }
    final int msPerSec = 1000;
    final Vector2 pp = new Vector2(box.x, box.y) + (velocity * 128 * dt / msPerSec);
    Box bb = new Box(pp.x, pp.y, box.w, box.h);

    /* This checks that the player doesn't move off the screen. */
    if (bb.left < 0) {
      bb.x = 0;
    } else if (bb.right > g.canvas.width) {
      bb.right = g.canvas.width;
    }
    if (bb.top < 0) {
      bb.y = 0;
    } else if (bb.bottom > g.canvas.height) {
      bb.bottom = g.canvas.height;
    }

    for (Tile t in g.world.getTilesNear(bb)) {
      if (t.isSolid && bb.intersects(t.box)) {
        if (box.bottom <= t.box.top && bb.bottom > t.box.top && bb.horizontalOverlap(t.box)) {
          bb.bottom = t.box.top;
          velocity.y = 0;
          state = 'walking';
        }
        if (box.right <= t.box.left && bb.right > t.box.left && bb.verticalOverlap(t.box)) {
          bb.right = t.box.left;
          velocity.x = 0;
        }
        if (box.left >= t.box.right && bb.left < t.box.right && bb.verticalOverlap(t.box)) {
          bb.left = t.box.right;
          velocity.x = 0;
        }
        if (box.top >= t.box.bottom && bb.top < t.box.bottom && bb.horizontalOverlap(t.box)) {
          bb.top = t.box.bottom;
          velocity.y = 0;
        }
      }
    }

    for (Entity e in g.entities) {
      if (this == e) {
        continue;
      }
      if (bb.intersects(e.box)) {
        if (box.right <= e.box.left && bb.right > e.box.left) {
          bb.right = e.box.left;
          if (e.velocity.x.sign == velocity.x.sign) {
            velocity.x = math.min(e.velocity.x, velocity.x);
          } else {
            velocity.x = 0;
          }
        }
        if (box.left >= e.box.right && bb.left < e.box.right) {
          bb.left = e.box.right;
          if (e.velocity.x.sign == velocity.x.sign) {
            velocity.x = math.min(e.velocity.x, velocity.x);
          } else {
            velocity.x = 0;
          }
        }
        if (box.top >= e.box.bottom && bb.top < e.box.bottom) {
          bb.top = e.box.bottom;
          velocity.y = 0;
        }
        if (box.bottom <= e.box.top && bb.bottom > e.box.top) {
          bb.bottom = e.box.top;
          state = 'walking';
          velocity.y = 0;
        }
      }
    }
    box = bb;
  }

  draw() {
    g.ctx.fillStyle = 'rgb(255, 0, 0)';
    g.ctx.fillRect(box.x, box.y, box.w, box.h);
    g.ctx.save();
    g.ctx.strokeStyle = 'rgb(0,255,0)';
    g.ctx.translate(box.center.x, box.center.y);
    g.ctx.beginPath();
    g.ctx.moveTo(0, 0);
    g.ctx.lineTo(velocity.x*16, velocity.y*16);
    g.ctx.closePath();
    g.ctx.stroke();
    g.ctx.restore();
  }
}
