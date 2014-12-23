part of platformShooter;

abstract class Entity {
  input();
  update(dt);
  draw();
}

class Bouncer extends Entity {
  Game g;
  Vector2 position, velocity;
  int w, h, speed;
  String color;
  
  Bouncer(this.g, this.position, this.w, this.h, this.speed, velocity, this.color) {
    this.velocity = velocity.normalize();
  }
  
  input() {}
  
  update(dt) {
    final Vector2 pp = position + (velocity * speed * (dt / 1000));
    if (pp.x < 0) {
      velocity.x = -velocity.x;
      position.x = 0;
    } else if (pp.x+w > g.canvas.width) {
      velocity.x = -velocity.x;
      position.x = g.canvas.width - w;
    } else {
      position.x = pp.x;
    }
    if (pp.y < 0) {
      velocity.y = -velocity.y;
      position.y = 0;
    } else if (pp.y+h > g.canvas.height) {
      velocity.y = -velocity.y;
      position.y = g.canvas.height - h;
    } else {
      position.y = pp.y;
    }
  }
  
  draw() {
    g.ctx.fillStyle = color;
    g.ctx.fillRect(position.x, position.y, w, h);
  }
}

class Player extends Entity {
  Game g;
  Input i;
  Vector2 position, velocity;
  int w, h, speed;
  
  Player(this.g, this.position, this.w, this.h, this.speed) {
    i = new PlayerInput();
    velocity = new Vector2(0, 0);
  }
  
  input() {
    velocity = new Vector2(0, 0);
    if (i.action('left') == true) {
      velocity.x = velocity.x - 1;
    }
    if (i.action('up') == true) {
      velocity.y = velocity.y - 1;
    }
    if (i.action('right') == true) {
      velocity.x = velocity.x + 1;
    }
    if (i.action('down') == true) {
      velocity.y = velocity.y + 1;
    }
    velocity = velocity.normalize();
  }
  
  update(final int dt) {
    final int msPerSec = 1000;
    Vector2 pp = position + (velocity * speed * dt / 1000);
    if (pp.x < 0) {
      position.x = 0;
    } else if (pp.x+w > g.canvas.width) {
      position.x = g.canvas.width - w;
    } else {
      position.x = pp.x;
    }
    if (pp.y < 0) {
      position.y = 0;
    } else if (pp.y+h > g.canvas.height) {
      position.y = g.canvas.height - h;
    } else {
      position.y = pp.y;
    }
  }
  
  draw() {
    g.ctx.fillStyle = 'rgba(255, 0, 0, .9)';
    g.ctx.fillRect(position.x, position.y, w, h);
  }
}
