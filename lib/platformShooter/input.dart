part of platformShooter;

abstract class Input {
  bool action(String s);
}

class PlayerInput extends Input {
  List<String> keys;
  Map<String, bool> actions;
  
  PlayerInput() {
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
  }
  
  bool action(String s) {
    var a = actions[s];
    if (a == null) {
      return false;
    }
    return a;
  }
}