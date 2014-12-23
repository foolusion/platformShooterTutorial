part of platformShooter;

class Game {
  html.CanvasElement canvas;
  html.CanvasRenderingContext2D ctx;
  
  Player p;
  List<Entity> entities;
  
  int time;
  int wallTime;
  final int maxStep = 32;
  
  html.DivElement debug;
  
  Game(String selector) {
    canvas = html.querySelector(selector);
    canvas.width = 640;
    canvas.height = 480;
    ctx = canvas.context2D;
    
    p = new Player(this, new Vector2(0, 0), 20, 50, 300);
    entities = new List<Entity>();
    entities.add(p);
    entities.add(new Bouncer(this, new Vector2(0, 0), 10, 10, 2000, new Vector2(2, 1), 'rgb(0,255,255)'));
    entities.add(new Bouncer(this, new Vector2(200, 345), 100, 100, 60, new Vector2(-1, -1), 'rgba(127, 127, 255, .5)'));
    entities.add(new Bouncer(this, new Vector2(234, 98), 30, 60, 300, new Vector2(1, 3), 'rgb(0,0,255)'));
    time = 0;
    wallTime = new DateTime.now().millisecondsSinceEpoch;
    debug = new html.DivElement();
    debug.className = "debug";
    html.document.body.append(debug);
  }
  
  gameLoop([_]) {
    // run game loop as fast as possible.
    async.Future f = html.window.animationFrame;
    f.then(gameLoop);
    // find out how much time has elapsed so we can move our player smoothly.
    int currentTime = new DateTime.now().millisecondsSinceEpoch;
    int dt = currentTime - wallTime;
    wallTime = currentTime;
    if (dt > maxStep) {
      dt = maxStep;
    }
    
    // resolve the players input actions from the keyboard then call their update function.
    for (Entity e in entities) {
      e.input();
    }
    
    for (Entity e in entities) {
      e.update(dt);
    }
    
    // clear the screen then draw background.
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = 'rgb(255,255,255)';
    ctx.fillRect(100, 100, 100, 100);
    ctx.fillRect(300, 300, 50, 50);
    ctx.fillRect(500, 100, 30, 123);
    ctx.fillRect(50, 420, 525, 60);
    
    for (Entity e in entities) {
      e.draw();
    }
    debug.text = '${1000~/dt}';
  }
}