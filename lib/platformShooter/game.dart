part of platformShooter;

class Game {
  html.CanvasElement canvas;
  html.CanvasRenderingContext2D ctx;
  
  List<String> keys;
  Map<String, bool> actions;
  
  Player p;
  
  int time;
  int wallTime;
  final int maxStep = 32;
  
  var debug;
  
  Game(String selector) {
    canvas = html.querySelector(selector);
    canvas.width = 640;
    canvas.height = 480;
    ctx = canvas.context2D;
    
    keys = new List<String>(256);
    actions = new Map<String, bool>();
    keys[37] = 'left';
    keys[38] = 'up';
    keys[39] = 'right';
    keys[40] = 'down';
    keys[17] = 'jump';
    keys[65] = 'left';
    keys[87] = 'up';
    keys[83] = 'right';
    keys[82] = 'down';
    keys[32] = 'jump';
    
    html.window.onKeyDown.listen((event) => actions[keys[event.keyCode]] = true);
    html.window.onKeyUp.listen((event) => actions[keys[event.keyCode]] = false);
    
    p = new Player(this, 0, 0, 20, 50, 300);
    
    time = 0;
    wallTime = new DateTime.now().millisecondsSinceEpoch;
    debug = html.querySelector('#debug');
  }
  
  gameLoop([_]) {
    // run game loop as fast as possible.
    async.Future f = html.window.animationFrame;
    f.then(gameLoop);
    // find out how much time has elapsed so we can move our player smoothly.
    int currentTime = new DateTime.now().millisecondsSinceEpoch;
    int dt = currentTime - wallTime;
    wallTime = currentTime;
    debug.text = '${dt}';
    if (dt > maxStep) {
      dt = maxStep;
    }
    
    // resolve the players input actions from the keyboard then call their update function.
    p.input(actions);
    p.update(dt);
    
    // clear the screen then draw background and player.
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = 'rgb(255,255,255)';
    ctx.fillRect(100, 100, 100, 100);
    ctx.fillRect(300, 300, 50, 50);
    ctx.fillRect(500, 100, 30, 123);
    ctx.fillRect(50, 420, 525, 60);
    p.draw();
  }
}