part of platformShooter;

class Player {
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
    final int xx = dx*speed*dt~/msPerSec;
    final int yy = dy*speed*dt~/msPerSec;
    if (x + xx < 0) {
      x = 0;
    } else if (x + w + xx > g.canvas.width) {
      x = g.canvas.width - w;
    } else {
      x += xx;
    }
    if (y + yy < 0) {
      y = 0;
    } else if (y+h+yy > g.canvas.height) {
      y = g.canvas.height - h;
    } else {
      y += yy;
    }
  }
  
  draw() {
    g.ctx.fillStyle = 'rgba(255, 0, 0, .9)';
    g.ctx.fillRect(x, y, w, h);
  }
}
