part of platformShooter;

abstract class Entity {
  input();
  update(dt);
  draw();
}

class Bouncer extends Entity {
  Game g;
  int x, y, w, h, speed;
  int dx, dy;
  String color;
  
  Bouncer(this.g, this.x, this.y, this.w, this.h, this.speed, this.dx, this.dy, this.color);
  
  input() {}
  
  update(dt) {
    int xx = x + dx * speed * dt ~/ 1000;
    int yy = y + dy * speed * dt ~/ 1000;
    if (xx < 0) {
      dx = -dx;
      x = 0;
    } else if (xx+w > g.canvas.width) {
      dx = -dx;
      x = g.canvas.width - w;
    } else {
      x = xx;
    }
    if (yy < 0) {
      dy = -dy;
      y = 0;
    } else if (yy+h > g.canvas.height) {
      dy = -dy;
      y = g.canvas.height - h;
    } else {
      y = yy;
    }
  }
  
  draw() {
    g.ctx.fillStyle = color;
    g.ctx.fillRect(x, y, w, h);
  }
}

class Player extends Entity {
  Game g;
  Input i;
  int x, y, w, h, speed;
  
  int dx;
  int dy;
  
  Player(this.g, this.x, this.y, this.w, this.h, this.speed) {
    i = new PlayerInput();
  }
  
  input() {
    dx = 0;
    dy = 0;
    if (i.action('left') == true) {
      dx -= 1;
    }
    if (i.action('up') == true) {
      dy -= 1;
    }
    if (i.action('right') == true) {
      dx += 1;
    }
    if (i.action('down') == true) {
      dy += 1;
    }
  }
  
  update(final int dt) {
    final int msPerSec = 1000;
    final int xx = x + dx * speed * dt ~/ msPerSec;
    final int yy = y + dy * speed * dt ~/ msPerSec;
    if (xx < 0) {
      x = 0;
    } else if (xx+w > g.canvas.width) {
      x = g.canvas.width - w;
    } else {
      x = xx;
    }
    if (yy < 0) {
      y = 0;
    } else if (yy+h > g.canvas.height) {
      y = g.canvas.height - h;
    } else {
      y = yy;
    }
  }
  
  draw() {
    g.ctx.fillStyle = 'rgba(255, 0, 0, .9)';
    g.ctx.fillRect(x, y, w, h);
  }
}
