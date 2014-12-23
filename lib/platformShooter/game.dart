part of platformShooter;

class Game {
  html.CanvasElement canvas;
  html.CanvasRenderingContext2D ctx;
  
  Player p;
  
  int time;
  int wallTime;
  final int maxStep = 32;
  
  html.DivElement debug;
  
  Game(String selector) {
    canvas = html.querySelector(selector);
    canvas.width = 640;
    canvas.height = 480;
    ctx = canvas.context2D;
    

    
    p = new Player(this, 0, 0, 20, 50, 300);
    
    time = 0;
    wallTime = new DateTime.now().millisecondsSinceEpoch;
    debug = new html.DivElement();
    debug.id = "debug";
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
    p.input();
    p.update(dt);
    
    // clear the screen then draw background and player.
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = 'rgb(255,255,255)';
    ctx.fillRect(100, 100, 100, 100);
    ctx.fillRect(300, 300, 50, 50);
    ctx.fillRect(500, 100, 30, 123);
    ctx.fillRect(50, 420, 525, 60);
    p.draw();
    debug.text = '${1000~/dt}  ${p.x} ${p.y} -- ${p.dx} ${p.dy}';
  }
}